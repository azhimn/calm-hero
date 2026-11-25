# Releasing an update

How to ship a new Calm Hero version. Based on Playnite's
[theme distribution docs](https://api.playnite.link/docs/tutorials/themes/distributionAndUpdates.html) and
[Toolbox docs](https://api.playnite.link/docs/tutorials/toolbox.html).

## 1. Test

- Theme edits show after a Playnite restart (the dev machine links the theme folder with a junction, see `tools/README.md`).
- Check both layouts (a carousel tab and the grid), the details page, the menus, and the Theme Options settings.
- Also check with Theme Options disabled: the theme must still work on its defaults.

## 2. Bump the version

- `HandheldHero/theme.yaml`: raise `Version` (e.g. `1.0.0` → `1.1.0`). Use a .NET version string (numbers and dots).
- Never change `Id` (`CalmHero_a1af5af7-dcb8-4ffe-9f19-19ba154b7b46`). Playnite and Theme Options key the
  install folder and users' saved settings on it.
- Only raise `ThemeApiVersion` if you used something from a newer Playnite theme API. A newer major API
  version stops older Playnite builds from loading the theme.

## 3. Pack

Toolbox ships with Playnite:

```powershell
& "$env:LOCALAPPDATA\Playnite\Toolbox.exe" pack "C:\Roggie\theme\HandheldHero" "C:\Roggie\theme\dist"
```

It writes `CalmHero_a1af5af7-dcb8-4ffe-9f19-19ba154b7b46_<version>.pthm` (dots as underscores, e.g. `_1_1_0`)
into the target folder. Upload it under that name; `.pthm` files are git-ignored.

## 4. Publish

1. Commit, tag and push: `git tag v1.1.0`, `git push origin main v1.1.0`. Not `--tags`: the clone also has upstream Handheld Hero tags.
2. Create a GitHub release for the tag, attach the `.pthm`, and list the changes.
3. Add the version to `Manifest/InstallerManifest.yaml` (newest first):

   ```yaml
   AddonId: 'CalmHero_a1af5af7-dcb8-4ffe-9f19-19ba154b7b46'
   Packages:
     - Version: 1.1.0
       RequiredApiVersion: 2.9.0
       ReleaseDate: 2026-12-01
       PackageUrl: https://github.com/azhimn/calm-hero/releases/download/v1.1.0/CalmHero_a1af5af7-dcb8-4ffe-9f19-19ba154b7b46_1_1_0.pthm
       Changelog:
         - What changed
   ```

   Check it with `Toolbox.exe verify installer Manifest\InstallerManifest.yaml`.



## Add-on browser and automatic updates

Playnite only offers automatic updates for themes listed in the
[add-on database](https://github.com/JosefNemec/PlayniteAddonDatabase): an entry (type `ThemeFullscreen`)
whose `InstallerManifestUrl` points at the raw `InstallerManifest.yaml` on GitHub. New submissions are on hold
until Playnite's new add-on portal launches (planned for Playnite 11, with a backport to 10). Until then users
update by hand (README, "Update").

## Warning for the dev machine

The installed theme folder is a junction to this repo. Installing a `.pthm` on this PC writes into the
junction, which means into the repo working tree. Test packed files on another machine, or remove the junction first.
