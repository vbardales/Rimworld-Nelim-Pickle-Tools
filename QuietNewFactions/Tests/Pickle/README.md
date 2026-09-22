# In-game scenarios, run by Pickle

Played inside a running RimWorld by [Pickle](https://github.com/RimWorks/Rimworld-Pickle)
(`rimworks.pickle`, Workshop 3791648678). `Mod/` is a companion mod, **Quiet New Factions -
Pickle tests**, never published: it holds the feature files. Its VEF workflow vocabulary now lives
in PickleTools under `VefFactionSteps`; the suite no longer owns or ships a step assembly.

| Feature | Checks |
| --- | --- |
| 01-loading | the mod loads after VEF, and its patch sits on `Dialog_NewFactionSpawning.OpenDialog` |
| 02-offered-faction | a faction the world lacks gets no window, is on VEF's ignored list, is logged, and stays ignored across a save and reload |
| 03-required-faction | a faction marked required still opens VEF's window and is not ignored |

The scenarios do not need a fixture that lacks a faction. They load Pickle's `test-colony`, pick a
faction the world lacks, take it off VEF's ignored list and call VEF's own load check
(`...LoadedGame_Patch+LoadedGame.OnGameLoaded`) again. Scenario 03 adds a `FactionDefExtension`
to that def for its own duration and removes it in `[AfterScenario]`.

A mod list where every visible faction is already in the fixture's world has nothing to offer:
02 and 03 then stop on a `Require`, with that reason, rather than fail.

## Setup, once

1. Enable Pickle and RimLogging.
2. Stage `PickleTools/QuietNewFactions` through the shared launcher.
3. The launcher enables Vanilla Expanded Framework, Nelim's Quiet New Factions, then this companion mod.

## Shared steps

```powershell
dotnet build PickleTools/VefFactionSteps/Source -c Release
powershell.exe -ExecutionPolicy Bypass -File PickleTools/VefFactionSteps/Check-Steps.ps1
```

`wsl-deps.pickletools.map` maps `nelim.pickletools.veffactions` to that local module for development.
The historical five-scenario pass used the former suite-owned DLL. The promoted shared assembly still
needs an in-game replay before it can inherit that runtime evidence.

## Run

- **In game**: dev mode on, debug actions menu, *Pickle*, tick the suite, *Run selected*.
- **Unattended through the repository launcher**:
  `powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod PickleTools/QuietNewFactions -DepMap wsl-deps.pickletools.map`.
  Reports land in the launcher's configured report directory.

Nothing here clicks through OS input: `I close all dialogs` closes windows directly.
