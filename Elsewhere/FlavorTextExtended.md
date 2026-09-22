# Flavor Text Extended

## Steps that live in a suite, and could be taken from there

Not tools yet: these are steps written for one suite that read as general, kept where they are until a second mod needs them.
Copy or promote them from there; a promoted step takes the `Nelim's Pickle Tools:` prefix.

| Where | What it gives a scenario |
| --- | --- |
| `FlavorText/FlavorTextExtended/Tests/Pickle/Source/FlavorTextExtendedSteps.cs` | **Cook a meal without simulating the walk**: `a colonist cooks {recipe} at the {station} from {ingredients}, {n} times` calls `GenRecipe.MakeRecipeProducts` on a colonist and a work table of the loaded save, so every postfix on the recipe (Flavor Text's meal naming, a mod that changes what a meal carries) runs for real, and records each product's label. Assertions on the names drawn, a step that puts the products on the map and one that checks they kept their names across `I save and reload`. As written it keeps only the products that carry Flavor Text's `CompFlavor` and asserts on its dish defNames, so promoting it means recording every product's label and moving those assertions out. |
| the same file | **Where a ThingDef is filed in a category tree**: `{def} is filed under {category}` and its negation, read from Flavor Text's `FlavorCategoryDef.DescendantThingDefs`. Specific to Flavor Text's categories, but the shape (assert membership of a def in a derived category tree, with the list of categories it IS under on failure) fits any mod that builds one. |

Their step texts start with `Flavor Text Extended:`.

Source review, 2026-09-22: the file has 12 step declarations. In addition to category membership and cooking,
it asserts dish names and dish counts, opens meal info cards, places generated meals on the map, and compares
their labels and dishes by saved thing ID after a reload. The info-card steps are also useful for review
captures. The assertions remain coupled to Flavor Text's `CompFlavor` and dish definitions.

This catalogue review did not compile or execute the suite. Consult that repository's `Tests/Pickle/`
and `STATUS.md` for dated run evidence; none is inferred from the presence of these methods.
