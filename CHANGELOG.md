# Changelog

No tag and no GitHub release exist: the CI creates both after a successful Steam upload. A `v1.0.0` tag and release made by hand on 2026-09-22 were deleted on 2026-09-25, for that reason.

## [Unreleased]

The content of the 1.0.0 candidate, below, and of the `Unreleased` tool notes at the end of this file. It is dated and renamed `## [1.0.0]` when the publication is prepared.

### 1.0.0 candidate, 2026-09-22

- Package thirteen reusable Pickle step modules as one `nelim.pickletools` Workshop item, with only Pickle
  required globally and test-specific integrations remaining optional.
- Add suite-authoring, testing and release documentation; consolidate the inventory of suite-owned steps.
- Promote QuietNewFactions' VEF workflow vocabulary into `VefFactionSteps` and migrate its suite to the shared module.
- Record licences, studied projects, AI assistance and DALL-E image provenance in the distributed attribution.
- Runtime validation of the aggregate bundle remains pending and must be recorded before publication.
- Add ScreenshotStudio as an optional companion. Its zen meadow is the default fixture for presentation and
  screenshot scenarios; construction/save-reload and separate-process fixture loading both passed.

### 0.1.0-rc.1 - local candidate, 2026-09-22

- Prepare one Workshop bundle with thirteen modules and a GitHub archive with development companions, preserving packageIds
  and source paths. ScreenshotStudio remains excluded as scene-specific work in progress.
- Include MIT notices in every payload, shared presentation assets, dependency metadata, source links,
  DLL SHA256 hashes and archive checksums. Publication and runtime validation are still pending.
- Add a new suite authoring guide and consolidate the Elsewhere catalogue with a checked sixteen-suite inventory.
- Correct dependency tags, restart arrays, report retention, scaled diagnostics and upstream migration guidance.

### Tool notes

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

## [0.1.0] - 2026-09-22

Creation of the Workshop item (a `publishIdFile`), the only Steam upload so far: item `3806142401`, uploaded at 11:59 UTC, 736,291 bytes, one subscriber, visibility public as read from Steam's public API on 2026-09-25 (`visibility` 0). `Mod/About/PublishedFileId.txt` was committed in `2dc9845`. **The commit whose `Mod/` was uploaded is not recorded**, so this entry cannot say what the item holds; the upload predates the dry-run and the tag rules of `PUBLISHING.md`. It does not say the bundle is tested.
