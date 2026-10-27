# Option catalogues that are missing (state of 2026-10-25)

Method: the 235 steps of `docs/steps.md` (353 steps of Nelim's Pickle Tools) that take a `{string}`, grouped by what the string names, against the catalogues in `ColonistRace/docs/` and `docs/SANCTUAIRE-LIEUX.md`. **Pickle's own 238 steps were not read** (their catalogue is `Docs/steps.md` of `RimWorks/Rimworld-Pickle`).

**Rule (owner, 2026-10-25): a catalogue is only for what is visual** (one photograph per value). Lists that nobody looks at (thoughts, sounds, research, ideologies, scenarios, storytellers, difficulties, traders, stats, jobs, interface keys) get no catalogue: the step fails and lists the valid names when a value is wrong, which is enough.

## Have

Hairstyles, beards, head types, face and body tattoos (Roo's two mods added 2026-10-25), body types, garments, hats, colours, eye and skin colour genes, face parts and expressions, weapons and crafts, utility items, buildings, animals and plants by mod, the Sanctuary places.

## Visual and still missing

| Catalogue | Step that takes it | Source | Photograph |
|---|---|---|---|
| **Weather** | `I set the weather to` | WeatherDef | one wide shot each (listing step and ticket 4b4a, 2026-10-25) |
| **Xenotypes** | `"X" xenotype is "Y"` | XenotypeDef | one pawn each |
| **Genes other than eye and skin colour** | `has the gene "X"` | GeneDef (the ones that change the look: hair, body, ears, tail) | one pawn each |
| **Pawn kinds (animal and race portraits)** | `animals of kind`, `a colonist of kind` | PawnKindDef | one portrait each (animal portraits ticket 5abb never refiled; `mods-world.md` only counts animals by mod) |
| **Studio presets** | `I frame the studio "X"` | the presets of ScreenshotStudio | one shot each |

## Not a catalogue of its own

- **Floors (terrain)**: seen through the Architect menu, like the buildings (one photograph per Architect category, ArchitectStudio owns the menu steps).
- **Joy givers and instruments**: buildings of the Architect menu (Joy category), same catalogue.

## What to build next

The listing steps are cheap (one line per mod, like `LookCatalogueSteps`): xenotypes, genes, pawn kinds and the studio presets are the four to write after the weather. **Owner to choose the order**; only the weather listing is built.
