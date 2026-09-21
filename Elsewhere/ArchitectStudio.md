# Architect Studio

Repository `ArchitectStudio` (`nelim.architectstudio`), suite under `Tests/Pickle/`: the steps are
`Tests/Pickle/Source/` (`ModSteps.cs`, `GroupSteps.cs`, `CategorySteps.cs`, `SettingsSandbox.cs`), built by
`ArchitectStudio.PickleSteps.csproj` into `Tests/Pickle/Mod/Pickle/Assemblies/` and staged by the companion mod
`ArchitectStudioPickleTests`. **Live**, played on 2026-09-21: 43 scenarios of 18 features, twice (11 mods, then 16).

Two things hold for every text below. The mod-specific ones start with `Architect Studio`, or name its groups and
categories, so none can clash with another suite. **A few are not prefixed** and are marked: two suites declaring
the same text make every scenario that uses it ambiguous, and Pickle refuses to pick.

## Dedicated to the mod: nobody else has a use for these

| Family | Where | What it does |
| --- | --- | --- |
| Groups (23 steps) | `GroupSteps.cs` | Create, fill, order, force a category on, delete and restore a *dropdown group* in the mod's editor, and read back what the Architect menu draws for it |
| Categories (16 steps) | `CategorySteps.cs` | Create, move, relabel, colour and delete an Architect category, and read the tab, its key binding category and the siblings' order |
| The mod's own wiring | `ModSteps.cs` | The access-check waiver and its startup probe, the mod's Architect button, its settings shortcut and reset, the height of the Architect window |

## Small, and worth a second look if another suite needs the same thing

| Steps | What they do, and what to know before copying |
| --- | --- |
| `I hide the interface around the windows on screen` / `I bring the interface back` (**unprefixed**) | Prepares a Workshop-page capture. Turns on the game's own screenshot mode (hides tab bar, alerts, colonist bar, dev tools), then **clears `drawInScreenshotMode` on every window of `RimWorks.Pickle*`**: a window draws in that mode unless told not to (it is `true` by default), so Pickle's runner panel would otherwise sit in a corner of every capture. Restores from an `[AfterScenario]` as well, so a scenario that dies between the two steps does not leave the game without its interface. **TailorMade Waistlines' history has the same two steps under the same text**: a second mod, and the reason to promote them, with a prefix. |
| `Architect Studio patched {string}` | Splits `Type::Member`, reads `Harmony.GetPatchInfo` and asserts the mod's Harmony id is among the owners, naming those it did find. **The same step as TailorMade's `... patched {string}`** with another name in front: a second mod. |
| `Architect Studio starts again from its settings file` | A restart in one process: writes the settings, reads the file, unwinds the runtime to the unmodded defs, writes the file back and replays it as the mod does at startup. It is the step that shows whether what a scenario did **survives being read back**: a deleted group that came back after a restart was found with it. It cannot reproduce a def database rebuilt from XML, so a full restart stays a manual check. Tied to the mod's classes; TailorMade's `the mod reads its settings file again` is the same idea. |
| `SettingsSandbox` (a `[BeforeScenario]` and an `[AfterScenario]`, no step text) | For a mod whose editor **writes its settings to disk on every action**: copies the settings file to a `.pickle-backup` **on disk** and starts each scenario from an empty configuration, restoring afterwards. A file and not a copy in memory, so that a game killed mid-scenario leaves the backup behind and the next scenario restores it rather than overwriting it with the test configuration. The idea holds for any mod with a settings file; the code is tied to this one's settings class. |
| `I click the Architect Studio button keyed {string}` | Clicks a button by the translation key its label comes from. Before it hovers, **waits up to 600 frames for any window with `absorbInputAroundWindow` to close**: such a window eats the click wherever it is drawn, so the button can be visible and unobstructed and the click still never arrive (a mod warming up at load did this, and failed the first click of the run). It then asks `WindowStack.GetWindowAt` what would receive the click and, if it is not the intended window, names the covering window and its assembly. **Overlaps `KeyedClick` and `ClickDiagnostics`**: the wait before the click is the part I did not find there. |
| `no Architect Studio button keyed {string} is drawn` | The labelled button is not in the frame. Tiny. |
| `I set the interface scale to {int} percent` | Sets `Prefs.UIScale` and lets the layout follow, restored from an `[AfterScenario]`. **Superseded by `InterfaceScale`'s `the interface scale is {int} percent`**, which is the maintained one. |
| `I open the keyboard configuration and let it draw` / `I scroll the keyboard configuration to the bottom` | Open `Dialog_KeyBindings`, let it draw, and scroll to the end, where a mod's generated key binding category sits. Useful to any mod that adds key bindings and wants a person to read them. |
| `research {string} is not finished` | Sets a research project as not finished. Small. `ResearchSteps` reads the research window; it does not set state. |
| `the game log holds nothing from Architect Studio since startup` | Fails on any log message containing `[Architect Studio]`. **It only sees what carries that prefix**: an uncaught exception, an error raised by Harmony or a game message *about* the mod would not, so it says "the mod logged nothing through its own channel", not "the log is clean". True today because every log call in the mod carries the prefix; nothing enforces that. |

## Not stepped

Removing the mod from a running game and checking that the Architect menu comes back. Nothing tests it.
