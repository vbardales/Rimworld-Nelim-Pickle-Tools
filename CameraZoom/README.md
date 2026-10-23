# Camera zoom - Pickle steps (shared)

Two steps for a capture that needs the camera closer than Pickle's own zoom steps go. **Compiled, never played.**

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the camera root size is set to {float}` | Calls `CameraDriver.SetRootSize` directly (smaller is closer) and waits 90 frames, since the game smooths the zoom. Does not check the size reached. |
| `Nelim's Pickle Tools: the camera root size is {float}` | Asserts the root size reads that value to 0.05; the failure prints the value read, which says whether the game bounds the zoom or the zoom had not finished. |
| `Nelim's Pickle Tools: the camera orthographic size is {float}` | Asserts the size the camera really draws (`Find.Camera.orthographicSize`, half the screen height in cells), to 0.05; the failure prints the value read. Added 2026-10-22: a camera mod can leave the root size alone and change what is drawn. |

## Why it exists

Pickle's `I zoom all the way in` is clamped to a root size of 12 (`CloseSize` in `CameraSteps.cs`, read from its source on
2026-10-02), and `SetRootSize` called directly is not. AncientBuildingsRenew measured about 45 px per cell at 12 on a
1080-pixel-high screen and wants about 6 (about 90 px). **The game itself bounds the size at 11** (measured 2026-10-10, ticket 9e60, Pickle 6.6.3: asked for 6, the camera read 11): no suite gets closer than 11, whatever the step asks.
The read-back step is how a suite finds out.

Ported on 2026-10-02 from AncientBuildingsRenew's provisional steps (`Tests/Pickle/Source/BuildingSteps.cs`), at Virginie's
request, so the gallery suites share one copy. The consumer removes its local copy once these pass.

## With a camera mod (2026-10-22)

Camera+ (Brrainz, 867467808; ticket 996e, Camera+ 2026-08-28 on the 1.6 game) does NOT lift the game's bound of 11 on the root size: asked for 6, the root size still reads 11. It keeps the root size in the game's own range (11 to 60) and maps it onto another orthographic size (`Tools.LerpRootSize`, source pardeike/CameraPlus `Source/Tools.cs` and `Settings.cs`): at root size 11 its default zoom range draws an orthographic size of 2, where the game alone draws 11. So the root size is not the zoom once a camera mod is in the list: read the orthographic size (the step above), and the `I frame ... at zoom` and cell-filling steps, which compute from the root size, no longer give the same picture. Probe: `pickletools-camerazoom-cameraplus.feature` with `wsl-deps.camerazoom-cameraplus.map`; SimpleCameraSetting (3232415388, ray1203) has the same probe, `pickletools-camerazoom-simplecamera.feature`, and it is the mod to use (2026-10-22, tickets 54d3 and 46b3, both passed): with its default settings the root size asked for is the root size read (6, then 6) AND the size drawn (orthographic size 6), so the frame steps keep computing the picture they name. It is staged in `wsl-deps.look-gallery.map` and `wsl-deps.faceparts.map`. Camera+ (996e) stays out of the galleries: it keeps the root size at 11 and remaps it.

## Using it from a suite

```
nelim.pickletools.camerazoom   path:PickleTools/CameraZoom/Mod
```

in a pass map of `Tests/Pickle/`. Not in the Workshop bundle: a companion staged by a pass map. Check the patterns with
`powershell.exe -ExecutionPolicy Bypass -File scripts/Check-Steps.ps1 -ModRoot PickleTools/CameraZoom -Tool`. The probe scenario is
`Tests/Pickle/Mod/Pickle/Features/pickletools-camerazoom.feature`, staged with `Tests/Pickle/wsl-deps.camerazoom.map`; it asks for
root size 6 and asserts the game's own closest size, 11 (the answer the probe found on 2026-10-10).

What a camera step does not do: frame a named pawn. `CoatSteps` frames `coat-N` animals only; a by-name step is wanted
(see `docs/Elsewhere/README.md`, the camera framing row).

## Framing a subject (2026-10-02)

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: I frame the cells \({int}, {int}\) to \({int}, {int}\) filling {int} percent of the screen` | Centres on the rectangle and sets the root size so it fills that share of the height or the width, whichever it fills more; reads the size back |
| `Nelim's Pickle Tools: I frame the cell \({int}, {int}\) at zoom {float}` | Centres on a cell at a root size, reads it back |

The size comes from two lengths: the camera shows twice its root size in cells vertically (about 45 px a cell at size 12 on 1080 px, a measurement relayed by AncientBuildingsRenew) and that times the aspect ratio horizontally. Not played; the read-back says what the game reached.

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the camera is centered on {string} at root size {float}` | Centres on a named pawn (colonist or animal) at a root size, reads it back. Pickle's own `I move the camera to {string}` centres without a zoom |
