# Clear screen - Pickle steps (shared)

Two Pickle steps that keep other mods' windows off the screen for the length of a scenario:

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the screen is clear` | closes every window Pickle does not own, and drops every one that opens afterwards, until the scenario ends |
| `Nelim's Pickle Tools: windows are allowed to open again` | lifts it early |

Developer tooling. GitHub and Workshop release preparation in progress; no Defs, no features: a suite stages the companion mod in `Mod/` and writes
its own scenarios.

## Why it exists

A click step aims at a point on screen, so a window another mod owns over that point takes the click, and the
scenario reads as a dead button: it blames the mod under test for a miss that belongs to a bystander. Closing
the windows once is not enough on a real load order, because a log viewer that tails errors, or a mod that
reopens its notice, is back on the next frame, before the click lands.

The end of the scenario lifts the suppression on its own (`[AfterScenario]`), so a scenario that dies between
the two steps does not leave the game unable to open anything.

## Two versions, kept in step

This is a copy of [RimWorks/Rimworld-Pickle#21](https://github.com/RimWorks/Rimworld-Pickle/pull/21), branch
`feat/clear-the-screen` on `vbardales/Rimworld-Pickle`. It exists so a suite can use the steps with the stock
Pickle, without a local build (`-PickleSrc`). **A change to one goes to the other.** Mirrored commit: `e9f893c`.
The patch series is in `Upstream/patches/pr-21/`, the ledger row in `Upstream/PENDING.md`.

| | Pull request | This folder |
| --- | --- | --- |
| Step text | `the screen is clear`, `windows are allowed to open again` | the same, with `Nelim's Pickle Tools: ` in front |
| Style | Pickle's: 2 spaces, braces on the line, nullable annotations | This repository's: 4 spaces, braces on their own line, nullable off |
| Where | `UiSteps.cs` in `Pickle.Vanilla`, `WindowSuppression.cs` in `Pickle/Runtime`, the rule in `Pickle.Core/Ui`, plus `Docs/steps.md` | `Source/ClearScreenSteps.cs`, `Source/WindowSuppression.cs`, `Source/WindowSuppressionRule.cs` |
| What reaches `WindowStack.Add` | Pickle's own prefix calls `WindowSuppression.ShouldAdd` | a prefix of this mod's own, installed the first time a scenario asks for a clear screen |
| Tests | five unit tests of the rule, and `window-suppression.feature` | the probe, see below |

The logic must not differ. The text of the steps does, on purpose: with the prefix, this mod and a Pickle that
already carries the pull request (the local integration build, or a later release) can be loaded together and no
step is ambiguous. The prefix of the game is the one thing a companion mod cannot share: Pickle's own hook is
inside Pickle. A suite that never asks for a clear screen never has the game patched.

`Source/WindowSuppressionRule.cs` is the decision itself, "which windows does a cleared screen let through",
copied from `Source/Pickle.Core/Ui/WindowSuppressionRule.cs` of the pull request. This folder has no unit test of
its own: the five of the pull request cover the rule.

## The day it is merged

A suite that needs the steps adds this mod to its pass map and runs on the stock Pickle: no `-PickleSrc`, no
modified Pickle. When the pull request merges and a Pickle release ships it:

1. Find every user. In the monorepo, the maps that name the mod and the scenarios that use its steps:

   ```
   grep -rl "nelim.pickletools.clearscreen" --include=wsl-deps*.map .
   grep -rl "Nelim's Pickle Tools: the screen is clear\|Nelim's Pickle Tools: windows are allowed" --include=*.feature .
   ```

2. In each map, delete the `nelim.pickletools.clearscreen` line. In each scenario, drop the `Nelim's Pickle Tools: `
   prefix from the two steps. The probe of this tool, `PickleToolsCheck/Tests/Pickle/Mod/Pickle/Features/pickletools-clearscreen.feature`
   and its `wsl-deps.clearscreen.map`, is one of the users: delete both, upstream has its own scenarios.
3. Delete this folder, `Upstream/patches/pr-21/`, and the row in `Upstream/PENDING.md`.

Do the first two steps before the third, and only once the Workshop Pickle carries the steps: a suite that loses the
mod on a Pickle without them fails on an unknown step. Leaving both in place is harmless, the prefix keeps the steps
apart and a window dropped twice is dropped once, but it is dead weight.

## Using it from a suite

1. A pass map, in the suite's `Tests/Pickle/`, that stages the mod from this repository:

   ```
   nelim.pickletools.clearscreen   path:PickleTools/ClearScreen/Mod
   ```

   Select it with `-DepMap <the map>`. The folder's own `About.xml` packageId must match the one written.
2. Write the scenario. The click has to land on something that is not a window: the map, a gizmo, the main tab bar.

   ```gherkin
   Given the save "test-colony" is loaded
   And a colonist "Tabby" exists
   When I select "Tabby"
   And Nelim's Pickle Tools: the screen is clear
   And I click gizmo "Draft"
   Then "Tabby" is drafted
   ```

   **Every window that opens after the clear screen is dropped, including one the scenario itself means to open**,
   and every window open at that moment is closed. To click a button whose effect is to open a window, lift the
   suppression first, `Nelim's Pickle Tools: windows are allowed to open again`, then click.

## Checking it

```
powershell.exe -ExecutionPolicy Bypass -File PickleTools/ClearScreen/Check-Steps.ps1
```

Compiles the patterns with Pickle's own expression engine and checks that neither is ambiguous against any other
suite in the repository or against Pickle's vocabulary. No game, a few seconds.

The probe is `PickleToolsCheck/Tests/Pickle/Mod/Pickle/Features/pickletools-clearscreen.feature`, in the
`clearscreen` pass (`wsl-deps.clearscreen.map`): four scenarios designed to run with stock Pickle and nothing else
modified. Each check that a window is dropped comes with a control that the same kind of window opens when
suppression is off, because "is closed" also holds when nothing ever tried to open it.

## What has and has not been played

This closes non-Pickle windows, including the settings window a suite may want to test. It is not
screenshot mode, which hides the HUD. See the [authoring guide](../Authoring/README.md).

**Nothing of this copy has been played yet.** It compiles with 0 warnings and 0 errors, the two patterns pass
`Check-Steps.ps1`, and the probe's step lines all resolve.

The **upstream** version was played: the four scenarios of `window-suppression.feature`, in the headless WSL
install with a locally built Pickle at `ab2aa2e`, passed (4 of 4), and `dotnet test` passes 186 of 186 on the
pull request head. That is not evidence for this copy: the prefix that reaches `WindowStack.Add` is the part
that differs, and it is exactly what the probe is for. The scenario "a window Pickle owns is spared" is not in
the probe, because the window it uses is internal to Pickle; the rule's unit test covers it upstream.

The build is `Source/`, net48, against `Krafs.Rimworld.Ref`, `Lib.Harmony` and `RimWorks.Pickle.Ref`; the DLL is
committed in `Mod/Pickle/Assemblies/`, as for the other tools.
