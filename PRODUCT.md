# Product

<!-- impeccable:product-schema 1 -->

## Platform

Playnite Fullscreen theme (WPF/XAML, Theme API 2.9.0, Playnite 10.x). Not web, not native mobile. Recorded here as a custom platform; the closest Impeccable bucket is `web` for tooling only.

## Users

People who play PC games on a Windows handheld and use Playnite's Fullscreen mode as the console-style launcher. They are holding the device, using a gamepad (no mouse, rarely touch), at arm's length, often in short sessions, sometimes in bright or dim rooms. Their job: find a game quickly, see what matters about it (playtime, last played, installed or not), and launch it.

Primary maintainer and first user: the theme author, on a ROG Ally (1920×1080, 7", 60 Hz).

## Product Purpose

A calm, fast, gamepad-first Fullscreen theme for Windows handhelds. Success: browsing a large library feels smooth on an iGPU, everything is readable at 7", and nothing needs a mouse.

## Positioning

A fork of Handheld Hero (MIT, nickhighland) that keeps its performance discipline (no pixel-shader effects, plain clips instead of VisualBrush masks) and its layout ideas, but with a quieter, more consistent visual language across every screen, including the filter and settings overlays that most themes leave half-styled.

## Operating Context

- Devices: all Windows handhelds. Design and test at 1920×1080 (Ally / Ally X, 7"), 1280×800 (Steam Deck on Windows, 16:10), 2560×1600 (Legion Go, 8.8"), and the MSI Claw's 1080p.
- Input: Xbox-style gamepad. Bottom bar shows button prompts; A = confirm, B = back, X/Y/menu as Playnite defines.
- Layout is chosen by filter-preset tab name: carousel tabs (HOME, FAVORITES, RECENT…) vs. the library grid (ALL GAMES and anything else).
- Optional plugins: Extra Metadata Loader (logos, trailers), SuccessStory (achievements).
- Distribution: GitHub repo and the Playnite add-on browser (needs a `Manifest/` entry and a `.pthm` package).

## Capabilities and Constraints

- Hard performance floor: no `BlurEffect`/`DropShadowEffect`/shader effects on repeated items, no `VisualBrush` opacity masks, background images are cheap to scale. Scroll and selection must hold up on an iGPU at 60 Hz.
- Must honour Playnite's required `PART_` element names so the app keeps working.
- Fonts and icons must be redistributable (OFL/MIT or similar) and bundled in the theme folder.
- `Views/Main.xaml` was produced by the upstream author's template generator, which is not in the repo; we edit the XAML directly.
- Name: Calm Hero (Id `CalmHero_a1af5af7-…`).

## Brand Commitments

- Credit Handheld Hero (nickhighland) and Playnite's default Fullscreen theme (Josef Nemec) in LICENSE and README; keep the MIT notice.
- Known user preferences (binding): calmer, non-cartoonish typeface; subtle selection state (no animated border); rounded corners everywhere including filter/settings overlays; simpler icons; a battery indicator; no redundant page titles or on-cover PLAY/INFO buttons.

## Evidence on Hand

- Upstream source and screenshots: `HandheldHero/`, `Media/1-Carousel.jpg`, `Media/2-Library.jpg`, `Media/3-Details.jpg`.
- Reference themes installed locally for comparison: Reskin XBOXSX (icon consistency), (u)biquity (settings overlay layout, but too low contrast), Toggle (navigation panel).
- No users, reviews, or download numbers yet; do not invent any.

## Product Principles

1. Fast before pretty: an effect that drops frames on an Ally does not ship.
2. One visual language on every screen: overlays, dialogs and menus match the main views.
3. Show each control once: if the bottom bar has the prompt, the content doesn't repeat it.
4. Readable at arm's length on a 7" screen, in any room light.
5. Quiet by default; motion only where it explains where focus went.

## Accessibility & Inclusion

Text contrast at least WCAG AA against the darkest and brightest backgrounds the art can produce (the main scrim must guarantee it). Focus state must be visible without relying on colour alone or animation. Minimum body text roughly 20 px at 1080p on a 7" panel.
