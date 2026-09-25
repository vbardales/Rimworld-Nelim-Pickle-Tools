# Publication

Steam Workshop item **3806142401**, **public** as read from Steam's public API on 2026-09-25 (`visibility` 0, created and last updated 2026-09-22 11:59 UTC, one upload, one subscriber; the API returns nothing for a private item). **Version 1.0.0 was released on 2026-09-22** (the Steam upload, and the GitHub release `v1.0.0` on `2dc9845`). Earlier text here called the item private; it was made public after its creation, and the VEF thank-you below was posted after that. `Mod/About/PublishedFileId.txt` is part of the
published payload and must never be deleted: losing it can create a duplicate item on the next upload.

## Steam description

RimWorld sends `About.xml`'s description only when creating an item. Because this item already exists, paste
the following text into the Steam page by hand. It is the BBCode source mirrored in `Mod/About/About.xml`.

```text
[h1]Shared utilities for Pickle test suites[/h1]
Developer tools for writing and running RimWorld 1.6 [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3791648678]Pickle[/url] scenarios.

[list]
[*]Open and inspect research and pawn tabs.
[*]Create and verify colonists: xenotypes, humanlike pawn kinds and body types.
[*]Check texture ownership, active expansions and optional mods.
[*]Capture tick-based films and clean review screenshots.
[*]Click translated buttons and diagnose missed clicks or interface-scale issues.
[*]Hover a tooltip by its text and check what is drawn.
[*]Exercise optional [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1084452457]RIMMSQOL[/url] and [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2023507013]Vanilla Expanded Framework[/url] workflows.
[/list]

Requires [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3791648678]Pickle[/url]. [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1084452457]RIMMSQOL[/url], [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2023507013]Vanilla Expanded Framework[/url] and mods targeted by particular tests are OPTIONAL: install them only for scenarios that need them. No gameplay content or test saves included. Do not enable this bundle together with its separate development companions: they contain the same steps.

Some utilities have been submitted upstream to Pickle. If equivalent functionality is integrated and released in a supported Pickle version, those utilities will be removed from this bundle in favor of the upstream implementation.

Tested against Pickle 4.9.1 in English and French: with and without Biotech, with optional RIMMSQOL and Vanilla Expanded Framework, and across a game restart. What was played and what was not (manual checks, some optional tools) is listed in TESTING.md and STATUS.md in the repository.

[h1]If I go quiet[/h1]
If I do not answer within a reasonable time after being contacted, anyone may freely update this or any other of my mods, including publishing a continuation of it. All credit must be preserved.

[h1]AI-generated[/h1]
Code and documentation include Claude Code (Anthropic) and Codex (OpenAI), under human direction and review. The icon and preview were generated with DALL-E (OpenAI).

[h1]Thanks[/h1]
[list]
[*]Aaron Scherer and RimWorks for [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3791648678]Pickle[/url], the test runner these utilities extend.
[*]Malte Schulze for [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1084452457]RIMMSQOL[/url] and its readable source, used for the optional MainButtons workflow.
[*]Oskar Potocki and the Vanilla Expanded team for [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2023507013]Vanilla Expanded Framework[/url], whose optional faction workflow is exercised by one module.
[*]Andreas Pardeike for [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2009463077]Harmony[/url].
[/list]

See ATTRIBUTION.md. This mod is MIT licensed.

[url=https://github.com/vbardales/rimworld-nelim-pickle-tools]Source code on GitHub[/url]
```

## Images

Steam takes `About/Preview.png` from the uploaded folder as the Workshop preview. `About/ModIcon.png` is the
in-game mod-list icon and stays in the payload; it is not an extra Workshop screenshot.

| Use | File | Verified |
|---|---|---|
| Workshop preview | `Mod/About/Preview.png` | 896 x 504, 538,239 bytes, opened on 2026-09-22 |
| In-game mod icon | `Mod/About/ModIcon.png` | 128 x 128, 24,607 bytes, opened on 2026-09-22 |

No additional gallery screenshot is claimed yet. Add one only after it has been produced and visually reviewed;
the current aggregate runtime matrix is still pending.

## Dependencies and DLC

- **One required Workshop item:** [Pickle](https://steamcommunity.com/sharedfiles/filedetails/?id=3791648678),
  packageId `rimworks.pickle`.
- RIMMSQOL and Vanilla Expanded Framework are optional integrations. Do not add them to Steam's required-items
  list. Scenarios that need them declare their own `@requires` tag.
- No RimWorld DLC is a global requirement. Scenario-specific DLC requirements remain optional.

## Content checkboxes

No adult content. The preview shows a stylized workshop with jars, tools and one clothed worker; the icon is a
cartoon pickle with tools. This developer utility contains no gameplay characters, nudity, violence or sexual
content.

## Steam thank-you comments

The global `WORKSHOP_COMMENTS.md` register controls duplicates.

- Pickle (`3791648678`): already posted for the collection; add PickleTools to `Covers`, do not repost.
- RIMMSQOL (`1084452457`): already posted for the collection; add PickleTools to `Covers`, do not repost.
- Harmony (`2009463077`): already posted for the collection; add PickleTools to `Covers`, do not repost.
- Vanilla Expanded Framework (`2023507013`): posted on 2026-09-22 after item 3806142401 became public.

Sarg Bjornson replied on the VEF Workshop page on 2026-09-22: “Not much of an enthusiast of anything touched by the vile offspring, sorry”. The target of “the vile offspring” is unclear from this exchange. Do not infer a specific accusation or endorsement, and do not post a follow-up without a clear reason. The optional VEF integration and its attribution remain factual.

### Vanilla Expanded Framework — posted

```text
[b]Thank you, Vanilla Expanded Framework![/b] 🥒✨

PickleTools includes an optional set of test steps for VEF's new-faction workflow: choosing a faction missing from a save, replaying the framework's check, and verifying its dialog and ignored state. VEF is not required by the bundle; test suites stage it only for scenarios that exercise this integration.

Thank you to Oskar Potocki and the Vanilla Expanded team for the framework, and for giving RimWorld modders such a rich integration surface to test against. 💛

https://steamcommunity.com/sharedfiles/filedetails/?id=3806142401
```

## Steam change notes

The publish workflow reads the fenced block under the heading `### <version>`. The version number 1.1.0 is proposed (a new step suggests a minor version) and awaits the owner's confirmation.

### 1.1.0

```text
[h3]1.1.0[/h3]

[b]Added[/b]
[list]
[*]Colonist body type step: a pawn gets Male, Female, Thin, Fat or Hulk for certain, whatever its xenotype's body-type genes.
[*]Hover steps: hover a tooltip by its text and check that it is drawn.
[*]Screenshot mode can turn developer mode off for a capture that keeps the interface.
[/list]

[b]Changed[/b]
[list]
[*]Click diagnostics: the stand-still wait says how long it waited and gives up on the clock; a window open before the click does not count.
[*]Tested against Pickle 4.9.1 in English and French.
[/list]
```

### 1.0.0

```text
[h3]1.0.0 — first release[/h3]

[b]Added[/b]
[list]
[*]Thirteen reusable Pickle step modules in one Workshop item.
[*]Research and inspect-tab controls, colonist and xenotype helpers, texture ownership and expansion checks.
[*]Tick-based filming, clean screenshot mode, keyed clicks, click diagnostics and interface-scale repair.
[*]Optional RIMMSQOL and Vanilla Expanded Framework test integrations.
[*]MIT licence, full attribution and suite-authoring documentation.
[/list]

Only Pickle is required globally. Mods and DLC exercised by particular scenarios remain optional.
```

## Before the next upload

The next release goes out by the CI, after `AUDIT.md`'s `tested` and `prepublished` gates and the fail-fast conditions: no red scenario without a green replay, the gallery, the owner's manual validations, a dry-run of the exact commit, the full SHA, and a rollback target chosen beforehand; the rollback target is `v1.0.0`, the commit `2dc9845`. No tag or release is made by hand: the workflow creates them after a successful upload.

The Steam description above is the text for that release: it no longer calls the bundle a release candidate. An upload from the game does not send the description again, so it is sent by the CI with `update_description` (its dry-run prints the text, its size and its diff against the page), or pasted by hand on the Steam page. `Mod/About/About.xml` carries the same text.

**The payload is committed.** The workflow uploads `Mod/` as committed and has no build step, so `Mod/Pickle/Assemblies` holds the
fourteen tool DLLs, copied byte for byte from the tools by `Release/Prepare-Release.ps1 -SyncMod`. Before every release run
`powershell.exe -ExecutionPolicy Bypass -File PickleTools/Release/Prepare-Release.ps1 -Check` (exit 1 on any difference); commit,
then dry-run that exact commit. The workflow requires all fourteen DLLs, so an incomplete payload fails the dry-run instead of
shipping a bundle without steps, and forbids `Source` and `.build` in `Mod/`.

**The workflow** (`.github/`, generated on 2026-09-25 from `Rimworld-Release-Admin` at 2ce34a3, its 49 tests passing) is
`publish-tag.yml`, dispatched with `ref`, `version` and `mode` (`dry-run` or `publish`). The command that wrote it, to be rerun with
`--replace` when the template moves:

```bash
bash Rimworld-Release-Admin/scripts/generate-publish-workflow.sh PickleTools \
  --workshop-id 3806142401 --package-id nelim.pickletools \
  --release-title "Nelim's Pickle Tools {version}" \
  --require Pickle/Assemblies/Nelim.PickleTools.ClearScreen.dll   --require Pickle/Assemblies/Nelim.PickleTools.ClickDiagnostics.dll \
  --require Pickle/Assemblies/Nelim.PickleTools.ColonistRace.dll  --require Pickle/Assemblies/Nelim.PickleTools.Expansions.dll \
  --require Pickle/Assemblies/Nelim.PickleTools.FilmTicks.dll     --require Pickle/Assemblies/Nelim.PickleTools.InspectTabs.dll \
  --require Pickle/Assemblies/Nelim.PickleTools.HoverSteps.dll \
  --require Pickle/Assemblies/Nelim.PickleTools.InterfaceScale.dll --require Pickle/Assemblies/Nelim.PickleTools.KeyedClick.dll \
  --require Pickle/Assemblies/Nelim.PickleTools.ResearchSteps.dll --require Pickle/Assemblies/Nelim.PickleTools.Rimmsqol.dll \
  --require Pickle/Assemblies/Nelim.PickleTools.ScreenshotMode.dll --require Pickle/Assemblies/Nelim.PickleTools.TextureOwner.dll \
  --require Pickle/Assemblies/Nelim.PickleTools.VefFactions.dll --forbid Source --forbid .build \
  --description-file PUBLICATION.md --description-heading '^## Steam description$'
```

The change note is the fenced block under `### 1.1.0` in "Steam change notes"; the release notes are the `## [1.1.0]` section of
`CHANGELOG.md`; the description is the block under "Steam description", sent only with `update_description` (turn it on for this
release: the live page still says release candidate; 8000 bytes maximum, no straight double quote, no backslash). The dry-run prints its
size, hash and diff against the live page, which is the review. No gallery folder is declared: no capture exists yet.

**Rollback.** `v1.0.0` (`2dc9845`) cannot be a CI rollback target: it has no `.github` and its `Mod/` has no DLL. For the first CI
publication the rollback is Steam's own "rÃ©tablir cette version" in the item's change history (the 1.0.0 uploaded on 2026-09-22 is
there), chosen by the owner before the publish. Once 1.1.0 is published from a commit that holds the payload and the workflow, that
commit is the target of a later 1.1.1. The CI creates `v1.1.0` and its release; nothing is tagged by hand.

`HoverSteps` joins the payload in this release (the owner, 2026-09-25): `Prepare-Release.ps1` lists fourteen tools and the workflow requires the fourteen DLLs. Its steps have not been played in this repository yet, see `STATUS.md`.
