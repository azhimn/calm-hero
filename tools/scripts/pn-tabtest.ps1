# Check the theme's LB/RB bindings: report current tab, then fire RB / LB bindings from PART_ViewHost.
function Send($c, $w = 1.6) { $c | Out-File "$env:TEMP\pn-cmd.txt" -Encoding ascii; Start-Sleep $w }
$find = 'function F($o,$n){ if($o -is [System.Windows.FrameworkElement] -and $o.Name -eq $n){return $o}; for($i=0;$i -lt [System.Windows.Media.VisualTreeHelper]::GetChildrenCount($o);$i++){ $r=F ([System.Windows.Media.VisualTreeHelper]::GetChild($o,$i)) $n; if($r){return $r} } }; $mw=[System.Windows.Application]::Current.MainWindow; $vm=$mw.DataContext; $vh=F $mw "PART_ViewHost";'
$state = '"tab=" + $vm.ActiveFilterPreset.Name + " bindings=" + $vh.InputBindings.Count + " next=" + $vh.InputBindings[0].CommandParameter.Name + " prev=" + $vh.InputBindings[1].CommandParameter.Name'
$fire = { param($i) "ps $find `$b=`$vh.InputBindings[$i]; `$b.Command.Execute(`$b.CommandParameter); Start-Sleep -m 300; $state" }
Send "ps $find $state"
Send (& $fire 0); Send (& $fire 0); Send (& $fire 0); Send (& $fire 0)
Send (& $fire 1)
Get-Content "$env:TEMP\pn-driver.log" | Select-String 'tab=' | Select-Object -Last 6 | ForEach-Object Line
