# Protocols read, and in which version

What the working session of this repository read of the workspace protocols, on **2026-09-25** (about 14:40 to 16:30),
at the owner's request. A version is the last commit that touched the file in the repository that holds it, plus the first
12 characters of the SHA256 of the file **as read**. When a hash below no longer matches, the document changed and must be
read again before it is relied on. Line counts are those of the file read.

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
  `steam-production`, and a rollback target chosen beforehand. Two scenarios are red by construction and must be repaired or
  removed with a reason first: `lost-click-probe` (fails on purpose) and `pickletools-soundcapture` (audio sink measured
  silent).

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
- **Not fixed, put to the CI/CD session: no `.github/workflows`.** The publish workflow uploads `Mod/` as committed, and
  this repository's `Mod/` holds only the metadata and the artwork: the thirteen DLLs are assembled into
  `.build/aggregate-current/Mod` by `Release/Prepare-Release.ps1`. A workflow generated now could only publish a bundle
  without its steps. Either the assembled payload is committed under `Mod/` (thirteen DLLs duplicated from the tool
  folders, `Prepare-Release.ps1` changed to write there), or the workflow builds it. Neither was done unasked.
- **Fixed for the next release: the description** (`Mod/About/About.xml` and `PUBLICATION.md`) no longer says release candidate; the live
  Steam page still does until a publish with `update_description` or a manual edit.
## Corrections made after reading

- A .NET 10 SDK exists at `C:\Users\nelim\.dotnet10` (10.0.401, used to build Pickle, see `Headless/README.md`); the SDK on the
  PATH is 8.0.424. An earlier note here and the message of commit c10fcd0 said 8 was "the only one installed". The FilmTicks
  test project targets net8.0 so that the default `dotnet test` runs it.
- `Upstream/PENDING.md` and `README.md` had rows saying ColonistRace was never played and that the sound scenario had not
  run; both are updated.
