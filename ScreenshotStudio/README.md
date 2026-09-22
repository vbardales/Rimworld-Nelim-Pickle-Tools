# Zen meadow screenshot studio

A reusable, paused photographic colony for Nelim's Pickle screenshots. The owner's `queue.png`
inspired the amber, gold and dark-brown palette and supplies the sampled 33-cell tiled emblem.
Japanese-garden-inspired pavilions have pale panels, dark wood verandas and mat floors. A pond and
footbridge, a raked dry garden, bonsai pots, rustic lanterns and flower beds surround the emblem.
The buildings sit in a meadow of grass, dandelions, daylilies and roses. This is a studio set,
with deliberately open roofs; it is not a survival-balanced colony.

## Load it in another suite

Add this line to that suite's explicit pass map (UTF-8, LF line endings):

```text
nelim.pickletools.screenshotstudio path:PickleTools/ScreenshotStudio/Mod
```

Once the completed fixture is installed, use:

```gherkin
Given the save "nelim-zen-meadow-studio" is loaded
And game speed is paused
When Nelim's Pickle Tools: I frame the studio "flowers"
And I take a screenshot "my-mod-in-the-meadow"
```

The tool adds no gameplay patches, settings, main buttons, or custom saved definitions.
The tested environment includes Core and all five DLC, plus the standard WSL Pickle dependencies.
Loading without those DLC has not been verified. Never replace a functional test's existing fixture
automatically: this scenery is an explicit choice for presentation screenshots.

## Camera presets and staging cells

| Preset | Camera cell | Purpose |
|---|---|---|
| overview | 125,125 | Whole colony |
| emblem | 125,125 | Icon mosaic and central garden |
| workshop | 96,125 | Tailoring, stonecutting, sculpture |
| kitchen | 154,125 | Cooking and dining |
| home | 125,154 | Three beds and sitting area |
| display | 125,96 | Empty indoor demonstration stage |
| flowers | 154,98 | Open glade surrounded by flowers |
| pond | 153,152 | Garden pond, island and timber footbridge |
| zen | 97,152 | Pale sand, curved gravel bands and natural stones |

Actors: Ambre (workshop), Flore (kitchen), Soleil (home), Miel (flower glade).
For a clean illustration, call `Nelim's Pickle Tools: studio presentation mode is enabled`
before capture. This uses RimWorld's own screenshot mode and restores its original state after the
scenario. Keep the normal interface when the screenshot is meant to demonstrate a menu.
If a log viewer or notice is open, stage the existing ClearScreen tool and use its documented step.

The preparation step is destructive **inside the loaded test map**, around its centre;
it is opt-in and must be used only on a disposable fixture. The saved studio is the usual entry point.

## Rebuild and verify

Build `Source/Nelim.PickleTools.ScreenshotStudio.csproj` with .NET and the pinned references.
The DLL goes to `Mod/Pickle/Assemblies/`; intermediates stay in `.build/`.

From the collection root:

```powershell
powershell.exe -ExecutionPolicy Bypass -File scripts/Pickle-Status.ps1
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.studio.map -Filter flower-meadow-studio.feature -Label "Flower meadow screenshot colony"
```

The scenario builds from `studio-base`, checks the meadow and stations, performs a save/reload,
checks all mosaic colors and garden features again, writes `Nelim-Zen-Meadow-Studio.rws` into WSL's Saves directory and
captures nine views without the interface plus one overview with it.
`load-flower-meadow-studio.feature` verifies the exported fixture in a new game process without rebuilding it.
The initial non-zen fixture is retained under `nelim-flower-meadow-studio` as an earlier alternative;
the current integrity assertions target the zen version.
Use `Use-Wsl.ps1` under the same queue/lock for any WSL copy or other preparation work.
Never launch the Windows game, bypass the launcher, or create/release the owner's reservation.

## Source and attribution

Code and documentation: OpenAI Codex, under Nelim's direction (2026-09-22).
Icon pattern: derived from the image supplied by the owner in this task. The original PNG is not bundled.
The seed save is a private working copy of Pickle's `test-colony.rws`, with pre-existing scene objects
removed from the set area. It does not modify the upstream fixture. Pickle's MIT notice is retained
beside the seed. No upstream code is copied into the studio assembly.
