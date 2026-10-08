# Where the Pickle steps of a mod live

Rule written 2026-10-08 (owner's agreement): a mod that adds gameplay delivers the Pickle steps that drive it, but never inside what players download.

| The mechanism belongs to | The steps go in | Prefix |
| --- | --- | --- |
| a mod of ours, gameplay of ours | that mod's repository, in its test suite: `Tests/Pickle/Source` (steps) and `Tests/Pickle/Mod` (the `.pickletests` companion). Never in `Mod/`. | one prefix per mod, e.g. `Nelim's Sanctuary: ` |
| a third-party mod (Facial Animation, EyeGenes3, VFAE...) | a sub-mod of Nelim's Pickle Tools, with its own `About.xml` and `loadAfter` on the mod it drives (for example `ColonistRace` for the face) | `Nelim's Pickle Tools: ` |
| several mods, or the game itself | Nelim's Pickle Tools, a generic sub-mod | `Nelim's Pickle Tools: ` |

Exception, by nature: Nelim's Pickle Tools is itself a test mod. Its steps ARE its published content, so they live in its own `Mod/Pickle/Assemblies` (one DLL per sub-mod); its own features that test them are in `Tests/Pickle/Mod`. The rule above is for gameplay mods.

Why not in `Mod/` (for a gameplay mod): it is what Steam sends to players. A steps DLL there adds weight, a dependency on Pickle and a risk of crash, for code only tests use, and it forces a Steam update each time a step changes.

What every owner keeps:
- **A prefix per owner**, so that two steps never share a text (two steps with the same text are "Ambiguous" and fail a healthy scenario).
- **A generated catalogue** (`docs/steps.md`, from the attributes and the summary above them; `Generate-Steps.ps1`, `-Check`).
- **The static check**: each repository's `Check-Steps.ps1` compares its steps with Pickle's and the other owners'. Where a repository holds steps, its check must read the others (see `SanctuaryBacklot/Check-Steps.ps1`).
- **A step is marked "not played"** in its README until a run was read; green is not proof of the rendering.
