# Firework Stand

Live: every step below is in the repository named, in the file named. Nothing here is staged from PickleTools with a
`path:` line: a suite that wants a step **copies the method** and gives it its own prefix.

Repository: `vbardales/Rimworld-Firework-Stand` (in the monorepo, `FireworkStand/`).
Steps: `Tests/Pickle/Source/FireworkStandSteps.cs`, one class, 28 steps, built by
`Tests/Pickle/Source/FireworkStand.PickleSteps.csproj` into `Tests/Pickle/Mod/Pickle/Assemblies/` (committed: the
staging mirrors that folder). The assembly references the game and Pickle only, not the mod under test: the stand is
found by its defName, its fuel and its light through vanilla's `CompRefuelable` and `CompGlower`, so a rename on the
mod's side fails a scenario with the name it looked for instead of failing to load the suite. The suite's own notes are
in `Tests/Pickle/README.md`; the passes it needs are in `TESTING.md`.

All texts start with `Firework Stand: `, left out of the table below. Every waiting step is `async Task` and awaits.

Played once, in French, 2026-09-21: 21 of 21 scenarios green, five films and sixteen stills opened
(`docs/runs/2026-09-21-french-full.md`, a text summary; the evidence stays on disk and out of git). **Not yet played in English**: the run that was lost its report before
it was read, and the suite changed after.

## What another suite may want

| Step | What it reads or does | Generic? |
| --- | --- | --- |
| `{string} is bored` | Sets the pawn's `Joy` need to 5 percent. A fixture colonist arrives with a full joy bar, and any recreation job ends through `JoyUtility.JoyTickCheckEnd` the moment it is full. | **Yes, and duplicated**: `Drum Bath Hygiene: {string} is bored` (`DrumBathHygiene/Tests/Pickle/Source/DrumBathHygieneSteps.cs`) is the same trap at 10 percent. One of them should become a tool. |
| `{string} is placed at x={int} z={int}` | `Pawn.Position` and `Notify_Teleported`, to stage a pawn without testing the walk. | **Yes.** |
| `the cells from x={int} z={int} to x={int} z={int} are roofed` | `RoofGrid.SetRoof(cell, RoofDefOf.RoofConstructed)` over a rectangle of open ground. It builds no walls, so it says nothing about rooms. | **Yes.** |
| `{string} is told to stay where they stand` | The real `Wait` job, ordered, 9000 ticks, so a bystander is where the scenario put it when something happens. | **Yes.** |
| `a bed stands at x={int} z={int}` | Spawns a wooden `Bed`. | **Yes.** |
| `{string} is ordered to sleep in the bed at x={int} z={int}` | The real `LayDown` job with `forceSleep`, so the pawn walks over and sleeps whatever the hour and however rested. | **Yes.** |
| `{string} is asleep` | Waits up to 60 s for `!Pawn.Awake()`; on failure prints the job, the driver and the position. | **Yes**, for any mod whose effect depends on a pawn being asleep. |
| `the stand at x={int} z={int} is loaded with {int} launchers`, `... holds {int} launchers`, `... comes to hold {int} launchers within {int} seconds` | `CompRefuelable`: empties then `Refuel(N)`; reads `Fuel` rounded; waits for it. | Half. The pattern fits any refuelable building; the texts and `FS_FireworkStand` are the mod's. Drum Bath Hygiene has the same calls (`the drum ... is burning`). |
| `the light of the stand at x={int} z={int} is off`, `... comes on within {int} seconds`, `... goes off within {int} seconds` | `CompGlower.Glows`, the flag the light grid is driven by, so it asserts the light and not the mod's own bookkeeping. | Half. Fits any building whose light a comp switches. |
| `I select the stand at x={int} z={int}` | `Selector.Select` on the building at a cell, then opens the inspect pane. No translated label, so a scenario runs unchanged in any language. | **Yes, and duplicated**: `I select the tree at x=.. z=..` in `AnimaSong/Tests/Pickle/Source/AnimaSongSteps.cs` is the same by-cell selection. Pickle's `I select {string}` is by label, which is why neither uses it. |
| `I select the {string} at x={int} z={int}` | The same by-cell selection for any def, by def name. `I select the stand at ...` calls it. | **Yes.** |
| `the label of the {word} {string} reads {string} in English and {string} in French` | Reads `LanguageDatabase.activeLanguage` and compares the def's `label` with the value written for THAT language, failing (naming the language) in any other. One scenario is then green in the English pass and in the French pass, with no tag that skips it: what the workflow's "no `@wip`, every conditional scenario played" gate asks. | **Yes**, for any mod with English and French labels. See the folder-name trap below. |
| `the research {string} is unfinished` | Sets the project's progress to 0 through the private `ResearchManager.progress` dictionary (reflection), so a check that a building is hidden until its research is done runs on a colony that really has not finished it. | **Yes.** |
| `the Architect menu lists the stand`, `... hides the stand`, `I open the Architect category of the stand` | Reads `Designator_Build.Visible` on the build designator held by the stand's `DesignationCategoryDef` (research, tech level, place workers), and opens the Architect tab on that category through `MainTabWindow_Architect.selectedDesPanel`, by def and not by translated label. | Half. The pattern fits any building; the def name is the mod's. |

## Specific, do not look here

| Step | What it reads or does |
| --- | --- |
| `{string} is ordered to watch the stand at x={int} z={int}` | Orders the mod's `FS_WatchFireworks` job on the cell `WatchBuildingUtility.TryFindBestWatchCell` picks, as `JoyGiver_WatchBuilding` would. The idea, "order the job a joy giver would give", travels; the JobDef and the building are the mod's. |
| `{string} is watching the stand at x={int} z={int}` | The mod's job is running on that stand with the pawn on the watch cell; a trace of every change of job is printed on failure. |
| `{string} stands between {int} and {int} cells from the stand at x={int} z={int}, with no chair` | Distance from the stand, and an empty `job.targetC`. |
| `{string} does not watch any stand` | The pawn's current job is not the mod's. |
| `the launcher at x={int} z={int} offers its launch gizmo exactly when Ideology is inactive` | Fireworks-specific: reads the launcher item's `CompLaunchFireworks.CompGetGizmosExtra` for a `Command_Action` labelled with the translation of `LaunchFirework`, and compares with the game's own answer about Ideology. |
| `{string} has a fireworks memory`, `{string} has no fireworks memory` | Any of the four `ThoughtDef`s Fireworks declares (`TerribleFireworks`, `UnimpressiveFireworks`, `BeautifulFireworks`, `UnforgettableFireworks`) among the pawn's memories; prints awake, roofed and position on failure. |

## Things that took no step, and things this suite learned

- **A screenshot taken while a film is recording is polluted**: the film's own 480x270 frame lands in the corner of the
  still (six of sixteen stills in the French run). `FilmTicks/` films between two steps and does not use `@film`.
- **A `void` step that calls a method returning a Task and discards it never waits and never fails.** Drum Bath
  Hygiene's suite went green over the wrong picture three runs in a row for that reason.
- **Vanilla's `JoyGiver_WatchBuilding` never reads fuel** (read from the compiled game, 2026-09-21): an empty building
  of that kind is still offered as recreation, and the driver's joy tick does not ask the building either. Any mod that
  guards a watched building's effect and not its joy has the same gap.
- **`I select "<label>"` is language-dependent**, and a suite meant to run in two languages unchanged cannot use it.
- **Core's language folders are named "English" and "French (Français)".** `LanguageDatabase.activeLanguage.folderName`
  is that full name, not "French": a comparison with `"French"` never matches, and the first version of the label step
  did exactly that (caught in review, before a run). Use `folderName == "English"` or `StartsWith("French (")`. The
  launcher prints the same full name when it stages a French pass.
- **The launch gizmo of Fireworks is read from its comp** (`CompLaunchFireworks.CompGetGizmosExtra`, which yields nothing
  when `ModsConfig.IdeologyActive`), and a scenario that asserts "offered exactly when Ideology is inactive" runs in both
  the default pass and a pass whose map leaves the DLC out (`!ludeon.rimworld.ideology`), asserting the opposite in each.
- **A fleck has no `def` to read.** A step that counts the puffs of a mod's own fleck near a building reads `FleckThrown`'s
  `baseData` (`FleckCreationData.def`) by reflection: asking the fleck for `def` fails to compile, and matching by the
  fleck's class counts every fleck. The first version of the smoke step counted nothing for that reason and went red on a
  smoke that was there (2026-09-24). Firework Stand's smoke step counts `FS_FuseSmoke` within 2.5 cells.
- **A gallery is a scenario, not a side effect of the tests.** `14-gallery.feature` mounts a staged scene (ScreenshotStudio's
  fixture, ClearScreen) through a `-DepMap`, is tagged `@requires:<the tool>` and is played by a pass of its own (`vitrine`);
  every picture is taken with the camera all the way in and cropped afterwards. It asserts only what makes a picture worth
  keeping, and a wait step that guards a picture prints the state it waited on (here the stand's shot tick, fuse, wanted light,
  `CompGlower.Glows`, game tick and speed), because a red with only "never came on" cost three runs.
