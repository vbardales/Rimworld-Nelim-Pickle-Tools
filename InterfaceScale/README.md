# Interface scale - a Pickle step and a repair (shared)

Two things in one assembly, because they are one change to Pickle:

| What | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the interface scale is {int} percent` | sets `Prefs.UIScale` the way the Options page does, for the length of the scenario, and puts it back afterwards |
| the tag store repair (no step: it needs no line of Gherkin) | put in place before every scenario of the run, so that a **click lands at any interface scale**, not only at 100 |

Development only. Never published, no Defs, no features: a suite stages the companion mod in `Mod/` and writes
its own scenarios.

## Why it exists

Pickle records a tagged widget by converting its window-local rect with `GUIUtility.GUIToScreenRect`. That
function composes two spaces: it adds the clip origin **unscaled** and the local offset **scaled**. Every
consumer of the store wants GUI space, so at a scale other than 100 the stored rect belongs to neither, and the
click lands elsewhere. Measured in a running game at 1920x1080 and 150 percent: a clip origin of `(0, 375)` and a
local `y 285` were stored as `802.5`, where the GUI rect is `660`. At scale 1 the two spaces coincide, which is why
no scenario noticed for months.

A suite that clicks at 150 percent - Architect Studio's `16-language-review.feature` does - fails on a Pickle
that has the defect with `the pointer never reached (50.25, 814.00)`, a `y` of 814 in a GUI space 720 tall. Staging
this mod makes it pass, **on the Workshop Pickle as it is**, with no modified Pickle and no `-PickleSrc`.

The step exists because writing `Prefs.UIScale` alone tests nothing: the windows already open keep the rect
they were laid out with at the old scale. It clears the measured label widths, lets `UI.screenWidth` and
`screenHeight` follow, lays the open windows out again as `WindowStack.AdjustWindowsIfResolutionChanged` does, and
refuses to go on if the GUI space did not follow.

## This is a copy, and it is kept in step

The same change is proposed to Pickle itself: **RimWorks/Rimworld-Pickle pull request 23**, branch
`fix/tag-rect-interface-scale` on the fork. The patch series is in `Upstream/patches/pr-23/`, the ledger row in
`Upstream/PENDING.md`.

Until it merges, **both versions are maintained**: a change asked for in review is made in the pull request and
here, in the same sitting. The step differs in exactly one thing, the `Nelim's Pickle Tools:` prefix, which is
what keeps the two from being an "Ambiguous step" when they meet in one run.

**What is NOT carried.** The pull request has three commits. The conversion fix and the regression scenario
are here. The first, `ignore a tagged rect measured at another interface scale`, is not: it makes a lookup at
a different scale read as a miss, and with the conversion right it has no wrong rect left to catch. It stays in
the pull request, where it guards the case of the scale moving between the repaint that records a rect and the
lookup that reads it.

**How the repair is applied.** A postfix on `TagStore.Record`, put in place by a `[BeforeScenario]` hook of this
assembly, since RimWorld itself never loads an assembly from `Pickle/Assemblies/`. The original runs, then the rect
it just stored is replaced by `rect.position + GUIToScreenPoint(zero)`, `GUIToScreenPoint(zero)` being exact for the
origin because the scaled term vanishes at zero. It is **idempotent**: on a Pickle that already does this it stores
the same value again, so having both in one run does no harm, and nothing has to detect which Pickle it is on.

**When the pull request lands and a Pickle release carries it**, delete this folder, `Upstream/patches/pr-23/` and
its row in `Upstream/PENDING.md`, the `nelim.pickletools.interfacescale` line of every pass map that stages it
(`PickleToolsCheck/Tests/Pickle/wsl-deps.interfacescale.map`, `ArchitectStudio/Tests/Pickle/wsl-deps.avec-pickletools.map`),
and change the one prefix in the scenarios that used the step.

## Using it from a suite

1. A pass map, in the suite's `Tests/Pickle/`, that stages the mod from this repository:

   ```
   nelim.pickletools.interfacescale   path:PickleTools/InterfaceScale/Mod
   ```

   Select it with `-DepMap <the map>`. The folder's own `About.xml` packageId must match the one written.
2. **The repair needs nothing else.** It applies to every scenario of the run, so a suite that already clicks at
   another scale passes without a change.
3. To set a scale from a scenario:

   ```gherkin
   Given the main menu is open
   And Nelim's Pickle Tools: the interface scale is 150 percent
   When I click button "New colony"
   Then window "Page_SelectScenario" is open
   ```

It applies to the whole run, not to the suite that staged it: a pass that plays several suites gets the repair
for all of them.

## Checking it

```
powershell.exe -ExecutionPolicy Bypass -File PickleTools/InterfaceScale/Check-Steps.ps1
```

Compiles the pattern with Pickle's own expression engine and checks that it is not ambiguous against any other
suite in the repository or against Pickle's vocabulary. No game, a few seconds.

The build is `Source/`, net48, against `Krafs.Rimworld.Ref`, `Lib.Harmony` and `RimWorks.Pickle.Ref`; the DLL is
committed in `Mod/Pickle/Assemblies/`, as for the other tools.

## What has and has not been played

Played on the headless WSL install, 2026-09-22, against the **Workshop Pickle staged as-is** (the log's
staging line carries no `override:`, so this is not a rebuilt or patched Pickle): `interface-scale.feature`,
`PickleToolsCheck` with only this tool's pass map added, filtered to that one feature. 1 scenario, 1 passed,
`exitReason: passed`, no exception. That is the repair working live, through a Harmony postfix on the DLL
Pickle actually ships - not a bundle built from source, which is the other way this pull request has been
proven (see `Upstream/bundles/README.md`).

Not yet measured: the negative control, the same feature with the tool NOT staged, to see the pass count
against the run recorded for the unfixed Workshop Pickle in `Upstream/PENDING.md`
(`the pointer never reached (50.25, 814.00)`).
