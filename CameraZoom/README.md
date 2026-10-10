# Camera zoom - Pickle steps (shared)

Two steps for a capture that needs the camera closer than Pickle's own zoom steps go. **Compiled, never played.**

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the camera root size is set to {float}` | Calls `CameraDriver.SetRootSize` directly (smaller is closer) and waits 90 frames, since the game smooths the zoom. Does not check the size reached. |
| `Nelim's Pickle Tools: the camera root size is {float}` | Asserts the root size reads that value to 0.05; the failure prints the value read, which says whether the game bounds the zoom or the zoom had not finished. |

## Why it exists

Pickle's `I zoom all the way in` is clamped to a root size of 12 (`CloseSize` in `CameraSteps.cs`, read from its source on
2026-10-02), and `SetRootSize` called directly is not. AncientBuildingsRenew measured about 45 px per cell at 12 on a
1080-pixel-high screen and wants about 6 (about 90 px). **The game itself bounds the size at 11** (measured 2026-10-10, ticket 9e60, Pickle 6.6.3: asked for 6, the camera read 11): no suite gets closer than 11, whatever the step asks.
The read-back step is how a suite finds out.

Ported on 2026-10-02 from AncientBuildingsRenew's provisional steps (`Tests/Pickle/Source/BuildingSteps.cs`), at Virginie's
request, so the gallery suites share one copy. The consumer removes its local copy once these pass.

## Using it from a suite

```
nelim.pickletools.camerazoom   path:PickleTools/CameraZoom/Mod
```

in a pass map of `Tests/Pickle/`. Not in the Workshop bundle: a companion staged by a pass map. Check the patterns with
`powershell.exe -ExecutionPolicy Bypass -File PickleTools/CameraZoom/Check-Steps.ps1`. The probe scenario is
`Tests/Pickle/Mod/Pickle/Features/pickletools-camerazoom.feature`, staged with `Tests/Pickle/wsl-deps.camerazoom.map`; it asks for
root size 6 and asserts the game's own closest size, 11 (the answer the probe found on 2026-10-10).

What a camera step does not do: frame a named pawn. `CoatSteps` frames `coat-N` animals only; a by-name step is wanted
(see `Elsewhere/README.md`, the camera framing row).

## Framing a subject (2026-10-02)

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: I frame the cells \({int}, {int}\) to \({int}, {int}\) filling {int} percent of the screen` | Centres on the rectangle and sets the root size so it fills that share of the height or the width, whichever it fills more; reads the size back |
| `Nelim's Pickle Tools: I frame the cell \({int}, {int}\) at zoom {float}` | Centres on a cell at a root size, reads it back |

The size comes from two lengths: the camera shows twice its root size in cells vertically (about 45 px a cell at size 12 on 1080 px, a measurement relayed by AncientBuildingsRenew) and that times the aspect ratio horizontally. Not played; the read-back says what the game reached.

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the camera is centered on {string} at root size {float}` | Centres on a named pawn (colonist or animal) at a root size, reads it back. Pickle's own `I move the camera to {string}` centres without a zoom |
