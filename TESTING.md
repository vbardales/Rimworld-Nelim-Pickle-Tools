# Testing PickleTools

Scope: one `nelim.pickletools` bundle, fourteen general-purpose modules. ScreenshotStudio and Quiet New Factions
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

**Baseline moved to [Pickle v4.9.1](https://github.com/RimWorks/Rimworld-Pickle/releases/tag/v4.9.1) on
2026-09-23** (v4.9.0 added `!` exclusions and extension-less feature names in the run filter; v4.9.1 refuses camera
steps while the world view is open). The official `Pickle-4.9.1.zip` has SHA256
`8C5BA4C17FBBD2A953EF3CE2661919D29D46F757D7CC3BFC14B0D1F096B7610B`, equal to the digest GitHub publishes for the
asset; its `RimWorks.Pickle.dll` reports assembly version `4.9.1.0`; it is unpacked at
`.build/upstream-v4.9.1/Pickle`. **One probe has run on it**: the English minimal aggregate smoke, filter
`aggregate-minimal,aggregate-no-biotech,!aggregate-no-biotech`, `exitReason: passed`, 1 of 1, the only scenario in
the report being the minimal one (the excluded feature was not played), report in
`evidence/aggregate/2026-09-23-v4.9.1-minimal-en-filter/`. That shows the two filter changes and a startup on the new
version with the generated payload; it is **not** the matrix by itself. The matrix was then replayed on 4.9.1 on
2026-09-23 and 2026-09-25 (rows `v4.9.1` of [`docs/runs/aggregate.md`](docs/runs/aggregate.md)); the passes still open
are listed in `remaining` of `STATUS.md`.

Previous baseline: [Pickle v4.8.4](https://github.com/RimWorks/Rimworld-Pickle/releases/tag/v4.8.4),
published 2026-09-22 and including upstream PR #20. The official `Pickle-4.8.4.zip` has SHA256
`088911EA5C29FE91D2AEE5C668BCDEF60061955AE75D38E1EA29E0B39CDBD93C`; its `RimWorks.Pickle.Core.dll`
reports assembly version `4.8.4.0`. It is unpacked locally at `.build/upstream-v4.8.4/Pickle` and passed to
`Run-PickleWsl.ps1 -PickleSrc` for the aggregate probes. Earlier runs against the staged Workshop
copy are historical evidence, not validation of this baseline. On 2026-09-23 the corrected bundle passed
the English main-menu smoke probe with the default DLC set (1/1) and without Biotech (1/1), with reports in
`evidence/aggregate/2026-09-23-v4.8.4-fixed-minimal-en/` and
`evidence/aggregate/2026-09-22-v4.8.4-fixed-no-biotech-en/`. The first attempts had failed 0/1 during
scenario teardown; the reports remain alongside these passes. These smoke probes do not cover the full matrix.

Three dependency sets in English and French: **six baseline launches**, plus restart sequences below.

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
`QuietNewFactions/Tests/Pickle/wsl-deps.pickletools.map` stages the same bundle for the VEF-present replay,
and its feature tags require the bundle plus VEF. VEF remains optional for the bundle itself.
The English and French VEF replays each passed 5/5 on 2026-09-23, with reports archived at
`evidence/aggregate/2026-09-23-v4.8.4-vef-en/` and
`evidence/aggregate/2026-09-23-v4.8.4-vef-fr/`. The game exited 137 after writing each complete
report; the launcher recorded `exitReason: passed`. The English RIMMSQOL-present bridge smoke probe
passed 1/1 with its report at `evidence/aggregate/2026-09-23-v4.8.4-rimmsqol-en/`.
Settings changes, restart and the French RIMMSQOL pass remain pending.
The French minimal/without-Biotech and French RIMMSQOL bridge passes, plus the English settings-cleanup
probe, were attempted on 2026-09-23 but stopped before game launch when WSL's root filesystem became
read-only. Their `no-report.txt` files are infrastructure records, not test results. Do not create or
retry a Pickle ticket until the owner explicitly authorizes it.
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

## Functional scenarios and their scope

The functional scenarios are the Gherkin features of `Tests/Pickle/Mod/Pickle/Features/`: each one names its precondition
(`Given`), its action (`When`) and its expected result (`Then`), and a step that fails says the state it found. Gherkin
holds only what a running game alone can show; everything else is checked offline (`Check-*.ps1`, the unit tests, the
behaviour checks, all listed under `automated_tests` in `STATUS.md`).

| Tool | Feature | Why it needs the game | What stays manual, and why |
|---|---|---|---|
| Bundle startup, no Biotech, RIMMSQOL bridge | `aggregate-minimal`, `aggregate-no-biotech`, `aggregate-rimmsqol`, `aggregate-rimmsqol-settings` | startup, step discovery, teardown, optional-mod reflection cannot be judged from source | none |
| RIMMSQOL restart hand-off | `aggregate-rimmsqol-restart-1-reveal`, `-2-hide`, `-3-forget` | a choice surviving a restart needs separate processes | the click on RIMMSQOL's own checkbox (the steps call what the checkbox calls; not clicked) |
| ClearScreen, InterfaceScale, KeyedClick, InspectTabs | `pickletools-clearscreen`, `interface-scale`, `pickletools-keyedclick`, `inspect-tabs` | a window, a scaled click, a translated label and a tab exist only in the game | none |
| ColonistRace | `tools`, `pickletools-colonistrace-bodytype` | genes, body types and races are game rules | none |
| HoverSteps | `pickletools-hoversteps` (written 2026-09-25, first play queued) | the game draws a tooltip only under a real pointer | the tooltip texts other suites hover (Housebroken) are read by a person in the captures; a tooltip whose text changes every frame cannot be named |
| ClickDiagnostics | `pickletools-clickdiagnostics` (passing case) | pointer position against a real button | the text of the failure report itself: the symptoms are asserted green (`lost-click-probe`: the page does not open, plus a control that opens it, written 2026-09-25, first play queued); the report's text is read from the copy that fails on purpose, `Upstream/tests/lost-click-probe.feature`, which is a diagnostic outside the suite |
| SoundCapture (optional, outside the bundle) | `pickletools-soundcapture` | sound on the audio sink | the sink measured silent (-91 dB) on WSL, cause not established. **Owner's rule, 2026-09-25: a test that uses SoundCapture is run alone and on Windows, the mod list changed then restored**; the recording is still to be tested there (the tool only knows PulseAudio), nothing was launched; the dedicated launcher is SoundCapture/Run-Windows.ps1 (dry run checked), and the WSL staging mutes the game (volumeMaster 0), which probably explains the silence. The game-side check (`pickletools-gamesound`, queued) needs none of it; listening stays by ear |
| ScreenshotStudio, ScreenshotMode | `flower-meadow-studio`, `load-flower-meadow-studio` | a saved fixture and a captured image | the captured images are read by a person (`@review`), in English and in French |
| VEF factions | QuietNewFactions' own suite | VEF's dialog is a game window | none |

**No XML tests**: the repository ships no Defs and no XML patches, only step assemblies loaded by the test runner, so
there is no XML to test; nothing artificial is added to fill the box.

## Evidence and acceptance

Reports and captures stay **on disk** under `evidence/` (ignored by git). The text summary of each run is in
[`docs/runs/`](docs/runs/README.md): `aggregate.md` is regenerated from the reports by `Summarize-Aggregate.ps1`.
The `evidence/...` paths quoted in this file name folders on the machine that ran the passes.

Retain command, map, language/DLC set, source revision, DLL hashes, fresh report, exitReason,
expected/executed/skipped counts, startup Player.log and reviewed captures. Missing/skipped required
scenarios and partial reports are unverified, not passed. Update STATUS without promoting blocked gates.

### What to keep after a test, and what to delete

Launch with `-EvidenceDir evidence/aggregate/<date>-<pickle version>-<pass>` so the report is copied out of the
shared, rolling `pickle-reports` before the next run overwrites it. The copy is clean; a folder copied by hand from
`pickle-reports` was once 1 GB because it dragged the shared `screenshots/` of every earlier run along.

| Keep, per pass | Why |
|---|---|
| `summary.json` and `summary.md` | The verdict: `exitReason`, counts, scenario names. Read `exitReason` first |
| `junit.xml` and `messages.ndjson` | The per-step outcome and the failure messages; a failed step is diagnosed from these |
| `Player.log` | Startup, load order, dropped mods, errors outside the scenarios |
| `evidence-complete.txt` or `no-report.txt` | Says the copy is whole, or that the launcher left no report (infrastructure, not a result) |
| The `@review` captures and films the pass exists to produce, **minified to JPEG** | Human review outcome; about 250 KB to 0.7 MB each, against 2.4 to 5.5 MB as PNG |
| One line in [`docs/runs/`](docs/runs/README.md) | The history. Regenerate `aggregate.md` with `Summarize-Aggregate.ps1` **before** deleting a folder |

| Delete | When |
|---|---|
| `screenshots/` copied whole from `pickle-reports` | Never keep it. It holds other runs' captures and failure shots |
| `report.html` | Optional once the verdict is recorded: the largest file of a text-only run (1.5 MB of 1.6 MB) |
| A report of a failed or infrastructure-error attempt | Once its line is in `aggregate.md` and its cause is written in `STATUS.md` |
| A report superseded by a newer one for the same scenario and the same revision | When the newer one exists, unless the older one is the **only** proof of a check the newer run did not repeat (a Biotech-absent pass, a language, a VEF-present pass) |
| Any report on a superseded build (an older Pickle version, an older payload) | After the pass is repeated on the current one: it proves nothing about the current build |

**Never delete a report that a `STATUS.md` field or a tracked file points to.** Repoint the field to its row in
`docs/runs/aggregate.md` first, then delete. Two files stay tracked although `evidence/` is ignored, because a script
reads them (`ScreenshotStudio/evidence/2026-09-22-zen/verification.json` and `fixture-load-summary.json`).
The rule comes from the collection's `AGENTS.md` ("Test evidence"): the disk was full at 3 GB free with 10 GB of
evidence here.

Check both archives: one Workshop root About, thirteen intended DLLs, licence/attribution, no dependency
DLLs or saves, exact packageId and only Pickle as a direct hard dependency. Verify SHA256SUMS and each DLL
hash against the build. Remaining publication gates are listed in [Release](Release/README.md).
