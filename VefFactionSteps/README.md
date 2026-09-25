# VEF faction spawning - Pickle steps

Nine shared steps for Vanilla Expanded Framework's new-faction workflow. They select a visible faction
missing from the loaded world, invoke VEF's own post-load check, inspect its dialog and ignored set, and
temporarily mark the chosen faction as required. The AfterScenario hook removes that temporary extension.

This module was promoted from `QuietNewFactions/Tests/Pickle/Source/FactionSteps.cs` on 2026-09-22.
Its behavior remains tied to VEF's `FactionDefExtension`, `NewFactionSpawningState`,
`Dialog_NewFactionSpawning` and private `ignoredFactions` field. Rebuild and replay its consumers when VEF
changes. No VEF binary is shipped.

The assembly now resolves VEF types only when a VEF scenario calls them. This keeps the aggregate
step assembly loadable when VEF is absent. Its reflection calls still require a VEF replay before
the changed implementation can be considered validated in game.

## Use from a suite

Standalone development companion map:

```text
nelim.pickletools.veffactions path:PickleTools/VefFactionSteps/Mod
```

Tag consuming features with both requirements:

```gherkin
@requires:nelim.pickletools.veffactions
@requires:OskarPotocki.VanillaFactionsExpanded.Core
```

For the aggregate Workshop bundle, replace the first tag with `@requires:nelim.pickletools`; VEF remains
optional. Do not enable the standalone companion and aggregate bundle together.

All phrases begin with `Nelim's Pickle Tools:`. See `QuietNewFactions/Tests/Pickle/Mod/Pickle/Features/` for complete examples.

## Build and checks

```powershell
dotnet build PickleTools/VefFactionSteps/Source/Nelim.PickleTools.VefFactions.csproj -c Release
powershell.exe -ExecutionPolicy Bypass -File PickleTools/VefFactionSteps/Check-Steps.ps1
```

The check compiles the Cucumber expressions, scans for duplicate/ambiguous patterns and resolves current
consumer lines. It is offline evidence only. The earlier promoted assembly passed the five
QuietNewFactions scenarios from this repository; the late-binding change above still awaits replay.

## Attribution

Original work for Quiet New Factions, written with Claude Code (Anthropic) under Nelim's direction and
review, then promoted and namespaced with OpenAI Codex. VEF was studied and referenced but not copied.
Pickle supplies the step API. See the repository ATTRIBUTION.md and included MIT licence.

## Steps

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the load has settled` | Waits until the game has no long event running or waiting (VEF runs its check after the load), then three frames |
| `Nelim's Pickle Tools: a faction the world lacks is chosen` | Picks a faction the loaded world does not have and VEF would offer (not the player's, not hidden), and remembers it as the chosen one for the steps that follow |
| `Nelim's Pickle Tools: the chosen faction is marked required by its mod` | Gives the chosen faction VEF's own extension that marks it required, refusing if it already carries one, and takes it off again after the scenario |
| `Nelim's Pickle Tools: VEF runs its new faction check` | Calls VEF's own on-game-loaded check by reflection, then waits three frames; fails, saying so, if VEF changed |
| `Nelim's Pickle Tools: no new faction window is open` | Asserts no new-faction window is open, and lists the factions of the ones that are |
| `Nelim's Pickle Tools: a new faction window is open for the chosen faction` | Asserts a new-faction window is open for the chosen faction, and lists the ones that are open |
| `Nelim's Pickle Tools: the chosen faction is ignored in this save` | Asserts the chosen faction is on VEF's ignored list |
| `Nelim's Pickle Tools: the chosen faction is not ignored` | Asserts the chosen faction is not on VEF's ignored list |
| `Nelim's Pickle Tools: the game log says the chosen faction was ignored` | Asserts the log holds a Quiet New Factions line for the chosen faction |
