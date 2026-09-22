# Expansion steps - two Pickle steps (shared)

Two steps that ask `ModsConfig` whether an expansion, or any mod, is **active**, by package id:

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the expansion {string} is active` | passes when `ModsConfig.IsActive(<packageId>)` is true |
| `Nelim's Pickle Tools: the expansion {string} is not active` | passes when it is false |

Developer tooling. GitHub and Workshop release preparation in progress; no Defs, no features: a suite stages the companion mod in `Mod/` and writes
its own scenarios.

## Why it exists

A pass can leave a DLC out of the mod list (a `!ludeon.rimworld.odyssey` line in its pass map, see
`Headless/README.md`). Nothing in the staging says whether the game then **keeps** it out once a save is loaded.
Pickle's own `mod {string} is not loaded` reads the loaded mod list; these read `ModsConfig`, the list the game
itself keeps. A scenario that asserts both proves the two agree, which is what a DLC-off pass has to establish
before anything else it says is worth reading. The first pass that used them, Flavor Text Extended's
`sans-odyssey`, passed on 2026-09-21 with both.

## Using it from a suite

1. In the pass map (`<Mod>/Tests/Pickle/wsl-deps.<pass>.map`), leave the DLC out and stage the steps:

   ```
   !ludeon.rimworld.odyssey
   nelim.pickletools.expansions   path:PickleTools/ExpansionSteps/Mod
   ```

   Select it with `-DepMap <the map>`. The folder's own `About.xml` packageId must match the one written.
2. Write the scenario:

   ```gherkin
   Then Nelim's Pickle Tools: the expansion "Ludeon.RimWorld.Odyssey" is not active
   And mod "Ludeon.RimWorld.Odyssey" is not loaded
   And Nelim's Pickle Tools: the expansion "Ludeon.RimWorld.Ideology" is active
   ```

   The last line is worth having: it says the pass dropped only the DLC it meant to.

## Checking it

```
powershell.exe -ExecutionPolicy Bypass -File PickleTools/ExpansionSteps/Check-Steps.ps1
```

Compiles the two patterns with Pickle's own expression engine and checks that neither is ambiguous against any
other suite in the repository or against Pickle's vocabulary. No game, a few seconds.

## What has and has not been played

Both steps were played, in Flavor Text Extended's `sans-odyssey` pass (`Tests/Pickle/results/2026-09-21-sans-odyssey/`
in that repository), when they still lived in that suite's own assembly: 3 of 3 scenarios, `exitReason: passed`.
**As a shared mod they have not been played yet**: the code is the same two calls, the pattern check passes, and the
first run staged from here is the one that says so.

The build is `Source/`, net48, against `Krafs.Rimworld.Ref` and `RimWorks.Pickle.Ref`; the DLL is committed in
`Mod/Pickle/Assemblies/`, as for the other tools. `Mod/Languages/README.md` is the inert file that stops RimWorld
logging "did not load any content" for a mod that holds only an assembly Pickle loads.
