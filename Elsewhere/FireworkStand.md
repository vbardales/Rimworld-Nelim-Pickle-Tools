# Firework Stand

Live: every step below is in the repository named, in the file named. Nothing here is staged from PickleTools with a
`path:` line: a suite that wants a step **copies the method** and gives it its own prefix.

Repository: `vbardales/Rimworld-Firework-Stand` (in the monorepo, `FireworkStand/`).
Steps: `Tests/Pickle/Source/FireworkStandSteps.cs`, one class, 20 steps, built by
`Tests/Pickle/Source/FireworkStand.PickleSteps.csproj` into `Tests/Pickle/Mod/Pickle/Assemblies/` (committed: the
staging mirrors that folder). The assembly references the game and Pickle only, not the mod under test: the stand is
found by its defName, its fuel and its light through vanilla's `CompRefuelable` and `CompGlower`, so a rename on the
mod's side fails a scenario with the name it looked for instead of failing to load the suite. The suite's own notes are
in `Tests/Pickle/README.md`; the passes it needs are in `TESTING.md`.

All texts start with `Firework Stand: `, left out of the table below. Every waiting step is `async Task` and awaits.

Played once, in French, 2026-09-21: 21 of 21 scenarios green, five films and sixteen stills opened
(`Tests/Pickle/runs/2026-09-21-french-full/`). **Not yet played in English**: the run that was lost its report before
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

## Specific, do not look here

| Step | What it reads or does |
| --- | --- |
| `{string} is ordered to watch the stand at x={int} z={int}` | Orders the mod's `FS_WatchFireworks` job on the cell `WatchBuildingUtility.TryFindBestWatchCell` picks, as `JoyGiver_WatchBuilding` would. The idea, "order the job a joy giver would give", travels; the JobDef and the building are the mod's. |
| `{string} is watching the stand at x={int} z={int}` | The mod's job is running on that stand with the pawn on the watch cell; a trace of every change of job is printed on failure. |
| `{string} stands between {int} and {int} cells from the stand at x={int} z={int}, with no chair` | Distance from the stand, and an empty `job.targetC`. |
| `{string} does not watch any stand` | The pawn's current job is not the mod's. |
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
