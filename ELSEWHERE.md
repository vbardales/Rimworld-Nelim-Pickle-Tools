# Steps that live in a suite, not here

The tools in this repository are the steps that more than one mod is likely to need. This file is the other list:
steps that exist in a suite and were **not** moved here, because they are tied to one mod or too small to be worth
a companion mod. It says what each does and where it is, so a suite that needs the same thing knows where to look
before writing it a second time. If you copy one, copy it with its caveats.

Kept by the session that owns each suite. An entry names the suite, the file, and what would have to change to
reuse it. Nothing below is a tool: none is staged with a `path:` line, and none has been checked for step-text
uniqueness across suites, so a copied phrase must be renamed.

## SkillIcons

Repository `SkillIcons`, folder `Tests/Pickle/Source/`. Every phrase there starts with `SkillIcons` on purpose:
Pickle keeps one step table across every suite, and identical phrases collide with "Ambiguous step".

### Dedicated to SkillIcons, no reuse expected

| File | Steps | What they do |
| --- | --- | --- |
| `PassionSteps.cs` | `SkillIcons sets {string} skill {string} passion to {string}`, `... clears ...`, `... grants ... the passion def {string}` | Set, clear or grant a Vanilla Skills Expanded passion (`VSE.Passions.PassionDef`) on a named colonist's skill. Useful to any mod that draws or reads passions; it goes through VSE's own types, so it needs VSE loaded. |
| `SettingsSteps.cs` | `SkillIcons work tab mode is set to`, `... icon size is set to N percent`, `... opacity ...`, `SkillIcons animated passion icons is turned`, `SkillIcons setting {string} reads {string}`, `I open the SkillIcons settings dialog` | Write and read `SkillIconsSettings` fields directly. Only the last one generalises: it opens a mod's `Dialog_ModSettings`, waiting three frames in the step itself because that dialog pauses the game and a tick wait would time out. |
| `VerificationSteps.cs` | `SkillIcons no-passion icon is turned`, `SkillIcons settings are written to disk`, `the SkillIcons settings file records {string} as {string}`, `SkillIcons settings are re-read from disk` | The object -> file -> object round trip of one mod's settings: write through the game's own `WriteSettings`, find the field by name in the XML on disk, re-read through `ReadModSettings`. The mechanism applies to any `Mod` subclass; the field names do not. |
| `AnimationSteps.cs` | `SkillIcons passion {string} shows a different frame after {int} frames`, `... shows the same frame after ...` | Ask `PassionDef.Icon` what it draws, twice, N frames apart. **The technique is the reusable part**: an animation is proved by reading the same getter the game draws from, twice, and the negative case (a still icon must NOT change) is what gives the positive one its meaning. It does not photograph anything: screen pixels pass for anything moving in the rectangle. |

### Small and generic, candidates to move if a second mod wants them

| File | Steps | What they do, and what to know before copying |
| --- | --- | --- |
| `MainButtonBarSteps.cs` | `... reveals the MainButtonDef {string}, as a customization mod would`, `... hides ... again`, `... MainButtonDef {string} is drawn in the bar`, `... is not drawn in the bar` | Move `MainButtonDef.buttonVisible` and read `Worker.Visible` and `Worker.Disabled`. **Prefer `RimmsqolSteps` here**: its `the main bar draws the button` works from the bar's own layout, which mine does not, and it drives RIMMSQOL itself. Mine only moves the field RIMMSQOL moves. |
| `MainButtonBarSteps.cs` | `... MainButtonDef {string} carries its description for the active language` | Asserts a def's `description` after `DefInjected`, for a game that **started** in that language: French must equal the text in `Languages/French/DefInjected/MainButtonDef/MainButtons.xml` and differ from the English source. The path and the French folder name are hard-coded. Works because a launch that chooses its language switches nothing; it was wrongly filed as unreachable until 2026-09-21. |
| `VerificationSteps.cs` | `SkillIcons MainButtonDef {string} is hidden on a clean configuration`, `... activates the MainButtonDef {string}`, `SkillIcons sees a {string} window open for mod {string}` | Read `buttonVisible`, call the def's worker `InterfaceTryActivate`, and check that a window of a named type is open **for a named mod** (a `Dialog_ModSettings` for another mod looks identical in a screenshot). The last one is the useful one. |
| `ScreenshotSteps.cs` | `SkillIcons hides the interface around the windows on screen`, `SkillIcons brings the interface back` | Turns on RimWorld's own screenshot mode so that only windows draw, after lowering `drawInScreenshotMode` on every window that is not Pickle's own. Restores from an explicit step **and** from `[AfterScenario]`, so a scenario that dies between the two does not leave every later scenario photographing a screen with no interface. Different mechanism from `ClearScreen`, which keeps other mods' windows away; this hides the HUD. Caveat: a publication capture taken with it in a headless run showed the settings window correctly; see the next row for the one that did not. |
| `BioTabSteps.cs` | `SkillIcons opens the Bio tab for {string}` | Opens a colonist's Bio tab. **`InspectTabs` covers this and is preferred.** Caveat found on 2026-09-20: in a headless run the step passed and the capture that followed held no Bio window at all, only the map and a colonist info box. The cause was not established. A green scenario there proved the path ran, not that the tab was drawn. |
| `SettingsSandbox.cs` | `SkillIcons settings are kept for the next process`, `SkillIcons reads what the previous process kept` | The hand-off of a settings file between two game launches, for a restart test. **`RimmsqolSteps` reimplements it for RIMMSQOL's own file**; the technique came from here. Three rules that were paid for: the stand-down is a STEP and not a hook tag (Pickle's hook filter is additive and ordered by `GetMethods`); the two launches must be ONE ticket (`Run-PickleWsl.ps1 -Filter a -Then b`); and the reader refuses to pass when the writer ran in the same process, which would be a restart that never restarted. |

### Exists, do not copy

`SkillIcons sets the game language to {string}` (in `VerificationSteps.cs`) switches the language **during a run**. It
failed four times: `SelectLanguage` clears and reloads every def, which takes the game apart underneath the runner
(`Find.WorldObjects` returns null, `Update()` throws every frame). No feature uses it any more. Choose the language at
launch with `Run-PickleWsl.ps1 -Language French` and assert against the language the pass runs in.

### Moved

`TextureOwnerSteps.cs` (which mod answers for a texture path, and that a path is contested by at least N mods) is
being moved here as `TextureOwner/`; see `STATUS.md` once it lands.
