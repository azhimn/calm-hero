# Set (or clear) Theme Options presets for the fork while Playnite is closed, then restart it.
param([string[]]$Presets = @())
$id = "HandheldHeroFork_a1af5af7-dcb8-4ffe-9f19-19ba154b7b46"
$cfg = "$env:APPDATA\Playnite\ExtensionsData\904cbf3b-573f-48f8-9642-0a09d05c64ef\config.json"
& "$env:LOCALAPPDATA\Playnite\Playnite.DesktopApp.exe" --shutdown
$t = 0; while ((Get-Process Playnite.FullscreenApp, Playnite.DesktopApp -ErrorAction SilentlyContinue) -and $t -lt 30) { Start-Sleep 1; $t++ }
if (-not (Test-Path "$cfg.bak-claude")) { Copy-Item $cfg "$cfg.bak-claude" }
$j = Get-Content $cfg -Raw | ConvertFrom-Json
if ($j.SelectedPresets.PSObject.Properties[$id]) { $j.SelectedPresets.PSObject.Properties.Remove($id) }
if ($Presets.Count) { $j.SelectedPresets | Add-Member -NotePropertyName $id -NotePropertyValue $Presets }
[IO.File]::WriteAllText($cfg, ($j | ConvertTo-Json -Depth 20))
"presets: $($Presets -join ', ')"
