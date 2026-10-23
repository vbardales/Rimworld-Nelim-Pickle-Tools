# Test scenarios: Nelim's Pickle Tools

Functional scenarios of repository (AUDIT.md, `writeTests`, 7.a), moved here from `TESTING.md` on 2026-10-10 where protocol expects them. Offline results, matrix, evidence rules stay in `TESTING.md`.

## Functional scenarios and their scope

Functional scenarios = Gherkin features of `Tests/Pickle/Mod/Pickle/Features/`: each names precondition
(`Given`), action (`When`), expected result (`Then`); failing step says state it found. Gherkin
holds only what running game alone can show; everything else checked offline (`Check-*.ps1`, unit tests,
behaviour checks, all listed under `automated_tests` in `STATUS.md`).

| Tool | Feature | Why it needs the game | What stays manual, and why |
|---|---|---|---|
| Bundle startup, no Biotech, RIMMSQOL bridge | `aggregate-minimal`, `aggregate-no-biotech`, `aggregate-rimmsqol`, `aggregate-rimmsqol-settings` | startup, step discovery, teardown, optional-mod reflection can't be judged from source | none |
| RIMMSQOL restart hand-off | `aggregate-rimmsqol-restart-1-reveal`, `-2-hide`, `-3-forget` | choice surviving restart needs separate processes | click on RIMMSQOL's own checkbox (steps call what checkbox calls; not clicked) |
| ClearScreen, InterfaceScale, KeyedClick, InspectTabs | `pickletools-clearscreen`, `interface-scale`, `pickletools-keyedclick`, `inspect-tabs` | window, scaled click, translated label, tab exist only in game | none |
| ColonistRace | `tools`, `pickletools-colonistrace-bodytype` | genes, body types, races = game rules | none |
| HoverSteps | `pickletools-hoversteps` (played 2026-09-25, English, 1 of 1: autosave interval tooltip hovered by key and drawn; not played in French) | game draws tooltip only under real pointer | tooltip texts other suites hover (Housebroken) read by person in captures; tooltip whose text changes every frame can't be named |
| ClickDiagnostics | `pickletools-clickdiagnostics` (passing case) | pointer position against real button | text of failure report itself. Green version (page does not open, plus control) written and played 2026-09-25: two probe scenarios failed at click, `tag 'btn:New colony' not found; known tags: no tags recorded this frame` (probe windows leave Pickle no tag to click), so symptom can't be asserted that way; scenarios **deleted from suite**, control duplicating `pickletools-keyedclick`. Probe that fails on purpose stays in `Upstream/tests/lost-click-probe.feature` as diagnostic, outside suite, does not yet reach its click |
| SoundCapture (optional, outside bundle) | `pickletools-soundcapture` | sound on audio sink | sink measured silent (-91 dB) on WSL because staging mutes game (volumeMaster 0); with volume step at 80 percent same scenario **passed in WSL on 2026-09-25, peak -16.2 dB** (ticket 0ce6), owner heard music. **Owner's rule of 2026-09-25 (alone, on Windows) withdrawn same day: test runs in WSL, as small ticket, plays on her speakers few seconds.** SoundCapture/Run-Windows.ps1 is hers, for listening, nothing launched on Windows. Game-side check (`pickletools-gamesound`, queued) needs none of it; listening stays by ear |
| ScreenshotStudio, ScreenshotMode | `flower-meadow-studio`, `load-flower-meadow-studio` | saved fixture and captured image | captured images read by person (`@review`), in English and French |
| VEF factions | QuietNewFactions' own suite | VEF's dialog is game window | none |

## Manual checks, disposition (AUDIT.md 8.k, 2026-10-23)

| Manual check | Disposition | Reason |
|---|---|---|
| Real click on RIMMSQOL's own checkbox | not applicable | tests RIMMSQOL, not PickleTools (owner, 2026-10-23); the steps call what the checkbox calls, the restart chain plays that |
| Text of ClickDiagnostics failure report | not applicable | probe windows leave Pickle no tag to click, so the symptom cannot be asserted; probe stays in `Upstream/tests/lost-click-probe.feature`, outside the suite |
| SoundCapture by ear | not applicable to the bundle | optional companion outside the Workshop payload; level measured by ticket 0ce6, listening is hers via `SoundCapture/Run-Windows.ps1` |
| Tooltip texts of other suites (HoverSteps) | read in `@review` captures | image reading already proven by a scenario, not a manual test |
| ScreenshotStudio and ScreenshotMode images, English and French | read in `@review` captures | same; French not played on the 1.7 pass (English-only install) |

**No XML tests**: repository ships no Defs, no XML patches, only step assemblies loaded by test runner, so
no XML to test; nothing artificial added to fill box.