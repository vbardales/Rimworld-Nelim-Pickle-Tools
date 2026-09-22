# Contented Livestock

Repository `ContentedLivestock`, folder `Tests/Pickle/Source/`, built by
`dotnet build Tests/Pickle/Source/ContentedLivestock.PickleSteps.csproj -c Release` into
`Tests/Pickle/Mod/Pickle/Assemblies/ContentedLivestock.PickleSteps.dll`.

Written on 2026-09-22. The earlier English minimal pass recorded `exitReason: passed`, six
passed scenarios, zero failed and three RIMMSQOL-only scenarios skipped. The suite has since
grown to fifteen features and six source files; that earlier report does not validate the new
scenarios. Read its own current reports for later passes.

## Local steps

| File | Steps | What they do |
| --- | --- | --- |
| `SettingsSteps.cs` | open the Contented Livestock settings dialog; assert it belongs to this mod; read a live setting field | Exercises the real `Dialog_ModSettings` and the settings object loaded by the game. Defaults, normalization and serialization remain in the offline suite. |
| `ShortcutSteps.cs` | assert the shortcut is hidden; reveal/hide it; assert it is drawn and enabled; activate it | Covers this mod's side of the MainButtons contract. An `AfterScenario` hook restores `buttonVisible=false`, including after failure. The RIMMSQOL side uses the shared `nelim.pickletools.rimmsqol` tool instead. |
| `LanguageSteps.cs` | assert every `ContentedLivestock.*` English key exists in the active language | Reads the live language databases selected at process start. English and French require separate launcher passes; it never switches language during a run. |
| `Driver.cs` | no steps | Resolves the loaded mod, live settings object and owning mod of an open settings dialog without retaining objects across save loads. |
| `AnimalSteps.cs` | mod-specific animal assertions | Covers eligibility, faction and save/reload behavior; inspect individual methods before proposing a generic extraction. |
| `SettingsSandbox.cs` | no steps | Preserves and restores user settings around the suite. |

## Features and passes

- `01-loading.feature`: startup, load ordering, defs and live defaults.
- `02-settings-and-language.feature`: settings dialog, active-language keys and native shortcut,
  with screenshot-mode captures for review.
- `03-rimmsqol.feature`: shared RIMMSQOL steps for list/reveal/open/hide/forget behavior.
- `04` through `15`: animal behavior, save/reload, settings and RIMMSQOL restart chains, and later scenario probes; see the feature files for their current preconditions.
- `wsl-deps.runtime-evidence.map`: shared screenshot-mode tool only.
- `wsl-deps.avec-rimmsqol.map`: RIMMSQOL, shared RIMMSQOL steps and screenshot mode.

The suite deliberately does not duplicate the 35-test offline harness's calculations, XML,
Scribe and static localization checks. Broader animal-production behavior remains documented in
`_tools/FUNCTIONAL-SCENARIOS.md` for the final in-game validation.
