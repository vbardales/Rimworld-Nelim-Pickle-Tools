# Nelim's Eden Garden

Live: every step below is in the repository named, in the file named. Nothing here is staged from PickleTools with a
`path:` line: the assembly references the mod's own types, so a suite that wants a step **copies the method** and gives
it its own prefix.

Repository: `vbardales/Rimworld-Nelim-Eden-Garden` (private, in the monorepo, `EdenGarden/`).
Steps: `Tests/Pickle/Source/EdenGardenSteps.cs`, one class, 22 declarations (`INVENTORY.md`). The suite's own notes,
run by run, are in `Tests/Pickle/README.md`; the evidence is summarised in `docs/runs/README.md`.

All texts start with `Eden Garden: `, left out of the table below. Updated 2026-10-14.

## Small and generic, candidates to move if a second mod wants them

| Step | What it does | State | Why it stays | Move it when |
|---|---|---|---|---|
| `an open field near {string} is cleared and laid as fertile soil` | Finds the nearest rectangle to a colonist whose cells are standable, unroofed, free of impassable things and reachable, clears it and lays soil; every later "in the field" step is offset from it | played, runs of 2026-10-02 and after | the fixture is a desert with granite, and a rectangle by coordinates met rock (`Added zone over zone-incompatible thing Granite`) | a second suite needs open ground |
| `I create a growing zone of {string} in the field ...`, `a growing zone ... covers the field cell ...`, `I create a stockpile in the field ...`, `I build a {string} in the field at ...`, `I spawn a {string} in the field at ...` | Place a zone, a stockpile, a building and a thing by offsets in the field | played | thin wrappers over the field origin | the field step is promoted |
| `{string} works every hour of the day` | Sets all 24 hours of the colonist's timetable to Work | played 2026-10-12 (scenario 11 green) | Pickle has no timetable step | a second mod needs a colonist to work now. Found by a diagnostic run: the default timetable gives Joy hours and a pawn on a Joy hour looks for no work (`job=Play_Horseshoes`) |
| `{string} can sow at the field cell ...` | Asks the game's own `WorkGiver_GrowerSow` why it offers no job on a zone cell and names every condition (work type disabled, priority, zone, growth season, fertility, allowed area) | played, diagnostic | reads Growing only | a second mod asks why a colonist offers no job |
| `I wait for the bill {string} to leave the {string}` | Waits until the bill has gone from the table's bill stack (up to 3000 frames); on a timeout names the bill and what every colonist is doing and carrying. Added 2026-10-14 to replace Pickle's `I wait for bill ... to finish`, whose failure `no <product> was made; the map held 0 before and 0 after` hid the cause | not yet played | one table | another suite needs a wait on bill removal |
| `{string} has put down what it carries` | Waits until the colonist holds nothing (a thing in the hands is not in `listerThings`), and names the thing and the job when it never does | not yet played | one pawn | the same |
| `the stockpile holds the ingredients of {string}`, `the products of {string} are on the map`, `nothing of the ingredients of {string} is left` | Read a `RecipeDef`'s ingredients and products from the loaded def, because the compatibility layer rewrites the recipes at load. The products assertion also lists what each colonist does and carries | played | the recipes are this mod's runtime patch | a second mod patches recipes at load |

## Dedicated to this mod, no reuse expected outside it

| Step | What it does | State |
|---|---|---|
| `the plant {string} is sowable`, `is not sowable` | Read `PlantProperties.Sowable` of a retired or live plant | played |
| `the plant in the field at ... draws art from {string}`, `is grown to {float}`, `I move the camera to the field cell ...`, `I wait {int} frames` | Mature-graphics checks: grow a plant, frame the camera, wait rendered frames (the zoom eases over frames) | played 2026-10-11 (09, five scenarios) |
| `opens its options window`, `sees its own options window open`, `options window lists at least {int} plants` | Open and read the mod's options window | played |

## Known pitfalls (found in this suite)

- `I wait for bill "X" to finish` (Pickle's own step) can fail with `no <product> was made; the map held 0 before and 0 after`
  while the screen shows "Bill complete": four of eight bills of feature 13 on 2026-10-13. The cause was open on 2026-10-14;
  the two steps above are the diagnostic. Check `docs/runs/README.md` for the result before relying on that step for a bill
  whose product a colonist hauls.
- A colonist on a Joy hour does not look for work: set the timetable before waiting for any job.
- `-EvidenceDir` is relative to the mod, not to the monorepo root.
