# Calm Hero

A calm, gamepad-first **Fullscreen theme for [Playnite](https://playnite.link)**, built for Windows handhelds
(ROG Ally, Legion Go, Steam Deck on Windows, MSI Claw). Forked from
[Handheld Hero](https://github.com/nickhighland/HandheldHero) by ProbablyModded.

![Calm Hero carousel on the Most Played tab](docs/previews/carousel.png)

## Previews

| | |
|---|---|
| ![Carousel sliding to the next game](docs/previews/carousel-slide.gif) | ![Filter panel sliding in over the library grid](docs/previews/filter-panel.gif) |
| The carousel row slides to the next game while the background crossfades. | The filter panel slides in from the left. |
| ![Library grid on the All tab](docs/previews/grid.png) | ![Game details page](docs/previews/details.png) |
| Library grid with the letter jump bar. | Details page, with Your activity, Ratings and Details on the right. |

When you press LB or RB, the accent underline moves over to the new tab:

![Tab underline moving between tabs](docs/previews/tab-underline.gif)

## Install

### From a release file (.pthm)

1. Download the `.pthm` file (`CalmHero_…_<version>.pthm`) from the latest release on the [Releases](https://github.com/azhimn/calm-hero/releases) page.
2. Double-click the file, or drag it onto the Playnite window. Playnite asks whether to install the theme.
3. Restart Playnite when it asks.

### Manual install

1. Download this repo (**Code > Download ZIP**) and unzip it.
2. Copy the `HandheldHero` folder into `%APPDATA%\Playnite\Themes\Fullscreen\` and rename it to
   `CalmHero_a1af5af7-dcb8-4ffe-9f19-19ba154b7b46`.
3. Restart Playnite.

### From the Playnite add-on browser

Coming soon.

### Select the theme

In Fullscreen mode, open the menu (View / Select button), go to **Settings > Visuals** and pick **Calm Hero** in the
**Theme** dropdown. Leave the menu and restart Playnite when it asks.

### Optional extensions

The theme works without these. Both are in Playnite's add-on browser (in Desktop mode, **Main menu > Add-ons… > Browse > Generic**):

- Theme Options, for the choices listed under [Settings](#settings-optional).
- Extra Metadata Loader, for game logos and the Trailer button.

### Update

Check the [Releases](https://github.com/azhimn/calm-hero/releases) page for a newer version, then:

- **Installed from a .pthm:** download the new `.pthm` from the latest release and install it the same way (double-click or drag
  onto Playnite). Restart Playnite when it asks.
- **Installed manually:** close Playnite, delete the contents of
  `%APPDATA%\Playnite\Themes\Fullscreen\CalmHero_a1af5af7-dcb8-4ffe-9f19-19ba154b7b46\`, copy in the contents of
  the new `HandheldHero` folder, then start Playnite. Deleting first makes sure no removed files are left behind.

Your Theme Options choices (including tab layouts) are stored by Theme Options, not in the theme folder, so
they carry over. Updates from the add-on browser will come once the theme is listed there.

## What changed from Handheld Hero

- **Typography and icons:** Segoe UI Variable and Segoe Fluent Icons (both ship with Windows 11; Windows 10 falls back to
  Segoe UI and Segoe MDL2 Assets). No more mixed symbol fonts.
- **Top bar:** clock and battery on the left, plain tabs with an accent underline that hands over between tabs,
  LB / RB hints next to the tabs, settings button with its View-button hint on the right.
- **No repeated page titles.** Grid pages show a quiet "N games · sort order" line instead.
- **Carousel:** the row slides to the next game; no PLAY / INFO buttons, reflection or glow on the cover (the bottom bar has the actions).
- **Selection:** "Lift" by default. The focused cover grows and the others dim, with no animated border.
- **Details page:** Your activity moved to the right column next to Ratings and Details; readable Play / Game options / Trailer buttons.
- **Overlays:** main menu, settings, filter panel, game menu, dialogs and the on-screen keyboard are rounded
  panels on one solid surface, with toggle switches, chevron rows and a short slide-in.
- **Button prompts:** mono discs (dark disc, coloured letter) by default.
- Still no pixel-shader effects anywhere, so it stays smooth on handheld iGPUs.

## Settings (optional)

Install the [Theme Options](https://playnite.link/addons.html#ThemeOptions_904cbf3b-573f-48f8-9642-0a09d05c64ef)
extension to change, in **Settings > Theme Options**:

| Option | Choices (default first) |
|---|---|
| Font | Segoe UI Variable, Bahnschrift, Segoe UI |
| Selection style | Lift, Ring, Thin accent ring |
| Tab style | Underline, Soft pill, Text only |
| Button prompts | Mono, Colour |
| Carousel movement | Animated slide, Instant |
| Reopen the last used tab | Off (start on the first tab), On |
| Tab layout | Built-in carousel tabs on/off, plus up to five carousel tab names (see [Choosing the layout per tab](#choosing-the-layout-per-tab)) |

**Tab order and names** come from Playnite itself: tabs are your filter presets, and their order is set in Playnite (Desktop mode filter presets). The first tab is where the theme starts.

Clock, battery and battery percentage follow Playnite's own Fullscreen settings.

## Tabs and layout

Each tab uses one of two layouts:

- **Carousel**: one row with the selected cover centred, plus the game's logo, genres and playtime.
- **Grid**: several rows of covers with a letter jump bar.

The layout is chosen by the **name of the filter preset** shown as a tab. By default these names get the
carousel (any case): `Home`, `Favorites`, `Favorite`, `Favourites`, `Recent`, `Recently Played`,
`Recently Added`, `Recent Games`, `Most Played`, `Top Played`, `Continue Playing`. Every other tab (for example
`All`) uses the grid.

### Choosing the layout per tab

Needs the [Theme Options](https://playnite.link/addons.html#ThemeOptions_904cbf3b-573f-48f8-9642-0a09d05c64ef)
extension. Open **Settings > Theme Options** and find **Tab layout**:

| Setting | What it does |
|---|---|
| Built-in carousel tabs | On: the names above get the carousel. Off: they get the grid, unless you list them below. |
| Carousel tab 1–5 | Tab names that get the carousel. Type the name as it appears on the tab (any case). Leave empty if unused. |

Examples:

- **Carousel on a tab of your own** (say `Shooters`): leave the checkbox on and type `Shooters` in Carousel tab 1.
- **Grid on Favorites, carousel kept on Recent and Most Played**: untick the checkbox, then type `Recent` and
  `Most Played` in Carousel tab 1 and 2.
- **Carousel everywhere except All**: untick the checkbox and list your other tabs (up to five).

Notes:

- A tab name must match exactly. If you rename a tab in Playnite, update its field too.
- A custom filter from the Filter panel (no tab selected) always uses the grid.
- Without Theme Options, the built-in names are used.

## Optional plugins

- [Extra Metadata Loader](https://github.com/darklinkpower/PlayniteExtraMetadataLoader): game logos and the Trailer button.
- [SuccessStory](https://github.com/Lacro59/playnite-successstory-plugin): achievements on the details screen.

## Development

The theme files live in `HandheldHero/`. `design/mockup/` holds the HTML mockup used to agree on the design
(its fonts and art are git-ignored), `tools/` the test helpers. Tested with Playnite 10.x (theme API 2.9.0).
Shipping a new version: [docs/releasing.md](docs/releasing.md). Parked ideas: [docs/ideas.md](docs/ideas.md).

## License

MIT. Based on Handheld Hero (MIT, nickhighland), which derives from Playnite's default Fullscreen theme (MIT, Josef Nemec).
