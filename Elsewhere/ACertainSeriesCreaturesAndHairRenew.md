# A Certain Series - Creatures and Hair Renew

Repository `ACertainSeriesCreaturesAndHairRenew`, folder `Tests/Pickle/Source/`, built by
`dotnet build Tests/Pickle/Source/ACertainSeriesCreaturesAndHairRenew.PickleSteps.csproj -c Release` (.NET SDK 8, `net48`, direct
references to the game and Pickle DLLs; the framework `csc.exe` is C# 5 and rejects `$"..."`) into
`Tests/Pickle/Mod/Pickle/Assemblies/ACertainSeriesCreaturesAndHairRenew.PickleSteps.dll` (committed, since the staging copies the folder
verbatim). Intermediates go to `.build/`, which is not tracked.
Every phrase starts `A Certain Series:`, because Pickle matches on text alone across every suite loaded.
Written 2026-09-24 by the mod's own session. **Source only, never run**: nothing below has been played, in a game or in WSL. What
was checked is that the assembly compiles against the 1.6 assemblies, that every local pattern compiles with Pickle's own Cucumber
expression engine, and that each of the 238 step lines of the 14 features resolves to exactly one step (`Tests/Pickle/Check-Steps.ps1`,
which was seen failing on a wrong line and on an invalid pattern). The features are in `INVENTORY.md`; the steps are one file,
`AcsSteps.cs`, 17 declarations.

A parenthesis in a pattern is optional text in Cucumber Expressions, so `(x, z)` must be written `\\({int}, {int}\\)` in C#. One
unescaped parenthesis makes the whole run play zero scenarios.

### Small and generic, candidates to move if a second mod wants them

| File | Steps | What they do, and what to know before copying |
| --- | --- | --- |
| `AcsSteps.cs` | `A Certain Series: the {string} at \\({int}, {int}\\) is powered` | **Switch a bench on without wiring a grid**: sets `CompPowerTrader.PowerOn` on the building of that def at that cell. Right for any mod whose bench draws power and whose bills must run in a test; it tests the bench, not the network. A pawn never walks to an unpowered bench. Nothing resets `PowerOn` before the bill ends, which is an assumption. *Not run.* |
| `AcsSteps.cs` | `... I select the {string}`, `... the {string} is given a {string} on its {string}`, `... the {string} has a {string} on its {string}`, `... the {string} has no {string} on its {string}` | **Read and injure an animal by the body part label the player reads.** The part is found by label and the step fails unless exactly one part carries it, so a label shared by two parts (the seraph's eight wings used to share one) is caught. The pawn is *the* spawned pawn of that `PawnKindDef`: the step fails on zero or two, so a scene holds one. Injuring sets the hediff's severity to 3 and adds it on the part; selecting also jumps the camera to the pawn. *Not run.* |
| `AcsSteps.cs` | `... the {string} fires at \\(x, z\\) and its {string} projectiles are watched`, `... at least {int} {string} projectiles were seen and none is left in flight` | **Start a wild creature's own verb and count its projectiles every tick** with `ctx.WaitTicks(1)`, keeping a `ShotLog`, until none is in flight. Step deadline 120 s. For any animal mod whose `<verbs>` shoot: the defect it catches, a projectile whose class does not resolve, leaves no log line. Assumes `TryStartCastOn` on an unowned creature is not cancelled by its AI. *Not run.* |
| `AcsSteps.cs` | `... {int} stocks of the trader {string} offer {string} at least once` | **Build a trader kind's stock N times and look for a def.** Only `StockGenerator_Tag` generators are called; the others build pawns that are not meant to be thrown away unspawned. Right for any mod that relies on a tag to reach the traders. Assumes `GenerateThings` with the map's tile and a non-player faction behaves like a trader's arrival. *Not run.* |
| `AcsSteps.cs` | `... I wait for the egg at \\(x, z\\) to hatch`, `... I note the incubation of the egg at \\(x, z\\)`, `... the egg at \\(x, z\\) has incubated as far as noted`, `... the {string} has no faction` | **Wait for a hatcher comp, and check that incubation survives a save.** The note and the check read the private `gestateProgress` of `CompHatcher` by reflection and fail loudly if it is renamed. The wait ends when the egg is destroyed and a beetle is spawned, inside 890 s within a 900 s step deadline (a game day is 60 000 ticks; the launcher measured 500 to 700 ticks a second, so the scene has to raise the game speed first). The faction step asserts the one spawned pawn of that kind has no faction. *Not run.* |
| `AcsSteps.cs` | `... butchering a {string} by {string} yields {string} and no meat`, `... yields {string} and {string} and no meat` | **What `ButcherProducts` gives for a generated animal**: `PawnGenerator.GeneratePawn`, the product list, `Discard`. Meat, leather and body part meet in the game's own code, which a def read cannot show. One or two named products. *Not run.* |
| `AcsSteps.cs` | `... I give {string} the hairstyle {string}`, `... {string} wears the hairstyle {string}` | Set and read `pawn.story.hairDef` on a named colonist, by def name. Generic to any hair mod. *Not run.* |
| `AcsSteps.cs` | `... the research {string} is finished` | Assert `ResearchProjectDef.IsFinished`. Used after a save round trip to show finished research is kept; it fails on an unknown def name rather than passing. *Not run.* |

### Dedicated to A Certain Series, no reuse expected

Nothing in the file names a def of the mod: every step takes its defs as arguments. The prefix is the only specific part, and
reusing a step means giving it another one.

### Not done, and why

- The features and their assumptions are in the suite's own `README.md`, "What the first run has to confirm" (ten items). The most
  fragile is the powered bench: the step turns `PowerOn` on, it does not connect a network.
- Nothing about the mod's settings is here. It has none: no dialog, no shortcut, and the settings audit is recorded as
  `not_applicable` in its `STATUS.md`.
- A step that reads the health tab or takes a screenshot is not local: the nine `@review` captures use Pickle's own steps.
