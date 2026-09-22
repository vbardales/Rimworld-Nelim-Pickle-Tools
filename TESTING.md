# Testing PickleTools

Scope: one `nelim.pickletools` bundle, thirteen general-purpose modules. ScreenshotStudio is excluded.

## Offline results - 2026-09-22

- All thirteen distributed modules passed Release builds with .NET SDK 10.0.401: 0 warnings, 0 errors.
- All thirteen available Check-*.ps1 scripts passed (patterns, bridge, reader, ownership).
- FilmTicks unit tests: 7 passed, 0 failed, 0 skipped.
- Elsewhere inventory matched sixteen local suites.
- VefFactionSteps built with 0 warnings and 0 errors; its nine patterns compiled, were unique and
  unambiguous, and every QuietNewFactions consumer line resolved. This is offline evidence only.

Current 1.0.0 logs: `.build/release-checks-1.0.0`. Each script covers its documented scan scope. ColonistRace and InspectTabs
have no individual Check-Steps script in this snapshot. These checks do not prove aggregate runtime safety.

## Runtime matrix - pending

Two dependency sets in English and French: **four baseline launches**, plus restart sequences below.

| Set | Content | Required checks |
|---|---|---|
| Minimal | Game, Pickle and its required dependencies, bundle, dedicated test companion; no RIMMSQOL or other optional targets | General modules discovered once, no missing types/assemblies at startup or teardown, representative success/refusal cases; optional scenarios skipped by requirement |
| RIMMSQOL | Minimal plus RIMMSQOL | UI/action/file assertions and cleanup, general modules still work, no duplicate expressions |
| VEF factions | Minimal plus Vanilla Expanded Framework and Quiet New Factions | The promoted QuietNewFactions scenarios pass with the aggregate bundle; required and optional factions retain their expected dialog/ignore behavior |

Also run the RIMMSQOL writer/reader/reset chain in separate processes under one `-Then` lock in each
language. Verify distinct processes and final settings cleanup; rereading inside one process is not a restart.
Biotech checks additionally need a Biotech-absent pass confirming suite requirement skips. Record all DLCs.
No declared incompatibility is currently established, so no conflict pass is claimed.

The aggregate probe suite still needs assembling from existing probes and executing. Change per-tool tags
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
