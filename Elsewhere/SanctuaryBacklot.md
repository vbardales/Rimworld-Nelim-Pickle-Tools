# Nelim's Sanctuary Backlot

Repository `SanctuaryBacklot` (`vbardales/Rimworld-Nelim-Sanctuary-Backlot`, private), folder `Source/` (its own step assembly, `Mod/Pickle/Assemblies/Nelim.SanctuaryBacklot.dll`),
9 steps in one file, prefix `Nelim's Sanctuary: `. The catalogue is generated from the sources and lives in the repository:
[`SanctuaryBacklot/docs/steps.md`](../../SanctuaryBacklot/docs/steps.md) (`docs/Generate-Steps.ps1`, `-Check` verifies it). Its own `Check-Steps.ps1` matches every pattern
against Pickle's vocabulary and the other suites' and reports none ambiguous (2026-10-08, the first of those checks to read a repository other than `PickleTools/<tool>/Source`).
Features: 19, in `Tests/Pickle/Mod/Pickle/Features/`, moved here from PickleTools on 2026-10-07; they run with `-Mod SanctuaryBacklot` and a pass map that stages PickleTools' tools by `path:PickleTools/...`.

## Generic, to reuse rather than rewrite

| File | Steps | What they do, and what to know before copying |
| --- | --- | --- |
| `SanctuarySteps.cs` | `I frame the sanctuary {string}`, `I am at the sanctuary {string}` | Centre the camera on a NAMED place of the Sanctuary with the zoom that frames it (about 50 names: houses, banks, workshops, infirmary, exhibition zones). A suite names the place and never writes a coordinate. Needs the save `Nelims-tribe` (250 x 250). The places are listed with photographs in `docs/SANCTUAIRE-LIEUX.md`. |
| `SanctuarySteps.cs` | `I empty the sanctuary {string}` / `the sanctuary {string} is emptied` | Remove what stands on the cells of a place (buildings, items, plants, filth), pawns excluded, so a capture shows a bare place. |
| `SanctuarySteps.cs` | `I bare the floor of the sanctuary {string}` / `the floor of the sanctuary {string} is bared` | Remove the floor as well, down to the base terrain. |
| `SanctuarySteps.cs` | `the animals are removed from the sanctuary {string}`, `the animals are kept out of the sanctuary {string}` | Take the animals out of a place, or keep them out until the scenario ends. |
| `SanctuarySteps.cs` | `the roof is removed from the sanctuary {string}` | Open the roof of a place. |

## What is NOT here

- **Eye colour and facial expression** are in Nelim's Pickle Tools (ColonistRace `GeneSteps.cs`: `{string} has the gene {string}`, `{string} holds the gene {string}`; `FaceSteps.cs` in progress). They were first written here on 2026-10-08 and moved the same day, at the owner's word.
- **Nelim's own eyes** are not a step: the fixture gives her `Eyes_DarkBrown` by default.
- **Body type, gender, age, clothes**: ColonistRace and Pickle, see the `Corps et apparence` section of `docs/GALERIE.md`.

## Where to look first

`docs/GALERIE.md` (how to photograph in the Sanctuary), `docs/SANCTUAIRE-LIEUX.md`, `docs/SANCTUAIRE-CASES.md`, and the pass map `Tests/Pickle/wsl-deps.sanctuary.map`. The older copies of these steps in ScreenshotStudio (prefix `Nelim's Pickle Tools:`) stay until every mod has migrated; do not write a new feature against them.
