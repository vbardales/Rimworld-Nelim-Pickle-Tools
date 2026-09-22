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
