# Testing PickleTools

Scope: one `nelim.pickletools` bundle, thirteen general-purpose modules. ScreenshotStudio and Quiet New Factions
are optional companions, excluded from the aggregate Workshop payload and validated independently.

## Offline results - 2026-09-22

- All thirteen distributed modules passed Release builds with .NET SDK 10.0.401: 0 warnings, 0 errors.
- All thirteen available Check-*.ps1 scripts passed (patterns, bridge, reader, ownership).
- FilmTicks unit tests: 7 passed, 0 failed, 0 skipped.
- Elsewhere inventory currently matches nineteen local suites (2026-09-22 refresh); this is a source inventory, not runtime validation.
- VefFactionSteps built with 0 warnings and 0 errors; its nine patterns compiled, were unique and
  unambiguous, and every QuietNewFactions consumer line resolved. This is offline evidence only.

Current 1.0.0 logs: `.build/release-checks-1.0.0`. Each script covers its documented scan scope. ColonistRace and InspectTabs
have no individual Check-Steps script in this snapshot. These checks do not prove aggregate runtime safety.

## Screenshot fixture default

For Pickle presentation and screenshot scenarios, use `nelim-zen-meadow-studio` as the default saved fixture.
Stage `nelim.pickletools.screenshotstudio` and `nelim.pickletools.clearscreen` through
`Tests/Pickle/wsl-deps.studio.map`, then load that save explicitly. The zen fixture passed construction,
save/reload and a separate-process direct load on 2026-09-22; its evidence is under
`ScreenshotStudio/evidence/2026-09-22-zen/`. It uses the tested five-DLC profile. Do not replace a functional
scenario's fixture unless the zen save establishes all of that scenario's documented preconditions.

## Runtime matrix - pending

Current preTest baseline: [Pickle v4.8.4](https://github.com/RimWorks/Rimworld-Pickle/releases/tag/v4.8.4),
published 2026-09-22 and including upstream PR #20. The official `Pickle-4.8.4.zip` has SHA256
`088911EA5C29FE91D2AEE5C668BCDEF60061955AE75D38E1EA29E0B39CDBD93C`; its `RimWorks.Pickle.Core.dll`
reports assembly version `4.8.4.0`. It is unpacked locally at `.build/upstream-v4.8.4/Pickle` and passed to
`Run-PickleWsl.ps1 -PickleSrc` for the queued aggregate probes. Earlier runs against the staged Workshop
copy are historical evidence, not validation of this baseline. No v4.8.4 in-game result is claimed yet.

Two dependency sets in English and French: **four baseline launches**, plus restart sequences below.

| Set | Content | Required checks |
|---|---|---|
| Minimal | Game, Pickle and its required dependencies, bundle, dedicated test companion; no RIMMSQOL or other optional targets | General modules discovered once, no missing types/assemblies at startup or teardown, representative success/refusal cases; optional scenarios skipped by requirement |
| RIMMSQOL | Minimal plus RIMMSQOL | UI/action/file assertions and cleanup, general modules still work, no duplicate expressions |
| VEF factions | Minimal plus Vanilla Expanded Framework and the optional Quiet New Factions companion | The promoted QuietNewFactions scenarios pass with the aggregate bundle; required and optional factions retain their expected dialog/ignore behavior |

Also run the RIMMSQOL writer/reader/reset chain in separate processes under one `-Then` lock in each
language. Verify distinct processes and final settings cleanup; rereading inside one process is not a restart.
Biotech checks additionally need a Biotech-absent pass confirming suite requirement skips. Record all DLCs.
No declared incompatibility is currently established, so no conflict pass is claimed.

The aggregate probe suite is in `Tests/Pickle/`; its minimal probe overlays the generated aggregate payload.
Extend it from the existing module probes, then execute the required matrix. Change per-tool tags
to `@requires:nelim.pickletools`, retaining actual optional target/DLC tags. Unchanged standalone tags would
skip and cannot certify the bundle. Historical standalone runs are not aggregate results.

Cover ClearScreen teardown, InterfaceScale restoration, scaled diagnostics, FilmTicks failure cleanup,
research/inspect tabs, pawn readback, texture ownership and expansion guards. Include cross-module
regressions: InterfaceScale installs a run-wide hook. Inspect required captures in both languages.
Never enable bundle and standalone companions together. Preserve existing settings during test cleanup.

Launch only through Run-PickleWsl.ps1 when the audit workflow permits it; see [Authoring](Authoring/README.md)
and [Headless](Headless/README.md). No Windows game launch. Without RIMMSQOL, startup/reflection/JIT is a
required explicit check: source guards alone do not prove it.

## Evidence and acceptance

Retain command, map, language/DLC set, source revision, DLL hashes, fresh report, exitReason,
expected/executed/skipped counts, startup Player.log and reviewed captures. Missing/skipped required
scenarios and partial reports are unverified, not passed. Update STATUS without promoting blocked gates.

Check both archives: one Workshop root About, thirteen intended DLLs, licence/attribution, no dependency
DLLs or saves, exact packageId and only Pickle as a direct hard dependency. Verify SHA256SUMS and each DLL
hash against the build. Remaining publication gates are listed in [Release](Release/README.md).
