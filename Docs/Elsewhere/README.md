# Steps owned by other suites

Single catalogue for Pickle steps kept in mod's own repository, and for known historical
steps removed from suite. Companion tools listed in [main README](../../README.md).
Before writing step, look there and here. Notes not stageable packages.

## Coverage

[Local inventory](INVENTORY.md) (generated, 2026-10-11: 81 suites, 21 with note below) lists every suite found by scanner, its source files, declaration
count, feature count. 2026-09-22 review included Git-ignored standalone repositories and nested
FlavorText repositories; directory-link aliases not counted twice. Local checkout inventory,
not claim about every repository on GitHub or every deleted step in history.

Suite gets note below only when own session has steps worth reusing or avoiding; others appear in
inventory as `none`. Table below lists suites with note.

| Suite | What to look for |
|---|---|
| [A Certain Series - Creatures and Hair Renew](ACertainSeriesCreaturesAndHairRenew.md) | Body-part labels, innate shots counted per tick, trader stocks, egg incubation, butchering; source only, never run |
| [Adaptive Storage Neolithic Renew](AdaptiveStorageNeolithicRenew.md) | Research tabs, project overlap, publication screenshot mode |
| [Nelim's Ancient Salvage](AncientSalvage.md) | Building placed with rotation, door held open on paused game, walled and roofed rectangle for sealed room |
| [Anima Song](AnimaSong.md) | Float-menu actions, toggle gizmos, hearing, maintained motes sampled by ticks |
| [Architect Studio](ArchitectStudio.md) | Categories/groups, Harmony ownership, settings sandbox, key-binding UI |
| [Bill Autopilot](BillAutopilot.md) | Bills, stock, profiles, letters and integration assertions |
| [Creatures of Ki Renew](CreaturesOfKiRenew.md) | Frozen poses: two animals mate (heart fleck), animal carries item |
| [Nelim's Eden Garden](EdenGarden.md) | Open-field fixture, timetable to Work, sowing diagnostic, waits on bill leaving table, recipe ingredients read from loaded def |
| [Drum Bath Hygiene](DrumBathHygiene.md) | Needs, carried filth, bathing jobs and diagnostic waits |
| [Fieldwork Companions](FieldworkCompanions.md) | Animal training/master, harvest gestures, yields, settings and translation checks |
| [Firework Stand](FireworkStand.md) | Fuel, glow, effects, joy jobs and time-sensitive captures |
| [Flavor Text Extended](FlavorTextExtended.md) | Category membership, recipe products, meal names and save/reload identity |
| [Flavor Text Extended - Francais](FlavorTextExtendedFR.md) | Cooking, translated meal names, settings and shortcuts |
| [Housebroken](Housebroken.md) | Settings dialog, persisted values and hidden MainButton shortcut |
| [Joy Rescue](JoyRescue.md) | Settings dialog, persisted values and hidden MainButton shortcut |
| [Retro Joy Renew](RetroJoyRenew.md) | Feature-only recreation Def and colony checks |
| [Nelim's Sanctuary Backlot](SanctuaryBacklot.md) | Place steps of Sanctuary (frame, empty, bare floor, animals out, roof), prefix `Nelim's Sanctuary: `; own assembly and generated catalogue in repository (`SanctuaryBacklot/docs/steps.md`) |
| [SkillIcons](SkillIcons.md) | Passions, animation getters, texture ownership, settings and restart hand-off |
| [Work Studio](WorkStudio.md) | Work priorities, backstories, editor interactions, patch and window diagnostics |
| [TailorMade Waistlines](TailorMadeWaistlines.md) | Historical assertions at commit 9988515; current suite has no local C# steps |
| [Epona Instruments Renew](EponaInstrumentsRenew.md) | Features only: crafting, captures, listening and save/reload |
| [Tech Level Fixes](TechLevelFixes.md) | Features only: bare and source-mod passes |

## Reading and reusing a note

- Source presence, compilation, scenario execution, visual review = separate facts. Dated run notes
  preserved from previous catalogues; cleanup did not replay or revalidate them.
- Do not stage another suite's assembly as general tool. May reference that mod's classes or carry
  scenario hooks. Inspect method and helpers, then adapt or promote deliberately.
- Copied phrase gets new suite's name. Pickle resolves steps across all active assemblies; C#
  namespace does not prevent ambiguous phrases. Promoted tool uses `Nelim's Pickle Tools:`.
- Second consumer requires promotion into PickleTools. Keep step in owning suite only while it has
  exactly one consumer. On second use, extract generic part, prefix its text, migrate both callers
  and check patterns before deleting duplicate implementations.
- Keep one maintained note per suite. Existing entries for historical code must name commit.

## Known overlap to review before extracting code

| Concern | Existing owners | Boundary |
|---|---|---|
| Hide HUD and Pickle panels for publication | WorkStudio, ArchitectStudio, SkillIcons, FieldworkCompanions, AdaptiveStorageNeolithicRenew; TailorMade history | Uses screenshot mode and drawInScreenshotMode. ClearScreen closes non-Pickle windows, not replacement |
| Harmony patch ownership | WorkStudio, ArchitectStudio, FieldworkCompanions; TailorMade history | Parameterise Harmony id and method lookup; keep mod-specific startup probes separate |
| Settings dialog ownership and persistence | SkillIcons, FieldworkCompanions, WorkStudio, ArchitectStudio, FlavorTextExtendedFR; TailorMade history | In-process reread not process restart; preserve file backup/restore and use launcher's -Then for restart chains |
| Research, inspect tabs, texture ownership, click diagnostics | See relevant suite notes and shared tools | Shared versions exist; source copies remaining in suite not proof migration finished |
| Tight camera framing for gallery capture (closer than Pickle's zoom limit, or on one named pawn) | AncientBuildingsRenew (asked 2026-10-02), AnimalApparelCollarsAndKitRenew (writing by-name step, hypothesis: game clamps `RootSize` near 11, value to be read), ScreenshotStudio presets (`SetRootSize` 12 to 16), CoatSteps `I frame the animals of kind` (`coat-N` only, never played) | Pickle's `I zoom all the way in` clamps at 12 (`CameraSteps.cs`, read from source); direct `SetRootSize` bypasses clamp. **Promoted 2026-10-02 as `CameraZoom/`** (set root size, read it back), ported from AncientBuildingsRenew; framing NAMED pawn still wanted (AACK writing it). `I move the mouse to` no longer moves pointer since Pickle 6 |
| Translation load errors (`Translation data for language X has N errors`) | AnimalArk (step written in own suite 2026-10-02, reads `LanguageDatabase.activeLanguage.loadErrors`, being played); FieldworkCompanions and FlavorTextExtendedFR (translation checks, other mechanism) | One consumer for this mechanism. If second mod needs error list, extract, probably into LoadAudit. Reported by AnimalArk session, not run here |
| Remove mod from save and reload it | AnimalApparelCollarsAndKitRenew (`Tests/Pickle/Removal`, two-launch chain, played green once per its STATUS), AnimaSong (`06-removal-write.feature` plus companion, `-ThenWithout`) | Both feature chains using Pickle's own steps (`mod "..." is not loaded`, `I save and reload as`). DalmatiansRenew asked for pattern 2026-10-02. Nothing asserts mod's content destroyed |
| Stage gallery capture: decor things, floors, hairstyle and colour, tattoos, dyed garment, removal of set | CrystalBall (asked 2026-10-02); hairstyle colours also ACertainSeriesCreaturesAndHairRenew | Promoted 2026-10-02: `StageDecor/` (place, lay floor, remove all) and `ColonistRace/` (LookSteps, HairSteps). Not played |
| Spawn hostile pawn with private state set before first tick; open ground to see it act | AncientChineseBeastAndGeneExpandedRenew (asked 2026-10-02) | One consumer. Known: single non-async step cannot be interrupted by tick, and `docs/FIXTURES.md` lists test-colony free areas; no open-ground step exists |

Extraction candidates, not completed migrations. No step DLL, feature or pass map changed.

## Maintaining coverage

From collection root:

```powershell
powershell.exe -ExecutionPolicy Bypass -File PickleTools/docs/Elsewhere/Update-Inventory.ps1
powershell.exe -ExecutionPolicy Bypass -File PickleTools/docs/Elsewhere/Update-Inventory.ps1 -Check
```

First writes INVENTORY.md after checking every discovered suite has note. Second read-only
and rejects stale snapshot or missing note. Uses rg, includes ignored repositories, does not follow
links, counts source declarations rather than resolving expressions. Not runtime or ambiguity test.
When new suite appears, add its note, inspect its code, regenerate. See script for precise scope.

Former [ELSEWHERE.md](../ELSEWHERE.md) and [InSuites/](../../InSuites/README.md) remain as redirects so old links
still lead here; do not add entries to them.