# Changelog

Nothing here has been released or tagged: this is a development-only tool, never published to the Workshop.

## Unreleased

### RimmsqolSteps

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

### ClickDiagnostics

- Three Pickle steps for a click that must land: wait until a button has stood still for 12 frames, check that the
  window under the pointer is the expected one and receives input, click and wait for a window, and on a lost click
  print the pointer, the buttons under it (image buttons too, through a Harmony postfix) and the window stack.
  Moved here on 2026-09-21 from Work Studio's suite (`ImageButtonProbe`, `WaitForButtonToSettle`, the window-stack
  dump), and generalised. Compiled with 0 warnings, patterns checked, not played as steps yet.

### ExpansionSteps

- Two Pickle steps that assert an expansion, or any mod, is active in `ModsConfig` by package id, for a pass that leaves a DLC
  out (`!ludeon.rimworld.odyssey` in the pass map). Moved here on 2026-09-21 from Flavor Text Extended's suite, where they
  passed in its `sans-odyssey` pass. Compiled with 0 warnings, patterns checked and unambiguous against 609 others, not played
  as a shared mod yet.

### Repository

- Icon (`Mod/About/ModIcon.png`, 128 x 128) and preview (`Mod/About/Preview.png`, 896 x 504), with their
  sources and the page that engraves the preview in `Art/`.
- `LICENSE` (MIT), `ATTRIBUTION.md`, `STATUS.md`.
- Other tools added by other sessions are recorded in their own folders: `FilmTicks/`, `ResearchSteps/`,
  `ColonistRace/`, `InspectTabs/`, `KeyedClick/`, `Upstream/`. Steps that live in a suite and could be taken from there are listed in the
  README.
