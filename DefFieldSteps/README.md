# Def field steps - one Pickle step (shared)

One step that reads a public field of a def **by the def's type and name**:

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: def {string} of type {string} field {string} is {string}` | Finds the def of that type and name (`ThingDef`, `PawnKindDef`, any def type the game knows), walks the dotted path over its public fields and properties, and compares the value's text with the expected text, ignoring case |

Developer tooling; no Defs, no features: a suite stages the companion mod in `Mod/` and writes its own scenarios.

## Why it exists

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
