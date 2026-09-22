# Quiet New Factions

Promoted on 2026-09-22 from `QuietNewFactions/Tests/Pickle/Source/FactionSteps.cs` to
`PickleTools/VefFactionSteps/Source/FactionSteps.cs`. The suite now consumes the shared module and no
longer owns a source project or DLL. Existing runtime results belong to the removed suite-owned DLL;
the promoted assembly has only offline build and expression-check evidence.

The actual Quiet New Factions companion, its Harmony patch, test suite and historical evidence now live at
`PickleTools/QuietNewFactions/`. This note stays only as the record of the step extraction; it is not an
external owner of code anymore.

| Step family | What the source reads or changes | Reuse boundary |
|---|---|---|
| `the load has settled` | Waits for `LongEventHandler.AnyEventNowOrWaiting` to clear, then three frames | Generic waiting pattern; retain an explicit timeout and rename the unprefixed text |
| `a faction the world lacks is chosen` | Selects an absent, visible, non-player `FactionDef` that VEF may offer; removes it from VEF's ignored set | Tied to VEF's faction spawning rules and private `ignoredFactions` field |
| `the chosen faction is marked required by its mod` | Adds a `FactionDefExtension` with `forcePlayerToAddFactionIfMissing`; an AfterScenario hook removes that added extension | Fixture technique for another VEF integration; not a generic mod-presence assertion |
| `VEF runs its new faction check` | Resolves the nested LoadedGame patch and invokes `OnGameLoaded` | Private upstream type/method names must be checked when VEF changes |
| Window and ignored-state assertions | Reads `Dialog_NewFactionSpawning.factionDef` and `NewFactionSpawningState.Instance.IsIgnored` | Specific to this integration |
| `the game log says the chosen faction was ignored` | Searches the log for the mod's prefix and chosen defName | A scoped message check, not proof of a clean startup log |

The promoted texts use the `Nelim's Pickle Tools:` prefix. Their implementation and maintenance record now
live in `VefFactionSteps`; this note remains as the migration record for the suite inventory.
