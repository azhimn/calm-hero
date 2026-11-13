# Temporary dev helper: polls %TEMP%\pn-cmd.txt and drives the fullscreen UI through the Playnite API.
# Commands: next | prev | preset <name> | details
function OnApplicationStarted() {
$Src = @"
using System; using System.IO; using System.Windows.Threading; using System.Management.Automation; using System.Management.Automation.Runspaces;
public class DevDriver {
  static DispatcherTimer t; static Runspace rs; static string body;
  public static void Start(object api, string script) {
    body = script;
    rs = RunspaceFactory.CreateRunspace(); rs.ThreadOptions = PSThreadOptions.UseCurrentThread; rs.Open();
    rs.SessionStateProxy.SetVariable("PlayniteApi", api);
    t = new DispatcherTimer(); t.Interval = TimeSpan.FromMilliseconds(200);
    t.Tick += (s, e) => {
      string cmdFile = Path.Combine(Path.GetTempPath(), "pn-cmd.txt");
      if (!File.Exists(cmdFile)) return;
      string cmd = File.ReadAllText(cmdFile).Trim(); File.Delete(cmdFile);
      var app = System.Windows.Application.Current; string log = Path.Combine(Path.GetTempPath(), "pn-driver.log");
      if (cmd.StartsWith("cmd ")) {
        var vm = app.MainWindow.DataContext; var prop = vm.GetType().GetProperty(cmd.Substring(4));
        var c = prop == null ? null : prop.GetValue(vm, null) as System.Windows.Input.ICommand;
        if (c != null) app.Dispatcher.BeginInvoke(new Action(() => c.Execute(null)));
        File.AppendAllText(log, DateTime.Now.ToString("HH:mm:ss.fff") + " " + cmd + (c == null ? " (not found)" : "") + Environment.NewLine); return;
      }
      if (cmd.StartsWith("topcmd ") || cmd == "toplist") {
        System.Windows.Window top = null;
        foreach (System.Windows.Window w in app.Windows) if (w != app.MainWindow && w.IsVisible) top = w;
        string msg = "no window";
        if (top != null && top.DataContext != null) {
          var dt = top.DataContext.GetType();
          if (cmd == "toplist") { var names = new System.Collections.Generic.List<string>(); foreach (var pi in dt.GetProperties()) if (pi.Name.EndsWith("Command")) names.Add(pi.Name); msg = dt.Name + ": " + string.Join(", ", names); }
          else { var pr = dt.GetProperty(cmd.Substring(7)); var cc = pr == null ? null : pr.GetValue(top.DataContext, null) as System.Windows.Input.ICommand;
                 if (cc != null) { app.Dispatcher.BeginInvoke(new Action(() => cc.Execute(null))); msg = "ok"; } else msg = "not found"; }
        }
        File.AppendAllText(log, DateTime.Now.ToString("HH:mm:ss.fff") + " " + cmd + " -> " + msg + Environment.NewLine); return;
      }
      if (cmd == "closetop") {
        System.Windows.Window last = null;
        foreach (System.Windows.Window w in app.Windows) if (w != app.MainWindow && w.IsVisible) last = w;
        if (last != null) last.Close();
        File.AppendAllText(log, DateTime.Now.ToString("HH:mm:ss.fff") + " closetop " + (last == null ? "none" : last.GetType().Name) + Environment.NewLine); return;
      }
      using (var ps = PowerShell.Create()) { ps.Runspace = rs; ps.AddScript(body).AddArgument(cmd);
        try { foreach (var o in ps.Invoke()) File.AppendAllText(Path.Combine(Path.GetTempPath(), "pn-driver.log"), o + Environment.NewLine); }
        catch (Exception ex) { File.AppendAllText(Path.Combine(Path.GetTempPath(), "pn-driver.log"), "ERR " + ex.Message + Environment.NewLine); } }
    };
    t.Start();
  }
}
"@
$Body = {
    param($cmd)
    $mv = $PlayniteApi.MainView
    $games = @($mv.FilteredGames)
    $sel = @($mv.SelectedGames) | Select-Object -First 1
    $ids = @($games | ForEach-Object { $_.Id })
    $idx = if ($sel) { [array]::IndexOf($ids, $sel.Id) } else { -1 }
    if ($cmd -eq 'next') { $mv.SelectGame($games[[Math]::Min($idx + 1, $games.Count - 1)].Id) }
    elseif ($cmd -eq 'prev') { $mv.SelectGame($games[[Math]::Max($idx - 1, 0)].Id) }
    elseif ($cmd -like 'ps *') { return (Invoke-Expression $cmd.Substring(3) | Out-String).Trim() }
    elseif ($cmd -like 'preset *') {
        $name = $cmd.Substring(7)
        $p = $PlayniteApi.Database.FilterPresets | Where-Object { $_.Name -eq $name } | Select-Object -First 1
        if ($p) { $mv.ApplyFilterPreset($p.Id) }
    }
    elseif ($cmd -eq 'listcmds') { $vm = [System.Windows.Application]::Current.MainWindow.DataContext; return ($vm.GetType().GetProperties() | Where-Object { $_.Name -like "*Command" } | ForEach-Object Name) -join ", " }
    elseif ($cmd -eq 'closetop') { $w = @([System.Windows.Application]::Current.Windows) | Where-Object { $_ -ne [System.Windows.Application]::Current.MainWindow -and $_.IsVisible } | Select-Object -Last 1; if ($w) { $w.Close(); return "closed $($w.GetType().Name)" } }
    elseif ($cmd -like 'cmd *') { $vm = [System.Windows.Application]::Current.MainWindow.DataContext; $c = $vm.GetType().GetProperty($cmd.Substring(4)).GetValue($vm); $c.Execute($null) }
    "$(Get-Date -Format HH:mm:ss.fff) $cmd idx=$idx n=$($games.Count) sel=$($sel.Name)"
}

    "started $(Get-Date -Format o)" | Set-Content (Join-Path $env:TEMP "pn-driver.log") -Encoding ascii
    try {
        Add-Type -TypeDefinition $Src -ReferencedAssemblies WindowsBase, PresentationFramework, PresentationCore, System.Xaml, System.Management.Automation -ErrorAction Stop
        [DevDriver]::Start($PlayniteApi, $Body.ToString())
    } catch { "ERR start $($_.Exception.Message)" | Out-File (Join-Path $env:TEMP "pn-driver.log") -Append }
}
