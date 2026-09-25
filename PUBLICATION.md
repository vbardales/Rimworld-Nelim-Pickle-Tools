# Publication

Steam Workshop item **3806142401**, **public** as read from Steam's public API on 2026-09-25 (`visibility` 0, created and last updated 2026-09-22 11:59 UTC, one upload, one subscriber; the API returns nothing for a private item). Earlier text here called it private; the item was made public after its creation, and the VEF thank-you below was posted after that. `Mod/About/PublishedFileId.txt` is part of the
published payload and must never be deleted: losing it can create a duplicate item on the next upload.

## Steam description

RimWorld sends `About.xml`'s description only when creating an item. Because this item already exists, paste
the following text into the Steam page by hand. It is the BBCode source mirrored in `Mod/About/About.xml`.

```text
[h1]Shared utilities for Pickle test suites[/h1]
Developer tools for writing and running RimWorld 1.6 [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3791648678]Pickle[/url] scenarios.

[list]
[*]Open and inspect research and pawn tabs.
[*]Create and verify colonists, xenotypes and humanlike pawn kinds.
[*]Check texture ownership, active expansions and optional mods.
[*]Capture tick-based films and clean review screenshots.
[*]Click translated buttons and diagnose missed clicks or interface-scale issues.
[*]Exercise optional [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1084452457]RIMMSQOL[/url] and [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2023507013]Vanilla Expanded Framework[/url] workflows.
[/list]

Requires [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3791648678]Pickle[/url]. [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1084452457]RIMMSQOL[/url], [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2023507013]Vanilla Expanded Framework[/url] and mods targeted by particular tests are OPTIONAL: install them only for scenarios that need them. No gameplay content or test saves included. Do not enable this bundle together with its separate development companions: they contain the same steps.

Some utilities have been submitted upstream to Pickle. If equivalent functionality is integrated and released in a supported Pickle version, those utilities will be removed from this bundle in favor of the upstream implementation.

This is a release candidate. Aggregate runtime validation is pending; see TESTING.md and STATUS.md in the repository for exact coverage and limitations.

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

## Before the 1.0.0 upload

The item is already public and holds the 2026-09-22 upload, whose commit is not recorded (see `CHANGELOG.md`, `[0.1.0]`). The 1.0.0 goes out by the CI, after AUDIT.md's `tested` and `prepublished` gates and the fail-fast conditions: no red scenario without a green replay, the gallery, the owner's manual validations, a dry-run of the exact commit, the full SHA, and a rollback target chosen beforehand. No tag or release is made by hand: the workflow creates `v1.0.0` and the release after a successful upload.

The Steam description above says this is a release candidate with runtime validation pending. The page description is not sent again by an upload from the game, so its correction is a manual edit on the Steam page, or an `update_description` publish once a workflow exists (see `STATUS.md`).
