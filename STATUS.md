---
mod: Nelim's Pickle Tools
packageId: nelim.pickletools
repo: Rimworld-Nelim-Pickle-Tools
remote: none yet (the GitHub repository does not exist; the name is proposed)
visibility: public, intended
visibility_verified_at: not applicable, nothing is on GitHub
detached: git repository of its own since 2026-09-21, still a folder of the monorepo checkout and excluded there locally; no remote
stage: dansMonoRepo
stage_meaning: "the criteria of dansMonoRepo -> horsMonoRepo are not all met: the repository is standalone and has its first commits, but no GitHub repository exists and nothing is pushed. Retained stage is the last fully established one."
licence: original
licence_at: "original work, MIT (LICENSE, Mod/LICENSE, RimmsqolSteps/Mod/LICENSE). RIMMSQOL is studied and not reused, no licence found for it; Pickle is used through its API and not redistributed; see ATTRIBUTION.md"
rights_reviewed_at: 2026-09-21
explicit_prohibition_found: not checked for RIMMSQOL's Workshop page, see remaining
settings_audit: not_applicable
localization: not_applicable
translation_en: not_applicable
translation_fr: not_applicable
dependencies: "verified for RimmsqolSteps only (rimworks.pickle, MalteSchulze.RIMMSqol, both read from their own About.xml on 2026-09-21); not audited for FilmTicks, ResearchSteps, ColonistRace"
showcase: "ModIcon (128 x 128, 24.6 KB) and Preview (896 x 504, 538 KB) present in Mod/About, sources and generator in Art/. Icon and preview were opened and read, the preview at 268 px too; the icon's two tools blur into one patch at 32 px."
build: "passed for RimmsqolSteps (dotnet build against the real RIMMSqol.dll, 0 warnings, 0 errors); other tools not built by this session"
automated_tests: "RimmsqolSteps: Check-Bridge (10 checks), Check-Reader (13 cases) and Check-Steps pass on the renamed build, 2026-09-21. Other tools not run by this session."
tested_on: "2026-09-21, in game, RimmsqolSteps only, BEFORE the rename: pass avec-rimmsqol of FlavorTextExtendedFR, four launches, all exitReason passed (evidence in RimmsqolSteps/evidence). The renamed build (packageId, assembly) has not been played."
updated: 2026-09-21
remaining:
  - "defect (dansMonoRepo -> horsMonoRepo): no GitHub repository and no remote. The About.xml <url> and the Source code on GitHub link name https://github.com/vbardales/Rimworld-Nelim-Pickle-Tools, which does not exist: the link is unverified, not known to be wrong."
  - "unverified: the renamed RimmsqolSteps build. Replay pass avec-rimmsqol after pointing the map of FlavorTextExtendedFR at PickleTools/RimmsqolSteps/Mod with the new packageId."
  - "open: Upstream/ holds patches against Pickle's source; Pickle's licence has not been checked for that. Must be settled before the repository goes public (ATTRIBUTION.md)."
  - "open: attribution of FilmTicks, ResearchSteps, ColonistRace, InspectTabs and KeyedClick, written in other sessions, is not established here."
  - "unverified: RIMMSQOL's Workshop page and description were not consulted for a licence or a prohibition; none was found in its About.xml, its shipped source or as a file."
  - "unverified: RIMMSQOL's checkbox is wired to the calls the steps make (read from its source, not clicked); other customization mods; the French interface."
  - "open: the image tool that generated the icon and the preview is not named in ATTRIBUTION.md."
  - "note, justified non-applicability: settings, localization and translation are not applicable. The mod has no Defs, no Mod subclass, no settings page and no MainButtonDef, only step assemblies loaded by the test runner; its logs are technical and in English."
  - "note, never published: no Workshop item, no PublishedFileId, no ModIcon or Preview obligation beyond the workflow's, and the chain stops before prepublished unless that is decided otherwise."
---
# Status

See the front matter. `stage` is `dansMonoRepo`, and the reason is the missing GitHub repository, not the quality
of the tools. `RimmsqolSteps/README.md` says what was played and what was not.
