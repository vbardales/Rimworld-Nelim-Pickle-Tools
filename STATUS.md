---
mod: Nelim's Pickle Tools
packageId: nelim.pickletools
repo: rimworld-nelim-pickle-tools
remote: https://github.com/vbardales/rimworld-nelim-pickle-tools.git
visibility: public
visibility_exception: "2026-09-21, owner decision in chat: public although the name is Nelim-prefixed, which defaults to private (user-stated convention). Same case as Nelim's Tech Level Fixes, where the user validated the same one-off exception on 2026-09-17. The decision is about visibility only: it does not create the repository, and pushing waits for the open points below."
visibility_verified_at: 2026-09-21
visibility_evidence: "gh api repos/vbardales/rimworld-nelim-pickle-tools: private=false, visibility public, licence MIT, default branch main; git ls-remote refs/heads/main = f1dca8c, equal to the local HEAD"
detached: yes, git repository of its own since 2026-09-21, pushed to GitHub the same day; still a folder of the monorepo checkout and excluded there locally
stage: horsMonoRepo
stage_meaning: "the criteria of dansMonoRepo -> horsMonoRepo are met on 2026-09-21: standalone repository, GitHub repository existing with remote origin and history pushed (main f1dca8c), STATUS.md initialised, public visibility (owner exception recorded) and licence status original justified, packageId nelim.pickletools / name Nelim's Pickle Tools / repo rimworld-nelim-pickle-tools / folder PickleTools coherent, documentation in English. Later transitions (ModIcon, Preview, preOptions, ...) are not certified here: the images exist and were checked, but this file makes no claim beyond horsMonoRepo, and the tools written by other sessions are not audited."
licence: original
licence_at: "2026-09-21, same treatment as Nelim's Tech Level Fixes, by the owner's instruction: licence original, plain MIT, Copyright (c) 2026 Nelim, the same text (LICENSE, Mod/LICENSE, RimmsqolSteps/Mod/LICENSE; a first version copied from another repository carried a paragraph about Flavor Text and was replaced the same day). Verified by inspection of what is shipped: step assemblies and their C# source written here, no third-party code, text or art copied in. RIMMSQOL is studied and not reused, no licence found for it; Pickle is used through its API and not redistributed; see ATTRIBUTION.md"
rights_reviewed_at: 2026-09-21
explicit_prohibition_found: none found for RIMMSQOL in its About.xml, its shipped source or its Workshop description (read 2026-09-21 through Steam's API); its manual, bug thread and comments not read
settings_audit: not_applicable
localization: not_applicable
translation_en: not_applicable
translation_fr: not_applicable
dependencies: "verified for RimmsqolSteps only (rimworks.pickle, MalteSchulze.RIMMSqol, both read from their own About.xml on 2026-09-21); not audited for FilmTicks, ResearchSteps, ColonistRace"
showcase: "ModIcon (128 x 128, 24.6 KB) and Preview (896 x 504, 538 KB) present in Mod/About, sources and generator in Art/. Icon and preview were opened and read, the preview at 268 px too; the icon's two tools blur into one patch at 32 px."
build: "passed for RimmsqolSteps (dotnet build against the real RIMMSqol.dll, 0 warnings, 0 errors); other tools not built by this session"
automated_tests: "RimmsqolSteps: Check-Bridge (10 checks), Check-Reader (13 cases) and Check-Steps pass on the renamed build, 2026-09-21. Other tools not run by this session."
tested_on: "2026-09-21, in game, RimmsqolSteps only, pass avec-rimmsqol of FlavorTextExtendedFR: four launches under one lock, all exitReason passed, played twice: 21:37 with the first identifiers (RimmsqolSteps/evidence/2026-09-21) and 23:12 to 23:18 with the renamed build nelim.pickletools.rimmsqol (RimmsqolSteps/evidence/2026-09-21-replay). Scenarios played equal scenarios discovered, 15 mods loaded, profile left clean. Not played: the other tools of this repository."
updated: 2026-09-21
remaining:
  - "resolved 2026-09-21 (was a defect at dansMonoRepo -> horsMonoRepo): the GitHub repository vbardales/rimworld-nelim-pickle-tools was created public and main pushed. The Source code on GitHub link of Mod/About/About.xml and its <url> now resolve to it (checked with gh api, not opened in a browser)."
  - "resolved 2026-09-21 23:18: the renamed RimmsqolSteps build was replayed through the map of FlavorTextExtendedFR pointing at PickleTools/RimmsqolSteps/Mod with the new packageId, four launches, all exitReason passed. The map and docs of FlavorTextExtendedFR that name it are still uncommitted in that repository."
  - "resolved 2026-09-21: Upstream/ holds patches against Pickle's source. Pickle is MIT, Copyright (c) 2026 Aaron Scherer, checked in the LICENSE of the Workshop copy and in the GitHub repository (byte-identical). Upstream/LICENSE-Pickle carries the notice, as MIT requires of copies; ATTRIBUTION.md declares the patches as derived. No longer a blocker for a public repository."
  - "open: attribution of FilmTicks, ResearchSteps, ColonistRace, InspectTabs and KeyedClick, written in other sessions, is not established here."
  - "partly resolved 2026-09-21: RIMMSQOL's Workshop description was read through Steam's API and holds no licence, permission or prohibition. Still unread: its manual and bug-report threads and the comments."
  - "unverified: RIMMSQOL's checkbox is wired to the calls the steps make (read from its source, not clicked); other customization mods; the French interface."
  - "open: the image tool that generated the icon and the preview is not named in ATTRIBUTION.md."
  - "note, justified non-applicability: settings, localization and translation are not applicable. The mod has no Defs, no Mod subclass, no settings page and no MainButtonDef, only step assemblies loaded by the test runner; its logs are technical and in English."
  - "note, never published: no Workshop item, no PublishedFileId, no ModIcon or Preview obligation beyond the workflow's, and the chain stops before prepublished unless that is decided otherwise."
---
# Status

See the front matter. `stage` is `horsMonoRepo`: the standalone repository and its first GitHub push
were recorded on 2026-09-21. Later workflow transitions are not certified here.
`RimmsqolSteps/README.md` says what was played and what was not.

Documentation correction, 2026-09-22: this paragraph now agrees with the existing front matter.
No new audit or test result is claimed; the stage and evidence dates above are unchanged.
