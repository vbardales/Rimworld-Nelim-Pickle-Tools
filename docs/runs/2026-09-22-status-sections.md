# STATUS.md dated sections, folded 2026-10-10

Moved verbatim from STATUS.md (AGENTS.md: STATUS keeps the current state only). The earlier text stays in git history.

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

## Audit: 2026-09-22

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

## QuietNewFactions absorption: 2026-09-22

The nine VEF faction workflow steps were moved from QuietNewFactions into `VefFactionSteps`, renamed with
the `Nelim's Pickle Tools:` prefix, built with 0 warnings and 0 errors, and checked against Pickle and the
local suites. The actual `nelim.quietnewfactions` companion has also been copied under
`QuietNewFactions/`: source, package, tests, reports and proposal are preserved there, outside the aggregate
payload because VEF is a load-time dependency. Its rebuilt DLL passes the six offline compatibility checks;
a 2026-09-22 WSL headless replay from the new location passed all five scenarios. The former repository is
redundant once this migration is pushed.

## Final publication audit and 1.0.0 offline candidate: 2026-09-22

The publication-facing identity, English documentation, MIT copies, distributed attribution, source link,
Steam links, AI credits, adoption clause and upstream-removal notice were reviewed against `PUBLISHING.md`.
Attribution for FilmTicks, ResearchSteps, ColonistRace, InspectTabs and KeyedClick was reconciled from their
READMEs, source relationships and Git history. The icon and preview remain the previously verified 128 x 128
and 896 x 504 artifacts; settings and localization remain justified `not_applicable` for a step-only bundle.

All thirteen distributed modules were rebuilt in Release with 0 warnings and 0 errors. All thirteen available
offline check scripts passed, FilmTicks tests passed 7/7, and the Elsewhere inventory matched sixteen suites.
The repository therefore advances to `preTest`. It does not advance to `done` or `tested`: the aggregate
English/French, optional-dependency, restart and VEF passes in `TESTING.md` have not been executed.

- 2026-10-10: owner accepted Preview-source.png at mean value 0.295 (0.30 asked, override by the owner, audit 2.e); PROMPT_PICKLETOOLS.md removed (2.f).
