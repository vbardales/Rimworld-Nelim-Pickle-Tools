# Ideology steps - Pickle steps (shared)

Steps that build, in the loaded game, the scene an Ideology-aware mod needs to test: an ideoligion made of chosen memes and
precepts, a colonist of another faith, a prison cell with a restrained prisoner, and the readings that tell what the game did with
them. Requested on 2026-10-01 by the Ancient Salvage session (scenarios 15, 16, 17.1 and 18 of its `TESTING.md`); nothing here goes
to Pickle upstream.

**NOT PLAYED.** The steps compile against the game's 1.6 reference assemblies and their patterns pass `Check-Steps.ps1`. No game has
run them: the queue held 46 requests and the machine was paused on 2026-10-01, so `Tests/Pickle/.../pickletools-ideologysteps.feature`
(one scenario per set of steps) has not been played. Until it has, treat every row below as written, not verified.

Every step needs the Ideology DLC and fails saying so otherwise; a scenario tags itself `@requires:Ludeon.RimWorld.Ideology`.

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the colony adopts an ideoligion with the memes {string} and the precepts {string}` | Builds an `Ideo` from the memes (comma-separated `MemeDef` names) and the precepts (comma-separated `PreceptDef` names, added to the ones the memes require), gives it to every free colonist and makes it the primary ideoligion of the player faction. |
| `Nelim's Pickle Tools: the colonist {string} follows an ideoligion with the precepts {string}` | Gives one pawn (a colonist or a prisoner) an ideoligion of its own: the memes of the colony's primary ideoligion plus those precepts. Fails if that changes the colony's primary ideoligion. |
| `Nelim's Pickle Tools: the colonist {string} follows an ideoligion with the memes {string} and the precepts {string}` | The same for a faith whose memes differ from the colony's. Not in the request; added because the precepts alone cannot express a different meme set. |
| `Nelim's Pickle Tools: the colony ideoligion has the precept {string}` / `... does not have the precept {string}` | Assertions on the primary ideoligion of the colony. |
| `Nelim's Pickle Tools: the colonist {string} has the precept {string}` | Assertion on the ideoligion that pawn follows. |
| `Nelim's Pickle Tools: a prison cell is built at \({int}, {int}\) with a bed and a door` | Walls around a 3 by 3 inside whose south-west cell is (x, z), a door in the middle of the south wall, a prisoner bed, a roof; waits for the game to class the room as a prison cell. |
| `Nelim's Pickle Tools: a prisoner {string} exists in the cell at \({int}, {int}\), in restraints` / `..., not in restraints` | Spawns a prisoner of the colony, assigns the bed, and reads `RestraintsUtility.InRestraints` back. The second form releases the prisoner to roam: the negative control. |
| `Nelim's Pickle Tools: the prisoner {string} interaction mode is {string}` | Sets the exclusive mode by `PrisonerInteractionModeDef` name and reads it back. |
| `Nelim's Pickle Tools: the colonist {string} has the work type {string} enabled` / `... disabled` | One work type, the others untouched. |
| `Nelim's Pickle Tools: the prisoner {string} is offered the interaction mode {string}` / `... is not offered ...` | Whether the prisoner tab lists the mode, by the game's own test (see below). |
| `Nelim's Pickle Tools: a message {string} appeared` | A message posted since the scenario began whose text is the translation of the key. |
| `Nelim's Pickle Tools: the colonist {string} is doing the job {string}` | The `JobDef` the colonist is on now, waiting up to 30 seconds. |

Each failure says the state it found. `docs/steps.md` lists them all, generated from the sources.

## What to know before relying on a step

- **The ideoligion is the game's.** `IdeoGenerator.GenerateIdeo` makes it, the memes are then trimmed to the ones asked for, and
  `IdeoFoundation.EnsurePreceptsCompatibleWithMemes` and `IdeoFoundation.CanAdd` (the editor's own tests) decide what stays and what is
  refused. A refusal fails the step with the game's reason. An issue keeps one precept (the new one replaces the old), except rituals,
  roles and buildings, which are added. Nothing is saved: the ideoligion lives in the loaded game.
- **Few colonists, fragile majority.** The game recomputes a colony's primary ideoligion from its colonists. The step that gives one
  colonist another faith fails, saying so, if the colony's primary ideoligion changed. `test-colony` has three colonists, so one convert holds.
- **The cell is a fixed shape.** 5 by 5 outside, 3 by 3 inside. It fails naming the first blocked cell (outside the map, terrain that
  cannot carry a wall, a building, a pawn or an item); plants and filth in the way are cleared. `docs/FIXTURES.md` gives free origins of
  `test-colony`; its terrain was never decoded, so a free origin can still fail here.
- **"In restraints" is the game's definition.** `RestraintsUtility.InRestraints` is true for a spawned prisoner of the colony who is not
  released and not a slave. There is no restraint item to equip.
- **"Offered" calls the game's own test by reflection.** The prisoner tab filters its rows with a local function of `DoPrisonerTab`, which
  the compiler turns into a method of a nested closure class. The step finds it by the name `CanUsePrisonerInteractionMode`, hands it a
  closure with `wildMan` and a tab, and fails saying what changed if the shape is not what it expects. **This is fragile across game
  versions** (read from the 1.6.4871 reference on 2026-10-01); it is the price of not copying the test.
- **Messages are compared by key.** The text between the placeholders of the key's translation must appear in the message, in order.
  A message the game was asked to show counts even if it then dropped it as a duplicate. Only messages after the scenario started are seen.
- **The interaction mode is set on the field the tab sets** (`Pawn_GuestTracker.interactionMode`, private, reached by reflection) and not
  through the tab, so the tab's warnings (for instance that no warden can enslave) do not fire.

## Using it from a suite

```
nelim.pickletools.ideologysteps   path:PickleTools/IdeologySteps/Mod
```

in a pass map of `Tests/Pickle/`, after Ideology. The tool is **not in the Workshop bundle** (`Mod/Pickle/Assemblies`): it is a companion
staged by a pass map, like `QuietNewFactions`.

Check the patterns offline: `powershell.exe -ExecutionPolicy Bypass -File PickleTools/IdeologySteps/Check-Steps.ps1`.
The scenario that exercises them is `Tests/Pickle/Mod/Pickle/Features/pickletools-ideologysteps.feature`, staged with
`Tests/Pickle/wsl-deps.ideologysteps.map`.
