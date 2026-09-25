# Aggregate passes: what each report said

Generated 2026-09-25 19:55 by `Summarize-Aggregate.ps1` from `evidence/aggregate/` on the machine that ran them.
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
| 2026-09-23-v4.9.1-rimmsqol-settings-en | passed | 2/2 (failed 0, skipped 0, flaky 0) | RIMMSQOL writes a temporary visible choice for a normally hidden vanilla button; the bundle's after-scenario hook forgets that choice |
| 2026-09-23-v4.9.1-rimmsqol-settings-fr | passed | 2/2 (failed 0, skipped 0, flaky 0) | RIMMSQOL writes a temporary visible choice for a normally hidden vanilla button; the bundle's after-scenario hook forgets that choice |
| 2026-09-23-v4.9.1-vef-en | NO REPORT | - | no current Pickle report; launcher exit code 1 |
| 2026-09-23-v4.9.1-vef-fr | NO REPORT | - | no current Pickle report; launcher exit code 1 |
| 2026-09-24-v4.9.1-clickdiag-en | passed | 2/2 (failed 0, skipped 0, flaky 0) | the main menu's New colony button stands still and its click opens the scenario page; the button of the page that opened stands still and is reacha... |
| 2026-09-24-v4.9.1-clickdiag-fr | passed | 2/2 (failed 0, skipped 0, flaky 0) | the main menu's New colony button stands still and its click opens the scenario page; the button of the page that opened stands still and is reacha... |
| 2026-09-24-v4.9.1-colonistrace-bodytype | failed | 1/2 (failed 1, skipped 0, flaky 0) | a pawn with two body-type genes gets each body type asked for, in turn; a female pawn gets the Female body when no gene is left |
| 2026-09-24-v4.9.1-rimmsqol-en | passed | 1/1 (failed 0, skipped 0, flaky 0) | the bundle can use the RIMMSQOL bridge when RIMMSQOL is installed |
| 2026-09-24-v4.9.1-rimmsqol-restart-en/seq1 | passed | 1/1 (failed 0, skipped 0, flaky 0) | RIMMSQOL reveals a hidden vanilla button and the choice is kept |
| 2026-09-24-v4.9.1-rimmsqol-restart-en/seq2 | passed | 1/1 (failed 0, skipped 0, flaky 0) | the revealed button survived the restart, then RIMMSQOL hides it again |
| 2026-09-24-v4.9.1-rimmsqol-restart-en/seq3 | passed | 1/1 (failed 0, skipped 0, flaky 0) | hiding the button survived the restart, and RIMMSQOL is put back |
| 2026-09-24-v4.9.1-rimmsqol-restart-en/seq4 | passed | 1/1 (failed 0, skipped 0, flaky 0) | hiding the button survived the restart, and RIMMSQOL is put back |
| 2026-09-24-v4.9.1-rimmsqol-restart-fr/seq1 | passed | 1/1 (failed 0, skipped 0, flaky 0) | RIMMSQOL reveals a hidden vanilla button and the choice is kept |
| 2026-09-24-v4.9.1-rimmsqol-restart-fr/seq2 | passed | 1/1 (failed 0, skipped 0, flaky 0) | the revealed button survived the restart, then RIMMSQOL hides it again |
| 2026-09-24-v4.9.1-rimmsqol-restart-fr/seq3 | passed | 1/1 (failed 0, skipped 0, flaky 0) | hiding the button survived the restart, and RIMMSQOL is put back |
| 2026-09-24-v4.9.1-rimmsqol-restart-fr/seq4 | passed | 1/1 (failed 0, skipped 0, flaky 0) | hiding the button survived the restart, and RIMMSQOL is put back |
| 2026-09-24-v4.9.1-soundcapture-en | NO REPORT | - | no current Pickle report; launcher exit code 1073807364 |
| 2026-09-24-v4.9.1-soundcapture-rerun | failed | 0/1 (failed 1, skipped 0, flaky 0) | the game's sound reaches the recorder from the main menu |
| 2026-09-24-v4.9.1-tools-en/seq1 | passed | 4/4 (failed 0, skipped 0, flaky 0) | a cleared screen closes what is open, and drops what opens next; the explicit step hands windows back; suppression left on is lifted when the scena... |
| 2026-09-24-v4.9.1-tools-en/seq2 | passed | 1/1 (failed 0, skipped 0, flaky 0) | the inspect tabs open on a selected pawn, by short name, type name and label key |
| 2026-09-24-v4.9.1-tools-en/seq3 | passed | 1/1 (failed 0, skipped 0, flaky 0) | a button is clickable at another interface scale |
| 2026-09-24-v4.9.1-tools-en/seq4 | passed | 1/1 (failed 0, skipped 0, flaky 0) | a button is clicked by the key its label comes from |
| 2026-09-24-v4.9.1-tools-en/seq5 | failed | 1/5 (failed 4, skipped 0, flaky 0) | the genie xenotype gives a thin body; the hussar xenotype gives a hulk body; a body type set after the xenotype wins; a colonist can be generated f... |
| 2026-09-24-v4.9.1-tools-en-cross | passed | 11/11 (failed 0, skipped 0, flaky 0) | the inspect tabs open on a selected pawn, by short name, type name and label key; a button is clickable at another interface scale; a cleared scree... |
| 2026-09-24-v4.9.1-tools-en-fix | passed | 4/4 (failed 0, skipped 0, flaky 0) | the genie xenotype gives a thin body; the yttakin xenotype gives a hulk body; a colonist can be generated from a humanlike kind; the readers see th... |
| 2026-09-24-v4.9.1-tools-fr/seq1 | passed | 4/4 (failed 0, skipped 0, flaky 0) | a cleared screen closes what is open, and drops what opens next; the explicit step hands windows back; suppression left on is lifted when the scena... |
| 2026-09-24-v4.9.1-tools-fr/seq2 | passed | 1/1 (failed 0, skipped 0, flaky 0) | the inspect tabs open on a selected pawn, by short name, type name and label key |
| 2026-09-24-v4.9.1-tools-fr/seq3 | failed | 0/1 (failed 1, skipped 0, flaky 0) | a button is clickable at another interface scale |
| 2026-09-24-v4.9.1-tools-fr-final | failed | 10/11 (failed 1, skipped 0, flaky 0) | the inspect tabs open on a selected pawn, by short name, type name and label key; a button is clickable at another interface scale; a cleared scree... |
| 2026-09-24-v4.9.1-vef-en | failed | 0/5 (failed 1, skipped 4, flaky 0) | the mod loads after the framework it patches; loading the fixture leaves no window open; VEF's check ignores the faction instead of asking; the cho... |
| 2026-09-24-v4.9.1-vef-en-rerun | passed | 5/5 (failed 0, skipped 0, flaky 0) | the mod loads after the framework it patches; loading the fixture leaves no window open; VEF's check ignores the faction instead of asking; the cho... |
| 2026-09-24-v4.9.1-vef-fr-final | passed | 5/5 (failed 0, skipped 0, flaky 0) | the mod loads after the framework it patches; loading the fixture leaves no window open; VEF's check ignores the faction instead of asking; the cho... |
| 2026-09-25-v4.9.1-colonistrace-bodytype-fix | passed | 2/2 (failed 0, skipped 0, flaky 0) | a pawn with two body-type genes gets each body type asked for, in turn; a female pawn gets the Female body when no gene is left |
| 2026-09-25-v4.9.1-colonistrace-child | failed | 2/3 (failed 1, skipped 0, flaky 0) | a pawn with two body-type genes gets each body type asked for, in turn; a female pawn gets the Female body when no gene is left; a child gets the b... |
| 2026-09-25-v4.9.1-gamesound-en | passed | 1/1 (failed 0, skipped 0, flaky 0) | the game holds a playing sound on the main menu |
| 2026-09-25-v4.9.1-hoversteps-en | failed | 0/1 (failed 1, skipped 0) | a tooltip of the options dialog is hovered by its key and is drawn; "Ambiguous step: Multiple matches found: KeyedClickSteps.ClickButtonKeyed" because the bundle committed under Mod/ was staged with the standalone tool; fixed by the StandaloneBase overlay (row written by hand, the folder was deleted before it was summarized) |
| 2026-09-25-v4.9.1-hoversteps-en2 | failed | 0/1 (failed 1, skipped 0, flaky 0) | a tooltip of the options dialog is hovered by its key and is drawn |
| 2026-09-25-v4.9.1-hoversteps-en3 | passed | 1/1 (failed 0, skipped 0, flaky 0) | a tooltip of the options dialog is hovered by its key and is drawn |
| 2026-09-25-v4.9.1-interfacescale-fr-fix | passed | 1/1 (failed 0, skipped 0, flaky 0) | a button is clickable at another interface scale |
| 2026-09-25-v4.9.1-lostclickprobe-en | failed | 1/3 (failed 2, skipped 0, flaky 0) | a window covers the button and an image button in it takes the click; a window that absorbs input elsewhere swallows the click; control, with nothi... |
| 2026-09-25-v4.9.1-soundcapture-volume-en | passed | 1/1 (failed 0, skipped 0, flaky 0) | the game's sound reaches the recorder from the main menu |
| 2026-09-25-v4.9.1-tools-fr-final2 | passed | 11/11 (failed 0, skipped 0, flaky 0) | the inspect tabs open on a selected pawn, by short name, type name and label key; a button is clickable at another interface scale; a cleared scree... |
