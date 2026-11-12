# Contented Livestock

Repository `ContentedLivestock`, folder `Tests/Pickle/Source/`, built by
`dotnet build Tests/Pickle/Source/ContentedLivestock.PickleSteps.csproj -c Release` into
`Tests/Pickle/Mod/Pickle/Assemblies/ContentedLivestock.PickleSteps.dll`.

Written 2026-09-22. Earlier English minimal pass: `exitReason: passed`, six
scenarios passed, zero failed, three RIMMSQOL-only scenarios skipped. Suite since
grown to fifteen features, six source files; earlier report not validate new
scenarios. Read own current reports for later passes.

## Local steps

| File | Steps | What they do |
| --- | --- | --- |
| `SettingsSteps.cs` | open Contented Livestock settings dialog; assert belongs to this mod; read live setting field | Exercise real `Dialog_ModSettings` and settings object loaded by game. Defaults, normalization, serialization stay in offline suite. |
| `ShortcutSteps.cs` | assert shortcut hidden; reveal/hide; assert drawn and enabled; activate | Cover this mod's side of MainButtons contract. `AfterScenario` hook restore `buttonVisible=false`, even after failure. RIMMSQOL side use shared `nelim.pickletools.rimmsqol` tool instead. |
| `LanguageSteps.cs` | assert every `ContentedLivestock.*` English key exist in active language | Read live language databases chosen at process start. English and French need separate launcher passes; never switch language during run. |
| `Driver.cs` | no steps | Resolve loaded mod, live settings object, owning mod of open settings dialog, no retain objects across save loads. |
| `AnimalSteps.cs` | mod-specific animal assertions | Cover eligibility, faction, save/reload behavior; inspect individual methods before propose generic extraction. |
| `SettingsSandbox.cs` | no steps | Preserve and restore user settings around suite. |

## Features and passes

- `01-loading.feature`: startup, load ordering, defs, live defaults.
- `02-settings-and-language.feature`: settings dialog, active-language keys, native shortcut,
  with screenshot-mode captures for review.
- `03-rimmsqol.feature`: shared RIMMSQOL steps for list/reveal/open/hide/forget behavior.
- `04` through `15`: animal behavior, save/reload, settings and RIMMSQOL restart chains, later scenario probes; see feature files for current preconditions.
- `wsl-deps.runtime-evidence.map`: shared screenshot-mode tool only.
- `wsl-deps.avec-rimmsqol.map`: RIMMSQOL, shared RIMMSQOL steps, screenshot mode.

Suite deliberately not duplicate 35-test offline harness's calculations, XML,
Scribe, static localization checks. Broader animal-production behavior stay documented in
`_tools/FUNCTIONAL-SCENARIOS.md` for final in-game validation.