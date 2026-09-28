# Coat steps - Pickle steps (shared)

Steps for the mods that add `alternateGraphics` and `alternateGraphicChance` to animal `PawnKindDef`s (the Colorful Coats
family). No mod, def or number is written in a step: the kind's defName and every count come from the feature.

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: {int} animals of kind {string} are spawned` | Generates N animals of the kind, player faction, at random age, named `coat-1`... and places each in a clear area around the map centre: a cell counts only when the cells around it are free too, for big animals. Fails saying which animal could not be placed, never a silent short count |
| `Nelim's Pickle Tools: {int} adult animals of kind {string} are spawned` | The same, at the kind's last life stage. Use it when the alternate graphics may differ by stage |
| `Nelim's Pickle Tools: among the animals of kind {string}, at least {int} different extra coats were drawn` | Counts the distinct coat indices of `0` or more among the `coat-N` animals of that kind. On failure prints N, K and the coats seen, so bad luck reads differently from a patch that did not apply |
| `Nelim's Pickle Tools: I note the coats of the animals of kind {string}` | Remembers each animal's coat by name |
| `Nelim's Pickle Tools: each animal of kind {string} still has the coat noted for it` | After `I save and reload`: finds the animals again by name on the current map and compares |

An `[AfterScenario]` destroys the `coat-N` animals still spawned on the current map.

## Choosing N and K

The chance applies to getting **any** extra coat; each single coat is rarer. With chance `c` and `m` extra coats, an animal
draws a given coat with probability about `c/m`. Ask for K well below `m` and N large enough that missing K is negligible.

## What it does not prove, and what is not played

- **Not played yet.** Compiled against the reference stubs only.
- The coat is what the renderer draws: `PawnGraphicUtils.GetGraphicIndex(pawn)`, computed on demand from the pawn's
  `thingIDNumber` and the kind's chance, `-1` for the original graphic (decompiled from 1.6 by the Megafauna session).
  `Pawn.overrideGraphicIndex` is not it: unread by the renderer, null for an ordinary animal. After a reload the same coat
  returns only while the animal's id and the kind's `alternateGraphics` list are unchanged; that is what "still has the
  coat noted" asserts.
- A coat replaces the stage's whole body graphic, the female one included, so it applies at every life stage and to both
  sexes; the adult variant is for size, not correctness.
- It says nothing about pixels: an index does not show the right texture on screen. That is a `@review` capture.

## Using it from a suite

In the pass map, after the mods it needs, ending with a newline:

```
nelim.pickletools.coatsteps   path:PickleTools/CoatSteps/Mod
```

Build: `dotnet build CoatSteps/Source -c Release` (output goes to `Mod/Pickle/Assemblies/`, intermediates under `.build/`).
