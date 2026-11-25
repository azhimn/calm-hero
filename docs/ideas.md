# Ideas

Parked ideas for Calm Hero. Not planned or promised; move an item to a GitHub issue when work starts.

## Companion extension

A small Playnite extension shipped alongside the theme, for things pure XAML + Theme Options can't do.
Themes can't run code, and Playnite's built-in converters can't split or search strings.

- **Tab layout as a list or picker.** Replace the five "Carousel tab" fields with one comma/semicolon list,
  or a checklist built from the user's actual filter presets. Would also remove the five-tab cap.
  Today: `Options.yaml` `UseDefaultPreviewTabs` + `PreviewTab1-5`, matched by `PreviewSlot1-5` in `Views/Main.xaml`.
- Cost: users need a second install; the theme must keep working without it (fall back to the fields).
