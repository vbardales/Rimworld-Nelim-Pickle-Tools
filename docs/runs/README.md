# Runs: what was played, in text

**Evidence lives on disk and is not in git.** A Pickle report is a folder of screenshots, a `Player.log`, a
`junit.xml` and a `report.html`, several megabytes each and ten gigabytes after a matrix. `evidence/` is in
`.gitignore` at every level. What the repository keeps is a text summary here, enough to read the verdict, the
counts and the scenario names without the folder.

| File | Covers |
|---|---|
| [`aggregate.md`](aggregate.md) | Every pass of the aggregate bundle kept in `evidence/aggregate/`, one row each. **Generated**: run [`Summarize-Aggregate.ps1`](Summarize-Aggregate.ps1) after a run |
| [`2026-09-21-rimmsqol.md`](2026-09-21-rimmsqol.md) | The RIMMSQOL steps in game, twice: first identifiers, then the renamed build |
| [`2026-09-22-screenshotstudio.md`](2026-09-22-screenshotstudio.md) | ScreenshotStudio: the zen fixture, its reload and its presentation captures |

## Rules

- **One verdict per row, from the report.** Read `exitReason` before the counts. A folder with a `no-report.txt`
  and no `summary.json` is an infrastructure record, listed as NO REPORT, never as a pass or a failure.
- **Say what was not shown.** A summary that lists only what passed misleads; each file ends with its limits.
- **Screenshots stay on disk.** Where one matters, describe it in a sentence here. Do not commit the image.
- **Exceptions still tracked although `evidence/` is ignored** (a tracked file stays tracked):
  `ScreenshotStudio/evidence/2026-09-22-zen/verification.json` and `fixture-load-summary.json`, which
  `Release/Package-ScreenshotStudio.ps1` reads to refuse a fixture that does not match its export; and
  `TextureOwner/evidence/suite/`, which is the source of a throwaway test suite that README describes,
  not evidence (a rename would be the honest fix, and was not done here).
- **Earlier commits still hold what was tracked before.** Untracking does not rewrite history.
