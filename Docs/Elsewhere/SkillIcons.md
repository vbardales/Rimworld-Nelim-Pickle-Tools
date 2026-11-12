# SkillIcons

Repository `SkillIcons`, folder `Tests/Pickle/Source/`. Every phrase start with `SkillIcons` on purpose:
Pickle keep one step table across all suites, identical phrases collide with "Ambiguous step".

### Dedicated to SkillIcons, no reuse expected

| File | Steps | What they do |
| --- | --- | --- |
| `PassionSteps.cs` | `SkillIcons sets {string} skill {string} passion to {string}`, `... clears ...`, `... grants ... the passion def {string}` | Set, clear, grant Vanilla Skills Expanded passion (`VSE.Passions.PassionDef`) on named colonist skill. Useful to any mod that draws or reads passions; use VSE own types, so need VSE loaded. |
| `SettingsSteps.cs` | `SkillIcons work tab mode is set to`, `... icon size is set to N percent`, `... opacity ...`, `SkillIcons animated passion icons is turned`, `SkillIcons setting {string} reads {string}`, `I open the SkillIcons settings dialog` | Write, read `SkillIconsSettings` fields directly. Only last one generalises: open mod `Dialog_ModSettings`, wait three frames inside step because dialog pauses game and tick wait would time out. |
| `VerificationSteps.cs` | `SkillIcons no-passion icon is turned`, `SkillIcons settings are written to disk`, `the SkillIcons settings file records {string} as {string}`, `SkillIcons settings are re-read from disk` | Object -> file -> object round trip of one mod settings: write via game own `WriteSettings`, find field by name in XML on disk, re-read via `ReadModSettings`. Mechanism apply to any `Mod` subclass; field names do not. |
| `AnimationSteps.cs` | `SkillIcons passion {string} shows a different frame after {int} frames`, `... shows the same frame after ...` | Ask `PassionDef.Icon` what it draws, twice, N frames apart. **Technique is reusable part**: animation proved by reading same getter game draws from, twice, and negative case (still icon must NOT change) give positive one its meaning. Does not photograph anything: screen pixels pass for anything moving in rectangle. |

### Small and generic, candidates to move if a second mod wants them

| File | Steps | What they do, and what to know before copying |
| --- | --- | --- |
| `MainButtonBarSteps.cs` | `... reveals the MainButtonDef {string}, as a customization mod would`, `... hides ... again`, `... MainButtonDef {string} is drawn in the bar`, `... is not drawn in the bar` | Move `MainButtonDef.buttonVisible`, read `Worker.Visible` and `Worker.Disabled`. **Prefer `RimmsqolSteps` here**: its `the main bar draws the button` work from bar own layout, mine does not, and it drive RIMMSQOL itself. Mine only move field RIMMSQOL moves. |
| `MainButtonBarSteps.cs` | `... MainButtonDef {string} carries its description for the active language` | Assert def `description` after `DefInjected`, for game that **started** in that language: French must equal text in `Languages/French/DefInjected/MainButtonDef/MainButtons.xml` and differ from English source. Path and French folder name hard-coded. Work because launch that choose its language switch nothing; wrongly filed as unreachable until 2026-09-21. |
| `VerificationSteps.cs` | `SkillIcons MainButtonDef {string} is hidden on a clean configuration`, `... activates the MainButtonDef {string}`, `SkillIcons sees a {string} window open for mod {string}` | Read `buttonVisible`, call def worker `InterfaceTryActivate`, check window of named type open **for named mod** (`Dialog_ModSettings` for another mod look identical in screenshot). Last one is useful one. |
| `ScreenshotSteps.cs` | `SkillIcons hides the interface around the windows on screen`, `SkillIcons brings the interface back` | Turn on RimWorld own screenshot mode so only windows draw, keep `drawInScreenshotMode` enabled on non-Pickle windows, disable on Pickle windows. Restore from explicit step **and** from `[AfterScenario]`, so scenario that die between the two not leave every later scenario photographing screen with no interface. Different mechanism from `ClearScreen`, which keep other mods' windows away; this hide HUD. Caveat: publication capture taken with it in headless run showed settings window correctly; see next row for the one that did not. |
| `BioTabSteps.cs` | `SkillIcons opens the Bio tab for {string}` | Open colonist Bio tab. **`InspectTabs` covers this and is preferred.** Caveat found 2026-09-20: in headless run step passed and capture after held no Bio window at all, only map and colonist info box. Cause not established. Green scenario there proved path ran, not that tab was drawn. |
| `SettingsSandbox.cs` | `SkillIcons settings are kept for the next process`, `SkillIcons reads what the previous process kept` | Hand-off of settings file between two game launches, for restart test. **`RimmsqolSteps` reimplements it for RIMMSQOL own file**; technique came from here. Three rules that were paid for: stand-down is a STEP not hook tag (Pickle hook filter additive and ordered by `GetMethods`); two launches must be ONE ticket (`Run-PickleWsl.ps1 -Filter a -Then b`); reader refuse to pass when writer ran in same process, which would be restart that never restarted. |

### Exists, do not copy

`SkillIcons sets the game language to {string}` (in `VerificationSteps.cs`) switch language **during a run**. It
failed four times: `SelectLanguage` clears and reloads every def, which take game apart under runner
(`Find.WorldObjects` returns null, `Update()` throws every frame). No feature use it any more. Choose language at
launch with `Run-PickleWsl.ps1 -Language French` and assert against language pass runs in.

### Shared version exists; local copy remains

Source inventory, 2026-09-22: `SkillIcons/Tests/Pickle/Source/TextureOwnerSteps.cs` still exist.
Shared version is [TextureOwner](../../TextureOwner/README.md), whose adoption instructions describe
phrase and pass-map changes. Do not report suite migration complete merely because shared DLL exist.