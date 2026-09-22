# Nelim's Quiet New Factions

Optional companion kept in PickleTools. Vanilla Expanded Framework opens a "new faction" window on every load for each
faction the save lacks; "skip" records nothing, only "ignore" is remembered. This mod answers
"ignore" for the player, except for factions their mod marks as required.

## How it works

One Harmony prefix on `VEF.Factions.Dialog_NewFactionSpawning.OpenDialog`. VEF calls it for the
first faction after a load, and the dialog's `PostClose` calls it again for each next one. The
prefix records the faction in `NewFactionSpawningState` — VEF's own world component, saved with
the game — and moves to the next, so no window opens. A faction whose
`FactionDefExtension.forcedFactionData.forcePlayerToAddFactionIfMissing` is set goes through to
the real dialog.

Read from VEF.dll (Workshop 2023507013, 1.6) on 2026-09-17: `LoadedGame` postfix
`OnGameLoaded`, `Dialog_NewFactionSpawning`, `NewFactionSpawningState`.

## Build

```bash
dotnet build Source -c Release
```

Compiles against the Workshop copy of `VEF.dll` (`VefDir` in the csproj), never shipped. Output
goes to `Mod/Assemblies/`. It is not part of the aggregate `nelim.pickletools` Workshop payload:
it requires VEF at load time and is staged only by suites that test this behavior.
