# Gamepad-like repro: move keyboard focus right N times (scrolls like the d-pad), toggle layout off/on, step right again.
param([string]$Tag = "fork", [int]$Steps = 12)
$D = "C:\Roggie\theme\design\shots-live"
function Send($c, $w = 1.2) { $c | Out-File "$env:TEMP\pn-cmd.txt" -Encoding ascii; Start-Sleep $w }
$find = 'function F($o,$n){ if($o -is [System.Windows.FrameworkElement] -and $o.Name -eq $n){return $o}; for($i=0;$i -lt [System.Windows.Media.VisualTreeHelper]::GetChildrenCount($o);$i++){ $r=F ([System.Windows.Media.VisualTreeHelper]::GetChild($o,$i)) $n; if($r){return $r} } }; $mw=[System.Windows.Application]::Current.MainWindow; $lb=F $mw "PART_ListGameItems"; $fs=$mw.DataContext.AppSettings.Fullscreen;'
$right = '$f=[System.Windows.Input.Keyboard]::FocusedElement; if($f){[void]$f.MoveFocus((New-Object System.Windows.Input.TraversalRequest "Right"))}; $g=[System.Windows.Input.Keyboard]::FocusedElement; if($g -is [System.Windows.Controls.ListBoxItem]){ $lb.SelectedItem = $g.DataContext };'
$report = '$f=[System.Windows.Input.Keyboard]::FocusedElement; "focus=" + $(if($f){$f.GetType().Name + "/" + $f.DataContext}else{"NONE"}) + " sel=" + $lb.SelectedIndex + " h=" + $fs.HorizontalLayout'
Send "preset All" 2.5
Send "ps $find `$fs.HorizontalLayout=`$true; $report" 1.5
1..$Steps | ForEach-Object { Send "ps $find $right" 1.1 }
Send "ps $find $report" 1
& "$env:TEMP\pn-shot.ps1" -Out "$D\h2-$Tag-1.png" | Out-Null
Send "ps $find `$fs.HorizontalLayout=`$false; $report" 2.5
& "$env:TEMP\pn-shot.ps1" -Out "$D\h2-$Tag-2-off.png" | Out-Null
Send "ps $find $report" 1
Send "ps $find `$fs.HorizontalLayout=`$true; $report" 2.5
& "$env:TEMP\pn-shot.ps1" -Out "$D\h2-$Tag-3-on.png" | Out-Null
Send "ps $find $right $report" 1.5
Send "ps $find $right $report" 1.5
& "$env:TEMP\pn-shot.ps1" -Out "$D\h2-$Tag-4-right.png" | Out-Null
Get-Content "$env:TEMP\pn-driver.log" | Select-String 'focus=' | Select-Object -Last 6 | ForEach-Object Line


