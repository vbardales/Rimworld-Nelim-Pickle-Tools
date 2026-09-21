# Changelog

Nothing here has been released or tagged: this is a development-only tool, never published to the Workshop.

## Unreleased

### RimmsqolSteps

- 17 Pickle steps that reveal, hide and forget any `MainButtonDef` through RIMMSQOL's own settings instance,
  read the file it wrote, assert what the main bar draws, and open its own window for a capture; a teardown after
  every scenario and a hand-off between launches for restart chains.
- Three offline checks: `Check-Bridge.ps1` (the binaries), `Check-Reader.ps1` (the settings-file reader),
  `Check-Steps.ps1` (patterns, ambiguity against Pickle, the other suites and the sibling tools).
- First in-game run, 2026-09-21, in the `avec-rimmsqol` pass of FlavorTextExtendedFR: four launches, all passed.
  Logs and four captures in `RimmsqolSteps/evidence/2026-09-21/`.
- Identifiers: packageId `nelim.pickletools.rimmsqol`, assembly and namespace `Nelim.PickleTools.Rimmsqol`.
  The first version was `nelim.pickleshared.rimmsqol`, in the monorepo's `PickleShared/`.

### Repository

- Icon (`Mod/About/ModIcon.png`, 128 x 128) and preview (`Mod/About/Preview.png`, 896 x 504), with their
  sources and the page that engraves the preview in `Art/`.
- `LICENSE` (MIT), `ATTRIBUTION.md`, `STATUS.md`.
- Other tools added by other sessions are recorded in their own folders: `FilmTicks/`, `ResearchSteps/`,
  `ColonistRace/`, `Upstream/`.
