# Nelim's Sanctuary Backlot

Repository `SanctuaryBacklot` (`vbardales/Rimworld-Nelim-Sanctuary-Backlot`, private), folder `Source/` (own step assembly, `Mod/Pickle/Assemblies/Nelim.SanctuaryBacklot.dll`),
9 steps in one file, prefix `Nelim's Sanctuary: `. Catalogue generated from sources, lives in repository:
[`SanctuaryBacklot/docs/steps.md`](../../../SanctuaryBacklot/docs/steps.md) (`docs/Generate-Steps.ps1`, `-Check` verifies it). Own `Check-Steps.ps1` matches every pattern
against Pickle vocabulary and other suites', reports none ambiguous (2026-10-08, first of those checks to read repository other than `PickleTools/<tool>/Source`).
Features: 19, in `Tests/Pickle/Mod/Pickle/Features/`, moved here from PickleTools 2026-10-07; run with `-Mod SanctuaryBacklot` and pass map that stages PickleTools' tools by `path:PickleTools/...`.

## Generic, to reuse rather than rewrite

| File | Steps | What they do, and what to know before copying |
| --- | --- | --- |
| `SanctuarySteps.cs` | `I frame the sanctuary {string}`, `I am at the sanctuary {string}` | Centre camera on NAMED Sanctuary place with zoom that frames it (about 50 names: houses, banks, workshops, infirmary, exhibition zones). Suite names place, never writes coordinate. Needs save `Nelims-tribe` (250 x 250). Places listed with photographs in `docs/SANCTUAIRE-LIEUX.md`. |
| `SanctuarySteps.cs` | `I empty the sanctuary {string}` / `the sanctuary {string} is emptied` | Remove what stands on cells of place (buildings, items, plants, filth), pawns excluded, so capture shows bare place. |
| `SanctuarySteps.cs` | `I bare the floor of the sanctuary {string}` / `the floor of the sanctuary {string} is bared` | Remove floor too, down to base terrain. |
| `SanctuarySteps.cs` | `the animals are removed from the sanctuary {string}`, `the animals are kept out of the sanctuary {string}` | Take animals out of place, or keep out until scenario ends. |
| `SanctuarySteps.cs` | `the roof is removed from the sanctuary {string}` | Open roof of place. |

## What is NOT here

- **Eye colour and facial expression** in Nelim's Pickle Tools (ColonistRace `GeneSteps.cs`: `{string} has the gene {string}`, `{string} holds the gene {string}`; `FaceSteps.cs` in progress). First written here 2026-10-08, moved same day, at owner's word.
- **Nelim's own eyes** not a step: fixture gives her `Eyes_DarkBrown` by default.
- **Body type, gender, age, clothes**: ColonistRace and Pickle, see `Corps et apparence` section of `docs/GALERIE.md`.

## Where to look first

`docs/GALERIE.md` (how to photograph in Sanctuary), `docs/SANCTUAIRE-LIEUX.md`, `docs/SANCTUAIRE-CASES.md`, and pass map `Tests/Pickle/wsl-deps.sanctuary.map`. Older copies of these steps in ScreenshotStudio (prefix `Nelim's Pickle Tools:`) stay until every mod migrated; do not write new feature against them.