# Nelim's Eden Garden

Live: every step below in repo named, file named. Nothing staged from PickleTools with `path:` line: assembly references mod's own types, so suite wanting a step **copies method**, gives own prefix.

Repository: `vbardales/Rimworld-Nelim-Eden-Garden` (private, in monorepo, `EdenGarden/`).
Steps: `Tests/Pickle/Source/EdenGardenSteps.cs`, one class, 22 declarations (`INVENTORY.md`). Suite's own notes, run by run, in `Tests/Pickle/README.md`; evidence summarised in `docs/runs/README.md`.

All texts start with `Eden Garden: `, left out of table below. Updated 2026-10-14.

## Small and generic, candidates to move if a second mod wants them

| Step | What it does | State | Why it stays | Move it when |
|---|---|---|---|---|
| `an open field near {string} is cleared and laid as fertile soil` | Finds nearest rectangle to colonist whose cells standable, unroofed, free of impassable things, reachable; clears it, lays soil; every later "in the field" step offset from it | played, runs of 2026-10-02 and after | fixture is desert with granite, rectangle by coordinates met rock (`Added zone over zone-incompatible thing Granite`) | second suite needs open ground |
| `I create a growing zone of {string} in the field ...`, `a growing zone ... covers the field cell ...`, `I create a stockpile in the field ...`, `I build a {string} in the field at ...`, `I spawn a {string} in the field at ...` | Place zone, stockpile, building, thing by offsets in field | played | thin wrappers over field origin | field step promoted |
| `{string} works every hour of the day` | Sets all 24 hours of colonist's timetable to Work | played 2026-10-12 (scenario 11 green) | Pickle has no timetable step | second mod needs colonist working now. Found by diagnostic run: default timetable gives Joy hours, pawn on Joy hour looks for no work (`job=Play_Horseshoes`) |
| `{string} can sow at the field cell ...` | Asks game's own `WorkGiver_GrowerSow` why it offers no job on zone cell, names every condition (work type disabled, priority, zone, growth season, fertility, allowed area) | played, diagnostic | reads Growing only | second mod asks why colonist offers no job |
| `I wait for the bill {string} to leave the {string}` | Waits until bill gone from table's bill stack (up to 3000 frames); on timeout names bill and what every colonist does and carries. Added 2026-10-14 to replace Pickle's `I wait for bill ... to finish`, whose failure `no <product> was made; the map held 0 before and 0 after` hid cause | not yet played | one table | another suite needs wait on bill removal |
| `{string} has put down what it carries` | Waits until colonist holds nothing (thing in hands not in `listerThings`), names thing and job when never does | not yet played | one pawn | same |
| `the stockpile holds the ingredients of {string}`, `the products of {string} are on the map`, `nothing of the ingredients of {string} is left` | Read `RecipeDef`'s ingredients and products from loaded def, because compatibility layer rewrites recipes at load. Products assertion also lists what each colonist does and carries | played | recipes are this mod's runtime patch | second mod patches recipes at load |

## Dedicated to this mod, no reuse expected outside it

| Step | What it does | State |
|---|---|---|
| `the plant {string} is sowable`, `is not sowable` | Read `PlantProperties.Sowable` of retired or live plant | played |
| `the plant in the field at ... draws art from {string}`, `is grown to {float}`, `I move the camera to the field cell ...`, `I wait {int} frames` | Mature-graphics checks: grow plant, frame camera, wait rendered frames (zoom eases over frames) | played 2026-10-11 (09, five scenarios) |
| `opens its options window`, `sees its own options window open`, `options window lists at least {int} plants` | Open and read mod's options window | played |

## Known pitfalls (found in this suite)

- `I wait for bill "X" to finish` (Pickle's own step) can fail with `no <product> was made; the map held 0 before and 0 after` while screen shows "Bill complete": four of eight bills of feature 13 on 2026-10-13. Cause open on 2026-10-14; two steps above are the diagnostic. Check `docs/runs/README.md` for result before relying on that step for bill whose product colonist hauls.
- Colonist on Joy hour does not look for work: set timetable before waiting for any job.
- `-EvidenceDir` relative to mod, not monorepo root.