# RIMMSQOL steps for Pickle (shared)

Reusable Pickle steps that **reveal and hide any `MainButtonDef` the way RIMMSQOL's own interface does**, and
assert what the main bar then draws. `MOD_SETTINGS.md` requires every mod with settings to ship a MainButtons
shortcut that is hidden by default and that RIMMSQOL can reveal; every suite so far tested only its own side
of that (`buttonVisible` moved by hand). These steps drive RIMMSQOL.

Developer tooling. GitHub and Workshop release preparation in progress; no Defs, no features: a suite stages the companion mod in `Mod/` in a pass
that also stages RIMMSQOL, and writes its own features. The demonstration is
`FlavorText/FlavorTextExtendedFR/Tests/Pickle/Mod/Pickle/Features/12` to `15-rimmsqol-*.feature`.

## What RIMMSQOL actually does

`MalteSchulze.RIMMSqol`, Workshop **1084452457**, 1.6 build. Read from its shipped `Source/RIMMSqol/` and
confirmed against the 1.6 `RIMMSqol.dll` (`Check-Bridge.ps1` reads the binaries with Mono.Cecil):

- **No Harmony patch on the bar or on `MainButtonWorker.Visible`.** Its only patch on `MainButtonsRoot` is a
  Postfix on `MainButtonsOnGUI` for its own key bindings. It reveals a button by **writing
  `MainButtonDef.buttonVisible`**, the field the game's own worker reads. The only code in the DLL that stores
  that field is the merger for the `"mainButtons"` property set in `SettingsInit`.
- **The choice is a `SettingsInstance` per `MainButtonDef`, keyed by defName**, in `SettingsStorage`'s generic
  store (fields `Label`, `IconPath`, `Description`, `Visible`, `Minimized`, `Order`, `Buttons`). It is written to
  RIMMSQOL's own mod settings file, `Config/Mod_1084452457_QOLMod.xml` (folder name = Workshop id, class name
  `QOLMod`), **only while the instance is active**, and an instance becomes active when a field is edited.
- **Applying it**: `QOLMod.WriteSettings()` runs `SettingsStorage.ApplySettings`, which runs the merger, then
  writes the file. `Dialog_ModSettings.PreClose` calls `WriteSettings`, so closing RIMMSQOL's window is the
  commit. At startup `HarmonyBootstrap` loads the file and applies it once, before any save is loaded.
- **Its interface**: a `Dialog_ModSettings` built for `QOLMod` (title `QoL`). Its menu button **Main Buttons**
  opens a list of **every** `MainButtonDef`, hidden ones included; each entry reads label, defName and mod name.
  The edit page's **Visible** checkbox is `instance.set("Visible", value)`. The small cross beside an entry, and
  the Summary page's, is `setActive(false); reset()`.
- **Hiding is not forgetting.** Hiding again leaves an active entry that records "Visible: configured, false" (the
  `Visible` node itself is only written when it is not false). Forgetting deactivates it and the entry leaves the
  file. The steps offer both, and the teardown forgets.
- **Hard dependencies**: its `About.xml` declares `brrainz.harmony` for 1.1 to 1.5 only and nothing for 1.6, but
  its code references `0Harmony` and its 1.6 folder ships no copy, so Harmony is a real dependency. The staging
  activates Harmony first in every pass. `loadAfter`: Core, Royalty, Ideology, Harmony, rimforge, pawnmorpher,
  CherryPicker; only the first four are staged.

The steps make exactly these calls (typed, against the real DLL) instead of pixel clicks. **They do not click the
checkbox**: that the checkbox is wired to `set("Visible", …)` is read from RIMMSQOL's source, not shown in a game.

## Using it from a suite

1. A pass map (`<Mod>/Tests/Pickle/wsl-deps.avec-rimmsqol.map`), RIMMSQOL first, then the steps:

   ```
   MalteSchulze.RIMMSqol            1084452457
   nelim.pickletools.rimmsqol      path:PickleTools/RimmsqolSteps/Mod
   ```

   Harmony is not repeated: the staging puts it first everywhere. The order is the file's order, and the steps
   mod hard-depends on both Pickle and RIMMSQOL. The folder's own `About.xml` packageId must match the one written.
2. Select `-DepMap wsl-deps.avec-rimmsqol.map`. Tag features with both
   `@requires:MalteSchulze.RIMMSqol` and `@requires:nelim.pickletools.rimmsqol`.
   `@rimmsqol` is only a filter label; `@wip` marks unfinished work and needs `-IncludeWip`.
   Without RIMMSQOL staged the first step stops with a sentence instead of a
   `TypeLoadException` (nothing in a `[PickleSteps]` signature names a RIMMSqol type).
   The aggregate's `[AfterScenario]` hook also checks `ModsConfig` before it touches the typed
   RIMMSQOL bridge. This matters even when a scenario uses no RIMMSQOL step: Pickle runs every
   installed hook. The corrected bundle passed both v4.8.4 English minimal smoke probes with
   RIMMSQOL absent on 2026-09-23; see `../evidence/aggregate/` and `../STATUS.md`.
3. Write features with the vocabulary below. Every text is unique across the repository and Pickle
   (`Check-Steps.ps1` proves it).

### Vocabulary

| Step | What it does |
| --- | --- |
| `RIMMSQOL is ready to be driven` | RIMMSQOL loaded, its `SettingsInit` run, its `mainButtons` property set present |
| `RIMMSQOL's own list of main buttons offers {string}` | the list a player opens has an entry for that defName; logs the label it shows |
| `RIMMSQOL shows the main button {string} as {word}` | what the Visible checkbox reads: `visible` or `hidden` |
| `RIMMSQOL holds no choice for the main button {string}` | the instance is not active (would not be saved or applied) |
| `RIMMSQOL reveals the main button {string}` | `OnStartEditing`, `set("Visible", true)`, `OnStopEditing`, `WriteSettings`. Refuses if it already reads visible |
| `RIMMSQOL hides the main button {string}` | the same with `false`. Refuses if it already reads hidden |
| `RIMMSQOL forgets its choice for the main button {string}` | the reset cross: `setActive(false)`, `reset()`, `WriteSettings` |
| `RIMMSQOL's settings file records the main button {string} as {word}` | reads the **file**, not memory: `visible`, or `hidden` (configured, not true) |
| `RIMMSQOL's settings file records no choice for the main button {string}` | no file, no entry, or no Visible choice in the entry |
| `the main bar draws the button {string}` | the def has a cell in the bar's own layout (its `allButtonsInOrder`, `Worker.Visible`, the same arithmetic as `DoButtons`) and is not `Disabled` (greyed) |
| `the main bar does not draw the button {string}` | it has no cell |
| `the main bar's button {string} is activated` | `Worker.InterfaceTryActivate()`, what a click ends up calling; refuses if the bar does not draw it |
| `RIMMSQOL's own window is opened on its list of main buttons` | the real dialog, navigated to the Main Buttons list; waits for its own frames |
| `RIMMSQOL's own window is opened on the main button {string}` | the real dialog on that button's edit page |
| `RIMMSQOL's own window is open` | a `Dialog_ModSettings` built for the `QOLMod` instance is on the stack |
| `RIMMSQOL's choices are kept for the next launch` | restart chain, see below |
| `the choices RIMMSQOL kept in the previous launch are in place` | restart chain, see below |

To take the capture that shows the shortcut listed, open the window and use Pickle's own
`I take a screenshot "…"`; the demonstration feature does it for the list page and the edit page.

"The main bar draws it" is computed from the bar's own list and rule, not photographed. It is not a visual
check, and a `@review` capture that is green shows only that the path ran.

## Restarts, and what a dead run leaves behind

A restart is two processes. The demonstration is a chain of three launches under one hold of the lock (`-Then`
stages once and keeps the profile). From PowerShell, pass a real array:
`& ./scripts/Run-PickleWsl.ps1 -Mod <mod> -DepMap wsl-deps.avec-rimmsqol.map -Filter <writer> -Then @('<reader>', '<last>')`.
With `powershell.exe -File`, a comma string can instead become one filter in one process; see the
[authoring guide](../Authoring/README.md).

1. reveal, then **keep**: `RIMMSQOL's choices are kept for the next launch` is the **last** step, so a scenario
   that fails before it leaves nothing;
2. **read** (`the choices RIMMSQOL kept in the previous launch are in place`, which refuses to pass when the writer
   ran in the same process), check the reveal survived, hide, keep again;
3. read, check the hide survived, **forget**, check the file records nothing.

A teardown (`[AfterScenario]`, after every scenario of every feature in the run, a no-op when there is nothing to
do) forgets whatever a step changed unless the scenario asked to keep it. The choice lives in the profile's
`Config`, which the staging does not wipe between passes, so without that a revealed shortcut would still be
revealed for the next run that stages RIMMSQOL. Technique from `SkillIcons/Tests/Pickle/Source/SettingsSandbox.cs`.

### Leftovers

If the game dies after a writer launch and before its reader (the machine reserved, the run killed, a failing
launch that ends the chain after a keep), RIMMSQOL's choice stays on disk. The next run that stages this assembly
forgets it after its first scenario (the marker beside the file names the process that wrote it). If nothing runs
again, delete both files from the WSL profile by hand:

```bash
wsl.exe -- bash -lc 'rm -f ~/.config/unity3d/"Ludeon Studios"/"RimWorld by Ludeon Studios"/Config/Mod_1084452457_QOLMod.xml*'
```

A profile without that file is what a clean run starts from. It only matters to a pass that stages RIMMSQOL:
none of the others reads it.

## Verification

Offline, run on 2026-09-21:

| Check | Command | Result |
| --- | --- | --- |
| Builds against the **real** `RIMMSqol.dll` (1.6) and the game's reference assemblies | `dotnet build Source/RimmsqolSteps.csproj -c Release` | 0 warnings, 0 errors: every RIMMSqol member the steps name exists with that signature |
| The three reflected names and the facts above, read from the binaries | `powershell.exe -ExecutionPolicy Bypass -File PickleTools/RimmsqolSteps/Check-Bridge.ps1` | 10 checks, all pass |
| The reader of RIMMSQOL's settings file follows its rules (13 hand-made cases: revealed, hidden with the `Visible` node absent, not configured, another property set, malformed...). It found one real defect on the way: `string.Split(char)` compiles against the game's references and is not on .NET Framework | `powershell.exe -ExecutionPolicy Bypass -File PickleTools/RimmsqolSteps/Check-Reader.ps1` | 13 cases, all pass. **The XML layout itself is derived from RIMMSqol's code and has not been seen** |
| 17 patterns compile with Pickle's own engine, none declared twice, none ambiguous against 609 others (Pickle, 12 suites), every line of the rimmsqol features resolves | `powershell.exe -ExecutionPolicy Bypass -File PickleTools/RimmsqolSteps/Check-Steps.ps1` | pass. Its failure modes were exercised by planting a duplicate, an invalid and an ambiguous pattern: it reported all three |
| The staging accepts the pass map, activates RIMMSQOL and this mod in dependency order, and RIMMSQOL lands in folder `1084452457` | `stage-pickle-wsl.sh` into a throwaway `GAME`/`CONFIG` with a lock path of its own | 15 mods staged in the order written in `wsl-deps.avec-rimmsqol.map` |

### In the game: played once, 2026-09-21

Pass `avec-rimmsqol` of `FlavorTextExtendedFR` (English, `-Then` chain, one hold of the lock, 15 mods staged in the
order written in the map, all loaded): four launches, **every one `exitReason: passed`, scenarios played = scenarios
discovered**: launch 1 feature 12 (3 of 3), launch 2 feature 13 (1 of 1), launch 3 feature 14 (1 of 1), launch 4
feature 15 (1 of 1). Reports and log lines were kept in `evidence/2026-09-21/` (on disk, no longer in git); the text summary is `docs/runs/2026-09-21-rimmsqol.md`.

**Replayed after the move and the rename, the same evening (23:12 to 23:18).** The same command against the
renamed build (`nelim.pickletools.rimmsqol`, assembly `Nelim.PickleTools.Rimmsqol`, staged from
`PickleTools/RimmsqolSteps/Mod`): four launches again, **every one `exitReason: passed`**, 15 mods loaded, scenarios played
3 of 3 (feature 12) and then 1 of 1 for each of features 13, 14 and 15. The logs name the new namespace
(`Nelim.PickleTools.Rimmsqol.RimmsqolBridge.SetVisible`, `.Forget`, `RimmsqolShortcutSteps.AssertDrawn`), the
settings-file entries read as before (visible, hidden, none), and the WSL profile was left with `<mainButtons />`
and no marker. Launcher output and step log lines in `evidence/2026-09-21-replay/`. No new captures were taken.
The `-Then` chain of four launches under one lock has now finished twice.

What that established, and where:

- **The file layout was right.** Revealed, the entry is `<li><id>mainButtons</id><isConfigured>…Visible;t;…</isConfigured>
  <baseObjectKey>FTFR_Settings</baseObjectKey><baseObjectReferenceKey>-1</baseObjectReferenceKey><Visible>True</Visible></li>`;
  hidden, the same entry **without** a `Visible` node; forgotten, no entry and `<mainButtons />`. (`baseObjectReferenceKey`
  is -1, not the -2 the source comment suggested; the reader does not depend on it.)
- **RIMMSQOL's own list offers the button** (`Flavor Text settings | FTFR_Settings | Flavor Text Extended - Français
  (unofficial)`), hidden and holding no choice on a clean profile.
- **A reveal through its settings instance reaches the bar**: `buttonVisible` becomes true, the bar's own list and rule give
  the button a cell (`x 1792..1920, y 1045, of 17 buttons`), it is not greyed, and the button opens **this mod's page** (capture).
- **Hide and forget work**: the bar stops visiting it, the file records "hidden" and then nothing.
- **The choice survives a restart, both ways**: launch 3 found the button visible without any step having revealed it in
  that process, launch 4 found it hidden the same way, and each launch refused to start unless the previous one had run in
  another process. Afterwards the WSL profile holds `Mod_1084452457_QOLMod.xml` with `<mainButtons />` and no marker.
- The four captures in `evidence/2026-09-21/captures/` were opened: RIMMSQOL's `Select Main Button` list with "Flavor Text
  settings" in it, its edit page with the Visible box ticked (the reset radio green), the mod's own settings page, and the
  edit page again after a restart. The bar shows "Flavor Text settings" at the far right in the two that were taken after a reveal.

Still **not** shown: that RIMMSQOL's checkbox is wired to `set("Visible", …)` (read from source; the steps make the call, they do
not click); other customization mods; the French interface; the same steps on a mod other than FlavorTextExtendedFR. The bar's
"drawn" is a calculation from the game's own list, corroborated by the captures but not measured on pixels. Two harmless lines
in every launch's log, `Mod … did not load any content`, come from Pickle companions having no Defs. Known cosmetic defect: the
log lines say "reveald" and "hided" (the verb plus "d"); left as is so that the tested DLL stays the tested DLL.

## Files

- `Source/` the C# project. `RimmsqolBridge.cs` is the only file that names a RIMMSqol type; `MainBar.cs` the
  bar's arithmetic; `RimmsqolShortcutSteps.cs` the vocabulary; `SettingsFileReader.cs` the parsing of RIMMSQOL's
  file (pure BCL, tested offline); `RimmsqolSandbox.cs` and `RimmsqolSession.cs` the teardown and the restart
  hand-off.
- `Mod/` the companion mod the staging copies (`About/About.xml`, `Pickle/Assemblies/Nelim.PickleTools.Rimmsqol.dll`,
  built). Nothing else may be put here: the staging copies it verbatim.
- `Check-Steps.ps1`, `Check-Bridge.ps1`, `Check-Reader.ps1` the offline checks.
- `evidence/2026-09-21/` the four captures and the step log lines of the first run (on disk, not in git; summary in `docs/runs/2026-09-21-rimmsqol.md`).
- `.build/` intermediates, not part of anything.
- Rebuild after any change to `Source/`, then run both checks; the DLLs of steps are loaded at game start, so a
  report produced without a restart after a rebuild does not test the rebuild.
