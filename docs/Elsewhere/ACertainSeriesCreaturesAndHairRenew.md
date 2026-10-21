# A Certain Series - Creatures and Hair Renew

Repository `ACertainSeriesCreaturesAndHairRenew`, folder `Tests/Pickle/Source/`, built by
`dotnet build Tests/Pickle/Source/ACertainSeriesCreaturesAndHairRenew.PickleSteps.csproj -c Release` (.NET SDK 8, `net48`, direct
references to game and Pickle DLLs; framework `csc.exe` is C# 5, rejects `$"..."`) into
`Tests/Pickle/Mod/Pickle/Assemblies/ACertainSeriesCreaturesAndHairRenew.PickleSteps.dll` (committed, staging copies folder
verbatim). Intermediates go to `.build/`, not tracked.
Every phrase starts `A Certain Series:`, because Pickle matches on text alone across every suite loaded.
Written 2026-09-24 by mod's own session. **Source only, never run**: nothing below played, in game or WSL. Checked: assembly compiles against 1.6 assemblies, every local pattern compiles with Pickle's own Cucumber expression engine, each of 238 step lines of 14 features resolves to exactly one step (`Tests/Pickle/Check-Steps.ps1`, seen failing on wrong line and invalid pattern). Features in `INVENTORY.md`; steps one file, `AcsSteps.cs`, 17 declarations.

Parenthesis in pattern is optional text in Cucumber Expressions, so `(x, z)` must be written `\\({int}, {int}\\)` in C#. One unescaped parenthesis makes whole run play zero scenarios.

### Small and generic, candidates to move if a second mod wants them

| File | Steps | What they do, and what to know before copying |
| --- | --- | --- |
| `AcsSteps.cs` | `A Certain Series: the {string} at \\({int}, {int}\\) is powered` | **Switch bench on without wiring grid**: sets `CompPowerTrader.PowerOn` on building of that def at that cell. Right for any mod whose bench draws power and whose bills must run in test; tests bench, not network. Pawn never walks to unpowered bench. Nothing resets `PowerOn` before bill ends, an assumption. *Not run.* |
| `AcsSteps.cs` | `... I select the {string}`, `... the {string} is given a {string} on its {string}`, `... the {string} has a {string} on its {string}`, `... the {string} has no {string} on its {string}` | **Read and injure animal by body part label player reads.** Part found by label; step fails unless exactly one part carries it, so label shared by two parts (seraph's eight wings used to share one) is caught. Pawn is *the* spawned pawn of that `PawnKindDef`: step fails on zero or two, so scene holds one. Injuring sets hediff severity to 3 and adds it on part; selecting also jumps camera to pawn. *Not run.* |
| `AcsSteps.cs` | `... the {string} fires at \\(x, z\\) and its {string} projectiles are watched`, `... at least {int} {string} projectiles were seen and none is left in flight` | **Start wild creature's own verb, count its projectiles every tick** with `ctx.WaitTicks(1)`, keeping `ShotLog`, until none in flight. Step deadline 120 s. For any animal mod whose `<verbs>` shoot: defect caught, projectile whose class does not resolve, leaves no log line. Assumes `TryStartCastOn` on unowned creature is not cancelled by its AI. *Not run.* |
| `AcsSteps.cs` | `... {int} stocks of the trader {string} offer {string} at least once` | **Build trader kind's stock N times, look for def.** Only `StockGenerator_Tag` generators called; others build pawns not meant to be thrown away unspawned. Right for any mod relying on tag to reach traders. Assumes `GenerateThings` with map's tile and non-player faction behaves like trader's arrival. *Not run.* |
| `AcsSteps.cs` | `... I wait for the egg at \\(x, z\\) to hatch`, `... I note the incubation of the egg at \\(x, z\\)`, `... the egg at \\(x, z\\) has incubated as far as noted`, `... the {string} has no faction` | **Wait for hatcher comp, check incubation survives save.** Note and check read private `gestateProgress` of `CompHatcher` by reflection, fail loudly if renamed. Wait ends when egg destroyed and beetle spawned, inside 890 s within 900 s step deadline (game day is 60 000 ticks; launcher measured 500 to 700 ticks a second, so scene must raise game speed first). Faction step asserts the one spawned pawn of that kind has no faction. *Not run.* |
| `AcsSteps.cs` | `... butchering a {string} by {string} yields {string} and no meat`, `... yields {string} and {string} and no meat` | **What `ButcherProducts` gives for generated animal**: `PawnGenerator.GeneratePawn`, product list, `Discard`. Meat, leather, body part meet in game's own code, which def read cannot show. One or two named products. *Not run.* |
| `AcsSteps.cs` | `... I give {string} the hairstyle {string}`, `... {string} wears the hairstyle {string}` | Set and read `pawn.story.hairDef` on named colonist, by def name. Generic to any hair mod. *Not run.* |
| `AcsSteps.cs` | `... the research {string} is finished` | Assert `ResearchProjectDef.IsFinished`. Used after save round trip to show finished research kept; fails on unknown def name rather than passing. *Not run.* |

### Dedicated to A Certain Series, no reuse expected

Nothing in file names def of mod: every step takes defs as arguments. Prefix only specific part; reusing step means giving it another one.

### Not done, and why

- Features and assumptions in suite's own `README.md`, "What the first run has to confirm" (ten items). Most fragile: powered bench: step turns `PowerOn` on, does not connect network.
- Nothing about mod's settings here. It has none: no dialog, no shortcut, settings audit recorded as `not_applicable` in its `STATUS.md`.
- Step reading health tab or taking screenshot is not local: nine `@review` captures use Pickle's own steps.