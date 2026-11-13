# Open each overlay via the dev driver, screenshot it, close it.
param([string]$Dir = "C:\Roggie\theme\design\shots-live", [string[]]$Steps = @("OpenMainMenuCommand", "OpenGameMenuCommand", "OpenSearchCommand"))
function Send($c) { $c | Out-File "$env:TEMP\pn-cmd.txt" -Encoding ascii; Start-Sleep -Milliseconds 700 }
foreach ($s in $Steps) {
  Send "cmd $s"; Start-Sleep 1.6
  & "$env:TEMP\pn-shot.ps1" -Out "$Dir\tour-$s.png" | Out-Null
  Send "closetop"; Start-Sleep 0.8
}
Get-Content "$env:TEMP\pn-driver.log" | Select-Object -Last ($Steps.Count * 2 + 1)
