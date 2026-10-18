# Architect Studio

Repository `ArchitectStudio` (`nelim.architectstudio`), suite under `Tests/Pickle/`: steps in
`Tests/Pickle/Source/` (`ModSteps.cs`, `GroupSteps.cs`, `CategorySteps.cs`, `RestartSteps.cs`, `UnsortedSteps.cs`, `SettingsSandbox.cs`, `Driver.cs`), built by
`ArchitectStudio.PickleSteps.csproj` into `Tests/Pickle/Mod/Pickle/Assemblies/`, staged by companion mod
`ArchitectStudioPickleTests`. **Live**, last full pass 2026-10-09 on 1.0.7: 69 scenarios, 22 features, English and French, five staged mod lists (minimal, optionals, reviews, RIMMSQOL, restart).

Two things hold for every text below. Mod-specific ones start with `Architect Studio`, or name its groups and
categories, so none clash with another suite. **A few not prefixed**, marked: two suites declaring
same text make every scenario using it ambiguous, Pickle refuses to pick.

## Dedicated to the mod: nobody else has a use for these

| Family | Where | What it does |
| --- | --- | --- |
| Groups (33 steps) | `GroupSteps.cs` | Create, fill, order, force category on, delete, restore *dropdown group* in mod's editor, read back what Architect menu draws for it |
| Categories (30 steps, parent row included: create or move category under parent, read parent back) | `CategorySteps.cs` | Create, move, relabel, colour, delete Architect category, read tab, its key binding category, siblings' order |
| The mod's own wiring (25 steps) | `ModSteps.cs` | Access-check waiver and startup probe, mod's Architect button, settings shortcut and reset, Architect window height |
| A real restart (4 steps) | `RestartSteps.cs` | Two game launches under one lock hold (`-Then`): first configures mod, keeps result on disk with marker, second is new process checking whole Architect menu against it. Played only where empty switch mod `nelim.architectstudio.restartpass` staged (`@requires`). If chain cut, next run puts player's file back from backup |
| The Unsorted tab (8 steps, 1.1.0) | `UnsortedSteps.cs` | Switch vanilla building's default designator off for one scenario, turn opt-in tab on or off, read what tab offers, what no other tab offers, count category editor shows. All texts name Unsorted tab or Architect designator, none generic |

## Small, and worth a second look if another suite needs the same thing

| Steps | What they do, what to know before copying |
| --- | --- |
| `I hide the interface around the windows on screen` / `I bring the interface back` (**unprefixed**) | Prepares Workshop-page capture. Turns on game's own screenshot mode (hides tab bar, alerts, colonist bar, dev tools), then **clears `drawInScreenshotMode` on every window of `RimWorks.Pickle*`**: window draws in that mode unless told not to (`true` by default), so Pickle's runner panel would otherwise sit in corner of every capture. Restores from `[AfterScenario]` too, so scenario dying between the two steps does not leave game without interface. **TailorMade Waistlines' history has same two steps under same text**: second mod, reason to promote them, with prefix. |
| `Architect Studio patched {string}` | Splits `Type::Member`, reads `Harmony.GetPatchInfo`, asserts mod's Harmony id among owners, naming those found. **Same step as TailorMade's `... patched {string}`** with other name in front: second mod. |
| `Architect Studio starts again from its settings file` | Restart in one process: writes settings, reads file, unwinds runtime to unmodded defs, writes file back, replays it as mod does at startup. Step showing whether what scenario did **survives being read back**: deleted group that came back after restart found with it. Cannot reproduce def database rebuilt from XML, so full restart stays manual check. Tied to mod's classes; TailorMade's `the mod reads its settings file again` same idea. |
| `SettingsSandbox` (`[BeforeScenario]` and `[AfterScenario]`, no step text) | For mod whose editor **writes settings to disk on every action**: copies settings file to `.pickle-backup` **on disk**, starts each scenario from empty configuration, restores afterwards. File not in-memory copy, so game killed mid-scenario leaves backup behind and next scenario restores it rather than overwriting with test configuration. Idea holds for any mod with settings file; code tied to this one's settings class. |
| `I click the Architect Studio button keyed {string}` | Clicks button by translation key its label comes from. Before hover, **waits up to 600 frames for any window with `absorbInputAroundWindow` to close**: such window eats click wherever drawn, so button can be visible, unobstructed, click still never arrive (mod warming up at load did this, failed first click of run). Then asks `WindowStack.GetWindowAt` what would receive click, if not intended window, names covering window and its assembly. **Overlaps `KeyedClick` and `ClickDiagnostics`**: wait before click is part I did not find there. |
| `no Architect Studio button keyed {string} is drawn` | Labelled button not in frame. Tiny. |
| `I set the interface scale to {int} percent` | Sets `Prefs.UIScale`, lets layout follow, restored from `[AfterScenario]`. **Superseded by `InterfaceScale`'s `the interface scale is {int} percent`**, the maintained one. |
| `I open the keyboard configuration and let it draw` / `I scroll the keyboard configuration to the bottom` | Open `Dialog_KeyBindings`, let it draw, scroll to end, where mod's generated key binding category sits. Useful to any mod adding key bindings wanting person to read them. |
| `research {string} is not finished` | Sets research project as not finished. Small. `ResearchSteps` reads research window; does not set state. |
| `the game log holds nothing from Architect Studio since startup` | Fails on any log message containing `[Architect Studio]`. **Only sees what carries that prefix**: uncaught exception, error raised by Harmony or game message *about* mod would not, so it says "mod logged nothing through its own channel", not "log is clean". True today because every log call in mod carries prefix; nothing enforces that. |
| `HideTabSteps` (declared 2026-10-18 by ArchitectStudio session, `Tests/Pickle/Source/HideTabSteps.cs`): `I hide the Architect tab {string}`, `I show the Architect tab {string} again`, `the Architect menu shows / does not show the tab {string}`, `the building {string} still exists and is buildable by the player`, `the editor lists the tab {string} as hidden`, `the Unsorted tab does not offer the buildings of the tab {string}` (**unprefixed**) | Hiding whole Architect tab through mod's `CategoryVisibilityRuntime`; tied to mod's classes. One consumer, no promotion. |
| `UnsortedSteps` (same declaration, `UnsortedSteps.cs`): `the building {string} has its default Architect designator switched off` and `[AfterScenario]` putting flags back | Switches vanilla building's default designator off for one scenario, rebuilds its tab, to make orphan for optional Unsorted tab. Tied to mod's classes. |
| `I show the Architect menu on the tab {string}` (**unprefixed**, declared 2026-10-18 by the ArchitectStudio session, `Tests/Pickle/Source/CategorySteps.cs`, method `ShowArchitectOnTab`, ArchitectStudio commit a4c40de) | Opens the Architect window on a tab named by its `DesignationCategoryDef` defName (for example `Structure`, `Furniture`, `Unsorted`), so a capture shows the whole bottom bar. Tied to the internals of `MainTabWindow_Architect`; one consumer so far, no promotion. User: `26-building-catalogue.feature` (a Scenario Outline, one screenshot "architect tab <tab>" per tab, 14 photographs: the 13 vanilla and DLC tabs with buildings plus Unsorted), the building catalogue sheets of PickleTools. Needs the DLCs staged, else the step fails "no Architect category named X". Not played. |

## Not stepped

Removing mod from running game, checking Architect menu comes back. Nothing tests it.