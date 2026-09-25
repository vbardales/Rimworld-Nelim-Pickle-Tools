# Changelog

## [1.1.0] - 2026-09-25

Changes since 1.0.0 (commit `2dc9845`). The payload DLLs that changed are ClickDiagnostics, ColonistRace, ScreenshotMode, VefFactions and Rimmsqol. The version number is proposed and awaits the owner's confirmation.

### Added

- ColonistRace: `Nelim's Pickle Tools: {string} body type is {word}` (`Male`, `Female`, `Thin`, `Fat`, `Hulk`) gives a pawn a body type that is certain, by removing every body-type gene and adding the one of that type (`Body_Standard` for Male and Female), then reads the type back. Played 2 of 2 on Pickle v4.9.1.
- ScreenshotMode: steps that turn developer mode off for a capture that keeps the interface.
- HoverSteps (hover a tooltip region by its text) and SoundCapture (optional: record the game's sound, and assert that the game holds a playing sound). **Neither is in the bundle**: `Release/Prepare-Release.ps1` lists thirteen tools and names neither.

### Changed

- ClickDiagnostics: the stand-still wait says how long it really waited and gives up on the clock; a window already open before the click does not count.
- The Workshop payload is committed under `Mod/` (the thirteen DLLs, copied from the tools by `Release/Prepare-Release.ps1 -SyncMod` and checked by `-Check`), so the publish workflow uploads exactly what was tested.
- The interface-scale scenario clicks by the key of its label, so it also plays in French.
- The step vocabulary checks (`Check-Steps.ps1`) read the sibling tools and attributes written as `Prefix + "..."`.

### Tested

- The aggregate bundle on Pickle v4.9.1, English and French: minimal, Biotech absent, RIMMSQOL bridge and settings, the RIMMSQOL restart chain, the five tool features together (11 of 11 in each language) and the VEF-present pass (5 of 5 in each language). See `docs/runs/aggregate.md`.

## [1.0.0] - 2026-09-22

First release: Steam Workshop item `3806142401` (uploaded 2026-09-22 11:59 UTC) and GitHub release `v1.0.0`, tag on `2dc9845`. The GitHub release was deleted by mistake on 2026-09-25 and recreated the same day, with its original text and on the same commit; **its three attached files** (`PickleTools-1.0.0-github.zip`, `PickleTools-1.0.0-workshop.zip` and `SHA256SUMS.txt`, sha256 `0cf9bbd5...`, `867f1137...`, `55832413...`) **could not be recovered** and are missing from the recreated release. The commit whose `Mod/` was uploaded to Steam is not recorded.
### Added

- Package thirteen reusable Pickle step modules as one `nelim.pickletools` Workshop item, with only Pickle
  required globally and test-specific integrations remaining optional.
- Add suite-authoring, testing and release documentation; consolidate the inventory of suite-owned steps.
- Promote QuietNewFactions' VEF workflow vocabulary into `VefFactionSteps` and migrate its suite to the shared module.
- Record licences, studied projects, AI assistance and DALL-E image provenance in the distributed attribution.
- Runtime validation of the aggregate bundle remains pending and must be recorded before publication.
- Add ScreenshotStudio as an optional companion. Its zen meadow is the default fixture for presentation and
  screenshot scenarios; construction/save-reload and separate-process fixture loading both passed.

### Earlier candidate, 0.1.0-rc.1, 2026-09-22

- Prepare one Workshop bundle with thirteen modules and a GitHub archive with development companions, preserving packageIds
  and source paths. ScreenshotStudio remains excluded as scene-specific work in progress.
- Include MIT notices in every payload, shared presentation assets, dependency metadata, source links,
  DLL SHA256 hashes and archive checksums. Publication and runtime validation are still pending.
- Add a new suite authoring guide and consolidate the Elsewhere catalogue with a checked sixteen-suite inventory.
- Correct dependency tags, restart arrays, report retention, scaled diagnostics and upstream migration guidance.

### Tool notes at the time of the release

#### RimmsqolSteps

- 17 Pickle steps that reveal, hide and forget any `MainButtonDef` through RIMMSQOL's own settings instance,
  read the file it wrote, assert what the main bar draws, and open its own window for a capture; a teardown after
  every scenario and a hand-off between launches for restart chains.
- Three offline checks: `Check-Bridge.ps1` (the binaries), `Check-Reader.ps1` (the settings-file reader),
  `Check-Steps.ps1` (patterns, ambiguity against Pickle, the other suites and the sibling tools).
- First in-game run, 2026-09-21, in the `avec-rimmsqol` pass of FlavorTextExtendedFR: four launches, all passed,
  and again after the rename, 23:12 to 23:18: four launches, all passed.
  Logs and four captures in `RimmsqolSteps/evidence/2026-09-21/`.
- Identifiers: packageId `nelim.pickletools.rimmsqol`, assembly and namespace `Nelim.PickleTools.Rimmsqol`.
  The first version was `nelim.pickleshared.rimmsqol`, in the monorepo's `PickleShared/`.

#### ClickDiagnostics

- Three Pickle steps for a click that must land: wait until a button has stood still for 12 frames, check that the
  window under the pointer is the expected one and receives input, click and wait for a window, and on a lost click
  print the pointer, the buttons under it (image buttons too, through a Harmony postfix) and the window stack.
  Moved here on 2026-09-21 from Work Studio's suite (`ImageButtonProbe`, `WaitForButtonToSettle`, the window-stack
  dump), and generalised. Compiled with 0 warnings, patterns checked, not played as steps yet.

#### ExpansionSteps

- Two Pickle steps that assert an expansion, or any mod, is active in `ModsConfig` by package id, for a pass that leaves a DLC
  out (`!ludeon.rimworld.odyssey` in the pass map). Moved here on 2026-09-21 from Flavor Text Extended's suite, where they
  passed in its `sans-odyssey` pass. Compiled with 0 warnings, patterns checked and unambiguous against 609 others, not played
  as a shared mod yet.

#### VefFactionSteps

- Promote QuietNewFactions' nine VEF workflow steps into a shared, prefixed module. The suite now consumes
  that module through an explicit pass map and no longer ships a private step DLL.
- Built with 0 warnings and 0 errors; all patterns compile and are unique and unambiguous in the repository.
  The former suite-owned DLL passed five scenarios on 2026-09-20, but the promoted DLL has not been replayed.

#### Repository

- Icon (`Mod/About/ModIcon.png`, 128 x 128) and preview (`Mod/About/Preview.png`, 896 x 504), with their
  sources and the page that engraves the preview in `Art/`.
- `LICENSE` (MIT), `ATTRIBUTION.md`, `STATUS.md`.
- Other tools added by other sessions are recorded in their own folders: `FilmTicks/`, `ResearchSteps/`,
  `ColonistRace/`, `InspectTabs/`, `KeyedClick/`, `Upstream/`. Steps that live in a suite and could be taken from there are listed in the
  README.
