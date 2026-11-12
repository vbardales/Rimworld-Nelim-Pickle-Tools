# Menu de debug de RimWorld : ce qu'on peut câbler en steps

Inventaire du menu de debug du jeu (Assembly-CSharp 1.6, relevé par réflexion le 2026-10-04), pour que les mods s'en inspirent quand ils écrivent leurs steps. **Pickle sait déjà lancer une action sans argument** (voir plus bas) ; PickleTools n'ajoute rien. Ce document dit quelles entrées existent, lesquelles demandent une cible, et ce qui reste à écrire pour elles.

Trois sections, comme les trois onglets du jeu : **Actions/outils** (412 entrées), **Réglages** (180 interrupteurs), **Production** (248 rapports).

## Comment le jeu appelle une entrée

Chaque entrée est une méthode statique marquée `[DebugAction(category, name, …)]` (ou `[DebugOutput]`, ou `[DebugActionYielder]` qui produit un sous-menu). Le champ `actionType` dit comment elle est lancée. À relire dans le code du jeu avant de s'y fier : ce document donne l'inventaire, pas le comportement exact de chaque méthode.

| actionType | Sorte | Signature | Ce que fait le menu |
|---|---|---|---|
| 0 `Action` | action | `()` | Appelle la méthode tout de suite. |
| 1 `ToolMap` | outil carte | `()` | Arme un outil : la méthode tourne au clic sur une cellule de la carte (position = `UI.MouseCell()`). |
| 2 `ToolMapForPawns` | outil pion | `(Pawn p)` | Arme un outil : la méthode tourne pour chaque pion sous le clic. |
| 3 `ToolWorld` | outil monde | `()` | Arme un outil du monde (à vérifier : quatorze entrées seulement, dont `SpawnPitBurrow` et `SpawnFleshmassHeart` qui ressemblent à des outils de carte). |

`allowedGameStates` (10 = en jeu sur une carte) dit quand l'entrée est offerte. `Needs` = extension requise. « plus » = rangée sous *Show more actions*.

### Les clés d'un step générique

**Pickle a déjà ce step** (relevé sur le dashboard de Pickle 6.4.1, 2026-10-04) : `I trigger debug action "<MéthodeDuJeu>"` et `I trigger debug action "<MéthodeDuJeu>" in category "<Catégorie>"`, ainsi que `dev mode is enabled`. Le nom attendu est celui de la **méthode** de la colonne « Méthode » ci-dessous (par exemple `FinishAllResearch`, catégorie `General`), pas l'étiquette affichée dans le menu : « Finish All Research » est refusé avec la suggestion « General/FinishAllResearch ». Joué sur la partie de Virginie (2026-10-04) : `FinishAllResearch` termine toute la recherche, donc débloque la moquette (`CarpetMaking`).

Ce que Pickle ne couvre pas : les entrées qui arment un **outil** (carte, pion, monde) et attendent un clic. Elles demandent une cellule ou un pion, donc un step dédié par outil. Les actions marquées *destructive* (`DestroyAllThings`…) devraient être refusées hors d'une fixture de test.

## 1. Actions et outils

### 

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Incidents Yielder | action | `DebugActionsIncidents.IncidentsYielder` |  |  |  |

### Anomaly

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Discover All Entities | action | `DebugToolsMisc.DiscoverAllEntities` |  | Anomaly |  |
| Emerge Metalhorrors | action | `DebugToolsMisc.EmergeMetalhorrors` |  | Anomaly |  |
| End revenant hypnosis | pawn tool | `DebugActionsMisc.EndRevenantHypnosis` | `Pawn p` | Anomaly |  |
| Generate CreepJoiner... | action | `DebugToolsSpawning.GenerateCreeperJoiner` |  | Anomaly |  |
| Max ghoul upgrades | pawn tool | `DebugToolsPawns.MaxGhoulUpgrades` | `Pawn p` | Anomaly |  |
| Raise corpse as shambler | map tool | `DebugToolsPawns.RaiseAsShambler` |  | Anomaly |  |
| Revert mutant | pawn tool | `DebugToolsPawns.RevertMutant` | `Pawn p` | Anomaly |  |
| Set Anomaly level... | action | `DebugActionsMisc.SetMonolithLevel` |  | Anomaly |  |
| Set mutant... | action | `DebugToolsPawns.SetMutant` |  |  |  |
| Spawn Fleshmass Heart | world tool | `DebugToolsMisc.SpawnFleshmassHeart` |  | Anomaly |  |
| Spawn Pit Burrow | world tool | `DebugToolsMisc.SpawnPitBurrow` |  | Anomaly |  |
| Spawn Pit Gate | world tool | `DebugToolsMisc.SpawnPitGate` |  | Anomaly |  |

### Autotests

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Battle Royale All PawnKinds | action | `DebugAutotests.BattleRoyaleAllPawnKinds` |  |  |  |
| Battle Royale By Damagetype | action | `DebugAutotests.BattleRoyaleByDamagetype` |  |  |  |
| Battle Royale Humanlikes | action | `DebugAutotests.BattleRoyaleHumanlikes` |  |  |  |
| Check Region Listers | action | `DebugAutotests.CheckRegionListers` |  |  |  |
| Generate Pawns Of All Shapes | map tool | `DebugAutotests.GeneratePawnsOfAllShapes` |  |  |  |
| Make colony (ancient junk) | action | `DebugAutotests.MakeColonyAncientJunk` |  |  |  |
| Make colony (animals) | action | `DebugAutotests.MakeColonyAnimals` |  |  |  |
| Make colony (full) | action | `DebugAutotests.MakeColonyFull` |  |  |  |
| Test force downed x100 | action | `DebugAutotests.TestForceDownedx100` |  |  |  |
| Test force kill x100 | action | `DebugAutotests.TestForceKillx100` |  |  |  |
| Test generate pawn x1000 | action | `DebugAutotests.TestGeneratePawnx1000` |  |  |  |
| Test time-to-down | action | `DebugAutotests.TestTimeToDown` |  |  |  |

### General

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| 10 damage | map tool | `DebugToolsGeneral.Take10Damage` |  |  |  |
| 300 damage | map tool | `DebugToolsGeneral.Take300Damage` |  |  |  |
| 5000 damage | map tool | `DebugToolsGeneral.Take5000Damage` |  |  |  |
| Adaption Progress10 Days | action | `DebugActionsMisc.AdaptionProgress10Days` |  |  |  |
| Add gas... | action | `DebugToolsGeneral.PushGas` |  |  |  |
| Add techprint to project | action | `DebugActionsMisc.AddTechprintsForProject` |  |  |  |
| Add Trade Ship Of Kind | action | `DebugActionsMisc.AddTradeShipOfKind` |  |  |  |
| Add Trait To Unique Weapon | map tool | `DebugToolsMisc.AddTraitToUniqueWeapon` |  | Odyssey |  |
| Apply techprint on project | action | `DebugActionsMisc.ApplyTechprintsForProject` |  |  |  |
| Atlas Rebuild | action | `DebugActionsMisc.AtlasRebuild` |  |  | plus |
| Attach Fire | map tool | `DebugToolsMisc.AttachFire` |  |  |  |
| Award 10 honor | action | `DebugActionsRoyalty.Award10RoyalFavor` |  | Royalty |  |
| Award 4 honor | action | `DebugActionsRoyalty.Award4RoyalFavor` |  | Royalty |  |
| Benchmark Performance | action | `DebugToolsMisc.BenchmarkPerformance` |  |  |  |
| Break down... | map tool | `DebugToolsGeneral.BreakDown` |  |  |  |
| Celestial debugger | action | `DebugActionsMisc.OpenCelestialDebugger` |  |  |  |
| Change camera config | action | `DebugToolsSpawning.ChangeCameraConfigWorld` |  |  |  |
| Change Camera Config | action | `DebugActionsMisc.ChangeCameraConfig` |  |  |  |
| Change Thing Style | map tool | `DebugToolsGeneral.ChangeThingStyle` |  |  |  |
| Change weather... | action | `DebugActionsMisc.ChangeWeather` |  |  |  |
| Check Reachability | map tool | `DebugToolsGeneral.CheckReachability` |  |  |  |
| Clear All Gas | action | `DebugToolsGeneral.ClearAllGas` |  |  |  |
| Clear area (rect) | action | `DebugToolsGeneral.ClearArea` |  |  |  |
| Clear Landmark | world tool | `DebugToolsMisc.ClearLandmark` |  | Odyssey |  |
| Compare Line Of Sight | pawn tool | `DebugToolsMisc.CompareLineOfSight` | `Pawn pawn` |  |  |
| Darklight At Position | map tool | `DebugActionsIdeo.DarklightAtPosition` |  |  |  |
| Destroy | map tool | `DebugToolsGeneral.Destroy` |  |  |  |
| Destroy All Corpses | action | `DebugActionsMisc.DestroyAllCorpses` |  |  | plus |
| Destroy All Hats | action | `DebugActionsMisc.DestroyAllHats` |  |  | plus |
| Destroy All Plants | action | `DebugActionsMisc.DestroyAllPlants` |  |  | plus |
| Destroy All Things | action | `DebugActionsMisc.DestroyAllThings` |  |  | plus |
| Destroy Clutter | action | `DebugActionsMisc.DestroyClutter` |  |  | plus |
| Destroy fire | action | `DebugToolsGeneral.DestroyAllFire` |  |  |  |
| Discard | map tool | `DebugToolsGeneral.Discard` |  |  |  |
| Draw Attach Points | map tool | `DebugToolsMisc.DrawAttachPoints` |  |  |  |
| Dump Pawn Atlases | action | `DebugActionsMisc.DumpPawnAtlases` |  |  | plus |
| Dump Static Atlases | action | `DebugActionsMisc.DumpStaticAtlases` |  |  | plus |
| Edit Animation... | action | `DebugActionsMisc.EditAnimation` |  |  |  |
| Edit effecter... | action | `DebugActionsMisc.EditEffecter` |  |  |  |
| Edit roof (rect) | action | `DebugToolsGeneral.MakeRoof` |  |  |  |
| Enable wound debug draw | map tool | `DebugToolsMisc.WoundDebug` |  |  | plus |
| End game condition... | action | `DebugActionsMisc.EndGameCondition` |  |  |  |
| Explosion... | action | `DebugToolsGeneral.Explosion` |  |  |  |
| Fill All Gas | action | `DebugToolsGeneral.FillAllGas` |  |  |  |
| Finish All Research | action | `DebugActionsMisc.FinishAllResearch` |  |  |  |
| Flash Blocked Landing Cells | action | `DebugActionsMisc.FlashBlockedLandingCells` |  |  | plus |
| Flash Closewalk Cell30 | map tool | `DebugToolsGeneral.FlashClosewalkCell30` |  |  | plus |
| Flash Direct Flee Dest | map tool | `DebugToolsGeneral.FlashDirectFleeDest` |  |  | plus |
| Flash Shuttle Drop Cells Near | map tool | `DebugToolsGeneral.FlashShuttleDropCellsNear` |  |  | plus |
| Flash Skygaze Cell | map tool | `DebugToolsGeneral.FlashSkygazeCell` |  |  | plus |
| Flash Spectators Cells | map tool | `DebugToolsGeneral.FlashSpectatorsCells` |  |  | plus |
| Flash Trade Drop Spot | action | `DebugActionsMisc.FlashTradeDropSpot` |  |  | plus |
| Flash TryFindRandomPawnExitCell | pawn tool | `DebugToolsGeneral.FlashTryFindRandomPawnExitCell` | `Pawn p` |  | plus |
| Flash Walk Path | map tool | `DebugToolsGeneral.FlashWalkPath` |  |  | plus |
| Fog (rect) | action | `DebugToolsGeneral.FogRect` |  |  |  |
| Force Enemy Assault | action | `DebugActionsMisc.ForceEnemyAssault` |  |  |  |
| Force Enemy Flee | action | `DebugActionsMisc.ForceEnemyFlee` |  |  |  |
| Force Ship Countdown | action | `DebugActionsMisc.ForceShipCountdown` |  |  | plus |
| Force sleep | map tool | `DebugToolsGeneral.ForceSleep` |  |  |  |
| Force Start Ship | action | `DebugActionsMisc.ForceStartShip` |  |  | plus |
| Glow At Position | map tool | `DebugActionsMisc.GlowAtPosition` |  |  |  |
| Grow plant 1 day | map tool | `DebugToolsGeneral.Grow1Day` |  |  |  |
| Grow plant to maturity | map tool | `DebugToolsGeneral.GrowPlantToMaturity` |  |  |  |
| Hot reload Defs | action | `DebugActionsMisc.HotReloadDefs` |  |  |  |
| HSV At Position | map tool | `DebugActionsMisc.HSVAtPosition` |  |  |  |
| Increment time | action | `DebugActionsMisc.IncrementTime` |  |  |  |
| Kill | map tool | `DebugToolsGeneral.Kill` |  |  |  |
| Kill Faction Leader | action | `DebugActionsMisc.KillFactionLeader` |  |  |  |
| Kill Kidnapped Pawn | action | `DebugActionsMisc.KillKidnappedPawn` |  |  |  |
| Kill Random Lent Colonist | action | `DebugActionsMisc.KillRandomLentColonist` |  |  | plus |
| Kill World Pawn | action | `DebugActionsMisc.KillWorldPawn` |  |  |  |
| Layer pathfinder... | action | `DebugActionsMisc.LayerPathfinder` |  |  |  |
| Lightning Strike | map tool | `DebugToolsGeneral.LightningStrike` |  |  |  |
| Lightning Strike Delayed | map tool | `DebugToolsGeneral.LightningStrikeDelayed` |  |  |  |
| Make empty room (rect) | action | `DebugToolsGeneral.MakeEmptyRoom` |  |  |  |
| Make plant leafless | map tool | `DebugToolsGeneral.MakePlantLeafless` |  |  |  |
| Map noise visualizer | action | `DebugActionsMisc.OpenMapNoiseDebugger` |  |  |  |
| Measure Draw Size | action | `DebugToolsMisc.MeasureDrawSize` |  |  |  |
| Measure World Distance | action | `DebugToolsMisc.MeasureWorldDistance` |  |  |  |
| Name settlement... | action | `DebugActionsMisc.NameSettlement` |  |  | plus |
| Next Lesson | action | `DebugActionsMisc.NextLesson` |  |  | plus |
| Nuzzle Pawn | pawn tool | `DebugToolsTrailer.NuzzlePawn` | `Pawn animal` | Odyssey |  |
| Pawn Kind Ability Check | action | `DebugActionsMisc.PawnKindAbilityCheck` |  |  | plus |
| Pawn Kind Apparel Check | action | `DebugActionsMisc.PawnKindApparelCheck` |  |  | plus |
| Pick Copy | map tool | `DebugToolsGeneral.PickCopy` |  |  |  |
| Pollution -25% | world tool | `DebugToolsMisc.DecreasePollutionLarge` |  | Biotech |  |
| Pollution +1% | world tool | `DebugToolsMisc.IncreasePollutionSmall` |  | Biotech |  |
| Pollution +25% | world tool | `DebugToolsMisc.IncreasePollutionLarge` |  | Biotech |  |
| Push heat... | action | `DebugToolsGeneral.PushHeat` |  |  |  |
| Random Spot Near Thing Avoiding Hostiles | map tool | `DebugToolsGeneral.RandomSpotNearThingAvoidingHostiles` |  |  | plus |
| RandomSpotJustOutsideColony | pawn tool | `DebugToolsGeneral.RandomSpotJustOutsideColony` | `Pawn p` |  | plus |
| Reduce royal title | action | `DebugActionsRoyalty.ReduceRoyalTitle` |  | Royalty |  |
| Regenerate Map Features | action | `DebugActionsMisc.RegenerateMapFeatures` |  | Odyssey |  |
| Remove 4 honor | action | `DebugActionsRoyalty.Remove4RoyalFavor` |  | Royalty |  |
| Remove Trait From Unique Weapon | map tool | `DebugToolsMisc.RemoveTraitFromUniqueWeapon` |  | Odyssey |  |
| Replace All Trade Ships | action | `DebugActionsMisc.ReplaceAllTradeShips` |  |  |  |
| Reset Bossgroup Cooldown | action | `DebugToolsMisc.ResetBossgroupCooldown` |  | Biotech |  |
| Reset Bossgroup Killed Pawns | action | `DebugToolsMisc.ResetBossgroupKilledPawns` |  | Biotech |  |
| Retroactively Add Landmarks To World | action | `DebugActionsMisc.RetroactivelyAddLandmarksToWorld` |  | Odyssey |  |
| Reveal Hidden Defs | action | `DebugActionsMisc.RevealHiddenDefs` |  |  |  |
| Rot 1 day | map tool | `DebugToolsGeneral.Rot1Day` |  |  |  |
| Rotate | action | `DebugToolsGeneral.Rotate` |  |  |  |
| Set biome | action | `DebugToolsMisc.SetBiome` |  |  |  |
| Set Color | map tool | `DebugToolsGeneral.SetColor` |  |  |  |
| Set Faction | map tool | `DebugToolsGeneral.SetFaction` |  |  |  |
| Set Faction Rect | action | `DebugToolsGeneral.SetFactionRect` |  |  |  |
| Set Faction Relations | action | `DebugActionsMisc.SetFactionRelations` |  |  |  |
| Set landmark | action | `DebugToolsMisc.SetLandmark` |  | Odyssey |  |
| Set Quality | map tool | `DebugToolsMisc.SetQuality` |  |  |  |
| Set royal title | action | `DebugActionsRoyalty.SetTitleForced` |  | Royalty |  |
| Set Stuff | map tool | `DebugToolsMisc.SetStuff` |  |  |  |
| Simulate Sanguophage Meeting | action | `DebugActionsMisc.SimulateSanguophageMeeting` |  | Biotech |  |
| Storywatcher tick 1 day | action | `DebugActionsMisc.StorywatcherTick1Day` |  |  | plus |
| Swim At | pawn tool | `DebugToolsTrailer.SwimAt` | `Pawn pawn` | Odyssey |  |
| Teleport | map tool | `DebugToolsGeneral.Teleport` |  |  |  |
| Test Flood Unfog | map tool | `DebugToolsGeneral.TestFloodUnfog` |  |  | plus |
| Unfog (rect) | action | `DebugToolsGeneral.UnfogRect` |  |  |  |
| Unload Unused Assets | action | `DebugActionsMisc.UnloadUnusedAssets` |  |  | plus |
| Visitor Gift | action | `DebugActionsMisc.VisitorGift` |  |  |  |
| Volcanic Debris | map tool | `DebugToolsTrailer.VolcanicDebris` |  | Odyssey |  |
| Volcanic Debris Delayed | map tool | `DebugToolsTrailer.VolcanicDebrisDelayed` |  | Odyssey |  |
| World noise visualizer | action | `DebugActionsMisc.OpenWorldNoiseDebugger` |  |  |  |
| Wound debug export (non-humanlike) | action | `DebugToolsMisc.WoundDebugExport` |  |  | plus |

### Generation

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Create Prefab | action | `DebugActionsPrefabs.CreatePrefab` |  |  |  |
| Rotate Prefab Spawn | action | `DebugActionsPrefabs.RotatePrefabSpawn` |  |  |  |
| Spawn Player Prefab | action | `DebugActionsPrefabs.SpawnPlayerPrefab` |  |  |  |
| Spawn Prefab | action | `DebugActionsPrefabs.SpawnPrefab` |  |  |  |
| Spawn Prefab Blueprint | action | `DebugActionsPrefabs.SpawnPrefabBlueprint` |  |  |  |

### Ideoligion

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Add 5 days to obligation timer | action | `DebugActionsIdeo.Add5DaysToObligationTimer` |  | Ideology |  |
| Add Development Point | action | `DebugActionsIdeo.AddDevelopmentPoint` |  | Ideology |  |
| Add Precept | action | `DebugActionsIdeo.AddPrecept` |  | Ideology |  |
| Certainty - 20% | pawn tool | `DebugActionsIdeo.OffsetCertaintyNegative20` | `Pawn p` | Ideology |  |
| Clear Development Points | action | `DebugActionsIdeo.ClearDevelopmentPoints` |  | Ideology |  |
| Generate 200 ritual names | action | `DebugActionsIdeo.Generate200RitualNames` |  | Ideology | plus |
| Max Development Points | action | `DebugActionsIdeo.MaxDevelopmentPoints` |  | Ideology |  |
| Remove Precept | action | `DebugActionsIdeo.RemovePrecept` |  | Ideology |  |
| Remove ritual obligation | action | `DebugActionsIdeo.RemoveRitualObligation` |  | Ideology |  |
| Set ideo role... | pawn tool | `DebugActionsIdeo.SetIdeoRole` | `Pawn p` | Ideology |  |
| Set Source Precept | map tool | `DebugActionsIdeo.SetSourcePrecept` |  | Ideology |  |
| Spawn Relic | map tool | `DebugActionsIdeo.SpawnRelic` |  | Ideology |  |
| Trigger Date Ritual | action | `DebugActionsIdeo.TriggerDateRitual` |  | Ideology |  |

### Incidents

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Do trade caravan arrival... | action | `DebugActionsIncidents.DoTradeCaravanSpecific` |  |  |  |
| Drop pod raid at location... | action | `DebugActionsIncidents.ExecuteDropPodRaidAtLocation` |  |  |  |
| Execute raid with faction... | action | `DebugActionsIncidents.ExecuteRaidWithFaction` |  |  |  |
| Execute raid with points... | action | `DebugActionsIncidents.ExecuteRaidWithPoints` |  |  |  |
| Execute raid with specifics... | action | `DebugActionsIncidents.ExecuteRaidWithSpecifics` |  |  |  |
| Psychic ritual siege... | action | `DebugActionsIncidents.RitualSiegeWithSpecifics` |  | Anomaly |  |
| Recalculate threat points | action | `DebugActionsIncidents.RecalculateThreatPoints` |  |  |  |

### Insect

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Spawn cocoon infestation | action | `DebugToolsMisc.SpawnCocoonInfestationWithPoints` |  | Biotech | plus |

### Lighting

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Log lights affecting cell | map tool | `DebugActionsMapManagement.LogLightsAffectinCell` |  |  |  |
| Regen glow grid cells (rect) | action | `DebugActionsMapManagement.RegenGlowGridCells` |  |  |  |

### Map

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Add Game Condition | action | `DebugActionsMapManagement.AddGameCondition` |  |  |  |
| Add Mutator To Current Map Tile | action | `DebugActionsMapManagement.AddMutatorToCurrentMapTile` |  |  |  |
| Add Sand | map tool | `DebugActionsMapManagement.AddSand` |  |  |  |
| Add Snow | map tool | `DebugActionsMapManagement.AddSnow` |  |  |  |
| BaseGen | action | `DebugActionsMapManagement.BaseGen` |  |  |  |
| Change Map | action | `DebugActionsMapManagement.ChangeMap` |  |  |  |
| Clear All Fog | action | `DebugToolsGeneral.ClearAllFog` |  |  |  |
| Clear All Sand | map tool | `DebugActionsMapManagement.ClearAllSand` |  | Odyssey |  |
| Clear All Snow | map tool | `DebugActionsMapManagement.ClearAllSnow` |  |  |  |
| Clear temp terrain (rect) | action | `DebugActionsMapManagement.ClearTempTerrainRect` |  |  |  |
| Destroy Map | action | `DebugActionsMapManagement.DestroyMap` |  |  |  |
| Do Next Gen Step | action | `DebugActionsMapManagement.DoNextGenStep` |  |  |  |
| Fill Map With Trees | action | `DebugActionsMapManagement.FillMapWithTrees` |  |  | plus |
| Force Reform In Current Map | action | `DebugActionsMapManagement.ForceReformInCurrentMap` |  |  |  |
| Generate Landmark Screenshots | action | `DebugActionsMapManagement.GenerateLandmarkScreenshots` |  |  |  |
| Generate Map | action | `DebugActionsMapManagement.GenerateMap` |  |  | plus |
| Generate Map With Caves | action | `DebugActionsMapManagement.GenerateMapWithCaves` |  |  |  |
| Generate Pocket Map | action | `DebugActionsMapManagement.GeneratePocketMap` |  |  |  |
| Grow pollution (x10 cell) | map tool | `DebugActionsMapManagement.PolluteCellTen` |  | Biotech |  |
| Grow pollution (x100 cell) | map tool | `DebugActionsMapManagement.PolluteCellHundred` |  | Biotech |  |
| Grow pollution (x1000 cell) | map tool | `DebugActionsMapManagement.PolluteCellThousand` |  | Biotech |  |
| Leak Map | action | `DebugActionsMapManagement.LeakMap` |  |  | plus |
| Log Map Pollution | action | `DebugActionsMapManagement.LogMapPollution` |  | Biotech |  |
| Make rock (rect) | action | `DebugActionsMapManagement.MakeRock` |  |  |  |
| Pollute (rect) | action | `DebugActionsMapManagement.PolluteRect` |  | Biotech |  |
| Print Leaked Map | action | `DebugActionsMapManagement.PrintLeakedMap` |  |  | plus |
| Refog Map | action | `DebugActionsMapManagement.RefogMap` |  |  |  |
| Regen All Map Mesh Sections | action | `DebugActionsMapManagement.RegenAllMapMeshSections` |  |  |  |
| Regen Section | map tool | `DebugActionsMapManagement.RegenSection` |  |  |  |
| Regenerate Current Map | action | `DebugActionsMapManagement.RegenerateCurrentMap` |  |  |  |
| Regenerate Current Map Stepped | action | `DebugActionsMapManagement.RegenerateCurrentMapStepped` |  |  |  |
| Regenerate Map With Landmark | action | `DebugActionsMapManagement.RegenerateMapWithLandmark` |  |  |  |
| Remove Game Condition | action | `DebugActionsMapManagement.RemoveGameCondition` |  |  |  |
| Remove Mutator From Current Map Tile | action | `DebugActionsMapManagement.RemoveMutatorFromCurrentMapTile` |  |  |  |
| Remove Sand | map tool | `DebugActionsMapManagement.RemoveSand` |  |  |  |
| Remove Snow | map tool | `DebugActionsMapManagement.RemoveSnow` |  |  |  |
| Run Map Generator | action | `DebugActionsMapManagement.RunMapGenerator` |  |  |  |
| Set temp terrain (rect) | action | `DebugActionsMapManagement.SetTempTerrainRect` |  |  |  |
| Set terrain (rect) | action | `DebugActionsMapManagement.SetTerrainRect` |  |  |  |
| SketchGen | action | `DebugActionsMapManagement.SketchGen` |  |  |  |
| Spawn Complex | action | `DebugActionsIdeo.SpawnComplex` |  |  |  |
| Transfer | map tool | `DebugActionsMapManagement.Transfer` |  |  |  |
| Unpollute (rect) | action | `DebugActionsMapManagement.UnpolluteRect` |  | Biotech |  |
| Use Gen Step | action | `DebugActionsMapManagement.UseGenStep` |  |  |  |
| Use Scatterer | map tool | `DebugActionsMapManagement.UseScatterer` |  |  |  |

### Mechanoid

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Disable Mechs | action | `DebugToolsMisc.DisableMechs` |  | Odyssey |  |

### Mods

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Loaded Files For Mod | action | `DebugActionsMods.LoadedFilesForMod` |  |  |  |

### Other

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Add Test Planet Layer | action | `DebugActionsMisc.AddTestPlanetLayer` |  | Odyssey | plus |
| Clear cached materials | action | `DebugActionsMisc.ClearCachedMaterials` |  |  | plus |
| Garbage Collect World Pawn | action | `DebugToolsPawns.GarbageCollectWorldPawn` |  |  | plus |
| Log Planet Layer Connections | action | `DebugActionsMisc.LogPlanetLayerConnections` |  |  | plus |
| Remove Test Planet Layer | action | `DebugActionsMisc.RemoveTestPlanetLayer` |  | Odyssey | plus |

### Pathing

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Breach | action | `DebugActionsMisc.Breach` |  |  |  |
| Goto | pawn tool | `DebugActionsMisc.Goto` | `Pawn pawn` |  |  |
| Log Cell Grid Result | map tool | `DebugActionsMisc.LogCellGridResult` |  |  |  |
| Log Cell Map Data | map tool | `DebugActionsMisc.LogCellMapData` |  |  |  |
| Log Pathfinder State | action | `DebugActionsMisc.LogPathfinderState` |  |  |  |
| Toggle Path Debugging | pawn tool | `DebugToolsPawns.TogglePathDebugging` | `Pawn p` |  |  |

### Pawns

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| 10 damage until dead | map tool | `DebugToolsPawns.Do10DamageUntilDead` |  |  | plus |
| Activate HediffGiver | pawn tool | `DebugToolsPawns.ActivateHediffGiver` | `Pawn p` |  |  |
| Activate HediffGiver World Pawn | action | `DebugToolsPawns.ActivateHediffGiverWorldPawn` |  |  | plus |
| Add Gene | action | `DebugToolsPawns.AddGene` |  | Biotech |  |
| Add Guest | action | `DebugToolsPawns.AddGuest` |  |  |  |
| Add Hediff | action | `DebugTools_Health.AddHediff` |  |  |  |
| Add Infection Pathway | action | `DebugToolsPawns.AddInfectionPathway` |  |  |  |
| Add Learning Desire | pawn tool | `DebugToolsPawns.AddLearningDesire` |  | Biotech |  |
| Add Opinion Talks About | pawn tool | `DebugToolsPawns.AddOpinionTalksAbout` | `Pawn p` |  |  |
| Add Prisoner | action | `DebugToolsPawns.AddPrisoner` |  |  |  |
| Add Slave | action | `DebugToolsPawns.AddSlave` |  | Ideology |  |
| Add/remove pawn relation | pawn tool | `DebugToolsPawns.AddRemovePawnRelation` | `Pawn p` |  |  |
| Apply damage | action | `DebugToolsPawns.ApplyDamage` |  |  |  |
| Carried Damage To Death | pawn tool | `DebugToolsPawns.CarriedDamageToDeath` | `Pawn p` |  | plus |
| Change style | pawn tool | `DebugActionsIdeo.ChangeStyle` | `Pawn p` |  |  |
| CheckForJobOverride | pawn tool | `DebugToolsPawns.CheckForJobOverride` | `Pawn p` |  |  |
| Clear Bound Unfinished Things | map tool | `DebugToolsPawns.ClearBoundUnfinishedThings` |  |  | plus |
| Clear Prisoner Interaction Schedule | pawn tool | `DebugActionsMisc.ClearPrisonerInteractionSchedule` | `Pawn p` |  |  |
| Clear suppression schedule | pawn tool | `DebugActionsIdeo.ResetSuppresionSchedule` | `Pawn p` | Ideology | plus |
| Convert To Ideo | action | `DebugActionsIdeo.ConvertToIdeo` |  | Ideology | plus |
| Create baby from parents | action | `DebugToolsPawns.CreateBabyFromParents` |  | Biotech |  |
| Damage Held Pawn To Death | map tool | `DebugToolsPawns.DamageHeldPawnToDeath` |  |  | plus |
| Damage Legs | pawn tool | `DebugToolsPawns.DamageLegs` | `Pawn p` |  | plus |
| Damage To Death | pawn tool | `DebugToolsPawns.DamageToDeath` | `Pawn p` |  |  |
| Damage Until Down | pawn tool | `DebugToolsPawns.DamageUntilDown` | `Pawn p` |  |  |
| Damage Until Incapable Of Manipulation | pawn tool | `DebugToolsPawns.DamageUntilIncapableOfManipulation` | `Pawn p` |  | plus |
| Destroy factionless animals | action | `DebugToolsPawns.DestroyAnimals` |  |  |  |
| Destroy non-colonists | action | `DebugToolsPawns.DestroyAllNonColonists` |  |  |  |
| Destroy player animals | action | `DebugToolsPawns.DestroyPlayerAnimals` |  |  |  |
| Discover Hediffs | pawn tool | `DebugToolsPawns.DiscoverHediffs` | `Pawn p` |  | plus |
| Display Interactions Info | pawn tool | `DebugToolsPawns.DisplayInteractionsInfo` | `Pawn pawn` |  | plus |
| Display Relations Info | pawn tool | `DebugToolsPawns.DisplayRelationsInfo` | `Pawn pawn` |  | plus |
| Do Voice Call | pawn tool | `DebugToolsPawns.DoVoiceCall` | `Pawn p` |  | plus |
| Draw breach path... | action | `BreachingGridDebug.DebugDrawBreachPath` |  |  | plus |
| EndCurrentJob(InterruptForced) | pawn tool | `DebugToolsPawns.EndCurrentJobInterruptForced` | `Pawn p` |  |  |
| Enslave | pawn tool | `DebugToolsPawns.Enslave` | `Pawn p` | Ideology |  |
| Equip primary (selected)... | action | `DebugToolsPawns.EquipPrimary_ToSelected` |  |  |  |
| Face cell (selected)... | map tool | `DebugToolsPawns.Selected_SetFacing` |  |  |  |
| Force age reversal demand now | pawn tool | `DebugToolsPawns.ForceAgeReversalDemandNow` | `Pawn p` | Ideology | plus |
| Force Birthday | pawn tool | `DebugToolsPawns.ForceBirthday` | `Pawn p` |  |  |
| Force Interaction | pawn tool | `DebugToolsPawns.ForceInteraction` | `Pawn p` |  |  |
| Force vomit | pawn tool | `DebugToolsPawns.ForceVomit` | `Pawn p` |  | plus |
| Give Ability | action | `DebugToolsPawns.GiveAbility` |  |  |  |
| Give bad thought | pawn tool | `DebugToolsPawns.GiveBadThought` | `Pawn p` |  | plus |
| Give Birth | pawn tool | `DebugToolsPawns.GiveBirth` | `Pawn p` |  |  |
| Give good thought | pawn tool | `DebugToolsPawns.GiveGoodThought` | `Pawn p` |  | plus |
| Give Psylink | action | `DebugToolsPawns.GivePsylink` |  | Royalty |  |
| Give Trait | action | `DebugToolsPawns.GiveTrait` |  |  |  |
| Grant Immunities | pawn tool | `DebugToolsPawns.GrantImmunities` | `Pawn p` |  |  |
| Grow Pawn To Maturity | map tool | `DebugToolsPawns.GrowPawnToMaturity` |  |  |  |
| Heal random injury (10) | pawn tool | `DebugToolsPawns.HealRandomInjury10` | `Pawn p` |  |  |
| Infection pathway debugger | action | `DebugToolsPawns.OpenInfectionPathwayDebugger` |  |  |  |
| Inspiration | action | `DebugToolsPawns.Inspiration` |  |  |  |
| Kidnap colonist | pawn tool | `DebugToolsPawns.Kidnap` | `Pawn p` |  |  |
| List Melee Verbs | pawn tool | `DebugToolsPawns.ListMeleeVerbs` | `Pawn p` |  | plus |
| Lock Rotation | action | `DebugActionsMisc.LockRotation` |  |  |  |
| Log Job Details | pawn tool | `DebugToolsPawns.LogJobDetails` | `Pawn p` |  |  |
| Make +1 day older | pawn tool | `DebugToolsPawns.Make1DayOlder` | `Pawn p` |  |  |
| Make +1 year older | pawn tool | `DebugToolsPawns.Make1YearOlder` | `Pawn p` |  |  |
| Make Faction Leader | pawn tool | `DebugActionsMisc.MakeFactionLeader` | `Pawn p` |  |  |
| Make guilty | pawn tool | `DebugToolsPawns.MakeGuilty` | `Pawn p` |  |  |
| Make injuries permanent | pawn tool | `DebugToolsPawns.MakeInjuryPermanent` | `Pawn p` |  |  |
| Max All Passions | pawn tool | `DebugToolsPawns.MaxAllPassions` | `Pawn p` |  |  |
| Max All Skills | pawn tool | `DebugToolsPawns.MaxAllSkills` | `Pawn p` |  |  |
| Max Passion | action | `DebugToolsPawns.MaxPassion` |  |  |  |
| Max Skill | action | `DebugToolsPawns.MaxSkill` |  |  |  |
| Melee Attack Target | pawn tool | `DebugToolsTrailer.MeleeAttackTarget` | `Pawn p` |  |  |
| Mental break | action | `DebugToolsPawns.MentalBreak` |  |  |  |
| Mental state... | action | `DebugToolsPawns.MentalState` |  |  |  |
| Pass To World | pawn tool | `DebugToolsPawns.PassToWorld` | `Pawn p` |  |  |
| Play Animation... | action | `DebugToolsPawns.PlayAnimation` |  |  |  |
| Progress life stage | pawn tool | `DebugToolsPawns.ProgressLifeStage` | `Pawn p` |  |  |
| Queue Training Decay | pawn tool | `DebugToolsPawns.QueueTrainingDecay` | `Pawn p` |  | plus |
| Recruit | pawn tool | `DebugToolsPawns.Recruit` | `Pawn p` |  |  |
| Remove all traits | pawn tool | `DebugToolsPawns.RemoveAllTraits` | `Pawn p` |  |  |
| Remove Gene | pawn tool | `DebugToolsPawns.RemoveGene` | `Pawn p` | Biotech |  |
| Request style change | pawn tool | `DebugActionsIdeo.RequestStyleChange` | `Pawn p` | Ideology | plus |
| Reset age reversal demand | pawn tool | `DebugToolsPawns.ResetAgeReversalDemandNow` | `Pawn p` | Ideology | plus |
| Reset pawn render cache | pawn tool | `DebugToolsPawns.ResetRenderCache` | `Pawn p` |  | plus |
| Resistance -1 | pawn tool | `DebugToolsPawns.ResistanceMinus1` | `Pawn p` |  |  |
| Resistance -10 | pawn tool | `DebugToolsPawns.ResistanceMinus10` | `Pawn p` |  |  |
| Restore Body Part | pawn tool | `DebugToolsPawns.RestoreBodyPart` | `Pawn p` |  |  |
| Resurrect | map tool | `DebugToolsPawns.Resurrect` |  |  |  |
| Set Backstory | action | `DebugToolsPawns.SetBackstory` |  |  |  |
| Set Body Type | pawn tool | `DebugToolsPawns.SetBodyType` | `Pawn p` |  |  |
| Set enemy target for (selected) | pawn tool | `DebugToolsPawns.Selected_SetTarget` | `Pawn p` |  |  |
| Set Graphics Dirty | pawn tool | `DebugActionsMisc.SetGraphicsDirty` | `Pawn p` |  |  |
| Set Head Type | pawn tool | `DebugToolsPawns.SetHeadType` | `Pawn p` |  |  |
| Set Ideo | action | `DebugActionsIdeo.SetIdeo` |  | Ideology |  |
| Set Passion | action | `DebugToolsPawns.SetPassion` |  |  |  |
| Set Skill | action | `DebugToolsPawns.SetSkill` |  |  |  |
| Set Xenotype | action | `DebugToolsPawns.SetXenotype` |  | Biotech |  |
| Start Gathering | action | `DebugToolsPawns.StartGathering` |  |  |  |
| Start Marriage Ceremony | pawn tool | `DebugToolsPawns.StartMarriageCeremony` | `Pawn p` |  | plus |
| Start Prison Break | pawn tool | `DebugToolsPawns.StartPrisonBreak` | `Pawn p` |  |  |
| Start slave rebellion (aggressive) | pawn tool | `DebugActionsIdeo.StartSlaveRebellionAggressive` | `Pawn p` | Ideology |  |
| Start slave rebellion (random) | pawn tool | `DebugActionsIdeo.StartSlaveRebellion` | `Pawn p` | Ideology |  |
| Stop mental state | pawn tool | `DebugToolsPawns.StopMentalState` | `Pawn p` |  |  |
| Suppression -10% | pawn tool | `DebugActionsIdeo.SuppressionMinus10` | `Pawn p` | Ideology |  |
| Suppression +10% | pawn tool | `DebugActionsIdeo.SuppressionPlus10` | `Pawn p` | Ideology |  |
| Tame Animal | pawn tool | `DebugToolsPawns.TameAnimal` | `Pawn p` |  |  |
| Tend Bleeding Hediffs | pawn tool | `DebugTools_Health.TendBleedingHediffs` | `Pawn pawn` |  |  |
| Toggle immunity | pawn tool | `DebugToolsPawns.ToggleImmunity` | `Pawn p` |  |  |
| Toggle Job Logging | pawn tool | `DebugToolsPawns.ToggleJobLogging` | `Pawn p` |  |  |
| Toggle Max Move Speed | pawn tool | `DebugActionsMisc.ToggleMaxMoveSpeed` | `Pawn p` |  |  |
| Toggle Movement | pawn tool | `DebugActionsMisc.ToggleMovement` | `Pawn p` |  |  |
| Toggle Recruitable | pawn tool | `DebugToolsPawns.ToggleRecruitable` | `Pawn p` |  |  |
| Toggle Stance Logging | pawn tool | `DebugToolsPawns.ToggleStanceLogging` | `Pawn p` |  | plus |
| Train Animal | pawn tool | `DebugToolsPawns.TrainAnimal` | `Pawn p` |  |  |
| Try Develop Bound Relation | pawn tool | `DebugToolsPawns.TryDevelopBoundRelation` | `Pawn p` |  |  |
| Try Job Giver | pawn tool | `DebugToolsPawns.TryJobGiver` | `Pawn p` |  |  |
| Try Joy Giver | pawn tool | `DebugToolsPawns.TryJoyGiver` | `Pawn p` |  |  |
| Try Learning Giver | pawn tool | `DebugToolsPawns.TryLearningGiver` | `Pawn p` | Biotech |  |
| Try make animal fish for food | pawn tool | `DebugToolsPawns.TryFishForFood` | `Pawn p` |  |  |
| Unlock All Apparel | pawn tool | `DebugToolsPawns.UnlockAllApparel` | `Pawn p` |  |  |
| Unlock Rotation | pawn tool | `DebugActionsMisc.UnlockRotation` | `Pawn p` |  |  |
| View render tree | pawn tool | `DebugActionsIdeo.ViewRenderTree` | `Pawn p` |  |  |
| Wear apparel (selected) | action | `DebugToolsPawns.WearApparel_ToSelected` |  |  |  |
| Will -1 | pawn tool | `DebugActionsIdeo.WillMinus1` | `Pawn p` |  |  |
| Will +1 | pawn tool | `DebugActionsIdeo.WillPlus1` | `Pawn p` |  |  |

### Quests

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Generate quest | action | `DebugActionsQuests.GenerateQuest` |  |  |  |
| Generate quests (1x for each points) | action | `DebugActionsQuests.GenerateQuestsSamples` |  |  |  |
| Generate quests x# | action | `DebugActionsQuests.GenerateQuests` |  |  |  |
| Log generated quest savedata | action | `DebugActionsQuests.QuestExample` |  |  |  |
| QuestPart test | action | `DebugActionsQuests.TestQuestPart` |  |  |  |

### Sound

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Music debugger | action | `DebugActionsMisc.OpenMusicDebugger` |  |  |  |
| Play song... | action | `DebugActionsMisc.PlaySong` |  |  |  |
| Play sound... | action | `DebugActionsMisc.PlaySound` |  |  |  |
| Test music fadeout and silence | action | `DebugActionsMisc.TestFadeoutAndSilence` |  |  |  |
| Trigger transition... | action | `DebugActionsMisc.TriggerTransition` |  |  |  |

### Spawning

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Abandon Thing | world tool | `DebugToolsSpawning.AbandonThing` |  |  |  |
| Create Colonist Duplicate | action | `DebugToolsSpawning.CreateColonistDuplicate` |  | Anomaly |  |
| Destroy Site | world tool | `DebugToolsSpawning.DestroySite` |  |  |  |
| Duplicate | map tool | `DebugToolsSpawning.Duplicate` |  | Anomaly |  |
| Make filth x100 | map tool | `DebugToolsSpawning.MakeFilthx100` |  |  | plus |
| Remove world pawn... | action | `DebugToolsPawns.RemoveWorldPawn` |  |  |  |
| Spawn Animal Group | action | `DebugToolsSpawning.SpawnAnimalGroup` |  |  |  |
| Spawn apparel | action | `DebugToolsSpawning.SpawnApparel` |  |  |  |
| Spawn Bossgroup | action | `DebugToolsSpawning.SpawnBossgroup` |  | Biotech |  |
| Spawn Child | action | `DebugToolsSpawning.SpawnChild` |  | Biotech |  |
| Spawn Faction Leader | map tool | `DebugToolsSpawning.SpawnFactionLeader` |  |  |  |
| Spawn fill area (rect) | action | `DebugToolsGeneral.SpawnFillArea` |  |  |  |
| Spawn Filth | action | `DebugToolsSpawning.SpawnFilth` |  |  |  |
| Spawn Flare | action | `DebugToolsSpawning.SpawnFlare` |  | Anomaly |  |
| Spawn full thing stack | action | `DebugToolsSpawning.TryPlaceNearFullStack` |  |  |  |
| Spawn meal with specifics... | action | `DebugToolsSpawning.CreateMealWithSpecifics` |  |  |  |
| Spawn Mech Cluster | action | `DebugToolsSpawning.SpawnMechCluster` |  | Royalty |  |
| Spawn Newborn | action | `DebugToolsSpawning.SpawnNewborn` |  | Biotech |  |
| Spawn Pawn | action | `DebugToolsSpawning.SpawnPawn` |  |  |  |
| Spawn Pawn With Lifestage | action | `DebugToolsSpawning.SpawnPawnWithLifestage` |  |  |  |
| Spawn Random Caravan | world tool | `DebugToolsSpawning.SpawnRandomCaravan` |  |  |  |
| Spawn Random Faction Base | world tool | `DebugToolsSpawning.SpawnRandomFactionBase` |  |  |  |
| Spawn Shuttle | action | `DebugToolsSpawning.SpawnShuttle` |  |  |  |
| Spawn Site | world tool | `DebugToolsSpawning.SpawnSite` |  |  |  |
| Spawn Site With Points | world tool | `DebugToolsSpawning.SpawnSiteWithPoints` |  |  |  |
| Spawn stack of 25 | action | `DebugToolsSpawning.TryPlaceNearStacksOf25` |  |  | plus |
| Spawn stack of 75 | action | `DebugToolsSpawning.TryPlaceNearStacksOf75` |  |  | plus |
| Spawn Statue Crafted By | pawn tool | `DebugToolsSpawning.SpawnStatueCraftedBy` | `Pawn sculptor` | Odyssey |  |
| Spawn thing | action | `DebugToolsSpawning.TryPlaceNearThing` |  |  |  |
| Spawn thing set | action | `DebugToolsSpawning.SpawnThingSet` |  |  |  |
| Spawn thing with style | action | `DebugToolsSpawning.TryPlaceNearThingWithStyle` |  |  |  |
| Spawn thing with wipe mode | action | `DebugToolsSpawning.SpawnThingWithWipeMode` |  |  | plus |
| Spawn unminified thing | action | `DebugToolsSpawning.TryPlaceMinifiedThing` |  |  |  |
| Spawn Weapon | action | `DebugToolsSpawning.SpawnWeapon` |  |  |  |
| Spawn World Object | world tool | `DebugToolsSpawning.SpawnWorldObject` |  |  |  |
| Spawn world pawn... | action | `DebugToolsSpawning.SpawnWorldPawn` |  |  |  |
| Test Deferred Spawner | action | `DebugToolsSpawning.TestDeferredSpawner` |  |  |  |
| Trigger effecter... | action | `DebugToolsSpawning.TriggerEffecter` |  |  |  |
| Trigger Maintained Effecter (12s)... | action | `DebugToolsSpawning.TriggerMaintainedEffecter12S` |  |  |  |
| Trigger Maintained Effecter (5s)... | action | `DebugToolsSpawning.TriggerMaintainedEffecter5S` |  |  |  |
| Trigger Maintained Effecter... | action | `DebugToolsSpawning.TriggerMaintainedEffecter` |  |  |  |
| Try place direct full stack | action | `DebugToolsSpawning.TryPlaceDirectFullStack` |  |  | plus |
| Try place direct stack of 25 | action | `DebugToolsSpawning.TryPlaceDirectStackOf25` |  |  | plus |
| Try place direct thing | action | `DebugToolsSpawning.TryPlaceDirectThing` |  |  | plus |
| Try spawn stack of market value... | action | `DebugToolsSpawning.TryPlaceNearMarketValue` |  |  |  |
| Water Emerge Pawn | action | `DebugToolsSpawning.WaterEmergePawn` |  |  |  |

### Translation

| Étiquette | Sorte | Méthode | Paramètres | Needs | |
|---|---|---|---|---|---|
| Save Translation Report | action | `DebugActionsTranslations.SaveTranslationReport` |  |  |  |
| Write Backstory Translation File | action | `DebugActionsTranslations.WriteBackstoryTranslationFile` |  |  |  |

## 2. Réglages (interrupteurs)

Champs booléens statiques de `Verse.DebugSettings` et `Verse.DebugViewSettings`. Un step les lirait ou les écrirait par réflexion (`I turn on the debug setting "Draw Fog"`).

### `Verse.DebugSettings`

`enableDamage` · `enablePlayerDamage` · `enableRandomMentalStates` · `enableStoryteller` · `enableRandomDiseases` · `enableTranslationWindowInEnglish` · `godMode` · `devPalette` · `pauseOnError` · `noAnimals` · `unlimitedPower` · `pathThroughWalls` · `instantRecruit` · `alwaysSocialFight` · `alwaysDoLovin` · `detectRegionListersBugs` · `instantVisitorsGift` · `lowFPS` · `allowUndraftedMechOrders` · `editableGlowerColors` · `showHiddenPawns` · `showHiddenInfo` · `anomalyDarkeningFX` · `fastResearch` · `fastLearning` · `fastEcology` · `fastEcologyRegrowRateOnly` · `fastCrafting` · `fastCaravans` · `fastMapUnpollution` · `activateAllBuildingDemands` · `activateAllIdeoRoles` · `showLocomotionUrgency` · `playRitualAmbience` · `simulateUsingSteamDeck` · `logRaidInfo` · `logTranslationLookupErrors` · `logPsychicRitualTransitions` · `fastMonolithRespawn` · `searchIgnoresRestrictions` · `alwaysRareCatches` · `alwaysNegativeCatches` · `logMismatchedLayoutFactions` · `loopGravshipCutscene` · `skipGravshipTileSelection` · `ignoreGravshipRange` · `DebugBuild`

### `Verse.DebugViewSettings`

`drawFog` · `drawSnow` · `drawSand` · `drawTerrain` · `drawTerrainWater` · `drawThingsDynamic` · `drawThingsPrinted` · `drawShadows` · `drawLightingOverlay` · `drawWorldOverlays` · `drawGas` · `singleThreadedDrawing` · `drawWorldObjects` · `drawPaths` · `drawPatherState` · `drawCastPositionSearch` · `drawDestSearch` · `drawStyleSearch` · `drawSectionEdges` · `drawRiverDebug` · `drawRiverFlowDebug` · `drawPawnDebug` · `drawPawnRotatorTarget` · `drawRegions` · `drawRegionLinks` · `drawRegionDirties` · `drawRegionTraversal` · `drawRegionThings` · `drawDistricts` · `drawRooms` · `drawPower` · `drawPowerNetGrid` · `drawOpportunisticJobs` · `drawTooltipEdges` · `drawRecordedNoise` · `drawFoodSearchFromMouse` · `drawPreyInfo` · `drawGlow` · `drawAvoidGrid` · `drawBreachingGrid` · `drawBreachingNoise` · `drawLords` · `drawDuties` · `drawShooting` · `drawInfestationChance` · `drawFleshmassHeartChance` · `drawStealDebug` · `drawDeepResources` · `drawAttackTargetScores` · `drawFOVSymmetry` · `drawNonCombatantTimer` · `drawInteractionCells` · `drawDoorsDebug` · `drawDestReservations` · `drawDamageRects` · `drawDissolutionCells` · `drawUnpollutionCells` · `drawHateChanterPositions` · `drawDarknessOverlay` · `drawWoundAnchorsOnHover` · `drawMapGraphs` · `drawMapRooms` · `drawIndoorMask` · `drawOutdoorMask` · `drawShamblerAlertMote` · `drawWaterBodies` · `drawMeltingIce` · `drawUsedRects` · `drawRoadPaths` · `drawGravshipMask` · `drawTerrainCurtain` · `writeGame` · `writeSteamItems` · `writeConcepts` · `writeReservations` · `writePathCosts` · `writeFertility` · `writeLinkFlags` · `writeCover` · `writeCellContents` · `writeMusicManagerPlay` · `writeStoryteller` · `writePlayingSounds` · `writeSoundEventsRecord` · `writeMoteSaturation` · `writeSnowDepth` · `writeSandDepth` · `writeEcosystem` · `writeRecentStrikes` · `writeBeauty` · `writeListRepairableBldgs` · `writeListFilthInHomeArea` · `writeListHaulables` · `writeListMergeables` · `writeTotalSnowDepth` · `writeCanReachColony` · `writeMentalStateCalcs` · `writeWind` · `writeTerrain` · `writeApparelScore` · `writeWorkSettings` · `writeSkyManager` · `writeMemoryUsage` · `writeMapGameConditions` · `writeAttackTargets` · `writeRopesAndPens` · `writeRoomRoles` · `logIncapChance` · `logInput` · `logApparelGeneration` · `logLordToilTransitions` · `logGrammarResolution` · `logCombatLogMouseover` · `logCauseOfDeath` · `logMapLoad` · `logTutor` · `logSignals` · `logWorldPawnGC` · `logTaleRecording` · `logHourlyScreenshot` · `logFilthSummary` · `logCarriedBetweenJobs` · `logComplexGenPoints` · `saveGravshipRenders` · `debugApparelOptimize` · `disableGravshipRenderShader` · `showAllRoomStats` · `showFloatMenuWorkGivers` · `neverForceNormalSpeed` · `showArchitectMenuOrder` · `showTpsCounter` · `showFpsCounter` · `showMemoryInfo`

## 3. Production (rapports)

Méthodes `[DebugOutput]` : elles écrivent un tableau dans une fenêtre de debug. Pas de signature, un step pourrait les lancer et lire le résultat (log ou fenêtre).

### Sans catégorie

Ability Costs · Adjacent Distance Between Layer Tiles · Analysis Details · Ancient Junk · Animal Special Trainables · Animal Wild Counts On Map · Apparel Pairs · Apparel Pairs By Thing · Apparel Valid Life Stages · Beauties · Beggar Quest Items · Best Thing Request Group · Biome Animals Spawn Chances · Biome Animals Typical Counts · Biome Plants Expected Count · Biomes · Bodies · Body Parts · Body Part Tag Groups · Burning And Smelting Things · Celestial Glow · Collections Memory Usage · Damage Test · Decree Selection Weights Now · Default Stuffs · Def Labels · Def Names · Def Names All · Difficulty Details · Drawer Types · Dynamic Drawn Things By Category Now · Dynamic Drawn Things Now · Fall Color · Food Poison Chances · Food Preferability · Generate Gene Sets X10 · Genes · Gen Steps · Gravship Building Checklist · Hits To Kill · Infections · Infection Simulator · Ingestible Max Satisfied Title · Installable Body Parts · Joy Givers · Joy Jobs · Joy Kinds · Key Strings · Landmarks · Log Any Player Home Map · Log Enroute · Lords · Manhunter Results · Map Danger · Map Pawns List · Mech Cluster Building Selection · Medicines · Meditation Foci · Memes And Precepts · Minifiable Tags · Mining Resource Generation · Natural Rocks · Pawn Groups Made · Pawns List All On Map · Permanent Injury Calculations · Plant Counts On Map · Plant Current Proportions · Plants · Player Has Grav Engine Test · Player Wealth · Population Intents · Precept Defs · Prosthetics · Psychic Rituals · Quality Generation Data · Quest Defs · Quest Rewards Sampled · Quest Selection Weights Now · Relic Market Values · Relic Stuffs · Relic Things · Research Projects · Rewards Generation · Rewards Generation Sampled · Ritual Duration · Honor Availability (slow) · Royal Titles · Shooting Accuracy · Shuttle Defs To Avoid · Site Part Defs · Song Selection Data · Stock Generation Animals · Structure Color Defs · Stuff Beauty · Stuffs · Stun Chances · Sun Angle · Surgeries · Tech Levels · Techprints From Factions · Techprints From Factions Chances · Temperature Data · Temperature Overlay Colors · Terrain Affordances · Terrains · Thing Damage Data · Thing Fillage And Passability · Thing Fill Percents · Thing Masses · Thing Nutritions · Thing Path Costs · Thing Path Costs Ignore Repeaters · Thing Set Maker Possible Defs · Thing Set Maker Sampled · Thing Set Maker Test · Things Existing List · Things Power And Heat · Thing Trade Tags · Tick Rates · Tools · Transhumanist Body Parts · Turrets · Unfinished Things · Visitor Gift Chance · Wall Stuffs · Weapon Classes · Weapon Pairs · Weapon Pairs By Thing · Weapons Melee · Weapons Ranged · Weather Chances · Weather Commonalities · Wild Miss Results · Wind Speeds · Work Disables · World Gen Steps · Xenotypes

### Bossgroups

Bossgroups

### Economy

Animal Breeding · Animal Economy · Apparel Armor · Apparel By Stuff · Apparel Counts For Nudity · Apparel Insulation · Archonexus Allowed Items · Buildings · Crops · Drugs · Floors · Hediffs Price Impact · Item Accessibility · Item And Building Acquisition · Recipes · Recipe Skills · Reward Tags · Roaming Vs Economy · Thing Set Maker Tags · Thing Smelt Products · Wool

### Factions

All Factions · All Factions From Pawns · All Factions To Remove

### Incidents

Current Threat Points · Future Incidents · Future Incidents Current Map · Incident Chances · Incident Chances Sampled · Incident Targets List · Min Threat Points · Pawn Arrival Candidates · Pawn Group Gen Sampled · Peace Talks Chances · Pod Contents Possible Defs · Pod Contents Test · Raid Arrivemode Sampled · Raid Faction Sampled · Raids Info Sampled · Raid Strategy Sampled · Threats Generator · Trader Animal Tags · Trader Kinds · Trader Kind Things · Trader Stock Generation · Trader Stock Generators Defs · Trader Stock Market Values

### Pawns

Animal Behavior · Animal Combat Balance · Animal Points To Hunt Or Slaughter · Animals Basics · Animals Ecosystem · Animal Trade Tags · Backstory Counts Per Tag · Entities · Ideo Thoughts · List Solid Backstories · Live Pawns Inspiration Chances · Mechanoids · Mental Breaks · Pawn Kind Gear Sampled · Pawn Kinds Apparel Usage · Pawn Kinds Basics · Pawn Kinds Tech Hediff Usage · Pawn Kinds Weapon Usage · Pawn Work Disables Sampled · Races Butchery · Races Food Consumption · Show Beard Frequency · Thoughts · Traits Sampled · Virtual Records · World Pawn Relations

### Performance

Pawn Generation Histogram

### Quests

Mission Ancient Complex

### System

All Graphics Loaded · Dynamic Draw Things List · Loaded Assets · Material Delta · Material Report · Material Snapshot · Mesh Pool Stats · Rand By Curve Tests · Rand Tests · Steam Workshop Status · Test Math Perf

### Text generation

Art Descs Database Tales · Art Descs Random Tales · Art Descs Specific Tale · Art Descs Taleless · Books · Cube Descriptions · Database Tales Interest · Database Tales List · Flavorful Combat Test · Growth Moment Flavor · Interaction Logs · Landmark Names · Names From Rulepack · Void Sculpture Descriptions · Word Count

### UI

Pawn Column Test

### World pawns

Colonist Relative Chance · Kidnapped Pawns · Run World Pawn Gc · Run World Pawn Mothball · World Pawn Dotgraph · World Pawn Gc Breakdown · World Pawn List · World Pawn Mothball Info

