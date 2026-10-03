# Stage decor - Pickle steps (shared)

Steps that dress a map for a gallery capture and take the dressing away, requested by CrystalBall on 2026-10-02 (rule of that day: every
gallery capture is staged). **Compiled, never played.** They complement Pickle's own `I spawn a {string} at` and `I destroy the {string} at`
(one thing at a cell); these add the floor, and the removal of the whole set in one step.

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: I place the decor {string} at \({int}, {int}\)` | Places a thing of the `ThingDef` at a cell, made of its default stuff, and remembers it. Fails naming the cell if it is off the map or holds a pawn or a building |
| `Nelim's Pickle Tools: I lay the floor {string} from \({int}, {int}\) to \({int}, {int}\)` | Lays a `TerrainDef` (carpet, tile, soil) on a rectangle and remembers what each cell held |
| `Nelim's Pickle Tools: I lay the floor {string} from \({int}, {int}\) to \({int}, {int}\) painted {string}` | The same, then paints the cells with a `ColorDef` (`Structure_Cream`, `Structure_OrangePastel`...): laying a floor on a painted one drops its paint, this brings it back. Not played yet |
| `Nelim's Pickle Tools: the plants from \({int}, {int}\) to \({int}, {int}\) are fully grown` | Sets every plant on a rectangle to full growth, so a tree a step spawned shows at adult size. Not played yet |
| `Nelim's Pickle Tools: the decor is removed` | Destroys every thing placed by the first step and puts every floor back, last laid first |

An `[AfterScenario]` does the same removal for a scenario that failed halfway. Only what is still spawned on the current map is touched: after a
reload, earlier references belong to the game that was replaced.

## Using it from a suite

```
nelim.pickletools.stagedecor   path:PickleTools/StageDecor/Mod
```

Not in the Workshop bundle. The probe is `Tests/Pickle/Mod/Pickle/Features/pickletools-stagedecor.feature`, staged with
`Tests/Pickle/wsl-deps.stagedecor.map`. Open ground matters: `docs/FIXTURES.md` lists free squares of `test-colony`.

## What is not here

A thing placed with **Pickle's own** `I spawn a {string} at` is not remembered; use `I place the decor` for what must come off. Plants a
colony would sow, shelves that need a stuff other than the default, or a floor that must stay under a wall are not handled. A floor laid under a
building the map already has is laid anyway (the building stays).

## Light and roof (2026-10-02)

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the decor {string} at \({int}, {int}\) is lit` | Fills the fuel of a placed thing that has a fuel component (torch, campfire), switches it on when it has a switch, waits up to 10 s for the game to say it glows, and fails if it has no light or does not glow (a lamp on a powerless network says so). Whether the picture then shows the glow at the chosen hour is not established |
| `Nelim's Pickle Tools: the roof is removed from \({int}, {int}\) to \({int}, {int}\)` | Takes the roof off a rectangle (a test colony under a mountain roof is dark) and remembers each roof; `the decor is removed` puts them back |

Hour and weather are Pickle's own: `I set the hour to {int}`, `I set the weather to {string}` (read from its `Docs/steps.md`).
