# Colonist race - Pickle steps (shared)

Three Pickle steps that give a scenario a colonist whose body is not the plain human one:

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: {string} body type is {word}` | A body type that is certain: `Male`, `Female`, `Thin`, `Fat` or `Hulk`, case insensitive. It removes **every** body-type gene the pawn has (xenogenes and endogenes), adds the one gene of that type (`Body_Standard` for `Male` and `Female`, whose body then follows the gender; **a pawn left with no body-type gene is not certain**: with none, the game takes the body type from the adulthood backstory or draws Thin one time in two, `PawnGenerator.GetBodyTypeFor`, which a first run of this step showed by giving a female Hussar Thin), redraws the pawn and **reads the body type back**, failing with the body type found and the genes the pawn holds if it is not the one asked for. Set the gender **before**: nothing here recomputes it, and `Male` on a female pawn fails saying so. `Child` and `Baby` are not body types a gene gives but the body of an age (the game keeps it whatever the genes), so they are refused with that explanation: set the age with `"Name" is N years old` and read the result with `has body type`. A child or a baby pawn is refused for the same reason. Without Biotech there are no genes and the body type is set directly. Needs the pawn to be an adult. |
| `Nelim's Pickle Tools: {string} xenotype is {string}` | `Pawn_GeneTracker.SetXenotype`: the pawn's xenogenes are removed and the xenotype's genes added one by one, then the pawn is redrawn. A gene that carries a body type (`Body_Thin`, `Body_Hulk`...) sets the body type as it is added, on a pawn that is not a child. The pawn's endogenes stay, so a pawn born with one keeps it beside the new ones. Case insensitive. An unknown name fails and lists every xenotype the game has. Needs Biotech. |
| `Nelim's Pickle Tools: a colonist {string} of kind {string} exists` | Generates a colonist of the player's faction from a `PawnKindDef` and spawns it near the colonists, as `a colonist {string} exists` does for the plain colonist kind. Does nothing if that colonist exists. The kind's race is the pawn's race. Refuses a kind that is not humanlike, and an unknown one lists how many humanlike kinds exist and the first thirty. |

And five that read a colonist back, because a step that sets a value says what was asked and not what the game
holds (a gene sets the body type again, a race keeps its own, a child is not an adult). Each failure says the state
it found:

| Step | What it asserts |
| --- | --- |
| `Nelim's Pickle Tools: {string} has gender {word}` | `male` or `female`, case insensitive |
| `Nelim's Pickle Tools: {string} has body type {word}` | the `BodyTypeDef` defName, case insensitive |
| `Nelim's Pickle Tools: {string} has xenotype {string}` | the xenotype def; a custom xenotype reads as the def it was built from, and the failure names the custom one. Needs Biotech |
| `Nelim's Pickle Tools: {string} is of race {string}` | the race def name: `Human`, or a race a mod adds |
| `Nelim's Pickle Tools: {string} is at the {word} stage of life` | `Baby`, `Newborn`, `Child` or `Adult`; the failure adds the age |

Developer tooling. GitHub and Workshop release preparation in progress; no Defs, no features: a suite stages the companion mod in `Mod/` and writes its
own scenarios.

## Why it exists

Pickle has `{string} gender is {word}` and, in RimWorks/Rimworld-Pickle#32, `{string} body type is {word}`, but
nothing that changes what a pawn **is**. A suite that photographs clothes on colonists needs a Thin, a Fat or a
Hulk pawn, and a race whose body is not the human one. These steps are written against Pickle's own conventions
(`ColonistSteps`, `WorldSteps`) so they can go there. **When they land, this mod's steps can go.** They sit under
a text of their own so that the day Pickle has the same step, the two are never ambiguous.

## A race cannot be changed in place

A pawn's trackers, life stages and render tree are built for the race it was generated as, and `Pawn.def` is only
a field. So the way to a race with another body is to **generate** the pawn from that race's kind: `a colonist
"Name" of kind "SomeAlienKind" exists`. That works for any humanlike race, Humanoid Alien Races' included, and it
needs no dependency on that mod: the kind is looked up by name. A Biotech xenotype is the other way, and it is a
change of genes, not of race.

**Not verified against Humanoid Alien Races.** No in-game result is recorded below, including for the vanilla
kind. The generic lookup is intended to support humanlike races; that is not runtime evidence. Open: which kind
names a given race mod defines, and whether a body type that a step sets without validating it is one the race can
draw (a race that lists its own body types may draw nothing for another).

## Using it from a suite

1. A pass map, in the suite's `Tests/Pickle/`, that stages the mod from this repository:

   ```
   nelim.pickletools.colonistrace   path:PickleTools/ColonistRace/Mod
   ```

   The folder's own `About.xml` packageId must match the one written. Steps that read the pawn back
   (`{string} body is drawn from {string}`, `{string} body type is {word}`) are #32's and come with the local
   Pickle build (`-PickleSrc`), not from here.
2. Set a body type **after** the xenotype: the genes choose the body type whenever one is added or removed, so a
   body type set before is overwritten.
3. **A xenotype with several body-type genes has no fixed body type.** The game keeps every body-type gene the pawn has and picks
   one **at random** each time the genes change (`PawnGenerator.GetBodyTypeFor`, called by `Pawn_GeneTracker.Notify_GenesChanged`;
   read from `Assembly-CSharp` on 2026-09-24). In Biotech, Hussar lists `Body_Standard` and `Body_Hulk` and comes out Male or Hulk
   by chance; Neanderthal, Pigskin and Highmate are in the same case. Only Genie (`Body_Thin`) and Yttakin (`Body_Hulk`) are
   deterministic, so those are the ones to assert on **after a xenotype step alone**; to get a certain body type on any pawn use
   `body type is {word}` above. A test that expected Hussar to be Hulk failed with `it has Male`: a wrong
   expectation, not a fault of the step, which only calls `Pawn_GeneTracker.SetXenotype`.

```gherkin
Given a colonist "Slim" exists
And "Slim" is 30 years old
And Nelim's Pickle Tools: "Slim" xenotype is "Genie"
Then Nelim's Pickle Tools: "Slim" has body type Thin

Given Nelim's Pickle Tools: a colonist "Farmer" of kind "Villager" exists
```

## Build

```powershell
dotnet build ColonistRace/Source/Nelim.PickleTools.ColonistRace.csproj -c Release   # net48, output in Mod/Pickle/Assemblies
```

Intermediates go to `ColonistRace/.build/`, never inside `Mod/`, since the staging copies `Mod/` verbatim.

## Verification

Built with 0 warnings, 0 errors. **Nothing played in a game yet** as of 2026-09-21: the five scenarios that will
play the seven steps (`Genie` gives Thin, `Hussar` gives Hulk, a body type set after the xenotype wins, a colonist
of the vanilla kind `Villager` dressed and read back, a girl of eight read back as a female child) are queued on
the WSL machine. This section is to be rewritten with the run's result.
