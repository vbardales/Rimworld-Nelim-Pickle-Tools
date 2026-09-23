# Click diagnostics - Pickle steps (shared)

Three Pickle steps for a click that must land, and a report that says why when it did not:

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the button keyed {string} has stood still` | Waits until the button has been drawn at the same place for 12 frames in a row. Fails if it never appears or never stops moving. |
| `Nelim's Pickle Tools: the button keyed {string} is reachable in {string}` | Hovers the button and asserts that the window under the pointer is the named one (by short or full type name, base types included) and that it receives input. |
| `Nelim's Pickle Tools: I click the button keyed {string} and the window {string} opens` | Clicks the button, waits up to 60 frames for the named window, and when it does not open prints what the click met. |

Developer tooling. GitHub and Workshop release preparation in progress; no Defs, no features: a suite stages the companion mod in `Mod/` and writes
its own scenarios.

## Why it exists

Pickle resolves a button's tag, moves the pointer to its centre and presses. When that opens nothing, its report
is `window should be open; open windows: ImmediateWindow, ImmediateWindow`, which names nothing. Three causes are
invisible to it:

- **The button was still moving.** IMGUI counts a click only when press and release land on the same control. Work
  Studio's button, drawn in the Work tab, MOVES for about ten frames after the tab opens when Work Tab is loaded
  (the window is drawn narrow, then widens to the full screen, and the button is anchored to its right edge). A
  trace of one run: raw x 975 for frames 216-225, 1748 from frame 226. Pickle's rectangle was right at every
  instant; the layout moved between press and release. This was the cause of a failure that three earlier
  explanations got wrong, see Work Studio's `BACKLOG.md`.
- **Something sat on it.** `Widgets.ButtonImage` and friends are not recorded by Pickle, so a control with no
  label can take a click without leaving a trace.
- **The window holding the button was not receiving input.** `WindowStack.GetWindowAt` asks only which rectangle
  holds a point; `GetsInput` answers false to everything below the first window that absorbs input around itself.

A lost click prints the pointer before and after, where the button was drawn, every button (of either kind) whose
rectangle holds the pointer, in draw order, and the window stack top first, with each window's assembly, layer,
rectangle, `absorbInputAroundWindow`, `GetsInput`, and, for an `ImmediateWindow`, the method that draws it
(`doWindowFunc.Method`, because its type name identifies nothing).

## How it works

`ButtonProbe` is a Harmony postfix on every `Widgets.ButtonText` and `Widgets.ButtonImage*` overload, installed
by the first step that needs it. It records the rectangle of each button drawn in the last two frames, converted
with `GUIUtility.GUIToScreenRect` during `Repaint` only. It changes nothing in Pickle.
At scales other than 100%, that conversion can mix coordinate spaces (see
[InterfaceScale](../InterfaceScale/README.md)). Do not assume these raw probe rectangles match a corrected
Pickle tag store when the InterfaceScale repair or its upstream equivalent is active.

Buttons are named by the translation key their label comes from, so a scenario runs in any language. A key nothing
translates fails with a message that names the key and the active language.

## Using it from a suite

1. Stage it in the suite's pass maps, `Tests/Pickle/wsl-deps.<pass>.map`:

   ```
   nelim.pickletools.clickdiagnostics   path:PickleTools/ClickDiagnostics/Mod
   ```

   A pass with no map stages no companion, so a suite that uses it needs a map for its minimal pass too. The
   folder's own `About.xml` packageId must match the one written.
2. Write the scenario:

   ```gherkin
   When I open the "Work" tab
   And Nelim's Pickle Tools: the button keyed "WorkStudio.OpenEditorShort" has stood still
   And Nelim's Pickle Tools: the button keyed "WorkStudio.OpenEditorShort" is reachable in "MainTabWindow"
   When Nelim's Pickle Tools: I click the button keyed "WorkStudio.OpenEditorShort" and the window "Dialog_WorkTypes" opens
   ```

## Checking it

```
powershell.exe -ExecutionPolicy Bypass -File PickleTools/ClickDiagnostics/Check-Steps.ps1
```

Compiles the patterns with Pickle's own expression engine and checks that none is ambiguous against any other suite
in the repository or against Pickle's vocabulary. No game, a few seconds.

## What has and has not been played

**Compiled with 0 warnings, patterns checked (3 compile, none ambiguous, the three lines of Work Studio's scenario 2
resolve). Not played yet.** The code is the code Work Studio's suite carried from 2026-09-21: `WaitForButtonToSettle`
and the failure report were played in a run that produced the trace above, and the wait was written from that trace
but not replayed afterwards. What has never been seen in a game: the three steps as steps, the failure report of
`is reachable in` (both branches), and the `ButtonImage*` half of the probe on a real lost click.

`Nelim's Pickle Tools: the button keyed ... has stood still` waits 12 frames, which is a fifth of a second at 60 fps;
that number is a judgement, not a measurement of every layout.

## Two of these could go to Pickle

Written here first because a suite needed them; each is a candidate for a pull request to Pickle, see
`Upstream/PENDING.md`:

- **A wait for a tag to stand still** (`the button {string} stands still`). **Open as
  [RimWorks/Rimworld-Pickle#34](https://github.com/RimWorks/Rimworld-Pickle/pull/34)**, as
  `I wait until button {string} stands still` / `I wait until tag {string} stands still`, 12 frames.
  This tool's own step counts 12 *repeats* after the first sighting, so 13 frames, not reconciled with
  the PR's count. Keep this copy in step until the PR merges and ships: a change asked for in review is
  made here too. When it lands, delete this step (and, if the report step below moves with it, that one)
  and change the callers' prefix to Pickle's own words.
- **A lost-click report**: when a `click` step is followed by a failed `window ... is open`, print the pointer, the
  buttons under it and the window stack.

## Building

```
dotnet build -c Release
```

in `Source/`. The DLL lands in `Mod/Pickle/Assemblies/` and is committed, as the other tools' are.
