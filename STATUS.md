---
mod: Nelim's Pickle Tools
packageId: nelim.pickletools
repo: rimworld-nelim-pickle-tools
remote: https://github.com/vbardales/rimworld-nelim-pickle-tools.git
visibility: public
visibility_exception: "2026-09-21, owner decision in chat: public although the name is Nelim-prefixed, which defaults to private (user-stated convention). Same case as Nelim's Tech Level Fixes, where the user validated the same one-off exception on 2026-09-17. The decision is about visibility only: it does not create the repository, and pushing waits for the open points below."
visibility_verified_at: 2026-09-22
visibility_evidence: "2026-09-22 audit: origin is https://github.com/vbardales/rimworld-nelim-pickle-tools.git; git ls-remote --heads origin main = a601aa92c2fca66b27c3df606e07a5459dcfb34d, equal to the audited local HEAD. The earlier f1dca8c value is historical."
detached: yes, git repository of its own since 2026-09-21, pushed to GitHub the same day; still a folder of the monorepo checkout and excluded there locally
stage: preTest
stage_meaning: "Final publication audit on 2026-09-22 verified the standalone repository identity, public visibility exception, original MIT licensing and distributed attribution; ModIcon and Preview artifacts; settings and localization as justified not_applicable; English publication documentation; and clean offline builds/checks for all thirteen distributed modules. The remaining gate is aggregate in-game validation defined in TESTING.md, so the repository is ready for preTest but is not done or tested."
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
build: "2026-09-22 1.0.0 preparation rebuilt all thirteen distributed modules in Release with .NET SDK 10.0.401: 0 warnings, 0 errors. Logs are in .build/release-checks-1.0.0. ScreenshotStudio is a separate opt-in companion and was not included."
automated_tests: "All thirteen available Check-*.ps1 scripts passed on 2026-09-22 after the full rebuild; FilmTicks unit tests passed 7/7. ScreenshotMode attributes were changed from constant concatenation to literal expressions so the repository-wide vocabulary checker can see them. ColonistRace and InspectTabs still have no individual Check-Steps script. These are offline results, not aggregate runtime validation."
tested_on: "2026-09-21, in game, RimmsqolSteps only, pass avec-rimmsqol of FlavorTextExtendedFR: four launches under one lock, all exitReason passed, played twice: 21:37 with the first identifiers (RimmsqolSteps/evidence/2026-09-21) and 23:12 to 23:18 with the renamed build nelim.pickletools.rimmsqol (RimmsqolSteps/evidence/2026-09-21-replay). Scenarios played equal scenarios discovered, 15 mods loaded, profile left clean. Not played: the other tools of this repository; TextureOwner has not been played in a game (a launch was queued and had not started when this was written)."
updated: 2026-09-22
remaining:
  - "resolved 2026-09-21 (was a defect at dansMonoRepo -> horsMonoRepo): the GitHub repository vbardales/rimworld-nelim-pickle-tools was created public and main pushed. The Source code on GitHub link of Mod/About/About.xml and its <url> now resolve to it (checked with gh api, not opened in a browser)."
  - "resolved 2026-09-21 23:18: the renamed RimmsqolSteps build was replayed through the map of FlavorTextExtendedFR pointing at PickleTools/RimmsqolSteps/Mod with the new packageId, four launches, all exitReason passed. The map and docs of FlavorTextExtendedFR that name it are still uncommitted in that repository."
  - "resolved 2026-09-21: Upstream/ holds patches against Pickle's source. Pickle is MIT, Copyright (c) 2026 Aaron Scherer, checked in the LICENSE of the Workshop copy and in the GitHub repository (byte-identical). Upstream/LICENSE-Pickle carries the notice, as MIT requires of copies; ATTRIBUTION.md declares the patches as derived. No longer a blocker for a public repository."
  - "resolved, 2026-09-22: attribution for FilmTicks, ResearchSteps, ColonistRace, InspectTabs and KeyedClick was reconciled from their READMEs, source relationships and Git commit trailers, then recorded in ATTRIBUTION.md."
  - "partly resolved 2026-09-21: RIMMSQOL's Workshop description was read through Steam's API and holds no licence, permission or prohibition. Still unread: its manual and bug-report threads and the comments."
  - "unverified: RIMMSQOL's checkbox is wired to the calls the steps make (read from its source, not clicked); other customization mods; the French interface."
  - "note, justified non-applicability: settings, localization and translation are not applicable. The mod has no Defs, no Mod subclass, no settings page and no MainButtonDef, only step assemblies loaded by the test runner; its logs are technical and in English."
  - "resolved, 2026-09-22: the private Workshop item is 3806142401. Mod/About/PublishedFileId.txt records it and release packaging preserves it; this prevents a later upload from creating a duplicate item."
  - "resolved, 2026-09-22: root ATTRIBUTION.md is now copied to Mod/ATTRIBUTION.md and their SHA256 hashes match. Regenerate the release archive from the final reviewed tree."
  - "resolved, 2026-09-22: ScreenshotStudio declares rimworks.pickle and ludeon.rimworld.ideology in About.xml. Its zen fixture is exported, passed construction/save-reload and a separate-process direct load, and is the documented default for presentation/screenshot scenarios. It remains outside the aggregate Workshop payload as an optional companion; see ScreenshotStudio/STATUS.md."
  - "resolved, 2026-09-22: About.xml and ATTRIBUTION.md explicitly name Claude Code, OpenAI Codex and DALL-E, following the AI-attribution rule in PUBLISHING.md."
  - "unverified, 2026-09-22 audit: no aggregate bundle run has established startup, step discovery or teardown with optional RIMMSQOL absent; no aggregate English/French, restart, DLC-absent or reviewed-capture evidence exists."
  - "failed probe, 2026-09-22: the first complete aggregate-minimal report in evidence/aggregate/2026-09-22-minimal-en-dlc-id is 0/1. Cucumber messages show the first step failed because Pickle's test-colony fixture was discovered twice: stage-pickle-wsl.sh activated rimworks.pickle once as baseline and again as the bundle's hard dependency. The launcher deduplication and a main-menu-only probe are pending replay; no aggregate pass is claimed."
  - "pending, 2026-09-22: Pickle v4.8.4 is the preTest baseline; its official release archive SHA256 and assembly version were checked, and PR #20 is included. Minimal and Biotech-absent bundle probes were queued against this archive with -PickleSrc. No result from this version has been reviewed yet."
  - "resolved, 2026-09-22 migration: VefFactionSteps was promoted from QuietNewFactions and built/checked offline. The migrated optional companion replayed from PickleTools/QuietNewFactions with 5/5 scenarios passed; this does not certify the aggregate bundle."
---
# Status

See the front matter. The final publication audit advanced the repository to `preTest`; aggregate runtime
validation is the remaining gate. `RimmsqolSteps/README.md` says what was played and what was not.

Documentation correction, 2026-09-22: this paragraph now agrees with the existing front matter.
No new audit or test result is claimed; the stage and evidence dates above are unchanged.

## Suite catalogue review - 2026-09-22

`Elsewhere/README.md` is now the single suite catalogue. Entries previously scattered across the main
README, `ELSEWHERE.md` and `InSuites/README.md` were consolidated into per-suite notes; the latter two
paths remain redirects. Existing dated run notes were retained as historical evidence, not revalidated.

`Elsewhere/INVENTORY.md` records the current local suites, including ignored standalone repositories and
nested FlavorText checkouts, without following directory aliases. `Elsewhere/Update-Inventory.ps1 -Check`
checks source/feature coverage and the presence of a note per suite. It does not prove step compatibility,
compilation, execution or visual correctness. Known internal probe fixtures and history-only code are
identified separately. See the catalogue for extraction candidates and the exact scan scope.

No gameplay source, step assembly, feature or pass map was changed by this cleanup. `stage` remains
`horsMonoRepo`; the earlier pending validations and attribution questions are unchanged.

## Suite authoring documentation review - 2026-09-22

Added `Authoring/README.md` as the entry point for new suites: layout, pass maps, dependency tags,
expression checks, async waits, restart arrays and evidence review. Corrected contradictory tool guidance
about wip selection, upstream migration, runtime evidence, scaled diagnostics and report retention.
Reviewed against local sources/scripts; examples were not executed in a game. Existing dated runtime
evidence remains scoped to its original runs. Nested FlavorText repositories and root junction aliases
are documented; no repositories were relocated and no workflow stage changed.

## GitHub and Workshop candidate preparation - 2026-09-22

Owner requested both distribution targets. Thirteen general-purpose companion folders retain their packageIds
and paths; one aggregate Workshop payload requires only Pickle; RIMMSQOL remains optional. Missing MIT notices were
added to eight Mod folders, descriptions/source links aligned, and the packaging script includes family art.
ScreenshotStudio is an optional companion with completed documentation, provenance and zen-fixture validation. It remains outside the aggregate Workshop payload; its zen save is the default for presentation and screenshot scenarios.

Eleven selected Release builds passed, and all twelve available Check-*.ps1 scripts passed against the local
installed dependencies. Logs are in `.build/release-checks`. These are offline results only; no game was
launched and no tag, GitHub release or Workshop item was created. See `Release/README.md` for remaining gates.
`stage` remains `horsMonoRepo`; existing per-tool historical runtime results are not generalized.

FilmTicks unit tests passed 7/7. TESTING.md now defines the pending aggregate minimal and optional runtime
passes. The bundle uses packageId nelim.pickletools, with thirteen DLLs and no hard dependency on optional
test targets. Startup without RIMMSQOL remains explicitly unverified. No publication has occurred.

## Audit — 2026-09-22

Audited revision `a601aa92c2fca66b27c3df606e07a5459dcfb34d` on `main`, with a dirty working tree.
The standalone repository, configured GitHub remote and pushed audited HEAD are established. This earlier
audit retained `horsMonoRepo`; the final publication audit below supersedes that stage assessment. No RimWorld
process was started by either audit.

Direct artifact checks: `Mod/About/ModIcon.png` is 128 x 128 (24,607 bytes); `Preview.png` is 896 x 504
(538,239 bytes) and was opened. Both MIT copies are byte-identical in substance. The source tree contains no
root Mod class, settings UI, MainButtonDef or player-facing language resources; `settings_audit`, localization
and English/French translation remain justified `not_applicable` for the identity-only bundle, while the
technical step phrases/logs remain English.

Offline evidence was preserved rather than promoted to runtime evidence. ScreenshotMode built cleanly during
this audit; the recorded release builds/checks and FilmTicks unit tests remain scoped as stated in front matter.
The audit initially found release-inventory, distributed-attribution, ScreenshotStudio dependency and
AI-provenance defects. All four were corrected locally on 2026-09-22; DALL-E is now recorded as the image
generator, so that attribution defect no longer blocks the first Workshop upload. No game run, tag, GitHub release, Steam upload, deletion
or relocation occurred.

The superseding local `0.1.0-rc.1` candidate generated after this migration contains one Workshop identity,
`nelim.pickletools`, thirteen step DLLs (including ScreenshotMode and VefFactionSteps), MIT and ATTRIBUTION.md; its sole hard
dependency is `rimworks.pickle`. The Workshop and GitHub archive SHA256 entries were recalculated and
verified. This confirms archive structure only, not aggregate runtime behavior.

## QuietNewFactions absorption — 2026-09-22

The nine VEF faction workflow steps were moved from QuietNewFactions into `VefFactionSteps`, renamed with
the `Nelim's Pickle Tools:` prefix, built with 0 warnings and 0 errors, and checked against Pickle and the
local suites. The actual `nelim.quietnewfactions` companion has also been copied under
`QuietNewFactions/`: source, package, tests, reports and proposal are preserved there, outside the aggregate
payload because VEF is a load-time dependency. Its rebuilt DLL passes the six offline compatibility checks;
a 2026-09-22 WSL headless replay from the new location passed all five scenarios. The former repository is
redundant once this migration is pushed.

## Final publication audit and 1.0.0 offline candidate — 2026-09-22

The publication-facing identity, English documentation, MIT copies, distributed attribution, source link,
Steam links, AI credits, adoption clause and upstream-removal notice were reviewed against `PUBLISHING.md`.
Attribution for FilmTicks, ResearchSteps, ColonistRace, InspectTabs and KeyedClick was reconciled from their
READMEs, source relationships and Git history. The icon and preview remain the previously verified 128 x 128
and 896 x 504 artifacts; settings and localization remain justified `not_applicable` for a step-only bundle.

All thirteen distributed modules were rebuilt in Release with 0 warnings and 0 errors. All thirteen available
offline check scripts passed, FilmTicks tests passed 7/7, and the Elsewhere inventory matched sixteen suites.
The repository therefore advances to `preTest`. It does not advance to `done` or `tested`: the aggregate
English/French, optional-dependency, restart and VEF passes in `TESTING.md` have not been executed.
