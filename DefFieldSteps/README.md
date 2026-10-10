# Def field steps - one Pickle step (shared)

One step that reads a public field of a def **by the def's type and name**:

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: def {string} of type {string} field {string} is {string}` | Finds the def of that type and name (`ThingDef`, `PawnKindDef`, any def type the game knows), walks the dotted path over its public fields and properties, and compares the value's text with the expected text, ignoring case |
| `Nelim's Pickle Tools: the biome {string} lists the wild animal {string}` | Asserts `BiomeDef.AllWildAnimals` holds the pawn kind (the commonality is not read). Compiled, not played |
| `Nelim's Pickle Tools: the recipe {string} is offered for the race {string}` | Asserts the race's recipe list (`ThingDef.AllRecipes`, built after the patches and after a mod copied its `recipeUsers`) holds the concrete recipe and that `AvailableNow` is true. Def level: no pawn, no body part check. Compiled, not played |
| `Nelim's Pickle Tools: the surgery recipes of the race {string} match those of the race {string}` | Compares the `IsSurgery` recipes of two races by defName (for example a mod's animal against a husky); a failure names the recipes only one has. Compiled, not played |

Developer tooling; no Defs, no features: a suite stages the companion mod in `Mod/` and writes its own scenarios.

## Why it exists

A field that is a list or an array (`tradeTags`, `recipeUsers`) reads as its items joined by `, ` (a def by its defName), in order.

Pickle's own `def {string} field {string} is {string}` looks the def up by name alone and refuses a name that two def
types share. Every animal is such a name (`Muffalo` is a ThingDef and a PawnKindDef), so an XML-only mod that rebalances
animals (body size, lifespan, taming, prey size) could not check any value its patches write. This step names the type.

```
Then Nelim's Pickle Tools: def "Muffalo" of type "ThingDef" field "race.lifeExpectancy" is "18"
And Nelim's Pickle Tools: def "Muffalo" of type "PawnKindDef" field "combatPower" is "80"
```

## What to know

- The path is a dotted walk over **public** fields and properties, as Pickle's step does: `race.lifeExpectancy`,
  `race.baseBodySize`. No list index and no method call.
- Numbers are written with the invariant culture (`1.5`, not `1,5` on a French install). A float that is not exact reads as a
  float writes it, so give the value the patch wrote literally.
- A failure names the def type, the path, the expected and the actual text; a missing type or def says so, and lists defs of
  that type with a similar name.
- **Not played yet.** Compiled against the reference stubs and checked for ambiguity against every suite in the
  repository; no scenario has run it.

## Using it from a suite

In the pass map, after the mods it needs, ending with a newline:

```
nelim.pickletools.deffields   path:PickleTools/DefFieldSteps/Mod
```

Build: `dotnet build DefFieldSteps/Source -c Release` (output goes to `Mod/Pickle/Assemblies/`, intermediates under `.build/`).
