# Interface scale - a Pickle step (shared)

One step, kept here until Pickle ships it:

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the interface scale is {int} percent` | sets `Prefs.UIScale` the way the Options page does, for the length of the scenario, and puts it back afterwards |

Developer tooling. GitHub and Workshop release preparation in progress; no Defs, no features: a suite stages the companion mod in `Mod/` and writes
its own scenarios.

## Why it exists

Writing `Prefs.UIScale` alone tests nothing: the windows already open keep the rect they were laid out with at
the old scale. The step clears the measured label widths, lets `UI.screenWidth` and `screenHeight` follow, lays
the open windows out again as `WindowStack.AdjustWindowsIfResolutionChanged` does, and refuses to go on if the GUI
space did not follow.

## History: the tag store repair is gone (2026-10-02)

Until Pickle 5.x this tool also carried a Harmony postfix on `TagStore.Record` that repaired the rect Pickle
stored at any interface scale but 100 (`GUIUtility.GUIToScreenRect` adds the clip origin unscaled and the local
offset scaled, and the OS-pointer path then scaled it again). It was the copy of RimWorks/Rimworld-Pickle pull
request 23.

**Pickle 6.0.0 (commit 095bfe9) took the OS pointer out**: a click is taken at the widget, `Record` and `TakeClick`
see the same rect in the same call, and the stored space no longer matters as long as both ends agree. The repair
would now make them disagree (`Record` translate-only, `InteractionRequest` still doing the full
`GUIToScreenRect`, a gap of `(UIScale - 1) x local offset` against a 1 px tolerance), and a button at local (0, 0)
would still pass while buttons deeper in a window failed. So it was **removed**, not kept for safety, and PR 23 is
closed by its author. The maintainer kept the step and its scenario in pull request 42, with the original author.

The patch series stays in `Upstream/patches/pr-23/` as a record of the old diagnosis; it must not be applied on a
Pickle 6.

## Using it from a suite

1. A pass map, in the suite's `Tests/Pickle/`, that stages the mod from this repository:

   ```
   nelim.pickletools.interfacescale   path:PickleTools/InterfaceScale/Mod
   ```

   Select it with `-DepMap <the map>`. The folder's own `About.xml` packageId must match the one written.
2. To set a scale from a scenario:

   The example uses an English label. For French, use the localized label or stage
   [KeyedClick](../KeyedClick/README.md) and its translation-key step. Tag features that need this tool
   `@requires:nelim.pickletools.interfacescale`.

   ```gherkin
   Given the main menu is open
   And Nelim's Pickle Tools: the interface scale is 150 percent
   When I click button "New colony"
   Then window "Page_SelectScenario" is open
   ```

**When Pickle ships the step (pull request 42 in a release)**, delete this folder, its row in `Upstream/PENDING.md`,
the `nelim.pickletools.interfacescale` line of every pass map that stages it, and change the one prefix in the
scenarios that use the step.

## Checking it

```
powershell.exe -ExecutionPolicy Bypass -File PickleTools/InterfaceScale/Check-Steps.ps1
```

Compiles the pattern with Pickle's own expression engine and checks that it is not ambiguous against any other
suite in the repository or against Pickle's vocabulary. No game, a few seconds.

The build is `Source/`, net48, against `Krafs.Rimworld.Ref`, `Lib.Harmony` and `RimWorks.Pickle.Ref`; the DLL is
committed in `Mod/Pickle/Assemblies/`, as for the other tools. The bundle copy under `PickleTools/Mod/Pickle/Assemblies/`
is refreshed by `Release/Prepare-Release.ps1 -SyncMod`.

## What has and has not been played

**Nothing of this tool has been played on Pickle 6.** The step compiled before the repair was removed. What was
played (2026-09-22, Pickle 5, Workshop Pickle as-is) was the repair, which no longer exists. The scenario
`interface-scale.feature` clicks at 150 percent and is the test that matters on Pickle 6: it passes if clicks
still land at another scale. It has not run since.
