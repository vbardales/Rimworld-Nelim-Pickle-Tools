# Build17: net10.0 builds for RimWorld 1.7

Pickle tool folders built for 1.7 (`net10.0`), kept here so a 1.7 Pickle run does not depend on a folder outside the repository (WSL `~/pt17/mods`). Each folder holds `About/About.xml` and `Pickle/Assemblies/`.

| Folder | Source tool folder | Built from (WSL) |
|---|---|---|
| `InspectTabs` | `InspectTabs/Source` | `~/pt17/src/InspectTabs` |
| `ScreenshotStudio` | `ScreenshotStudio/Source` | `~/pt17/src/Nelim.PickleTools.ScreenshotStudio` |
| `ScreenshotMode` | `ScreenshotMode/Source` | `~/pt17/src/ScreenshotMode` |

Copied 2026-11-09 from `~/pt17/mods/<Name>` (DLL dates: InspectTabs and ScreenshotMode 2026-10-12, ScreenshotStudio 2026-11-05).

## Known gap

The `net10.0` ScreenshotStudio DLL (95 KB) is older than the 1.6 one in `ScreenshotStudio/Mod` (118 KB): it was built from `~/pt17/src`, which is not synced with `ScreenshotStudio/Source` here. Steps added later (for example `CameraOrthoSteps`) are not in the 1.7 build until it is rebuilt.

A mod whose scenario uses a step missing from these builds must fail loudly (an undefined step is an error), never be skipped.

## Rebuild

The 1.7 csproj files are not in this repository. They live in `~/pt17/src/<folder>` (WSL), reference the game in `~/rimworld17` and Pickle in `~/Rimworld-Pickle/1.7`, and write to `~/pt17/out-<name>`. From WSL, after copying the current `.cs` files of the tool's `Source/` into the folder above:

```bash
~/.dotnet/dotnet build ~/pt17/src/<folder>/<Project>.csproj -c Release
cp ~/pt17/out-<name>/* /mnt/c/Users/nelim/Documents/rimworld/PickleTools/Build17/<Name>/Pickle/Assemblies/
```

`<Name>` is the Build17 folder. `About/About.xml` changes only when the tool's About changes.

## When to rebuild

Whenever the `Source/` of one of these three tools changes (a new or changed step), then commit the new DLL here by path.

A 1.7 shell references a folder as `path:PickleTools/Build17/<Name>` (see `DrumBathHygiene/Tests/Pickle/wsl-deps.tools-17.map`).
