# Test scenarios: Nelim's Pickle Tools

The functional scenarios of the repository (AUDIT.md, `writeTests`, 7.a), moved here from `TESTING.md` on 2026-10-10 where the protocol expects them. The offline results, the matrix and the evidence rules stay in `TESTING.md`.

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
| HoverSteps | `pickletools-hoversteps` (played 2026-09-25, English, 1 of 1: the autosave interval tooltip is hovered by its key and drawn; not played in French) | the game draws a tooltip only under a real pointer | the tooltip texts other suites hover (Housebroken) are read by a person in the captures; a tooltip whose text changes every frame cannot be named |
| ClickDiagnostics | `pickletools-clickdiagnostics` (passing case) | pointer position against a real button | the text of the failure report itself. A green version (the page does not open, plus a control) was written and played on 2026-09-25: the two probe scenarios failed at the click, `tag 'btn:New colony' not found; known tags: no tags recorded this frame` (the probe windows leave Pickle no tag to click), so the symptom cannot be asserted that way and the scenarios were **deleted from the suite**, the control duplicating `pickletools-keyedclick`. The probe that fails on purpose stays in `Upstream/tests/lost-click-probe.feature` as a diagnostic, outside the suite, and does not yet reach its click |
| SoundCapture (optional, outside the bundle) | `pickletools-soundcapture` | sound on the audio sink | the sink measured silent (-91 dB) on WSL because the staging mutes the game (volumeMaster 0); with the volume step at 80 percent the same scenario **passed in WSL on 2026-09-25, peak -16.2 dB** (ticket 0ce6), and the owner heard the music. **The owner's rule of 2026-09-25 (alone, on Windows) was withdrawn the same day: the test runs in WSL, as a small ticket, and plays on her speakers for a few seconds.** SoundCapture/Run-Windows.ps1 is hers, for listening, and nothing was launched on Windows. The game-side check (`pickletools-gamesound`, queued) needs none of it; listening stays by ear |
| ScreenshotStudio, ScreenshotMode | `flower-meadow-studio`, `load-flower-meadow-studio` | a saved fixture and a captured image | the captured images are read by a person (`@review`), in English and in French |
| VEF factions | QuietNewFactions' own suite | VEF's dialog is a game window | none |

**No XML tests**: the repository ships no Defs and no XML patches, only step assemblies loaded by the test runner, so
there is no XML to test; nothing artificial is added to fill the box.
