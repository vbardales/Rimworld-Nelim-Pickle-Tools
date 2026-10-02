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
| [A Certain Series - Creatures and Hair Renew](ACertainSeriesCreaturesAndHairRenew.md) | Body-part labels, innate shots counted per tick, trader stocks, egg incubation, butchering; source only, never run |
| [Adaptive Storage Neolithic Renew](AdaptiveStorageNeolithicRenew.md) | Research tabs, project overlap, publication screenshot mode |
| [Anima Song](AnimaSong.md) | Float-menu actions, toggle gizmos, hearing, maintained motes sampled by ticks |
| [Architect Studio](ArchitectStudio.md) | Categories/groups, Harmony ownership, settings sandbox, key-binding UI |
| [Bill Autopilot](BillAutopilot.md) | Bills, stock, profiles, letters and integration assertions |
| [Drum Bath Hygiene](DrumBathHygiene.md) | Needs, carried filth, bathing jobs and diagnostic waits |
| [Fieldwork Companions](FieldworkCompanions.md) | Animal training/master, harvest gestures, yields, settings and translation checks |
| [Firework Stand](FireworkStand.md) | Fuel, glow, effects, joy jobs and time-sensitive captures |
| [Flavor Text Extended](FlavorTextExtended.md) | Category membership, recipe products, meal names and save/reload identity |
| [Flavor Text Extended - Francais](FlavorTextExtendedFR.md) | Cooking, translated meal names, settings and shortcuts |
| [Housebroken](Housebroken.md) | Settings dialog, persisted values and hidden MainButton shortcut |
| [Joy Rescue](JoyRescue.md) | Settings dialog, persisted values and hidden MainButton shortcut |
| [Retro Joy Renew](RetroJoyRenew.md) | Feature-only recreation Def and colony checks |
| [SkillIcons](SkillIcons.md) | Passions, animation getters, texture ownership, settings and restart hand-off |
| [Work Studio](WorkStudio.md) | Work priorities, backstories, editor interactions, patch and window diagnostics |
| [TailorMade Waistlines](TailorMadeWaistlines.md) | Historical assertions at commit 9988515; current suite has no local C# steps |
| [Epona Instruments Renew](EponaInstrumentsRenew.md) | Features only: crafting, captures, listening and save/reload |
| [Tech Level Fixes](TechLevelFixes.md) | Features only: bare and source-mod passes |

## Reading and reusing a note

- Source presence, compilation, scenario execution and visual review are separate facts. Dated run notes
  were preserved from the previous catalogues; this cleanup did not replay or revalidate them.
- Do not stage another suite's assembly as a general tool. It may reference that mod's classes or carry
  scenario hooks. Inspect the method and its helpers, then adapt it or promote it deliberately.
- A copied phrase gets the new suite's name. Pickle resolves steps across all active assemblies; a C#
  namespace does not prevent ambiguous phrases. A promoted tool uses `Nelim's Pickle Tools:`.
- A second consumer requires promotion into PickleTools. Keep a step in its owning suite only while it has
  exactly one consumer. On the second use, extract the generic part, prefix its text, migrate both callers
  and check patterns before deleting the duplicate implementations.
- Keep one maintained note per suite. Existing entries for historical code must name a commit.

## Known overlap to review before extracting code

| Concern | Existing owners | Boundary |
|---|---|---|
| Hide HUD and Pickle panels for publication | WorkStudio, ArchitectStudio, SkillIcons, FieldworkCompanions, AdaptiveStorageNeolithicRenew; TailorMade history | Uses screenshot mode and drawInScreenshotMode. ClearScreen closes non-Pickle windows and is not a replacement |
| Harmony patch ownership | WorkStudio, ArchitectStudio, FieldworkCompanions; TailorMade history | Parameterise the Harmony id and method lookup; keep mod-specific startup probes separate |
| Settings dialog ownership and persistence | SkillIcons, FieldworkCompanions, WorkStudio, ArchitectStudio, FlavorTextExtendedFR; TailorMade history | In-process reread is not a process restart; preserve file backup/restore and use the launcher's -Then for restart chains |
| Research, inspect tabs, texture ownership, click diagnostics | See the relevant suite notes and shared tools | Shared versions exist; source copies remaining in a suite are not proof that migration finished |
| Tight camera framing for a gallery capture (closer than Pickle's zoom limit, or on one named pawn) | AncientBuildingsRenew (asked 2026-10-02), AnimalApparelCollarsAndKitRenew (writing a by-name step, hypothesis: the game clamps `RootSize` near 11, value to be read), ScreenshotStudio presets (`SetRootSize` 12 to 16), CoatSteps `I frame the animals of kind` (`coat-N` only, never played) | Pickle's `I zoom all the way in` clamps at 12 (`CameraSteps.cs`, read from the source); a direct `SetRootSize` bypasses that clamp. **Promoted 2026-10-02 as `CameraZoom/`** (set the root size, read it back), ported from AncientBuildingsRenew; framing a NAMED pawn is still wanted (AACK is writing it). `I move the mouse to` no longer moves a pointer since Pickle 6 |
| Translation load errors (`Translation data for language X has N errors`) | AnimalArk (step written in its own suite 2026-10-02, reads `LanguageDatabase.activeLanguage.loadErrors`, being played); FieldworkCompanions and FlavorTextExtendedFR (translation checks, other mechanism) | One consumer for this mechanism. If a second mod needs the error list, extract it, probably into LoadAudit. Reported by the AnimalArk session, not run here |
| Remove a mod from a save and reload it | AnimalApparelCollarsAndKitRenew (`Tests/Pickle/Removal`, a two-launch chain, played green once per its STATUS), AnimaSong (`06-removal-write.feature` plus a companion, `-ThenWithout`) | Both are feature chains using Pickle's own steps (`mod "..." is not loaded`, `I save and reload as`). DalmatiansRenew asked for the pattern 2026-10-02. Nothing asserts that a mod's content is destroyed |
| Stage a gallery capture: decor things, floors, hairstyle and colour, tattoos, dyed garment, removal of the set | CrystalBall (asked 2026-10-02); hairstyle colours also ACertainSeriesCreaturesAndHairRenew | Promoted 2026-10-02: `StageDecor/` (place, lay floor, remove all) and `ColonistRace/` (LookSteps, HairSteps). Not played |
| Spawn a hostile pawn with private state set before the first tick; open ground to see it act | AncientChineseBeastAndGeneExpandedRenew (asked 2026-10-02) | One consumer. Known: a single non-async step cannot be interrupted by a tick, and `docs/FIXTURES.md` lists test-colony free areas; no open-ground step exists |

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
