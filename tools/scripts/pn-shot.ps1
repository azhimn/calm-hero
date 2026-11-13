# Restart Playnite fullscreen (optional), bring it to the front and capture the primary screen at native resolution.
param([string]$Out = "C:\Roggie\theme\design\shots-live\screen.png", [switch]$Restart, [int]$Wait = 14)
Add-Type @"
using System; using System.Runtime.InteropServices;
public static class W {
  [DllImport("user32.dll")] public static extern bool SetProcessDPIAware();
  [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
  [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int c);
  [DllImport("user32.dll")] public static extern void keybd_event(byte k, byte s, uint f, UIntPtr e);
}
"@
[W]::SetProcessDPIAware() | Out-Null
$pn = "$env:LOCALAPPDATA\Playnite"
if ($Restart) {
    & "$pn\Playnite.DesktopApp.exe" --shutdown
    $t = 0; while ((Get-Process Playnite.FullscreenApp, Playnite.DesktopApp -ErrorAction SilentlyContinue) -and $t -lt 30) { Start-Sleep 1; $t++ }
    Start-Process "$pn\Playnite.FullscreenApp.exe" -ArgumentList "--hidesplashscreen"
    Start-Sleep $Wait
}
$p = Get-Process Playnite.FullscreenApp -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowHandle -ne 0 } | Select-Object -First 1
if ($p) {
    [W]::keybd_event(0x12, 0, 0, [UIntPtr]::Zero); [W]::keybd_event(0x12, 0, 2, [UIntPtr]::Zero)  # Alt tap lets SetForegroundWindow succeed
    # no ShowWindow: maximizing pulls the taskbar over Playnite
    [W]::SetForegroundWindow($p.MainWindowHandle) | Out-Null
    Start-Sleep -Milliseconds 1500
}
Add-Type -AssemblyName System.Windows.Forms, System.Drawing
$b = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$bmp = New-Object System.Drawing.Bitmap $b.Width, $b.Height
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.CopyFromScreen($b.Location, [System.Drawing.Point]::Empty, $b.Size)
New-Item -ItemType Directory -Force (Split-Path $Out) | Out-Null
$bmp.Save($Out, [System.Drawing.Imaging.ImageFormat]::Png)
"$($b.Width)x$($b.Height) -> $Out"
