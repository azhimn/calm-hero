# Dev tools (not part of the theme package)

Simulated keyboard/mouse input does not reach Playnite on the dev machine, so testing goes through the API instead.

- `dev-driver/`: temporary Playnite script extension. Copy to `%APPDATA%\Playnite\Extensions\ThemeDevDriver\`,
  restart Playnite, then write one command to `%TEMP%\pn-cmd.txt`:
  `next`, `prev`, `preset <tab name>`, `cmd <MainViewModel command>` (e.g. `cmd OpenMainMenuCommand`,
  `cmd ToggleFiltersCommand`, `cmd OpenSearchCommand`), `toplist`, `topcmd <command on the top window>`, `closetop`.
  Log: `%TEMP%\pn-driver.log`. Remove the folder when done.
- `scripts/pn-shot.ps1 [-Restart]`: restart Playnite and capture the screen at native resolution.
- `scripts/pn-burst.ps1 -Cmd next`: send a driver command and stack a burst of frames (checks animations).
- `scripts/pn-tour.ps1`: open and capture each modal overlay.
- `scripts/pn-presets.ps1 -Presets Selection.Ring,...`: set Theme Options presets for the fork (Playnite closed).

The theme folder is linked into Playnite with a junction:
`mklink /J "%APPDATA%\Playnite\Themes\Fullscreen\CalmHero_a1af5af7-dcb8-4ffe-9f19-19ba154b7b46" C:\Roggie\theme\HandheldHero`
