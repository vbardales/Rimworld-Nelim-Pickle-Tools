# Protocols read, and in which version

What the working session of this repository read of the workspace protocols, on **2026-09-25** (about 14:40 to 16:30),
at the owner's request. A version is the last commit that touched the file in the repository that holds it, plus the first
12 characters of the SHA256 of the file **as read**. When a hash below no longer matches, the document changed and must be
read again before it is relied on. Line counts are those of the file read.

**Where they live now.** On 2026-09-25 (monorepo commit `90d51374`) the protocol documents (`AGENTS`, `AUDIT`, `PUBLISHING`,
`TRANSLATIONS`, `STYLE_RIMWORLD`, `MOD_SETTINGS`, `EXTERNAL_TOOLS`, `scripts/PICKLE-WSL`, `scripts/SEARCHING`,
`scripts/Tests/README`) left the monorepo: the repository **`vbardales/Rimworld-protocols`** owns them, with the collection
folder as its work tree (git dir `Documents\rimworld-protocols.git`). The commits below are the monorepo's, from before the move.
Checked again after it: `AGENTS.md` (3a1d2cb), `AUDIT.md` (f3dc1e4, the uncommitted edit read here is now committed),
`MOD_SETTINGS.md` and `TRANSLATIONS.md` (b83933b) have **the same hashes as read**. **`PUBLISHING.md` has changed**
(now 3d83491eb5bf, commit 04aa365, "drop a paragraph written twice": the duplicated paragraph noticed while reading; not
re-read) and `STYLE_RIMWORLD.md` has changed (f27a0a9e1398, irrelevant here). `EXTERNAL_TOOLS.md` gained an entry for
Just Start (28069db, pushed).

Documents of the collection root (`Documents\rimworld`, monorepo HEAD `48a19e4b`):

| Document | Read | Version | Useful here? |
|---|---|---|---|
| `AGENTS.md` | whole | 8ce2aeeb, 2026-09-24, 36631e730433, 46 lines | Yes: evidence rule, publishing by CI |
| `AUDIT.md` | whole | 48a19e4b **plus an uncommitted edit** (file modified 2026-09-25 14:34, the fail-fast paragraph was rewritten while it was being read), 45cbab660f8d, 227 lines | Yes: the stage chain, the Pickle rules, the queue |
| `PUBLISHING.md` | whole | 48a19e4b, 2026-09-25, 34c9bd75b282, 685 lines | Yes for `prepublished`/`published`, fail fast, CI |
| `MOD_SETTINGS.md` | whole | 2e563481, 2026-09-23, 404916bc99a7, 107 lines | Only to justify `settings_audit: not_applicable` |
| `TRANSLATIONS.md` | whole | 2e563481, 2026-09-23, 3368579d01dc, 100 lines | Only to justify `localization: not_applicable` |
| `STYLE_RIMWORLD.md` | whole | 2e563481, 2026-09-23, d3d30b86e487, 502 lines | **No**: graphic style of Preview and ModIcon, which no session generates and this repository does not need to |
| `EXTERNAL_TOOLS.md` | whole | 3c78b2e7, 2026-09-24, 24a4567c5a09, 124 lines | Partly: the Pickle flags (`-pickle-max-film-seconds`, `-pickle-retry`, report-dir fallback) |
| `PUBLISHING_STATE.md` | whole | 5b3104e8, 2026-09-11, a745d3e23e4c, 170 lines | **No**: a historical snapshot of the 2026-09-11 rename and repository inventory |
| `WORKSHOP_COMMENTS.md` | whole | fa79963f, 2026-09-24, e5c0c3a12886, 66 lines | Only before a publication |
| `scripts/PICKLE-WSL.md` | whole | 8c1c0fb1, 2026-09-21, fb2652f94ae0, 7 lines | **No**: a pointer to `Headless/README.md` |
| `scripts/SEARCHING.md` | whole | 9a52ea1b, 2026-09-17, 9dbd52b2bcd4, 168 lines | **No**: searching the mod corpus, not needed here |
| `scripts/Tests/README.md` | whole | a32c50f5, 2026-09-25, 3d08691908dc, 76 lines | **No**: tests of the launcher, owned by others. One rule worth keeping: never run `test-stop-game-wsl.sh` while a run is in progress |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | whole (207 lines) | 2ce34a3 in its repository, 2026-09-25, 41428924093a | Yes: dry-run, `publish`, first publication, machine coordination |
| `BACKLOG.md` (root, 1510 lines) | **not read** | | |

Documents of this repository (HEAD `0a661c9` when written): read `README.md` (76e9179, 2da7a94e2dee),
`Headless/README.md` (2da3bb5, d14e68908f17, 466 lines), `Upstream/PENDING.md` (730aa20, a4fa78410aa2), `STATUS.md`
(0264612, 58a7e1630114), `CHANGELOG.md` (f966e96, fc33276e2db2), `ATTRIBUTION.md` (e0410eb, 072ca0f47cb3),
`PUBLICATION.md` (9cfb669, ad514cdeaa3c), `TESTING.md` (a1bee51, 6976b710323f), `Mod/About/About.xml` (2dc9845,
7b84c9af8eda), `docs/runs/README.md` (44680e5, 76f53dcb5dd3) and `Tests/Pickle/README.md` (07f660a, 64695d0d9ab7).
`LICENSE` was not reread. `BACKLOG.md`, `NOTES.md` and `BUGS.md` do not exist in this repository.

`Docs/steps.md` of Pickle, read whole (577 lines), is a **copy in the session's scratch folder** dated 2026-09-24, SHA256
prefix 9c79dde2ede9. It is not a git checkout and carries no version, so it is **not established that it is v4.9.1's**; it
lists no body-type step, which agrees with `ColonistRace/` still supplying one. Re-read the file of the release actually used
(`.build/upstream-v4.9.1/Pickle` holds the assemblies, not the docs) before quoting it as v4.9.1.

## What reading them changed

- **The stage chain**: `preTest -> done` needs no game run; every game run is `done -> tested`. The repository moved to `done`
  on 2026-09-25 (`STATUS.md`).
- **Fail fast (2026-09-25) needs, before a `publish`**: no red scenario without a green replay, the Workshop gallery, the
  owner's manual validations, a dry-run of the exact commit, the full 40-character SHA, the owner's approval of
  `steam-production`, and a rollback target chosen beforehand. Two scenarios were red by construction and had to be repaired or
  removed with a reason first: `lost-click-probe` (fails on purpose) and `pickletools-soundcapture` (audio sink measured
  silent). The first was rewritten on 2026-09-25 to assert the symptom (the page does not open) plus a control, so it is green
  when the click is lost as intended (first play queued); the second waits for the game-side check (ticket f3c5).

## Findings, and what was done about them (2026-09-25)

- **A mistake of the reading session, put right.** It took the `v1.0.0` tag and the GitHub release for hand-made objects that
  the CI should have created, and **deleted them on 2026-09-25**. Version 1.0.0 had in fact been released (the owner: the
  first release did take place). Tag and release were **recreated the same day** on the same commit (`2dc9845`) with the
  original title and text; the release date is now 2026-09-25, and **its three attached files** (the two archives and
  `SHA256SUMS.txt`, sha256 `0cf9bbd5...`, `867f1137...`, `55832413...`) **could not be recovered**: none of the local
  archives in `.build/releases/` has those hashes, and a substitute would carry the wrong checksums. They are regenerated by the
  next release.
- **Fixed: `CHANGELOG.md`** now has `## [Unreleased]` (the changes since 1.0.0) above `## [1.0.0] - 2026-09-22`, the format the
  publish workflow reads. It says the commit whose `Mod/` was uploaded to Steam is **not recorded**.
- **Fixed: the item is public, not private.** Steam's public API returns it (`visibility` 0, created and updated
  2026-09-22 11:59 UTC, one upload, one subscriber), and it returns nothing for a private item. `PUBLICATION.md` and
  `STATUS.md` said private; both are corrected. The root `PUBLISHING.md` still says "fiche Workshop privÃ©e" for
  PickleTools: it is not a file of this repository, so it is left for the owner.
- **Fixed: `ATTRIBUTION.md`** now names ClearScreen, InterfaceScale, ClickDiagnostics, ExpansionSteps, HoverSteps,
  ScreenshotMode, ScreenshotStudio, TextureOwner and SoundCapture, with the limit of that record (commit trailers and
  READMEs, not a line-by-line audit). `Mod/ATTRIBUTION.md` is the same file (hash checked).
- **Fixed on the CI/CD session's answer (2026-09-25): the publish workflow and the payload.** `Mod/` only held the metadata and
  the artwork, and the workflow uploads it as committed. The thirteen DLLs are now committed under `Mod/Pickle/Assemblies`
  (`Release/Prepare-Release.ps1 -SyncMod`, checked by `-Check`), and `.github/` holds the manual publish workflow generated from
  `Rimworld-Release-Admin` 2ce34a3 with all thirteen DLLs required, its 49 tests passing. No dry-run and no publish was run. A
  rebuild from source is **not** byte-identical to the tracked DLLs (floating package references), so the gate is the hash
  comparison, not a rebuild. `v1.0.0` (`2dc9845`) cannot be a CI rollback target (no `.github`, no DLL in its `Mod/`): the first
  rollback is Steam's own "rétablir cette version", chosen by the owner.
- **Fixed for the next release: the description** (`Mod/About/About.xml` and `PUBLICATION.md`) no longer says release candidate; the live
  Steam page still does until a publish with `update_description` or a manual edit.
## Corrections made after reading

- A .NET 10 SDK exists at `C:\Users\nelim\.dotnet10` (10.0.401, used to build Pickle, see `Headless/README.md`); the SDK on the
  PATH is 8.0.424. An earlier note here and the message of commit c10fcd0 said 8 was "the only one installed". The FilmTicks
  test project targets net8.0 so that the default `dotnet test` runs it.
- `Upstream/PENDING.md` and `README.md` had rows saying ColonistRace was never played and that the sound scenario had not
  run; both are updated.

## Read again on 2026-10-08 (owner: "relis AUDIT.md et applique-le")

Hashes are the first 12 characters of the SHA256 of the file as read; the protocols' history is in `../rimworld-protocols.git`, not in the monorepo.

| Document | SHA256 (12) | Lines | Useful here? |
|---|---|---|---|
| `AGENTS.md` | 7a236f03ca15 | 21 | Yes: evidence rule, history trim, publishing by CI |
| `AUDIT.md` | 4982872340e3 | 278 | Yes, the main source: stage chain, `workflow_stage`, session name `pickletools / <workflow_stage>` |
| `MOD_SETTINGS.md` | 404916bc99a7 | 107 | Barely (`not_applicable`, unchanged since 2026-09-25) |
| `TRANSLATIONS.md` | 491f88e5eb3b | 225 | Barely (`not_applicable`: no player-facing text); only the start was read line by line |
| `PUBLISHING.md` | cffd8d0f5688 | 798 | Yes: gallery (scripted scenarios), Preview, CI, thanks |
| `STYLE_RIMWORLD.md` | 0c551b87ac4d | 729 | Partly: ModIcon/Preview sections; the illustration prompt blocks are not used |
| `WORKSHOP_COMMENTS.md` | 7575d4e2570a | 166 | Barely: one line concerns this mod (`not_applicable`) |
| `scripts/SEARCHING.md` | cde797ddcdbc | 228 | **No**: searching the Workshop corpus |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | d3ea56ae977b | 128 | Yes: dry-run, full 40-character SHA, the gallery never goes through CI |
| `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` | a35fb8cfef5a | 159 | Yes: the queue rules |
| `Rimworld-Ticket-Dispatcher/docs/SUBMIT.md` | a301c2fe7594 | 169 | Yes: options, `-EvidenceDir` (relative, starts with the mod folder), `-DepMap` |
| `README.md` (this repository) | d1749f3baf4a | 91 | Yes |
| `Headless/README.md` | 2310bb974f68 | 509 | Yes, partly out of date: it still shows direct `Run-PickleWsl.ps1` launches (the queue only now) and `-RunTimeoutMinutes` defaults |

Findings applied the same day: `workflow_stage` added to `STATUS.md` (`stage` itself stays `preTest` although 1.1.0 is published: the owner decides, see `STATUS.md`);
`*.dds` was already ignored, `Art/ModIcon-badge.png` and `Art/Preview.png` are now ignored (generated); `Tests/Pickle/Evidence/` (150 MB of Sanctuary runs from
2026-10-04/05, no document pointed at them, the Sanctuary now lives in SanctuaryBacklot) was deleted; `PUBLICATION.md` line 170 had a literal `\n`
in the publication command (fixed). Differences left between `PUBLICATION.md` and `PUBLISHING.md`: the description is still BBCode while PUBLISHING asks for one Markdown source
(`--description-markdown`, `--about-from-description`); the committed workflow does not pass `--gallery-dir`; the sizes quoted for the Preview are stale after the regeneration.
**Evidence to keep when testing**: the latest report per scenario for the current revision, `summary.json` and the one screenshot that proves a rendering;
everything else (full Player.log, `report.html`, `messages.ndjson` of a superseded build) is deleted once a newer report replaces it.

## Read again on 2026-10-09 (owner: "relis la doc")

Hashes are the first 12 characters of the SHA256 of the file as read. Read whole: `AGENTS.md`, `AUDIT.md`, `PICKLE.md`, `PUBLISHING.md`. NOT re-read: `MOD_SETTINGS.md`, `TRANSLATIONS.md`, `Rimworld-Release-Admin/docs/OPERATIONS.md`, `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` and `SUBMIT.md` (hashes below are their current ones, not a reading). `Mark-ProtocolsRead.ps1` was not run, so `STATUS.md` has no `protocols_read_sha` yet: it must be run once the protocols that matter are read.

| Document | SHA256 (12) | Lines | Read |
|---|---|---|---|
| `AGENTS.md` | 75c64b0f19cc | 53 | whole |
| `AUDIT.md` | 621d50c614db | 212 | whole |
| `PICKLE.md` | 4e30cb1ed24e | 113 | whole (new file: the run rules moved out of `AUDIT.md`) |
| `PUBLISHING.md` | b8af9b7406b5 | 463 | whole, later the same day |
| `MOD_SETTINGS.md` | 8a445d4bb7d3 | 109 | no |
| `TRANSLATIONS.md` | db973554758b | 231 | no |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | e51dfbe4ad1b | 130 | no |
| `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` | 9e6f6f785c06 | 155 | no |
| `Rimworld-Ticket-Dispatcher/docs/SUBMIT.md` | 3960330b6518 | 169 | no |

What changed since 2026-10-08 and bites this repository:
- **There is no monorepo any more** (2026-10-09): the rimworld root is the protocols repository and ignores mod folders. Run rules are in `PICKLE.md`, not `AUDIT.md`; the session title marker is in `AGENTS.md`.
- **Closing pass before each commit + push** (`AGENTS.md`, 10 steps, each result recorded in `STATUS.md`): Art/ clean, ModIcon/Preview chain, mod root clean, gallery refresh (candidates `<index>-candidate-<name>.png`, <2 MB each, <8 MB in all; UI captures on `window-backdrop-for-height`: crop the sides, keep 5 px each side), PUBLICATION.md against PUBLISHING.md, French, docs, code review, STATUS lint (`scripts/Check-Status.ps1 -Mod PickleTools`), commit + push. Protocol files never go into a mod repository.
- **New STATUS fields**: `protocols_read_sha` (written by `scripts/Mark-ProtocolsRead.ps1 -Mod <Mod>`; needed before every change of `stage` or `workflow_stage`), `publication_changelog_review_sha` (full SHA, written only on the owner's confirmation in chat), `echo_review` (after the first gallery captures: keep|redo with the reason; PickleTools has no Preview echo decision recorded). `STATUS.md` keeps the current state only (lint: INFO over 20 KB, WARN over 40 KB, ERROR over 80 KB); ours is 32 KB.
- **`stage` after `published`** carries the version: `published[1.0.1]`. `prepublished` needs the gallery ready, not only a green dry-run.
- **Code review**: `code_review_sha..HEAD` is required before `tested -> prepublished`; a code commit after the SHA reopens it. Ours covers 3 files only (`982efbe`).
- **Passes**: at least two (without / with the optional mods), named with `-DepMap` (`-pickle-set-name` writes the set name into `summary.md`); one more per declared incompatibility, asserting the symptom, never an expected red; non-regression passes all at the end, on the final revision. A scenario that only repeats a unit test is deleted. "We do not test the game": load order the game computes, language switch, dependency warnings are not tested; the mod answers for what it declares.
- **Run rules** (`PICKLE.md`): no session launches a game; a request is filed with `Submit-PickleRun.ps1` (a request carries no SHA: put it in `-Label`, keep the tree frozen until `RUN_DONE`); one pass = one request; first contact with TicketDispatcher is `REGISTER local_<id> <Mod>`; nobody creates a watcher, `Monitor` or cron for the queue; read `exitReason` before the figures; exit 7 = nothing played, 8 = Pickle's own code 2, 9 = infrastructure.
- **Wrong in `Headless/README.md` still?** It was corrected on 2026-10-09 for `merge-reports.py` and the AUDIT reference only; the direct `Run-PickleWsl.ps1` examples were not re-checked against `PICKLE.md`.
- **`PUBLISHING.md` (read later the same day)** now has annexes: `GALLERY.md`, `ANIMALS.md`, `PUBLISHING-CI.md`, `TOOLING-PITFALLS.md` (none read). Rules that bite us: description is written once as Markdown under `## Steam description` of `PUBLICATION.md` (ours is still BBCode, a known gap) and ends with `[Source code on GitHub](URL)`; description order IF I GO QUIET, AI-GENERATED, THANKS, ATTRIBUTION line, source link; gallery folder only numbered images `0-`.. with `0-` a byte copy of `Preview.png`, contiguous indexes; thanks must name Pickle and PickleTools where a pass stages them (PickleTools Workshop page is public per Steam, the protocol still says private); one Steam thanks comment per recipient page via `WORKSHOP_COMMENTS.md`; docs, commits and code comments in English; the three GitHub topics `rimworld`, `rimworld-mod`, `mod` and the social preview image for a public repository (checked for PickleTools: not done by me); release notes start with the version on line 1 (the CI refuses otherwise); `About/PublishedFileId.txt` committed at once.
