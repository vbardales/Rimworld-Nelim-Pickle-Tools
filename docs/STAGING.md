# Staged gallery captures: which step does what

Rule of 2026-10-02 (Virginie): every gallery capture is a staged photograph (a common set, a subject chosen and styled, nothing at its
defaults); only menus are plain screenshots. This page answers "which step do I use for X". Step texts are exact, with the prefix
`Nelim's Pickle Tools: ` omitted below; in a `.feature`, write the parentheses **without** the backslash.

**Status of everything marked "PickleTools": written 2026-10-02, compiled, patterns checked offline, NOT PLAYED yet** (probe scenario
`Tests/Pickle/Mod/Pickle/Features/pickletools-staging.feature`, pass map `wsl-deps.staging.map`). Nothing is committed at the time of writing.
A line of a pass map is `nelim.pickletools.<name>   path:PickleTools/<Folder>/Mod`.

| Need | Step | Where |
| --- | --- | --- |
| Hour of the day | `I set the hour to {int}` | Pickle |
| Weather | `I set the weather to {string}` | Pickle |
| Pause the game | `game speed is paused` | Pickle |
| Camera to a cell / a pawn | `I move the camera to ({int}, {int})`, `I move the camera to {string}` | Pickle |
| Camera at a root size (closer than Pickle's 12) | `the camera root size is set to {float}`, `the camera root size is {float}` | CameraZoom (`camerazoom`) |
| Camera on a cell at a zoom | `I frame the cell ({int}, {int}) at zoom {float}` | CameraZoom |
| Camera on a pawn at a zoom | `the camera is centered on {string} at root size {float}` | CameraZoom |
| Camera so a rectangle fills N % of the screen | `I frame the cells ({int}, {int}) to ({int}, {int}) filling {int} percent of the screen` | CameraZoom |
| Place a decor thing | `I place the decor {string} at ({int}, {int})` | StageDecor (`stagedecor`) |
| Lay a floor on a rectangle | `I lay the floor {string} from ({int}, {int}) to ({int}, {int})` | StageDecor |
| Make a torch / campfire burn | `the decor {string} at ({int}, {int}) is lit` | StageDecor |
| Take the roof off a rectangle | `the roof is removed from ({int}, {int}) to ({int}, {int})` | StageDecor |
| Remove all of it (things, floors, roofs) | `the decor is removed` (and after every scenario) | StageDecor |
| One thing at a cell, Pickle's way | `I spawn a {string} at ({int}, {int})`, `I destroy the {string} at ({int}, {int})` | Pickle |
| Put a colonist on a cell | `{string} stands at ({int}, {int})` | ColonistRace (`colonistrace`) |
| ... and turn it | `{string} stands at ({int}, {int}) facing {word}` (North, East, South, West) | ColonistRace |
| Put an animal on a cell, turned | `the animal {string} stands at ({int}, {int})`, `the animal {string} stands at ({int}, {int}) facing {word}` | ColonistRace |
| Turn a pawn where it stands | `{string} faces {word}` | ColonistRace |
| Assert the framed cells fill enough | `the framed cells fill at least {int} percent of the screen` (after `I frame the cells …`) | CameraZoom |
| Take a studio actor off the map | `the colonist {string} is removed from the map` | ColonistRace |
| Move all the non-subject colonists away | `the other colonists are out of frame` | ColonistRace |
| Dress, undyed / dyed | `{string} wears {string}`, `{string} wears {string} dyed rgb ({int}, {int}, {int})` | ColonistRace |
| Dye what is already worn | `the {string} worn by {string} is dyed rgb ({int}, {int}, {int})` | ColonistRace |
| Give the clothes back | `{string} gets back the clothes it had` | ColonistRace |
| Hairstyle, hair colour | `{string} hairstyle is {string}`, `{string} hair colour is rgb ({int}, {int}, {int})`, `I let the hairstyle of {string} show its own colours` | ColonistRace |
| Tattoos | `{string} face tattoo is {string}`, `{string} body tattoo is {string}` (`none` removes; needs Ideology) | ColonistRace |
| Head, beard | `{string} head type is {string}`, `{string} beard is {string}` (`none` removes) | ColonistRace |
| Body type, gender, xenotype, race | `{string} body type is {word}`, `{string} gender is {word}`, `{string} xenotype is {string}`, `a colonist {string} of kind {string} exists` | Pickle / ColonistRace |
| Animals around a cell | `{int} adult animals of kind {string} are spawned around ({int}, {int})` | CoatSteps (`coatsteps`) |
| Animals in a row | `{int} adult animals of kind {string} are spawned in a row from ({int}, {int}), spacing {int}` | CoatSteps |
| An animal's coat | `the animal {string} is given coat {int}` | CoatSteps |
| An animal's hunger | `the animals of kind {string} have food at {int} percent` | CoatSteps |
| Hide the interface | see `ScreenshotMode/README.md` | ScreenshotMode |

## Not available

A frozen pose or animation, a neutral stance beyond "paused and without a job"; a step that clears an area of every thing and restores
it (only what StageDecor placed comes off); a trader coming and a purchase; full-resolution capture (not known whether the launcher
reduces the picture); the map centre of a 250 x 250 map is (125, 125), so "relative to the centre" is arithmetic done by the author.
What the sky and the lamps look like in the captured picture at a given hour is not established.

## Wanted and not built: who asked, and whether it looks feasible

Kept so a "no" is not a "never". "Lead" is a reading of the game API on 2026-10-02, **not a test**; nothing below was tried.

| Wanted | Asked by | Lead on feasibility |
| --- | --- | --- |
| A frozen pose or animation, a neutral stance | AncientBuildingsRenew, AncientChineseBeastAndGeneExpanded, ASlothModRenew | Unknown. Pausing the game plus an empty job already keeps a pawn still; freezing the *animation* would mean touching the renderer's tweener or the job driver. Read `Pawn_DrawTracker` and `PawnRenderer` first |
| Clear an area of every thing and restore it | AncientChineseBeastAndGeneExpanded | Likely feasible: record the things in a rectangle, despawn them, respawn the same instances at the end (pawns left alone). Medium work; plants and filth are the awkward part |
| A trader arrives, the trade window opens, an animal is bought | ContentedLivestock | Large: an incident for a trader, a trade session, a purchase. Check whether Pickle already has caravan or trade steps before starting |
| Capture at full resolution, not reduced | AncientChineseBeastAndGeneExpanded | Not known whether anything reduces it. Read-only check: the launcher's screenshot path and `I take a screenshot` in Pickle's source |
| Turn or place an **animal** (not only a colonist) | ASlothModRenew | Easy: `stands at … facing …` finds free colonists only (`ColonistLookup`); the same code with a lookup by pawn name would do |
| A step that only turns a pawn, without moving it | ebbbs (via Ticket Manager) | Easy; for now `stands at` on the pawn's own cell does it |
| Cells relative to the map centre (`at offset (dx, dz)`) | ColorfulCoatsDodos | Trivial arithmetic; the author can write `(125 + dx, 125 + dz)` on a 250 by 250 map |
| An assertion that the framed subject fills at least N percent | AnimalsNaturally | Feasible: the framing step already computes the size; an assertion would compare the rectangle's drawn size with the screen. Not written |
| What the sky glow and the lamps look like in the picture at an hour | CreaturesOfKi, CrystalBall | Not a step: a capture has to be looked at. The `is lit` step only says the game reports the thing as glowing |
| A list of decor defs known safe in vanilla 1.6 (standing lamp, potted plant, shelf, brazier) | ColorfulCoatsDodos | **Done as a reading, 2026-10-02**: these defNames exist in the game's `Core/Defs/ThingDefs_Buildings` of this install: `TorchLamp` (refuelable, burns when lit), `StandingLamp` (needs power, so it will not glow on its own), `Campfire`, `PlantPot`, `Shelf`, `Bookcase`, `Stool`, `DiningChair`, `Table1x2c`, `Table2x2c`, `SculptureSmall`, `SculptureLarge`, `SculptureGrand`, `Bed`, `DoubleBed`, `Bedroll`. There is no `Brazier` def in vanilla. That they place cleanly on a given cell is not tested |
| A frozen pose or animation | (see the first row) | **Checked 2026-10-02**: in this install only the Anomaly DLC defines `AnimationDef`s (`ShamblerSway`, `RevenantSpasm`, `HoldingPlatformWiggleLight`...), entity twitches and lunges; none is a neutral stance for a colonist. The renderer does have `SetAnimation` and an animation tick that follows game ticks, so a paused game freezes one, but there is nothing neutral to apply. A paused game with a pawn that has no job is the stance to use |
| A head or face for an animal | none | Not asked; mentioned only because heads exist for colonists |

## Who asked

CrystalBall, AncientBuildingsRenew, AncientChineseBeastAndGeneExpandedRenew, AnimalsNaturally, ColorfulCoatsMegafaunaRenew,
DrumBathHygiene, ACertainSeriesCreaturesAndHairRenew, ASlothModRenew, FieldworkCompanions, ContentedLivestock, ColorfulCoatsDodos,
ColorfulCoatsVAERenew, ExtinguishRefuelablesCompatibilityPatch, EponaInstrumentsRenew, CreaturesOfKi. The recurring needs are recorded
in `Elsewhere/README.md` (known overlap table).
