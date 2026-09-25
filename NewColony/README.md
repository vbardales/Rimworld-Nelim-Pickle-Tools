# New colony - Pickle steps (optional)

Six Pickle steps that start a **new colony** from the main menu, for the suites that have to play what no saved game reaches: the first
minutes of a colony (a mod's "new colony" regression scenario, for example). Optional companion: nothing runs unless a scenario asks for
it, nothing in Pickle or in the launcher changes, and it is not part of the aggregate bundle.

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: a new colony is started` | From the main menu: sets the game up as the developer quick start does, with the choices below, generates the world (5 percent of the planet), picks a starting tile, then takes the last new-colony page's path (`PageUtility.InitGameStart`): the scene "Play" is loaded, the map is generated, the game is put on pause. Returns when a map is playable (up to 280 s, the step's timeout is 300). Attaches `new-colony`, a line naming the choices, the tile, the colonists and the time it took |
| `Nelim's Pickle Tools: the new colony's seed is {string}` | The seed of the world; also seeds the draw of the starting tile and of the colonists. Default `picklecolony` |
| `Nelim's Pickle Tools: the new colony's map size is {int}` | Cells a side, 25 to 500. Default 75 |
| `Nelim's Pickle Tools: the new colony's scenario is {string}` | A `ScenarioDef` by name. Default `Crashlanded`; an unknown name fails and lists the scenarios the game has |
| `Nelim's Pickle Tools: the new colony's storyteller is {string}` | A `StorytellerDef`. Default `Cassandra` |
| `Nelim's Pickle Tools: the new colony's difficulty is {string}` | A `DifficultyDef`. Default `Rough` |

The choices are the scenario's own and go back to their defaults afterwards. Set them **before** the start step, which must follow `Given the main menu is open`.

## Status

**Written 2026-09-25, not played.** It compiles (0 warnings), and its patterns compile with Pickle's engine and are not ambiguous. The open
question is whether a step can change the scene from Entry to Play and hand the game back to a normal scenario, which is what the first
run (`pickletools-newcolony.feature`) answers; this section is to be rewritten with its result. Not yet known either: whether the
same seed gives the same colonists (the world and the tile are drawn from it; the colonists are drawn under the same seeded state,
which is an assumption until the scenario is played twice).

Where it comes from: `Root_Play.SetupForQuickTestPlay` and `PageUtility.InitGameStart` of `Assembly-CSharp` 1.6, decompiled on
2026-09-25. It is a copy of what the game's own developer quick start does, with the choices fixed.

## Using it from a suite

```
nelim.pickletools.newcolony   path:PickleTools/NewColony/Mod
```

in the suite's pass map, and tag the feature `@requires:nelim.pickletools.newcolony`:

```gherkin
Given the main menu is open
And Nelim's Pickle Tools: the new colony's seed is "my-mod-s16"
When Nelim's Pickle Tools: a new colony is started
Then no errors were logged
```

## Build

```powershell
dotnet build NewColony/Source/Nelim.PickleTools.NewColony.csproj -c Release   # net48, output in Mod/Pickle/Assemblies
```

Intermediates go to `NewColony/.build/`, never inside `Mod/`, since the staging copies `Mod/` verbatim.
