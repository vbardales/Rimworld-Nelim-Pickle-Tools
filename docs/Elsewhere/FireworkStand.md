# Firework Stand

Live: every step below in repo named, file named. Nothing staged from PickleTools with `path:` line: suite wanting step **copies method**, gives own prefix.

Repository: `vbardales/Rimworld-Firework-Stand` (in monorepo, `FireworkStand/`).
Steps: `Tests/Pickle/Source/FireworkStandSteps.cs`, one class, 28 steps, built by
`Tests/Pickle/Source/FireworkStand.PickleSteps.csproj` into `Tests/Pickle/Mod/Pickle/Assemblies/` (committed: staging mirrors that folder). Assembly references game and Pickle only, not mod under test: stand found by defName, fuel and light through vanilla `CompRefuelable` and `CompGlower`, so mod-side rename fails scenario with name it looked for, not fails to load suite. Suite notes in `Tests/Pickle/README.md`; passes needed in `TESTING.md`.

All texts start with `Firework Stand: `, left out of table below. Every waiting step is `async Task`, awaits.

Played once, in French, 2026-09-21: 21 of 21 scenarios green, five films, sixteen stills opened
(`docs/runs/2026-09-21-french-full.md`, text summary; evidence stays on disk, out of git). **Not yet played in English**: lost run lost report before read, suite changed after.

## What another suite may want

| Step | What it reads or does | Generic? |
| --- | --- | --- |
| `{string} is bored` | Sets pawn `Joy` need to 5 percent. Fixture colonist arrives with full joy bar; any recreation job ends via `JoyUtility.JoyTickCheckEnd` once full. | **Yes, and duplicated**: `Drum Bath Hygiene: {string} is bored` (`DrumBathHygiene/Tests/Pickle/Source/DrumBathHygieneSteps.cs`) same trap at 10 percent. One should become tool. |
| `{string} is placed at x={int} z={int}` | `Pawn.Position` and `Notify_Teleported`, stage pawn without testing walk. | **Yes.** |
| `the cells from x={int} z={int} to x={int} z={int} are roofed` | `RoofGrid.SetRoof(cell, RoofDefOf.RoofConstructed)` over rectangle of open ground. Builds no walls, says nothing about rooms. | **Yes.** |
| `{string} is told to stay where they stand` | Real `Wait` job, ordered, 9000 ticks, so bystander stays where scenario put it when something happens. | **Yes.** |
| `a bed stands at x={int} z={int}` | Spawns wooden `Bed`. | **Yes.** |
| `{string} is ordered to sleep in the bed at x={int} z={int}` | Real `LayDown` job with `forceSleep`, pawn walks over, sleeps whatever hour, however rested. | **Yes.** |
| `{string} is asleep` | Waits up to 60 s for `!Pawn.Awake()`; on failure prints job, driver, position. | **Yes**, for any mod whose effect depends on pawn asleep. |
| `the stand at x={int} z={int} is loaded with {int} launchers`, `... holds {int} launchers`, `... comes to hold {int} launchers within {int} seconds` | `CompRefuelable`: empties then `Refuel(N)`; reads `Fuel` rounded; waits for it. | Half. Pattern fits any refuelable building; texts and `FS_FireworkStand` are mod's. Drum Bath Hygiene has same calls (`the drum ... is burning`). |
| `the light of the stand at x={int} z={int} is off`, `... comes on within {int} seconds`, `... goes off within {int} seconds` | `CompGlower.Glows`, flag light grid driven by, so asserts light, not mod's own bookkeeping. | Half. Fits any building whose light a comp switches. |
| `I select the stand at x={int} z={int}` | `Selector.Select` on building at cell, then opens inspect pane. No translated label, so scenario runs unchanged in any language. | **Yes, and duplicated**: `I select the tree at x=.. z=..` in `AnimaSong/Tests/Pickle/Source/AnimaSongSteps.cs` same by-cell selection. Pickle `I select {string}` is by label, so neither uses it. |
| `I select the {string} at x={int} z={int}` | Same by-cell selection for any def, by def name. `I select the stand at ...` calls it. | **Yes.** |
| `the label of the {word} {string} reads {string} in English and {string} in French` | Reads `LanguageDatabase.activeLanguage`, compares def `label` with value written for THAT language, failing (naming language) in any other. One scenario green in English pass and French pass, no tag skipping it: what workflow's "no `@wip`, every conditional scenario played" gate asks. | **Yes**, for any mod with English and French labels. See folder-name trap below. |
| `the research {string} is unfinished` | Sets project progress to 0 via private `ResearchManager.progress` dictionary (reflection), so check that building hidden until research done runs on colony that truly has not finished it. | **Yes.** |
| `the Architect menu lists the stand`, `... hides the stand`, `I open the Architect category of the stand` | Reads `Designator_Build.Visible` on build designator held by stand's `DesignationCategoryDef` (research, tech level, place workers), opens Architect tab on that category via `MainTabWindow_Architect.selectedDesPanel`, by def not translated label. | Half. Pattern fits any building; def name is mod's. |

## Specific, do not look here

| Step | What it reads or does |
| --- | --- |
| `{string} is ordered to watch the stand at x={int} z={int}` | Orders mod's `FS_WatchFireworks` job on cell `WatchBuildingUtility.TryFindBestWatchCell` picks, as `JoyGiver_WatchBuilding` would. Idea, "order job a joy giver would give", travels; JobDef and building are mod's. |
| `{string} is watching the stand at x={int} z={int}` | Mod's job running on that stand, pawn on watch cell; trace of every job change printed on failure. |
| `{string} stands between {int} and {int} cells from the stand at x={int} z={int}, with no chair` | Distance from stand, empty `job.targetC`. |
| `{string} does not watch any stand` | Pawn's current job not mod's. |
| `the launcher at x={int} z={int} offers its launch gizmo exactly when Ideology is inactive` | Fireworks-specific: reads launcher item's `CompLaunchFireworks.CompGetGizmosExtra` for `Command_Action` labelled with translation of `LaunchFirework`, compares with game's own answer about Ideology. |
| `{string} has a fireworks memory`, `{string} has no fireworks memory` | Any of four `ThoughtDef`s Fireworks declares (`TerribleFireworks`, `UnimpressiveFireworks`, `BeautifulFireworks`, `UnforgettableFireworks`) among pawn's memories; prints awake, roofed, position on failure. |

## Things that took no step, and things this suite learned

- **Screenshot taken while film recording is polluted**: film's own 480x270 frame lands in still corner (six of sixteen stills in French run). `FilmTicks/` films between two steps, does not use `@film`.
- **`void` step calling method returning Task and discarding it never waits, never fails.** Drum Bath Hygiene suite went green over wrong picture three runs in a row for that reason.
- **Vanilla `JoyGiver_WatchBuilding` never reads fuel** (read from compiled game, 2026-09-21): empty building of that kind still offered as recreation, driver's joy tick does not ask building either. Any mod guarding watched building's effect, not its joy, has same gap.
- **`I select "<label>"` is language-dependent**; suite meant to run in two languages unchanged cannot use it.
- **Core language folders named "English" and "French (Français)".** `LanguageDatabase.activeLanguage.folderName` is that full name, not "French": comparison with `"French"` never matches, first version of label step did exactly that (caught in review, before run). Use `folderName == "English"` or `StartsWith("French (")`. Launcher prints same full name when staging French pass.
- **Launch gizmo of Fireworks read from its comp** (`CompLaunchFireworks.CompGetGizmosExtra`, yields nothing when `ModsConfig.IdeologyActive`), and scenario asserting "offered exactly when Ideology is inactive" runs in both default pass and pass whose map leaves DLC out (`!ludeon.rimworld.ideology`), asserting opposite in each.
- **Fleck has no `def` to read.** Step counting puffs of mod's own fleck near building reads `FleckThrown`'s `baseData` (`FleckCreationData.def`) by reflection: asking fleck for `def` fails to compile, matching by fleck's class counts every fleck. First version of smoke step counted nothing for that reason, went red on smoke that was there (2026-09-24). Firework Stand smoke step counts `FS_FuseSmoke` within 2.5 cells.
- **Gallery is scenario, not side effect of tests.** `14-gallery.feature` mounts staged scene (ScreenshotStudio's fixture, ClearScreen) through `-DepMap`, tagged `@requires:<the tool>`, played by own pass (`vitrine`); every picture taken with camera all the way in, cropped afterwards. Asserts only what makes picture worth keeping, and wait step guarding picture prints state it waited on (here stand's shot tick, fuse, wanted light, `CompGlower.Glows`, game tick and speed), because red with only "never came on" cost three runs.