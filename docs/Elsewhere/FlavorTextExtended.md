# Flavor Text Extended

## Steps that live in a suite, and could be taken from there

Not tools yet: steps written for one suite, read as general, kept where they are until second mod needs them.
Copy or promote from there; promoted step takes `Nelim's Pickle Tools:` prefix.

| Where | What it gives a scenario |
| --- | --- |
| `FlavorText/FlavorTextExtended/Tests/Pickle/Source/FlavorTextExtendedSteps.cs` | **Cook meal without simulating walk**: `a colonist cooks {recipe} at the {station} from {ingredients}, {n} times` calls `GenRecipe.MakeRecipeProducts` on colonist and work table of loaded save, so every postfix on recipe (Flavor Text meal naming, mod changing what meal carries) runs for real, records each product label. Assertions on names drawn, step putting products on map, step checking they kept names across `I save and reload`. As written keeps only products carrying Flavor Text `CompFlavor`, asserts on its dish defNames, so promoting means recording every product label and moving those assertions out. |
| the same file | **Where ThingDef filed in category tree**: `{def} is filed under {category}` and negation, read from Flavor Text `FlavorCategoryDef.DescendantThingDefs`. Specific to Flavor Text categories, but shape (assert def membership in derived category tree, list categories it IS under on failure) fits any mod building one. |

Step texts start with `Flavor Text Extended:`.

Source review, 2026-09-22: file has 12 step declarations. Besides category membership and cooking,
asserts dish names and counts, opens meal info cards, places generated meals on map, compares
labels and dishes by saved thing ID after reload. Info-card steps also useful for review
captures. Assertions stay coupled to Flavor Text `CompFlavor` and dish definitions.

Catalogue review did not compile or execute suite. See that repository `Tests/Pickle/`
and `STATUS.md` for dated run evidence; none inferred from presence of these methods.