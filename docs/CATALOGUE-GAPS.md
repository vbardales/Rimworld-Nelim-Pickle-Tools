# Option catalogues that are missing (state of 2026-10-25)

Method: the 235 steps of `docs/steps.md` (353 steps of Nelim's Pickle Tools) that take a `{string}`, grouped by what the string names (a def, a key, a preset), against the catalogues in `ColonistRace/docs/` (`CATALOGUE-LOOKS`, `-APPAREL`, `-COLOURS`, `-GENES`, `-ITEMS`, `-WEAPONS-CRAFTS`, `-MODS-*`, `FACE-PARTS`) and `docs/SANCTUAIRE-LIEUX.md`. **Pickle's own 238 steps were not read** (their catalogue is `Docs/steps.md` of `RimWorks/Rimworld-Pickle`): the gaps below are the value lists that NPT steps take; a Pickle step that takes a def by name (weather, storyteller, scenario, expansion...) shares the same gap.

A catalogue here means: the list of accepted values read from the game by a listing step (`[look-*]` lines), one table per mod, and a photograph where the value is visible.

## Have

Hairstyles, beards, head types, face and body tattoos (Roo's two mods added 2026-10-25), body types, garments, hats, colours, eye and skin colour genes, face parts and expressions, weapons and crafts, utility items, buildings, animals and plants by mod, the Sanctuary places.

## Missing, with who would use it

| Value list | Step that takes it | Def or source | Photograph? | Likely users |
|---|---|---|---|---|
| **Weather** | `I set the weather to` (Studio) | WeatherDef | yes, one wide shot each | every gallery (listing step written 2026-10-25, ticket 4b4a) |
| **Jobs** | `is forced into the job "X" on ...` (also `Ingest`, `Play_*`) | JobDef (names of the jobs a mod adds: Tame, Train, Refuel, HaulToCell, nuzzle jobs) | no | gestures, AlphaMythology, Ebb, Dal |
| **Terrain / floors** | `I lay the floor "X"`, `the floor ... is bared` | TerrainDef | yes, one swatch each | building galleries |
| **Xenotypes** | `"X" xenotype is "Y"`, `has xenotype` | XenotypeDef | yes, one pawn each | race and gene mods |
| **Genes other than eye and skin colour** | `has the gene "X"` | GeneDef (hair, body, ability genes) | partly | race and gene mods |
| **Pawn kinds and races** | `a colonist "X" of kind "Y" exists`, `is of race`, `animals of kind` | PawnKindDef, ThingDef races | portraits (animal portraits ticket 5abb never refiled) | every animal mod; animals are only counted by mod in `CATALOGUE-MODS-WORLD.md` |
| **Thoughts** | `has the thought "X"`, `thought "X" mood offset` | ThoughtDef | no | mood mods |
| **Joy givers and joy kinds** | `the joy giver "X" ...` | JoyGiverDef | no | joy and instrument mods |
| **Sounds** | `the game is playing the sound "X"` | SoundDef | no (listening) | sound sessions (SoundCapture) |
| **Research projects and tabs** | ResearchSteps `the research projects "X"`, `I open the research tab` | ResearchProjectDef, ResearchTabDef | no | research mods |
| **Ideology: memes, precepts, interaction modes, work types** | IdeologySteps | MemeDef, PreceptDef, PrisonerInteractionModeDef, WorkTypeDef | no | ideology mods |
| **New colony: scenarios, storytellers, difficulties** | NewColony steps | ScenarioDef, StorytellerDef, DifficultyDef | no | NewColony |
| **Traders** | TradeSteps `a trader of kind` | TraderKindDef | no | trade mods |
| **Stats** | `I remember "X"'s stat "Y"` | StatDef | no | stat mods |
| **Main buttons, tabs, windows, gizmos** | KeyedClick, RimmsqolSteps, InspectTabs, `no window of the type` | MainButtonDef, InspectTabBase types, Window types, keyed strings | no | interface mods |
| **Studio presets** | `I frame the studio "X"` | the presets of ScreenshotStudio | one shot each | gallery sessions |

## What to build first

The cheapest are the pure listings (one `Dump` line per mod, like `LookCatalogueSteps`): weather (done), jobs, terrain, xenotypes, genes, pawn kinds, thoughts, joy givers, sounds, research, ideology, scenarios, storytellers, difficulties, traders, stats, main buttons. Photographs come only for weather, terrain, xenotypes and pawn kinds. **Owner to choose the order**; nothing here is built except the weather listing.
