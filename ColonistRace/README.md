# Colonist race - Pickle steps (shared)

Three Pickle steps that give a scenario a colonist whose body is not the plain human one:

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: {string} body type is {word}` | A body type that is certain: `Male`, `Female`, `Thin`, `Fat` or `Hulk`, case insensitive. It removes **every** body-type gene the pawn has (xenogenes and endogenes), adds the one gene of that type (`Body_Standard` for `Male` and `Female`, whose body then follows the gender; **a pawn left with no body-type gene is not certain**: with none, the game takes the body type from the adulthood backstory or draws Thin one time in two, `PawnGenerator.GetBodyTypeFor`, which a first run of this step showed by giving a female Hussar Thin), redraws the pawn and **reads the body type back**, failing with the body type found and the genes the pawn holds if it is not the one asked for. Set the gender **before**: nothing here recomputes it, and `Male` on a female pawn fails saying so. **For a child or a baby**: `body type is Child` and `body type is Baby`. Their body is the body of an age, not of a gene, and **setting the age (`"Name" is 8 years old`) does not recompute it**: a pawn made an adult and aged to eight keeps its adult body (seen by TailorMade Waistlines, 2026-09-25: it read Male, not Child). These two words ask the game for the body type of the pawn's *current* stage (`PawnGenerator.GetBodyTypeFor`), store it, redraw and read it back, failing with what it found if the pawn's stage is not the one asked for. Before it does, the apparel the stage may not wear (the vanilla button-down shirt has no child texture, and drawing it logs an error that fails the scenario, seen 2026-09-25) goes to the pawn's inventory, as the game does when a pawn grows into a stage. The pawn must already be a child or a baby (set the age first) and Biotech must be active. The adult words (`Male`... `Hulk`) refuse a child or a baby. Without Biotech there are no genes and an adult body type is set directly. |
| `Nelim's Pickle Tools: {string} xenotype is {string}` | `Pawn_GeneTracker.SetXenotype`: the pawn's xenogenes are removed and the xenotype's genes added one by one, then the pawn is redrawn. A gene that carries a body type (`Body_Thin`, `Body_Hulk`...) sets the body type as it is added, on a pawn that is not a child. The pawn's endogenes stay, so a pawn born with one keeps it beside the new ones. Case insensitive. An unknown name fails and lists every xenotype the game has. Needs Biotech. |
| `Nelim's Pickle Tools: a colonist {string} of kind {string} exists` | Generates a colonist of the player's faction from a `PawnKindDef` and spawns it near the colonists, as `a colonist {string} exists` does for the plain colonist kind. Does nothing if that colonist exists. The kind's race is the pawn's race. Refuses a kind that is not humanlike, and an unknown one lists how many humanlike kinds exist and the first thirty. |

And five that read a colonist back, because a step that sets a value says what was asked and not what the game
holds (a gene sets the body type again, a race keeps its own, a child is not an adult). Each failure says the state
it found:

| Step | What it asserts |
| --- | --- |
| `Nelim's Pickle Tools: {string} has gender {word}` | `male` or `female`, case insensitive |
| `Nelim's Pickle Tools: {string} gender is {word}` | Given. `male` or `female`; the plain body and a head of the other gender follow. Call it BEFORE body type, hairstyle and head type. **Not played in a game yet** |
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

Built with 0 warnings, 0 errors. **Played in game on 2026-09-25, in English, on Pickle 4.9.1** (`pickletools-colonistrace-bodytype`, pass map
`wsl-deps.colonistrace.map`; `docs/runs/aggregate.md`, rows `2026-09-25-v4.9.1-colonistrace-child` and `-child2`):

- **A pawn with two body-type genes gets each body type asked for in turn** (Hussar through Thin, Fat, Hulk, Male; the xenotype kept): passed.
- **A female pawn gets the Female body when no gene is left** (Hulk, then Female): passed.
- **A child gets the body of a child** (`body type is Child`, read back as Child, at the Child stage of life): **failed once**, then passed.
  The first play logged `Failed to find any textures at .../ShirtButton_Child`: the pawn still wore an adult's shirt, which has no child texture, and
  the redraw's error failed the scenario. The step now first takes off what the stage may not wear (to the inventory), and the scenario passed (1 of 1).
  The two adult scenarios ran on the build before that change, which did not touch their path.

The steps these scenarios use, and so have played: `body type is {word}` (Thin, Fat, Hulk, Male, Female, Child), `xenotype is {string}`, and the reads
`has gender`, `has body type`, `has xenotype`, `is at the {word} stage of life`. **Not played in a game**: `a colonist {string} of kind {string} exists`, `is of race {string}`,
`Baby` for the body type, and any race a mod adds (Humanoid Alien Races). Not played in French, and not with a Biotech-less game (the steps that need
Biotech say so and stop, unplayed).
## Hairstyle in its own colours (2026-10-02)

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: I let the hairstyle of {string} show its own colours` | Sets the colonist's hair colour to white and redraws it. The game multiplies the hairstyle texture by the hair colour, so a brown pawn lays brown over a white-tipped or multicoloured hairstyle (Accelerator's white spikes come out chestnut); white multiplies by one |
| `Nelim's Pickle Tools: the hairstyle of {string} is drawn in its own colours` | Asserts the hair colour reads white; the failure prints the colour and the hairstyle |

For a hairstyle gallery capture of any mod: set it before the screenshot, after the colonist and its hairstyle are in place. Ported from
ACertainSeriesCreaturesAndHairRenew's local steps; **not played**, scenario `pickletools-colonistrace-hair.feature`. A colour forced on top
by an effect (a Biotech gene, for one) is not undone, and the second step says what the game reports. Which hairstyle a pawn wears is
not set here: use Pickle's own steps or the suite's.

## Hairstyle, hair colour, tattoos, dyed garment (2026-10-02)

Written for CrystalBall's staged workshop captures. **Not played.** Colours are RGB 0 to 255; each step sets the value, redraws the pawn and reads
it back, failing with what the game reports.

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: {string} hairstyle is {string}` | A `HairDef` by name; the hair colour is left alone |
| `Nelim's Pickle Tools: {string} hair colour is rgb \({int}, {int}, {int}\)` | Any hair colour; a colour forced by a gene is not undone and the failure says so |
| `Nelim's Pickle Tools: {string} eye colour is rgb ({int}, {int}, {int})` | Eye colour in Nals Facial Animation's eyeball controller (both eyes), read back through the mod; a colour forced by an eye gene is not undone and the failure says so. Not played yet (2026-10-08) |
| `Nelim's Pickle Tools: {string} facial expression is {string}` | Plays a Nals Facial Animation `FaceAnimationDef` by defName as a temporary animation; an unknown name lists the valid ones. Runs on ticks; whether it holds through a capture is not proven yet |
| `Nelim's Pickle Tools: {string} face tattoo is {string}` / `... body tattoo is ...` | A `TattooDef` of that kind, or `none`. Needs Ideology; a tattoo of the other kind is refused |
| `Nelim's Pickle Tools: the {string} worn by {string} is dyed rgb \({int}, {int}, {int}\)` | Dyes a worn garment by apparel def; fails if it is not worn or cannot take a colour |

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: {string} wears {string} dyed rgb \({int}, {int}, {int}\)` | Dresses a colonist in a new garment of that apparel def, dyed; the garments that cannot be worn with it (same layer and body parts) go to the inventory. What the colonist wore is remembered once |
| `Nelim's Pickle Tools: {string} gets back the clothes it had` | Takes off what the step above made and puts the original clothes back. Also run after every scenario (`[AfterScenario]`), so a failed one leaves the colonist as it was found |

(Asked by DrumBathHygiene on 2026-10-02. Not played.)

## Staging a colonist: place, face, remove, undyed clothes (2026-10-02)

For staged gallery captures (rule of the day). **Not played.** The pawn stays where it is put while the game is paused (Pickle's own `game speed is paused`) and nothing gives it a job; it is not a pose (no step freezes an animation).

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: {string} stands at \({int}, {int}\)` | Stops the colonist's job and walking and puts it on a standable cell |
| `Nelim's Pickle Tools: {string} stands at \({int}, {int}\) facing {word}` | The same, turned North, East, South or West |
| `Nelim's Pickle Tools: the colonist {string} is removed from the map` | Despawns the colonist (not destroyed; a reload brings the fixture back), for the studio actors standing on the camera cell |
| `Nelim's Pickle Tools: {string} wears {string}` | Dresses the colonist in a new undyed garment of that apparel def, moving what clashes to the inventory; `gets back the clothes it had` undoes it |

Not here: a head type or face shape, and a neutral pose.

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: {string} head type is {string}` | A `HeadTypeDef` by name, refused if it is for the other gender |
| `Nelim's Pickle Tools: the other colonists are out of frame` | Sends every colonist that no `stands at` step placed in this scenario to a standable cell near the far corner of the map, and puts each back after the scenario (for a studio's actors) |

| `Nelim's Pickle Tools: {string} beard is {string}` | A `BeardDef` by name, or `none`; the failure lists the valid beards |
