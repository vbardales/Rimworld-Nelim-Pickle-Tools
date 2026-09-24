# Aggregate passes: what each report said

Generated 2026-09-24 07:55 by `Summarize-Aggregate.ps1` from `evidence/aggregate/` on the machine that ran them.
The reports are not in git and the superseded ones are deleted (AGENTS.md, Test evidence); their rows stay. Read `exitReason` before the counts; a NO REPORT row is an infrastructure record, not a result.
The Pickle version is in the folder name (`v4.8.4`, `v4.9.1`); a folder without one ran against the staged Workshop copy.

| Folder | exitReason | Scenarios passed/total | Scenarios |
|---|---|---|---|
| 2026-09-22-minimal-en | infrastructure-error | 0/0 (failed 0, skipped 0) |  |
| 2026-09-22-minimal-en-dlc-id | failed | 0/1 (failed 1, skipped 0) | The generated aggregate exposes a distributed step in a minimal game |
| 2026-09-22-minimal-en-retry | failed | 0/1 (failed 1, skipped 0) | The generated aggregate exposes a distributed step in a minimal game |
| 2026-09-22-v4.8.4-fixed-no-biotech-en | passed | 1/1 (failed 0, skipped 0, flaky 0) | the bundle starts and discovers expansion steps without Biotech |
| 2026-09-22-v4.8.4-minimal-en | failed | 0/1 (failed 1, skipped 0) | The generated aggregate exposes a distributed step in a minimal game |
| 2026-09-22-v4.8.4-no-biotech-en | failed | 0/1 (failed 1, skipped 0) | the bundle starts and discovers expansion steps without Biotech |
| 2026-09-23-v4.8.4-fixed-minimal-en | passed | 1/1 (failed 0, skipped 0, flaky 0) | The generated aggregate exposes a distributed step in a minimal game |
| 2026-09-23-v4.8.4-fixed-minimal-fr | NO REPORT | - | no current Pickle report; launcher exit code 1 |
| 2026-09-23-v4.8.4-fixed-no-biotech-fr | NO REPORT | - | no current Pickle report; launcher exit code 1 |
| 2026-09-23-v4.8.4-rimmsqol-en | passed | 1/1 (failed 0, skipped 0, flaky 0) | the bundle can use the RIMMSQOL bridge when RIMMSQOL is installed |
| 2026-09-23-v4.8.4-rimmsqol-fr | NO REPORT | - | no current Pickle report; launcher exit code 1 |
| 2026-09-23-v4.8.4-rimmsqol-settings-en | NO REPORT | - | no current Pickle report; launcher exit code 1 |
| 2026-09-23-v4.8.4-vef-en | passed | 5/5 (failed 0, skipped 0, flaky 0) | the mod loads after the framework it patches; loading the fixture leaves no window open; VEF's check ignores the faction instead of asking; the cho... |
| 2026-09-23-v4.8.4-vef-fr | passed | 5/5 (failed 0, skipped 0, flaky 0) | the mod loads after the framework it patches; loading the fixture leaves no window open; VEF's check ignores the faction instead of asking; the cho... |
| 2026-09-23-v4.9.1-minimal-en-filter | passed | 1/1 (failed 0, skipped 0, flaky 0) | The generated aggregate exposes a distributed step in a minimal game |
| 2026-09-23-v4.9.1-minimal-fr | passed | 1/1 (failed 0, skipped 0, flaky 0) | The generated aggregate exposes a distributed step in a minimal game |
| 2026-09-23-v4.9.1-no-biotech-en | passed | 1/1 (failed 0, skipped 0, flaky 0) | the bundle starts and discovers expansion steps without Biotech |
| 2026-09-23-v4.9.1-no-biotech-fr | passed | 1/1 (failed 0, skipped 0, flaky 0) | the bundle starts and discovers expansion steps without Biotech |
| 2026-09-23-v4.9.1-rimmsqol-fr | passed | 1/1 (failed 0, skipped 0, flaky 0) | the bundle can use the RIMMSQOL bridge when RIMMSQOL is installed |
