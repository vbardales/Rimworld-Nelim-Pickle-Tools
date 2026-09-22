# Steps owned by other suites

This is the single catalogue for Pickle steps kept in a mod's own repository, and for known historical
steps removed from a suite. The companion tools are listed in the [main README](../README.md).
Before writing a step, look there and here. These notes are not stageable packages.

## Coverage

The [local inventory](INVENTORY.md) lists every suite found by the scanner, its source files, declaration
count and feature count. The 2026-09-22 review included Git-ignored standalone repositories and nested
FlavorText repositories; directory-link aliases were not counted twice. It is a local checkout inventory,
not a claim about every repository on GitHub or every deleted step in history.

| Suite | What to look for |
|---|---|
| [Adaptive Storage Neolithic Renew](AdaptiveStorageNeolithicRenew.md) | Research tabs, project overlap, publication screenshot mode |
| [Anima Song](AnimaSong.md) | Float-menu actions, toggle gizmos, hearing, maintained motes sampled by ticks |
| [Architect Studio](ArchitectStudio.md) | Categories/groups, Harmony ownership, settings sandbox, key-binding UI |
| [Bill Autopilot](BillAutopilot.md) | Bills, stock, profiles, letters and integration assertions |
| [Drum Bath Hygiene](DrumBathHygiene.md) | Needs, carried filth, bathing jobs and diagnostic waits |
| [Fieldwork Companions](FieldworkCompanions.md) | Animal training/master, harvest gestures, yields, settings and translation checks |
| [Firework Stand](FireworkStand.md) | Fuel, glow, effects, joy jobs and time-sensitive captures |
| [Flavor Text Extended](FlavorTextExtended.md) | Category membership, recipe products, meal names and save/reload identity |
| [Flavor Text Extended - Francais](FlavorTextExtendedFR.md) | Cooking, translated meal names, settings and shortcuts |
| [SkillIcons](SkillIcons.md) | Passions, animation getters, texture ownership, settings and restart hand-off |
| [Work Studio](WorkStudio.md) | Work priorities, backstories, editor interactions, patch and window diagnostics |
| [TailorMade Waistlines](TailorMadeWaistlines.md) | Historical assertions at commit 9988515; current suite has no local C# steps |
| [Epona Instruments Renew](EponaInstrumentsRenew.md) | Features only: crafting, captures, listening and save/reload |
| [Tech Level Fixes](TechLevelFixes.md) | Features only: bare and source-mod passes |
| [PickleToolsCheck](PickleToolsCheck.md) | Tooling probes using shared tools, not a gameplay step library |

## Reading and reusing a note

- Source presence, compilation, scenario execution and visual review are separate facts. Dated run notes
  were preserved from the previous catalogues; this cleanup did not replay or revalidate them.
- Do not stage another suite's assembly as a general tool. It may reference that mod's classes or carry
  scenario hooks. Inspect the method and its helpers, then adapt it or promote it deliberately.
- A copied phrase gets the new suite's name. Pickle resolves steps across all active assemblies; a C#
  namespace does not prevent ambiguous phrases. A promoted tool uses `Nelim's Pickle Tools:`.
- A second consumer is a reason to review promotion, not proof that an extraction is already safe.
  Keep mod-specific assertions in their owning suite; migrate callers and check patterns when promoting.
- Keep one maintained note per suite. Existing entries for historical code must name a commit.

## Known overlap to review before extracting code

| Concern | Existing owners | Boundary |
|---|---|---|
| Hide HUD and Pickle panels for publication | WorkStudio, ArchitectStudio, SkillIcons, FieldworkCompanions, AdaptiveStorageNeolithicRenew; TailorMade history | Uses screenshot mode and drawInScreenshotMode. ClearScreen closes non-Pickle windows and is not a replacement |
| Harmony patch ownership | WorkStudio, ArchitectStudio, FieldworkCompanions; TailorMade history | Parameterise the Harmony id and method lookup; keep mod-specific startup probes separate |
| Settings dialog ownership and persistence | SkillIcons, FieldworkCompanions, WorkStudio, ArchitectStudio, FlavorTextExtendedFR; TailorMade history | In-process reread is not a process restart; preserve file backup/restore and use the launcher's -Then for restart chains |
| Research, inspect tabs, texture ownership, click diagnostics | See the relevant suite notes and shared tools | Shared versions exist; source copies remaining in a suite are not proof that migration finished |

These are extraction candidates, not completed migrations. No step DLL, feature or pass map was changed.

## Maintaining coverage

From the collection root:

```powershell
powershell.exe -ExecutionPolicy Bypass -File PickleTools/Elsewhere/Update-Inventory.ps1
powershell.exe -ExecutionPolicy Bypass -File PickleTools/Elsewhere/Update-Inventory.ps1 -Check
```

The first writes INVENTORY.md after checking that every discovered suite has a note. The second is read-only
and rejects a stale snapshot or a missing note. It uses rg, includes ignored repositories, does not follow
links, and counts source declarations rather than resolving expressions. It is not a runtime or ambiguity test.
When a new suite appears, add its note, inspect its code and regenerate. See the script for the precise scope.

The former [ELSEWHERE.md](../ELSEWHERE.md) and [InSuites/](../InSuites/README.md) remain as redirects so old links
still lead here; do not add entries to them.
