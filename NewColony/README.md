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
| `Nelim's Pickle Tools: the new colony's colonists have landed` | After the start step. The start step counts the colonists the map holds, pods and containers included; this one runs the game at the fast speed until every one is spawned on the map (90 s at most, the step's timeout is 120), then pauses again. It does not close the scenario's intro dialog: a dialog that pauses the game keeps the pods from landing, and the step then fails naming each colonist's state (spawned, downed, container). Attaches `new-colony-landed`. **Written 2026-09-26 after Many Happy Returns saw 0 spawned colonists; not played yet** |

The choices are the scenario's own and go back to their defaults afterwards. Set them **before** the start step, which must follow `Given the main menu is open`.

## ðŸŸ  Risks: read before playing it

ðŸŸ  **It is the costly test of the repository. Play it once, in an initial or a final pass.**

- **Not reproducible.** Colonists are not proven the same twice (see below).
- **Long, or not: measured 4 s.** The world (5 percent of the planet), a 75 by 75 map and the colonists took 4.1 s to generate and the whole scenario 6.4 s in the WSL. A bigger map or world takes longer, and the machine is shared: keep to the defaults unless the scenario needs more.
- **Pickle's watchdog kills it at 120 s by default**, whatever the step's `@timeout` says, and the run then has **no report**. A ticket that plays it passes
  `-Extra "-pickle-scenario-timeout=400"` (`Submit-PickleRun.ps1 -Extra`, `Run-PickleWsl.ps1 -Extra`); nothing sets it for you.
- **It replaces the game's state and changes the scene.** Play it **in a ticket of its own**, not chained with other features: what a scenario that follows
  it would find has not been checked.
- **Played once by another suite, first red then green** (see Status): one draw, nothing about a game without Ideology.

## When to play it, and what it does not prove

**A new colony is not reproducible, so it is played sparingly** (the owner's rule, 2026-09-25): **in an initial or a final pass, never for a fix or an
exploration**, and once. A scenario that uses it takes minutes of generation and holds the machine that long.

- **Nothing about the colonists is proven reproducible.** The seed fixes the world and, as far as the game's draw goes, the starting tile; the colonists
  are drawn under the same seeded state, but that is an assumption no run has checked, and this tool does not replay a scenario to check it. Write scenarios
  that hold for **any** three colonists (a colony exists, the game is paused, no error was logged), not for these names.
- It stays **out of the bundle** and behind its own package and tag: a mod's ordinary pass never stages it, so it cannot be played by accident. A pass
  that wants it names it (`nelim.pickletools.newcolony` in the map) and tags the feature `@requires:nelim.pickletools.newcolony`.

## Status

**Played once by another suite on 2026-09-25 (Creatures of Ki, all DLCs on, scenario Crashlanded): it failed, and the first version was wrong.** What that run showed:
the change of scene works (the map was generated in 4.2 s and the game was playable, paused), but with **Ideology** active the player faction had no ideoligion,
so the scenario's starting meals threw (`NullReferenceException` in `FoodUtility.HasHumanMeatEatingRequiredPrecept`, from `GenerateGoodIngredients`) and the
starting pawns never arrived: a map with **no colonist**. The step now chooses the classic ideoligion the way the new-colony screens do
(`Page_ChooseIdeoPreset`: generate it, make it the player's and every faction's, drop the unused ones) before the scenario is set up, and it **fails if the map has no colonist**.
It also pops the random states the game's code left pushed inside the seeded draw (the game had warned `Random state stack is not empty`).
**Replayed by the same suite after the fix (2026-09-26 by its clock, request dcb2, revision 1fcc51f, all DLCs on, `-pickle-scenario-timeout=400`): green.** The scenario passed in **6.4 s**: Crashlanded, seed `teshi-renew`, tile 2541,
3 colonists (Jec, Tomboy, Fjellsmel), classic ideoligion, map generated in **4.1 s**, paused, and the `NullReferenceException` gone with no error logged (the log holds only the usual notice that mods with only an assembly load no content).
Played **once** with one draw. **Not checked:** the `Random state stack` warning line by line (only that no error or warning failed the scenario), a game without Ideology, another scenario, and the same seed twice. Whether the same seed gives the same colonists is deliberately not tested: see above.

Where it comes from: `Root_Play.SetupForQuickTestPlay`, `PageUtility.InitGameStart` and, for Ideology, `Page_ChooseIdeoPreset` of `Assembly-CSharp` 1.6, decompiled on
2026-09-25: a copy of what the game's developer quick start and its new-colony pages do, with the choices fixed.
## A use case to copy: proving that generation works with the mod active (Creatures of Ki, at the owner's request)

**What it is for.** Showing that the game can **generate** a world and a first map with the mod active. Creatures of Ki adds an animal with `wildBiomes` and spawn weights, values that only world and map generation read.
No saved game can show it, since a save is made after generation. Every other scenario of that suite loads a fixture colony saved **without** the mod, so the mod is added to a colony that already exists and generation is never exercised.

**What the scenario asserts, and nothing about the colony obtained.** `Given the main menu is open`, `the new colony's seed is "..."`, `a new colony is started`, then only that a def of the mod exists
(`def "Teshi" of type "PawnKindDef" exists`), `no warnings from mod "<mod name>"` and `no errors were logged`. It reads no colonist, no tile, no map content, so it holds for any draw.
The colony is random and never the same twice, so a colony-dependent assertion would be a coin flip. **Green means one clean draw, not every draw**; a red may not replay, so keep the `new-colony`
attachment (choices, tile, colonists) with the report: it is the only record of which draw it was.

**When.** Once, in an initial or a final validation, never in a fix or an exploration loop; in its own ticket, with its own pass map
(`nelim.pickletools.newcolony   path:PickleTools/NewColony/Mod`), the feature tagged `@requires:nelim.pickletools.newcolony`, and `-Extra "-pickle-scenario-timeout=400"`.
Anything that must repeat is played on a fixture colony instead.

**Who should use it.** A mod whose defs matter to generation: animals with `wildBiomes` or `commonality`, plants, terrain, biome or world-generation patches, things with a scatterer or a gen step,
starting items, scenario or faction changes. A mod that only adds items, UI or recipes has nothing that generation can break and should not spend the machine on it.

Verdict of that suite's first successful use: green on its revision `1fcc51f` after the fix above, 6.4 s, 3 colonists, classic ideoligion (one draw).
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
