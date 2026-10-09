# Steps of Nelim's Pickle Tools

The Pickle steps this repository ships, one table per tool. **Pickle's own steps are in its catalogue:
[Docs/steps.md](https://github.com/RimWorks/Rimworld-Pickle/blob/main/Docs/steps.md)** (defs, mods, fixtures, pawns,
simulation, interface...); look there first, and here for what Pickle does not have. The steps of the Sanctuary's named places (Nelim's Sanctuary:) are in the catalogue of [Nelim's Sanctuary Backlot](https://github.com/vbardales/Rimworld-Nelim-Sanctuary-Backlot/blob/main/docs/steps.md). Every step starts with `Nelim's Pickle Tools:`, which keeps it from being ambiguous with one of Pickle's, **except 17 of them: RimmsqolSteps (17)**. Those texts have no prefix, so nothing in the text protects them: each tool's `Check-Steps.ps1` matches every step line of every feature of the repository against Pickle's own vocabulary and the other tools', and fails on an ambiguity. It is staged with one line
of a pass map ("Using a tool from a suite" in the [README](../README.md)).

This file is **generated** from the `[Given]`, `[When]` and `[Then]` attributes of each tool's `Source/` and the first
sentences of the summary above them: do not edit it, run `docs/Generate-Steps.ps1` (`-Check` verifies that it is current).
247 steps. The keyword in brackets is the one the source declares; Pickle matches on the text alone, so a scenario may
use `Given`, `When`, `Then` or `And` as it reads best. What a step does not say here (its limits, what was played and what
was not) is in the tool's README.

## CameraZoom

Package `nelim.pickletools.camerazoom`. Not in the bundle: a companion staged by a pass map. [README](../CameraZoom/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the camera root size is set to {float}` (When) | Sets the camera root size directly (smaller is closer: Pickle's closest is 12, the studio presets use 12 to 16) and waits 90 frames, since the game smooths the zoom over several frames. Does not check the size reached: use the read-back step. |
| `Nelim's Pickle Tools: I frame the cells \({int}, {int}\) to \({int}, {int}\) filling {int} percent of the screen` (When) | Centres the camera on the middle of a rectangle of cells and sets the zoom so the rectangle fills the given percentage of the screen: of the height or of the width, whichever the rectangle fills more. |
| `Nelim's Pickle Tools: the camera is centered on {string} at root size {float}` (When) | Centres the camera on a named pawn (colonist or animal) at a root size and reads it back, as the cell version does. |
| `Nelim's Pickle Tools: the framed cells fill at least {int} percent of the screen` (Then) | After a rectangle was framed, asserts from the camera as it IS now (the root size read back, not the one asked for) that the rectangle fills at least this percentage of the screen's height or of its width, whichever it fills more. The failure prints both shares. Fails if no rectangle was framed in this scenario. **Parameters:** `percent` (int): a percentage, a whole number. |
| `Nelim's Pickle Tools: I frame the cell \({int}, {int}\) at zoom {float}` (When) | Centres the camera on one cell at the given root size (smaller is closer), then reads it back like the step that sets the size. |
| `Nelim's Pickle Tools: the camera root size is {float}` (Then) | Asserts that the camera root size reads the value asked for, to 0.05. The failure prints the value read, which tells whether the game bounds the zoom (the size stops short and stays there) or the zoom had not finished. **Parameters:** `size` (float): a size, in cells (int) or in camera root size (float: smaller is closer). |

## ClearScreen

Package `nelim.pickletools.clearscreen`. In the bundle (`Mod/Pickle/Assemblies`). [README](../ClearScreen/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the screen is clear` (Given) | Closes every window the runner does not own, and drops every one that opens until the scenario ends, the scenario's own included: lift it with "windows are allowed to open again" before a click whose effect is to open a window. |
| `Nelim's Pickle Tools: windows are allowed to open again` (When) | Lets the game open its own windows again, undoing the clear screen. |

## ClickDiagnostics

Package `nelim.pickletools.clickdiagnostics`. In the bundle (`Mod/Pickle/Assemblies`). [README](../ClickDiagnostics/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: I move the mouse to \({int}, {int}\)` (When) | Parks the pointer: drops whatever hover Pickle had armed, so no control is drawn as hovered and no tooltip or selection bracket draws over the subject of a capture. |
| `Nelim's Pickle Tools: the button keyed {string} has stood still` (When) | Waits until the button has been drawn at the same place for sixty frames in a row and two seconds. |
| `Nelim's Pickle Tools: the button keyed {string} is reachable in {string}` (Then) | Hovers the button and asserts the window under the pointer is the named one, and that it receives input. |
| `Nelim's Pickle Tools: I click the button keyed {string} and the window {string} opens` (When) | Clicks the button and waits for the named window to open; when it does not, says what the click met. |

## CoatSteps

Package `nelim.pickletools.coatsteps`. Not in the bundle: a companion staged by a pass map. [README](../CoatSteps/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: {int} animals of kind {string} are spawned` (Given) | Generates N animals of the kind, player faction, at random age, named `coat-1`... and places each in a clear area around the map centre: a cell counts only when the cells around it are free too, for big animals. Fails saying which animal could not be placed, never a silent short count **Parameters:** `count` (int): a count, a whole number; `kindDefName` (string): a PawnKindDef name of the loaded game (any humanlike or animal kind). |
| `Nelim's Pickle Tools: {int} adult animals of kind {string} are spawned` (Given) | The same, at the kind's last life stage. Use it when the alternate graphics may differ by stage **Parameters:** `count` (int): a count, a whole number; `kindDefName` (string): a PawnKindDef name of the loaded game (any humanlike or animal kind). |
| `Nelim's Pickle Tools: {int} animals of kind {string} are spawned close together` (Given) | The same, but every animal within four cells of the map centre so one frame can hold them: for a `@review` capture. A batch that does not fit fails saying which animal could not be placed. Wording and radius from the Cats and Dogs suite **Parameters:** `count` (int): a count, a whole number; `kindDefName` (string): a PawnKindDef name of the loaded game (any humanlike or animal kind). |
| `Nelim's Pickle Tools: {int} adult animals of kind {string} are spawned close together` (Given) | The same, at the kind's last life stage **Parameters:** `count` (int): a count, a whole number; `kindDefName` (string): a PawnKindDef name of the loaded game (any humanlike or animal kind). |
| `Nelim's Pickle Tools: I frame the animals of kind {string}` (When) | Pauses the game, clears the selection, centres the camera on the `coat-N` animals of the kind, two cells past them so the tooltip under the pointer stays off the batch, sets the zoom to 9, and waits five frames. Zoom from the Dalmatians suite (8) and Cats and Dogs (9) |
| `Nelim's Pickle Tools: {int} adult animals of kind {string} are spawned around \({int}, {int}\)` (Given) | Like `close together`, but centred on a cell and within 16 cells, a clear 3 by 3 around each so a large animal fits; names continue after the `coat-N` already there **Parameters:** `count` (int): a count, a whole number; `kindDefName` (string): a PawnKindDef name of the loaded game (any humanlike or animal kind); `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge. |
| `Nelim's Pickle Tools: {int} adult animals of kind {string} are spawned in a row from \({int}, {int}\), spacing {int}` (Given) | One animal every N cells towards +x on the first cell's z; every cell is checked before any animal is made **Parameters:** `count` (int): a count, a whole number; `kindDefName` (string): a PawnKindDef name of the loaded game (any humanlike or animal kind); `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge; `spacing` (int): cells between two spawned things. |
| `Nelim's Pickle Tools: the animals of kind {string} have food at {int} percent` (Given) | Sets the food need of the `coat-N` animals of the kind, e.g. a hungry bear for a mod that digs for food when hungry **Parameters:** `kindDefName` (string): a PawnKindDef name of the loaded game (any humanlike or animal kind); `percent` (int): a percentage, a whole number. |
| `Nelim's Pickle Tools: the animal {string} is given coat {int}` (Given) | Gives a named animal an alternate coat (-1 = the original). The coat is computed from the thing ID, so the step searches an ID that gives the index and reads it back; fails if the kind has too few coats or none of 20000 IDs gives it **Parameters:** `animalName` (string): the short name of the animal; `coat` (int): the number of a coat variant, from 0. |
| `Nelim's Pickle Tools: the pawn kind {string} keeps {int} alternate graphics at a chance of {string}` (Then) | Asserts the kind's number of `alternateGraphics` and its `alternateGraphicChance` (a number with a dot, `0.8`). Names the def type, for a defName shared by a ThingDef and a PawnKindDef, which Pickle's own field step refuses as ambiguous **Parameters:** `kindDefName` (string): a PawnKindDef name of the loaded game (any humanlike or animal kind); `count` (int): a count, a whole number; `chance` (string): a probability between 0 and 1, as text. |
| `Nelim's Pickle Tools: among the animals of kind {string}, at least {int} different extra coats were drawn` (Then) | Counts the distinct coat indices of `0` or more among the `coat-N` animals of that kind. On failure prints N, K and the coats seen, so bad luck reads differently from a patch that did not apply |
| `Nelim's Pickle Tools: among the animals of kind {string}, at least {int} carry an extra coat` (Then) | Counts animals whose coat index is `0` or more, not different coats: for rare coats (5 percent) where distinct coats would be luck. Prints N, K and the coats seen |
| `Nelim's Pickle Tools: no animal of kind {string} carries an extra coat` (Then) | For a pass where a patch must not apply |
| `Nelim's Pickle Tools: each animal of kind {string} that carries an extra coat is drawn with that coat's own texture` (Then) | Deterministic, not chance: for every animal with a coat, compares the path of the graphic the renderer built (`PawnRenderer.BodyGraphic`, after initialising the render tree) with the `texPath` of the alternate graphic its index names. Fails if none of the animals carries a coat, so it cannot pass on an empty comparison |
| `Nelim's Pickle Tools: I note the coats of the animals of kind {string}` (When) | Remembers each animal's coat by name |
| `Nelim's Pickle Tools: each animal of kind {string} still has the coat noted for it` (Then) | After `I save and reload`: finds the animals again by name on the current map and compares |

## ColonistRace

Package `nelim.pickletools.colonistrace`. In the bundle (`Mod/Pickle/Assemblies`). [README](../ColonistRace/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: {string} xenotype is {string}` (Given) | Gives a pawn a Biotech xenotype and redraws it. The game removes the pawn's xenogenes and adds the xenotype's genes one by one, so a gene that carries a body type (Body_Thin, Body_Hulk...) sets the body type as it goes. The endogenes the pawn was born with are kept, so a pawn already carrying one of those keeps it alongside the new ones. **Parameters:** `nickname` (string): the colonist's nickname; `xenotypeDefName` (string): a XenotypeDef name of the loaded game (Biotech). |
| `Nelim's Pickle Tools: {string} gender is {word}` (Given) | Sets a pawn's gender, `male`, `female` or `neutral` (also `none`, `neutre`, `nonbinary`, `genderless`: the game's Gender.None; the body type is then left as it is and a head reserved for one gender is replaced by a gender-free head), then makes the look agree with it: a Male or Female plain body follows the new gender, and a head type... **Parameters:** `nickname` (string): the colonist's nickname; `gender` (word): `male`, `female`, `neutral`, `none`, `neutre`, `nonbinary`, `genderless` (the last five are Gender.None); any case; anything else fails. |
| `Nelim's Pickle Tools: {string} body type is {word}` (Given) | Gives a pawn a body type the game cannot draw at random: `Thin`, `Fat` or `Hulk`, or `Male` / `Female` (the plain body of that gender). The game keeps every body-type gene a pawn has and picks one at random each time the genes change, so a pawn with two of them (Hussar: Body_Standard and Body_Hulk) has no fixed body type. **Parameters:** `nickname` (string): the colonist's nickname; `bodyType` (word): `Thin`, `Fat`, `Hulk`, `Male`, `Female` (adults only), `Child`, `Baby` (juveniles only); any case; anything else fails. |
| `Nelim's Pickle Tools: a colonist {string} of kind {string} exists` (Given) | Generates a colonist from a humanlike PawnKindDef, the way "a colonist exists" does from the plain colonist kind, and does nothing if a colonist by that nickname already exists. The race is the kind's, so a kind from a race mod gives a pawn of that race, with that race's body types. **Parameters:** `nickname` (string): the colonist's nickname; `kindDefName` (string): a PawnKindDef name of the loaded game (any humanlike or animal kind). |
| `Nelim's Pickle Tools: {string} eye colour is rgb \({int}, {int}, {int}\)` (Given) | Gives a colonist an eye colour, RGB 0 to 255, in Nals Facial Animation's eyeball controller (both eyes, so no heterochromia), and reads it back through the mod's own colour. A colour forced by a gene (EyeGenes3 for instance) is not undone: if the mod keeps reading the gene, the step fails saying what the mod reports. **Parameters:** `nickname` (string): the colonist's nickname; `r` (int): red, 0 to 255; `g` (int): green, 0 to 255; `b` (int): blue, 0 to 255. |
| `Nelim's Pickle Tools: {string} eye colour reads rgb \({int}, {int}, {int}\)` (Then) | Asserts the eye colour Nals Facial Animation draws for a colonist, read from the mod's own colour (`GetCurrentColor` of the eyeball controller: what the Given step writes, and what a gene such as EyeGenes3's forces), each channel within 3 of 255. It reads the colour the mod hands to the renderer, not the pixels of the capture. **Parameters:** `nickname` (string): the colonist's nickname; `r` (int): red, 0 to 255; `g` (int): green, 0 to 255; `b` (int): blue, 0 to 255. |
| `Nelim's Pickle Tools: {string} mouth is {string}` (Given) | Gives a colonist a mouth by `MouthTypeDef` name (Nals Facial Animation, and the types of the mods that add some: Vanilla Textures Expanded has MouthSmile, MouthLipsSmallSmile, MouthSad, MouthScowl...). This is the fixed shape of the face, not an animation: it does not depend on the job, the mood or the heat. **Parameters:** `nickname` (string): the colonist's nickname; `typeName` (string): a MouthTypeDef name; the valid names by mod are in ColonistRace/docs/FACE-PARTS.md (Mouths), a wrong name fails with the list. |
| `Nelim's Pickle Tools: {string} brows are {string}` (Given) | Gives a colonist brows by `BrowTypeDef` name, as the mouth step does for the mouth. **Parameters:** `nickname` (string): the colonist's nickname; `typeName` (string): a BrowTypeDef name; see ColonistRace/docs/FACE-PARTS.md (Brows). |
| `Nelim's Pickle Tools: {string} lids are {string}` (Given) | Gives a colonist lids (the look of the eyes: cheerful, almond, squinting...) by `LidTypeDef` name, as the mouth step does for the mouth. **Parameters:** `nickname` (string): the colonist's nickname; `typeName` (string): a LidTypeDef name; see ColonistRace/docs/FACE-PARTS.md (Lids). |
| `Nelim's Pickle Tools: {string} face skin is {string}` (Given) | Gives a colonist a skin detail (rosy cheeks, freckles, smile lines...) by `SkinTypeDef` name, as the mouth step does for the mouth. **Parameters:** `nickname` (string): the colonist's nickname; `typeName` (string): a SkinTypeDef name; see ColonistRace/docs/FACE-PARTS.md (Skins). |
| `Nelim's Pickle Tools: {string} eyeballs are {string}` (Given) | Gives a colonist eyeballs (the iris and white shape) by `EyeballTypeDef` name, as the mouth step does for the mouth. **Parameters:** `nickname` (string): the colonist's nickname; `typeName` (string): an EyeballTypeDef name; see ColonistRace/docs/FACE-PARTS.md (Eyeballs). |
| `Nelim's Pickle Tools: {string} lid option is {string}` (Given) | Gives a colonist an eyelid option (lashes and the like) by `LidOptionTypeDef` name, as the mouth step does for the mouth. **Parameters:** `nickname` (string): the colonist's nickname; `typeName` (string): a LidOptionTypeDef name; see ColonistRace/docs/FACE-PARTS.md (Lid options). |
| `Nelim's Pickle Tools: {string} emotion mark is {string}` (Given) | Gives a colonist an emotion mark (blush, sweat drops, anger marks) by `EmotionTypeDef` name, as the mouth step does for the mouth. **Parameters:** `nickname` (string): the colonist's nickname; `typeName` (string): an EmotionTypeDef name; see ColonistRace/docs/FACE-PARTS.md (Emotion marks). |
| `Nelim's Pickle Tools: {string} face head shape is {string}` (Given) | Gives a colonist a face head shape by Facial Animation's own `HeadTypeDef` name (not the game's head type), as the mouth step does for the mouth. **Parameters:** `nickname` (string): the colonist's nickname; `typeName` (string): a Facial Animation HeadTypeDef name (not the game's head type); see ColonistRace/docs/FACE-PARTS.md (Head shapes). |
| `Nelim's Pickle Tools: {string} face kit is {string}` (Given) | Gives a colonist a whole face by kit name: a list of face parts set together (mouth, lids, brows, skin). Kits: smile, calm, sad, angry, smug, neutral. They use the part types of Vanilla Textures Expanded and Facial Animation; a part whose type does not exist (the mod is not loaded) fails the step naming it. **Parameters:** `nickname` (string): the colonist's nickname; `kit` (string): `smile` (MouthSmile, LidCheerful, BrowEven, SkinRosyCheeks), `calm` (MouthLipsTinySmile, LidSimple, BrowEven), `sad` (MouthSad, LidUnimpressed, BrowRaised), `angry` (MouthScowl, LidHardened, BrowTriangle), `smug` (MouthSmug, LidFlirty, BrowEven), `neutral` (MouthSimpleMouth, LidSimple, BrowEven); any case. |
| `Nelim's Pickle Tools: {string} mouth reads {string}` (Then) | Asserts the mouth of a colonist is this `MouthTypeDef` (the failure prints the one it has). **Parameters:** `nickname` (string): the colonist's nickname; `typeName` (string): a MouthTypeDef name, as the mouth step takes it. |
| `Nelim's Pickle Tools: the facial animations are listed` (Given) | Logs the facial animations by mod, then every face part type by mod: the dictionary the expression and part steps accept. |
| `Nelim's Pickle Tools: {string} facial expression is {string}` (Given) | Plays a Nals Facial Animation expression on a colonist by `FaceAnimationDef` name (for example `normal`, `blink`, `laydown`, `SocialRelax`): the mod's own temporary animation, started now. The names are those of the mod's animation defs; a name that does not exist fails with the list of valid ones. **Parameters:** `nickname` (string): the colonist's nickname; `animationName` (string): one FaceAnimationDef name, or several joined by `+` (the last one that defines a part of the face wins); the 55 names by mod are in ColonistRace/docs/FACIAL-ANIMATIONS.md, a wrong name fails with the list. |
| `Nelim's Pickle Tools: {string} face is held neutral` (Given) | Keeps the face of a colonist free of the expression its job and state give it, until the scenario ends: Facial Animation picks the animations of the pawn's job (a drafted pawn waiting in combat gets angry brows and dark red eyes), its mood and its pain again at every update, so a face kit or a temporary animation does not last. **Parameters:** `nickname` (string): the colonist's nickname. |
| `Nelim's Pickle Tools: {string} face state is logged` (Given) | Writes to the game log (lines starting `[face-state]`) what draws the face of a colonist right now: the part type of every Facial Animation controller (brow, lid, eyeball, mouth, skin, head, emotion...), the job the mod reads, the animations of that job and the temporary ones still running, the comps of the pawn that belong to another... **Parameters:** `nickname` (string): the colonist's nickname. |
| `Nelim's Pickle Tools: {string} has the gene {string}` (Given) | Gives a colonist a gene by its def name and redraws it. Any gene of the pawn that shares an exclusion tag with the new one is removed first (an eye colour replaces the previous eye colour, which the game would otherwise refuse to combine), then the gene is added as an endogene. **Parameters:** `nickname` (string): the colonist's nickname; `geneName` (string): a GeneDef name of the loaded game (Biotech). |
| `Nelim's Pickle Tools: {string} holds the gene {string}` (Then) | Asserts that a colonist holds a gene, by its def name. The failure lists the genes the pawn holds. **Parameters:** `nickname` (string): the colonist's nickname; `geneName` (string): a GeneDef name of the loaded game (Biotech). |
| `Nelim's Pickle Tools: I let the hairstyle of {string} show its own colours` (When) | Sets the colonist's hair colour to white and redraws the pawn, so its hairstyle is drawn in its own colours. The colour is the pawn's for the rest of the scenario (the scenario's pawn is not saved unless the scenario saves). **Parameters:** `nickname` (string): the colonist's nickname. |
| `Nelim's Pickle Tools: the hairstyle of {string} is drawn in its own colours` (Then) | Asserts that the colonist's hair colour reads white, to 0.01; the failure prints the colour and the hairstyle. **Parameters:** `nickname` (string): the colonist's nickname. |
| `Nelim's Pickle Tools: {string} hairstyle is {string}` (Given) | Gives a colonist a hairstyle by `HairDef` name and redraws it. The hair colour is left as it is. **Parameters:** `nickname` (string): the colonist's nickname; `hairDefName` (string): a HairDef name of the loaded game. |
| `Nelim's Pickle Tools: {string} hair colour is rgb \({int}, {int}, {int}\)` (Given) | Gives a colonist any hair colour, RGB 0 to 255, and redraws it. The game multiplies the hairstyle texture by this colour; the step that lets a hairstyle show its own colours is the white case. A colour forced on top by an effect such as a gene is not undone: the step reads the colour back and fails saying what the game reports. **Parameters:** `nickname` (string): the colonist's nickname; `r` (int): red, 0 to 255; `g` (int): green, 0 to 255; `b` (int): blue, 0 to 255. |
| `Nelim's Pickle Tools: {string} face tattoo is {string}` (Given) | Gives a colonist a face tattoo by `TattooDef` name, or `none` to remove it, and redraws it. Needs Ideology. The tattoo must belong to the face: the game's own face tattoos are the ones whose `tattooType` is Face. **Parameters:** `nickname` (string): the colonist's nickname; `tattooName` (string): a TattooDef name of the loaded game. |
| `Nelim's Pickle Tools: {string} body tattoo is {string}` (Given) | Gives a colonist a body tattoo by `TattooDef` name, or `none` to remove it, and redraws it. Needs Ideology. **Parameters:** `nickname` (string): the colonist's nickname; `tattooName` (string): a TattooDef name of the loaded game. |
| `Nelim's Pickle Tools: the {string} worn by {string} is dyed rgb \({int}, {int}, {int}\)` (Given) | Dyes a garment the colonist wears, by apparel def name, in an RGB colour 0 to 255, and redraws the pawn. Fails if the colonist does not wear it, or if the garment cannot be coloured (no colour comp, as for apparel drawn from its stuff alone). **Parameters:** `apparelDefName` (string): an apparel ThingDef name of the loaded game; `nickname` (string): the colonist's nickname; `r` (int): red, 0 to 255; `g` (int): green, 0 to 255; `b` (int): blue, 0 to 255. |
| `Nelim's Pickle Tools: {string} drops its clothes` (Given) | Takes every garment off with the game's own drop (Pawn_ApparelTracker.TryDrop: the same Thing is placed on the ground, as the bath job does) and remembers them for the step that checks their colour. **Parameters:** `nickname` (string): the colonist's nickname. |
| `Nelim's Pickle Tools: the {string} dropped by {string} is drawn in rgb \({int}, {int}, {int}\)` (Then) | Reads a garment dropped by the step above: its DrawColor must be the colour asked for. (Graphic.Color reads white even when the ground picture is dyed: run fd04 photo, so it is only logged.) **Parameters:** `apparelDefName` (string): an apparel ThingDef name of the loaded game; `nickname` (string): the colonist's nickname; `r` (int): red, 0 to 255; `g` (int): green, 0 to 255; `b` (int): blue, 0 to 255. |
| `Nelim's Pickle Tools: {string} wears {string} dyed rgb \({int}, {int}, {int}\)` (Given) | Dresses a colonist in a garment of the def, dyed in an RGB colour 0 to 255: makes it of its default stuff, moves the garments that cannot be worn with it (same layer and body parts) to the inventory, wears it and dyes it, then reads the colour back. What the colonist wore is remembered once, for the step that gives it back. **Parameters:** `nickname` (string): the colonist's nickname; `apparelDefName` (string): an apparel ThingDef name of the loaded game; `r` (int): red, 0 to 255; `g` (int): green, 0 to 255; `b` (int): blue, 0 to 255. |
| `Nelim's Pickle Tools: I undress {string}` (When) | Takes off what the dyed-clothes step made and puts back what the colonist wore before. Does nothing for a colonist that step never dressed. Also run after every scenario, so a failed one leaves the colonist as it found it. **Parameters:** `nickname` (string): the colonist's nickname. |
| `Nelim's Pickle Tools: {string} is undressed` (Given) | (no description yet) **Parameters:** `nickname` (string): the colonist's nickname. |
| `Nelim's Pickle Tools: {string} gets back the clothes it had` (When) | Takes off what the step above made and puts the original clothes back. Also run after every scenario (`[AfterScenario]`), so a failed one leaves the colonist as it was found **Parameters:** `nickname` (string): the colonist's nickname. |
| `Nelim's Pickle Tools: {string} stands at \({int}, {int}\)` (Given) | Puts a colonist on a cell of the current map, stops its job and its walking, and keeps it where it stands: the pawn stays put as long as the game is paused (Pickle's own `game speed is paused`) and as long as nothing gives it a job. Fails if the cell is off the map or not standable. **Parameters:** `nickname` (string): the colonist's nickname; `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge. |
| `Nelim's Pickle Tools: {string} stands at \({int}, {int}\) facing {word}` (Given) | The same, and turns the colonist to face North, East, South or West (what the renderer draws it looking at). **Parameters:** `nickname` (string): the colonist's nickname; `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge; `direction` (word): `North`, `East`, `South` or `West`; any case; anything else fails. |
| `Nelim's Pickle Tools: the animal {string} stands at \({int}, {int}\)` (Given) | Puts an ANIMAL (any spawned pawn that is not a free colonist, found by its short name, e.g. the `coat-N` names) on a standable cell, stops it and keeps it there while the game is paused. Same checks and read-back as the colonist step. **Parameters:** `name` (string): the short name of the pawn (colonist or animal) or of the thing; `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge. |
| `Nelim's Pickle Tools: the animal {string} stands at \({int}, {int}\) facing {word}` (Given) | The same, turned North, East, South or West. **Parameters:** `name` (string): the short name of the animal (for example a `coat-N` name); `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge; `direction` (word): `North`, `East`, `South` or `West`; any case; anything else fails. |
| `Nelim's Pickle Tools: {string} faces {word}` (Given) | Turns a pawn (colonist or animal, found by its short name) where it stands, without moving it. **Parameters:** `name` (string): the short name of a colonist or of an animal; `direction` (word): `North`, `East`, `South` or `West`; any case; anything else fails. |
| `Nelim's Pickle Tools: {string} carries the item {string}` (Given) | Puts one item in the hands of a pawn (colonist or animal, found by its short name), as a hauler carries it: the thing is made from the def and held by the carry tracker, which draws it on the pawn. Holds while the game is paused and nothing gives the pawn a job; a pawn already carrying something drops it first. **Parameters:** `name` (string): the short name of the pawn (colonist or animal) or of the thing; `defName` (string): a def name of the loaded game (any case). |
| `Nelim's Pickle Tools: {string} carries {int} of the item {string}` (Given) | The same, with a stack of {int} items. **Parameters:** `name` (string): the short name of the pawn (colonist or animal) or of the thing; `count` (int): a count, a whole number; `defName` (string): a def name of the loaded game (any case). |
| `Nelim's Pickle Tools: the colonist {string} is removed from the map` (Given) | Takes a colonist off the map (despawns it) so it is not in the picture, e.g. the actors a studio fixture puts on the camera cell. The pawn is not destroyed; a reload brings the fixture back as it was. Fails if the colonist is not on a map. **Parameters:** `nickname` (string): the colonist's nickname. |
| `Nelim's Pickle Tools: {string} wears {string}` (Given) | Dresses a colonist in a new garment of the apparel def, undyed, in the same way as the dyed step: the garments that cannot be worn with it go to the inventory, and the clothes it had come back with the step that gives them back. **Parameters:** `nickname` (string): the colonist's nickname; `apparelDefName` (string): an apparel ThingDef name of the loaded game. |
| `Nelim's Pickle Tools: {string} head type is {string}` (Given) | Gives a colonist a head (a `HeadTypeDef` name, e.g. Male_AverageNormal) and redraws it. The def must suit the colonist's gender. **Parameters:** `nickname` (string): the colonist's nickname; `headDefName` (string): a HeadTypeDef name of the loaded game. |
| `Nelim's Pickle Tools: {string} beard is {string}` (Given) | Gives a colonist a beard (a `BeardDef` name) or `none`, and redraws it. Refuses a beard for a pawn that has no style tracker. The failure lists the valid beard defs. **Parameters:** `nickname` (string): the colonist's nickname; `beardName` (string): a BeardDef name of the loaded game. |
| `Nelim's Pickle Tools: the other colonists are out of frame` (Given) | Moves every colonist that no "stands at" step has placed in this scenario to a standable cell far from the camera (the corner of the map farthest from the first subject, or the map's far corner when there is none), so the studio's actors are out of the picture. Each is put back where it stood after the scenario. |
| `Nelim's Pickle Tools: {string} has gender {word}` (Then) | Asserts a pawn's gender, `male` or `female`, case insensitive. **Parameters:** `nickname` (string): the colonist's nickname; `gender` (word): `male` or `female`; any case; anything else fails. |
| `Nelim's Pickle Tools: {string} has body type {word}` (Then) | Asserts a pawn's body type by def name, case insensitive. **Parameters:** `nickname` (string): the colonist's nickname; `bodyTypeDefName` (word): a BodyTypeDef name, any case: vanilla has `Male`, `Female`, `Thin`, `Fat`, `Hulk`, `Child`, `Baby`; a mod may add more. |
| `Nelim's Pickle Tools: {string} has xenotype {string}` (Then) | Asserts a pawn's xenotype by def name, case insensitive. A pawn with a custom xenotype reads as the def it was built from, and the failure names the custom one. **Parameters:** `nickname` (string): the colonist's nickname; `xenotypeDefName` (string): a XenotypeDef name of the loaded game (Biotech). |
| `Nelim's Pickle Tools: {string} is of race {string}` (Then) | Asserts a pawn's race by def name, case insensitive: `Human`, or a race a mod adds. **Parameters:** `nickname` (string): the colonist's nickname; `raceDefName` (string): a race ThingDef name of the loaded game. |
| `Nelim's Pickle Tools: {string} is at the {word} stage of life` (Then) | Asserts a pawn's stage of life: `Baby`, `Newborn`, `Child` or `Adult`, case insensitive. Needs Biotech for the first three. **Parameters:** `nickname` (string): the colonist's nickname; `stage` (word): `Baby`, `Newborn`, `Child` or `Adult`; any case; the first three need Biotech. |
| `Nelim's Pickle Tools: the thermal state and thoughts of {string} are logged` (When) | Writes in the log, and fails with nothing, the ambient temperature of a colonist, its comfortable range and every mood thought it has now (situational ones included). To read in the report why a face shows sweat or a blush. **Parameters:** `nickname` (string): the colonist's nickname. |
| `Nelim's Pickle Tools: {string} has the thought {string}` (Then) | Asserts a colonist has the mood thought `ThoughtDef` now (for example `EnvironmentHot`); the failure lists the thoughts it has. **Parameters:** `nickname` (string): the colonist's nickname; `thoughtName` (string): a ThoughtDef name of the loaded game. |
| `Nelim's Pickle Tools: {string} has no thought {string}` (Then) | Asserts a colonist does NOT have the mood thought `ThoughtDef` now; the failure says it is there, with its mood offset. **Parameters:** `nickname` (string): the colonist's nickname; `thoughtName` (string): a ThoughtDef name of the loaded game. |

## DefFieldSteps

Package `nelim.pickletools.deffields`. Not in the bundle: a companion staged by a pass map. [README](../DefFieldSteps/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: def {string} of type {string} field {string} is {string}` (Then) | Finds the def of that type and name (`ThingDef`, `PawnKindDef`, any def type the game knows), walks the dotted path over its public fields and properties, and compares the value's text with the expected text, ignoring case **Parameters:** `defName` (string): a def name of the loaded game (any case); `typeName` (string): a def name of the type the step names; a wrong name fails with the list of valid ones; `fieldPath` (string): a field path, names joined by dots; `expected` (string): the expected text. |

## ExpansionSteps

Package `nelim.pickletools.expansions`. In the bundle (`Mod/Pickle/Assemblies`). [README](../ExpansionSteps/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the expansion {string} is active` (Then) | passes when `ModsConfig.IsActive(<packageId>)` is true **Parameters:** `packageId` (string): the packageId of a mod, any case. |
| `Nelim's Pickle Tools: the expansion {string} is not active` (Then) | passes when it is false **Parameters:** `packageId` (string): the packageId of a mod, any case. |

## FilmTicks

Package `nelim.pickletools.filmticks`. In the bundle (`Mod/Pickle/Assemblies`). [README](../FilmTicks/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: I film every {int} ticks as {string}` (When) | starts filming; the name is the film's folder in the report **Parameters:** `ticksPerFrame` (int): game ticks between two pictures of the film; `name` (string): the short name of the pawn (colonist or animal) or of the thing. |
| `Nelim's Pickle Tools: I stop filming` (When) | waits ten frames for the last pictures to land, then encodes the video |

## HoverSteps

Package `nelim.pickletools.hoversteps`. In the bundle (`Mod/Pickle/Assemblies`). [README](../HoverSteps/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: I hover over the tooltip keyed {string}` (When) | Resolves the key with the game's own `Translate()`, hovers the region whose tooltip reads that, and waits for the tooltip to be drawn |
| `Nelim's Pickle Tools: I hover over the tooltip reading {string}` (When) | Hovers the region whose tooltip reads exactly this text, and waits for the tooltip to be drawn |
| `Nelim's Pickle Tools: I hover over the tooltip containing {string}` (When) | Hovers the region whose tooltip contains this text, and waits for it to be drawn; fails and lists the regions on screen if none or several match |
| `Nelim's Pickle Tools: the tooltip keyed {string} is drawn` (Then) | Asserts the tooltip whose text is the translation of this key is on screen now **Parameters:** `key` (string): a translation key (language independent), not the translated text. |
| `Nelim's Pickle Tools: the tooltip containing {string} is drawn` (Then) | Asserts a tooltip containing this text is on screen now **Parameters:** `part` (string): a part of a tooltip text: a fragment that appears in it. |
| `Nelim's Pickle Tools: no tooltip is drawn` (Then) | Asserts no tooltip is on screen |

## IdeologySteps

Package `nelim.pickletools.ideologysteps`. Not in the bundle: a companion staged by a pass map. [README](../IdeologySteps/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the colony adopts an ideoligion with the memes {string} and the precepts {string}` (Given) | Builds an ideoligion from the memes (comma-separated MemeDef names) and the precepts (comma-separated PreceptDef names, added to the ones the memes require), gives it to every free colonist and makes it the primary ideoligion of the player faction. **Parameters:** `memeNames` (string): MemeDef names separated by commas (Ideology); `preceptNames` (string): PreceptDef names separated by commas (Ideology). |
| `Nelim's Pickle Tools: the colonist {string} follows an ideoligion with the precepts {string}` (Given) | Gives one pawn (a colonist or a prisoner) an ideoligion of its own, built from the memes of the colony's primary ideoligion and the precepts asked for, so it follows a different faith from the colony's. Fails if the game would then change the colony's primary ideoligion, which happens when too few colonists follow the colony's. **Parameters:** `nickname` (string): the colonist's nickname; `preceptNames` (string): PreceptDef names separated by commas (Ideology). |
| `Nelim's Pickle Tools: the colonist {string} follows an ideoligion with the memes {string} and the precepts {string}` (Given) | Like the step without memes, for a faith whose memes differ from the colony's: the pawn follows an ideoligion made from exactly these memes and precepts. **Parameters:** `nickname` (string): the colonist's nickname; `memeNames` (string): MemeDef names separated by commas (Ideology); `preceptNames` (string): PreceptDef names separated by commas (Ideology). |
| `Nelim's Pickle Tools: the colony ideoligion has the precept {string}` (Then) | Asserts that the primary ideoligion of the colony holds a precept. **Parameters:** `preceptName` (string): a PreceptDef name of the loaded game (Ideology). |
| `Nelim's Pickle Tools: the colony ideoligion does not have the precept {string}` (Then) | Asserts that the primary ideoligion of the colony does not hold a precept. **Parameters:** `preceptName` (string): a PreceptDef name of the loaded game (Ideology). |
| `Nelim's Pickle Tools: the colonist {string} has the precept {string}` (Then) | Asserts that the ideoligion a colonist (or a prisoner) follows holds a precept. **Parameters:** `nickname` (string): the colonist's nickname; `preceptName` (string): a PreceptDef name of the loaded game (Ideology). |
| `Nelim's Pickle Tools: the prisoner {string} is offered the interaction mode {string}` (Then) | Asserts that the prisoner tab lists the interaction mode for this prisoner. The test is the game's own: the local function of ITab_Pawn_Visitor.DoPrisonerTab that decides which rows the tab draws, called by reflection, not a copy. |
| `Nelim's Pickle Tools: the prisoner {string} is not offered the interaction mode {string}` (Then) | Asserts that the prisoner tab does not list the interaction mode for this prisoner (same test as the step that asserts it is offered). |
| `Nelim's Pickle Tools: a message {string} appeared` (Then) | Asserts that the game posted a message whose text is the translation of the key, since the scenario began. The key is compared, not an English sentence: the fixed text around the placeholders of the translation must appear in the message, in order, whatever the language and whatever fills the placeholders. |
| `Nelim's Pickle Tools: the colonist {string} is doing the job {string}` (Then) | Asserts that the job a colonist is doing now is this JobDef, by defName, waiting up to 30 seconds for it. |
| `Nelim's Pickle Tools: a prison cell is built at \({int}, {int}\) with a bed and a door` (Given) | Builds a prison cell whose south-west inside cell is (x, z): walls around a 3 by 3 inside, a door in the middle of the south wall, a prisoner bed, and a roof, then waits for the game to class the room as a prison cell. Plants and filth in the way are cleared. |
| `Nelim's Pickle Tools: a prisoner {string} exists in the cell at \({int}, {int}\), in restraints` (Given) | Spawns a prisoner of the colony in the cell built at (x, z), assigns it the bed, and leaves it in restraints: `RestraintsUtility.InRestraints` is true, and the step fails if it is not. **Parameters:** `nickname` (string): the colonist's nickname; `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge. |
| `Nelim's Pickle Tools: a prisoner {string} exists in the cell at \({int}, {int}\), not in restraints` (Given) | The negative control of the step in restraints: the prisoner is released to roam (the "free" setting of the prisoner tab), so `RestraintsUtility.InRestraints` is false, and the step fails if it is not. **Parameters:** `nickname` (string): the colonist's nickname; `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge. |
| `Nelim's Pickle Tools: the prisoner {string} interaction mode is {string}` (Given) | Sets the exclusive interaction mode of a prisoner of the colony (Ideology's Convert, Reduce resistance, Recruit, Release, or a mode a mod adds) by PrisonerInteractionModeDef name, then reads it back. It sets the same field the prisoner tab sets, without the tab's warnings. **Parameters:** `nickname` (string): the nickname of a prisoner of the colony; `modeName` (string): a PrisonerInteractionModeDef defName; a wrong name fails with the list of the defs of this game. |
| `Nelim's Pickle Tools: the colonist {string} has the work type {string} enabled` (Given) | Enables one work type of a colonist (priority 3, or 1 when the colony does not use priorities) and leaves the others as they are. **Parameters:** `nickname` (string): the colonist's nickname; `workTypeName` (string): a WorkTypeDef name of the loaded game. |
| `Nelim's Pickle Tools: the colonist {string} has the work type {string} disabled` (Given) | Disables one work type of a colonist (priority 0) and leaves the others as they are. **Parameters:** `nickname` (string): the colonist's nickname; `workTypeName` (string): a WorkTypeDef name of the loaded game. |

## InspectTabs

Package `nelim.pickletools.inspecttabs`. In the bundle (`Mod/Pickle/Assemblies`). [README](../InspectTabs/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: I open the {string} inspect tab` (When) | Opens an inspect tab on the selected thing, naming it by type or label key. |
| `Nelim's Pickle Tools: I select the thing of def {string} at \({int}, {int}\)` (When) | Selects the one thing of a def on a cell, language independent: Pickle's own `I select {string}` takes a label, which is text in the language of the run. Clears the selection first. A cell with none, or with two of that def, is refused, and the message lists what the cell holds, so the scenario never selects "one of them" by luck. **Parameters:** `defName` (string): a def name of the loaded game (any case); `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge. |
| `Nelim's Pickle Tools: the {string} inspect tab is open` (Then) | Asserts the named inspect tab is the one currently open. |

## InterfaceScale

Package `nelim.pickletools.interfacescale`. In the bundle (`Mod/Pickle/Assemblies`). [README](../InterfaceScale/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the interface scale is {int} percent` (Given) | sets `Prefs.UIScale` the way the Options page does, for the length of the scenario, and puts it back afterwards |

## KeyedClick

Package `nelim.pickletools.keyedclick`. In the bundle (`Mod/Pickle/Assemblies`). [README](../KeyedClick/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: I click button keyed {string}` (When) | resolves the key with the game's own `Translate()`, then clicks the button drawn under that label |
| `Nelim's Pickle Tools: I click the gizmo keyed {string}` (When) | Runs the gizmo of the current selection whose label is the translation of a key, the way Pickle's `I click gizmo {string}` runs the one whose label it is given as text (same lookup, same `ProcessInput`), so a scenario passes in every language. **Parameters:** `key` (string): a translation key (language independent), not the translated text. |

## LoadAudit

Package `nelim.pickletools.loadaudit`. Not in the bundle: a companion staged by a pass map. [README](../LoadAudit/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the load of the mod {string} is clean` (Then) | `{string}` is the mod's packageId. Reads the game log **from the start of the game to now** and fails, listing the lines, when it holds what the four checks below find; also compares the mod's keyed translations with the active language. Attaches `load-audit`, a line saying what was read **Parameters:** `packageId` (string): the packageId of a mod, any case. |
| `Nelim's Pickle Tools: the load of the mod {string} is clean, apart from {string}` (Then) | The same, leaving out every message whose text or stack contains the second text (ignoring case): a known message the owner justifies. Say why in the feature, next to the step **Parameters:** `packageId` (string): the packageId of a mod, any case; `known` (string): a fragment of the message that is known and justified. |

## NewColony

Package `nelim.pickletools.newcolony`. Not in the bundle: a companion staged by a pass map. [README](../NewColony/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the new colony's seed is {string}` (Given) | The seed of the world; also seeds the draw of the starting tile and of the colonists. Default `picklecolony` **Parameters:** `value` (string): the value written, as text. |
| `Nelim's Pickle Tools: the new colony's map size is {int}` (Given) | Cells a side, 25 to 500. Default 75 **Parameters:** `size` (int): a size, in cells (int) or in camera root size (float: smaller is closer). |
| `Nelim's Pickle Tools: the new colony's scenario is {string}` (Given) | A `ScenarioDef` by name. Default `Crashlanded`; an unknown name fails and lists the scenarios the game has **Parameters:** `defName` (string): a def name of the loaded game (any case). |
| `Nelim's Pickle Tools: the new colony's storyteller is {string}` (Given) | A `StorytellerDef`. Default `Cassandra` **Parameters:** `defName` (string): a def name of the loaded game (any case). |
| `Nelim's Pickle Tools: the new colony's difficulty is {string}` (Given) | A `DifficultyDef`. Default `Rough` **Parameters:** `defName` (string): a def name of the loaded game (any case). |
| `Nelim's Pickle Tools: a new colony is started` (Given) | From the main menu: sets the game up as the developer quick start does, with the choices below, generates the world (5 percent of the planet), picks a starting tile, then takes the last new-colony page's path (`PageUtility.InitGameStart`): the scene "Play" is loaded, the map is generated, the game is put on pause. |
| `Nelim's Pickle Tools: any open message dialog is accepted` (When) | Accepts every open dialog of the two kinds a scenario's own intro can be, the way a click on its first option or button would: `Dialog_MessageBox` (its accept action if it has one, then closed) and `Dialog_NodeTree` (its current node's first, non-disabled option: its action if it has one, closed if the option resolves the tree, moved... |
| `Nelim's Pickle Tools: the new colony's colonists have landed` (When) | The start step counts the colonists the map holds (`FreeColonistsCount`), which includes pawns still in a drop pod or a container. This one lets the game run, at the fast speed, until every one of them is spawned on the map, then pauses again. |

## ResearchSteps

Package `nelim.pickletools.research`. In the bundle (`Mod/Pickle/Assemblies`). [README](../ResearchSteps/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: I open the research tab {string}` (When) | By def name first, then by the label the tab is drawn with, in the language the game runs in. **Parameters:** `nameOrLabel` (string): the def name or the label of the tab. |
| `Nelim's Pickle Tools: I open the research tab keyed {string}` (When) | By translation key: the key is translated and the result is matched against the tabs' labels, so a scenario naming the key runs in any language. It only reaches a tab whose label comes from a Keyed string; a def's label injected by DefInjected has no key that `.Translate()` resolves. **Parameters:** `key` (string): a translation key (language independent), not the translated text. |
| `Nelim's Pickle Tools: the research window is on the tab {string}` (Then) | The window is on that tab, it drew a selected record for it, and its contents are revealed. **Parameters:** `nameOrLabel` (string): the def name or the label of the tab. |
| `Nelim's Pickle Tools: the research window labels the tab {string} as {string}` (Then) | The label of the tab's record, which the window built from `LabelCap` when it opened. **Parameters:** `nameOrLabel` (string): the def name or the label of the tab; `label` (string): the text as displayed. |
| `Nelim's Pickle Tools: the research window lists the project {string}` (Then) | The project is one the window lists on its current tab: among the visible projects whose tab is the selected one, the very list `ListProjects` draws from, and not hidden. By def name or by label. **Parameters:** `nameOrLabel` (string): the def name or the label of the tab. |
| `Nelim's Pickle Tools: the research window lists the project {string} costing {int}` (Then) | The same, and its `Cost` **Parameters:** `nameOrLabel` (string): the def name or the label of the tab; `cost` (int): the research cost of the project, as the game shows it. |

## RimmsqolSteps

Package `nelim.pickletools.rimmsqol`. In the bundle (`Mod/Pickle/Assemblies`). [README](../RimmsqolSteps/README.md).  

| Step | Does |
| --- | --- |
| `RIMMSQOL's choices are kept for the next launch` (Given) | restart chain, see below |
| `the choices RIMMSQOL kept in the previous launch are in place` (Given) | First step of a launch that reads what the previous one kept. It refuses to pass when the writer ran in THIS process: that would be a restart test that never restarted, with the values still sitting in memory. It takes ownership of the kept choices, so the teardown of this launch puts them back unless this launch keeps them again. |
| `RIMMSQOL is ready to be driven` (Then) | RIMMSQOL loaded, its `SettingsInit` run, its `mainButtons` property set present |
| `RIMMSQOL's own list of main buttons offers {string}` (Then) | The claim is that a player, opening RIMMSQOL's "Main Buttons" list, finds the button. The list is built from every MainButtonDef whatever its visibility, so this is expected to hold; the entry's own label is logged because it is what the player reads there. **Parameters:** `defName` (string): a def name of the loaded game (any case). |
| `RIMMSQOL shows the main button {string} as {word}` (Then) | What the Visible checkbox on the button's edit page reads, {word} being visible or hidden. **Parameters:** `defName` (string): the defName of a MainButtonDef; `state` (word): `visible` or `hidden`, lower case; anything else fails. |
| `RIMMSQOL holds no choice for the main button {string}` (Then) | the instance is not active (would not be saved or applied) **Parameters:** `defName` (string): a def name of the loaded game (any case). |
| `RIMMSQOL reveals the main button {string}` (When) | `OnStartEditing`, `set("Visible", true)`, `OnStopEditing`, `WriteSettings`. Refuses if it already reads visible **Parameters:** `defName` (string): a def name of the loaded game (any case). |
| `RIMMSQOL hides the main button {string}` (When) | the same with `false`. Refuses if it already reads hidden **Parameters:** `defName` (string): a def name of the loaded game (any case). |
| `RIMMSQOL forgets its choice for the main button {string}` (When) | The reset cross beside the list entry: the choice is dropped and the def goes back to what its mod shipped. **Parameters:** `defName` (string): a def name of the loaded game (any case). |
| `RIMMSQOL's settings file records the main button {string} as {word}` (Then) | reads the **file**, not memory: `visible`, or `hidden` (configured, not true) **Parameters:** `defName` (string): the defName of a MainButtonDef; `state` (word): `visible` or `hidden`, lower case; anything else fails. |
| `RIMMSQOL's settings file records no choice for the main button {string}` (Then) | no file, no entry, or no Visible choice in the entry **Parameters:** `defName` (string): a def name of the loaded game (any case). |
| `the main bar draws the button {string}` (Then) | Both halves, because a def can be in the bar and dead: the bar visits it (Worker.Visible, hence a cell) and the worker is not Disabled, which is what turns the cell grey. MOD_SETTINGS.md forbids a greyed shortcut as firmly as a visible one. **Parameters:** `defName` (string): a def name of the loaded game (any case). |
| `the main bar does not draw the button {string}` (Then) | it has no cell **Parameters:** `defName` (string): a def name of the loaded game (any case). |
| `the main bar's button {string} is activated` (When) | What the bar's own click ends up calling. InterfaceTryActivate, not Activate: it is the method DoButton invokes, tutorial checks included. **Parameters:** `defName` (string): a def name of the loaded game (any case). |
| `RIMMSQOL's own window is opened on its list of main buttons` (When) | Waits for its own frames, as every step that opens a Dialog_ModSettings must: the dialog force-pauses the game, so a tick wait in the scenario can never be satisfied. RIMMSQOL builds its whole menu on the first frame, which can take seconds, hence the timeout. |
| `RIMMSQOL's own window is opened on the main button {string}` (When) | the real dialog on that button's edit page |
| `RIMMSQOL's own window is open` (Then) | a `Dialog_ModSettings` built for the `QOLMod` instance is on the stack |

## ScreenshotMode

Package `nelim.pickletools.screenshotmode`. In the bundle (`Mod/Pickle/Assemblies`). [README](../ScreenshotMode/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: screenshot mode is enabled around the open windows` (When) | Keeps open non-Pickle windows, hides the HUD and Pickle panels. Fails when there is no non-Pickle window to review. |
| `Nelim's Pickle Tools: screenshot mode is disabled` (When) | Restores the prior window flags and screenshot-mode state. |
| `Nelim's Pickle Tools: developer mode is turned off for the capture` (When) | Sets `Prefs.DevMode` to false and waits three frames. For a capture that must keep the full interface (a main tab and its tab bar), which screenshot mode would hide: the runner starts the game with developer mode on, and its toolbar would show. |
| `Nelim's Pickle Tools: developer mode is restored` (When) | Puts developer mode back. Optional: the `AfterScenario` hook does it. |
| `Nelim's Pickle Tools: the letters and the alerts are cleared from the screen` (When) | Clears the letter stack (public API: `LetterStack.RemoveLetter`) and the alerts readout's currently drawn list (private field, cleared by reflection: `AlertsReadout` has no public way to do this). |

## ScreenshotStudio

Package `nelim.pickletools.screenshotstudio`. Not in the bundle: a companion staged by a pass map. [README](../ScreenshotStudio/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: an animal of kind {string} named {string} is spawned at \({int}, {int}\) at life stage {int}` (Given) | (no description yet) **Parameters:** `kindName` (string): a PawnKindDef name of the loaded game; `nickname` (string): the colonist's nickname; `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge; `stageIndex` (int): index of the life stage, from 0 (the first stage of the kind). |
| `Nelim's Pickle Tools: an animal of kind {string} named {string} is spawned at \({int}, {int}\) at the life stage {string}` (Given) | (no description yet) **Parameters:** `kindName` (string): a PawnKindDef name of the loaded game; `nickname` (string): the colonist's nickname; `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge; `stageDefName` (string): a LifeStageDef name of the loaded game. |
| `Nelim's Pickle Tools: an adult animal of kind {string} named {string} is spawned at \({int}, {int}\)` (Given) | (no description yet) **Parameters:** `kindName` (string): a PawnKindDef name of the loaded game; `nickname` (string): the colonist's nickname; `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge. |
| `Nelim's Pickle Tools: I frame the animal {string} at zoom {int}` (When) | (no description yet) |
| `Nelim's Pickle Tools: I frame the area centred on \({int}, {int}\) at root size {float}` (When) | Centres the camera on a cell at a root size (smaller is closer, down to 2 and up to 130: the game's own limit is lifted) and waits until the sky glow holds still. Same as framing a rectangle, but the zoom is the one asked for. **Parameters:** `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge; `rootSize` (float): camera root size (smaller is closer); 2 to 130 once the zoom limit is lifted. |
| `Nelim's Pickle Tools: the area from \({int}, {int}\) to \({int}, {int}\) is emptied` (Given) | Destroys the furniture, items, plants, filth and corpses of the rectangle. Pawns, walls, doors and natural rock stay; terrain and roofs are untouched. **Parameters:** `x0` (int): first corner, x; `z0` (int): first corner, z; `x1` (int): second corner, x; `z1` (int): second corner, z. |
| `Nelim's Pickle Tools: the floor of the area from \({int}, {int}\) to \({int}, {int}\) is bared` (Given) | Gives the dry cells of the rectangle the terrain of the cell 3 cells west of it at mid height (Soil if that is water or rock), without paint. One sample for the whole rectangle: do not use it on an enclosure. **Parameters:** `x0` (int): first corner, x; `z0` (int): first corner, z; `x1` (int): second corner, x; `z1` (int): second corner, z. |
| `Nelim's Pickle Tools: the floor of the area from \({int}, {int}\) to \({int}, {int}\) is bared like the cell \({int}, {int}\)` (Given) | Gives the dry cells of the rectangle the terrain of a chosen cell, without paint (the sample cell for an enclosure or mixed ground). **Parameters:** `x0` (int): first corner, x; `z0` (int): first corner, z; `x1` (int): second corner, x; `z1` (int): second corner, z; `sx` (int): sample cell, x; `sz` (int): sample cell, z. |
| `Nelim's Pickle Tools: the animals are removed from the area from \({int}, {int}\) to \({int}, {int}\)` (Given) | Despawns the animals standing in the rectangle now, once. Colonists stay. Does not fail when there is none. **Parameters:** `x0` (int): first corner, x; `z0` (int): first corner, z; `x1` (int): second corner, x; `z1` (int): second corner, z. |
| `Nelim's Pickle Tools: the animals are kept out of the area from \({int}, {int}\) to \({int}, {int}\)` (Given) | Despawns the animals of the rectangle now and on every frame until the scenario ends. May be written for several rectangles. **Parameters:** `x0` (int): first corner, x; `z0` (int): first corner, z; `x1` (int): second corner, x; `z1` (int): second corner, z. |
| `Nelim's Pickle Tools: the roof is removed from the area from \({int}, {int}\) to \({int}, {int}\)` (Given) | Removes the roofs of the rectangle (thick roofs stay) so the sun lights it. **Parameters:** `x0` (int): first corner, x; `z0` (int): first corner, z; `x1` (int): second corner, x; `z1` (int): second corner, z. |
| `Nelim's Pickle Tools: the things {string} within {int} cells of \({int}, {int}\) are hidden` (Given) | Despawns the things of a def (by defName) within N cells of a cell, for this run only. Fails when none is there. **Parameters:** `defName` (string): a def name of the loaded game (any case); `radius` (int): a distance in cells, a whole number; `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge. |
| `Nelim's Pickle Tools: the frame is emptied` (Given) | Destroys the furniture, items, plants, filth and corpses of every cell the camera shows now. Pawns, walls, doors and natural rock stay. |
| `Nelim's Pickle Tools: the floor of the frame is bared` (Given) | Bares the floor of every cell the camera shows now, with the terrain of the cell 3 cells west of the view at mid height. One sample: not for an enclosure. |
| `Nelim's Pickle Tools: the animals are removed from the frame` (Given) | Despawns the animals standing in the frame now, once. |
| `Nelim's Pickle Tools: the animals are kept out of the frame` (Given) | Keeps animals out of the cells the camera shows now, every frame until the scenario ends (the area is fixed at the moment of the step). |
| `Nelim's Pickle Tools: the roof is removed from the frame` (Given) | Removes the roofs of the frame (thick roofs stay). |
| `Nelim's Pickle Tools: I let {int} frames pass` (When) | Waits this many rendered frames (the game keeps its pause): enough for a pawn just changed to be drawn again before a capture, at a fraction of the 90 frames a framing step waits. |
| `Nelim's Pickle Tools: the light of the map is logged` (Then) | (no description yet) |
| `Nelim's Pickle Tools: the eclipse of the map is ended` (Given) | (no description yet) |
| `Nelim's Pickle Tools: the sun glow of the map is at least {float}` (Then) | (no description yet) **Parameters:** `minimum` (float): the smallest value accepted. |
| `Nelim's Pickle Tools: I frame the studio {string}` (When) | REMOVED on 2026-10-08 (owner: the flower meadow / zen studio is deleted; galleries are shot at the Sanctuary). The step stays only to fail with where to go: `Nelim's Sanctuary: I am at the sanctuary "<place>"` with the save "Nelims-tribe" (SanctuaryBacklot). **Parameters:** `shot` (string): the name of a studio shot (the studios are gone; the step fails and says where to go). |
| `Nelim's Pickle Tools: I let {int} ticks pass` (When) | (no description yet) |
| `Nelim's Pickle Tools: I frame the rectangle from \({int}, {int}\) to \({int}, {int}\)` (When) | (no description yet) |
| `Nelim's Pickle Tools: a flower border is planted around the square from \({int}, {int}\) to \({int}, {int}\)` (Given) | (no description yet) **Parameters:** `x1` (int): second corner, x; `z1` (int): second corner, z; `x2` (int): second corner, x; `z2` (int): second corner, z. |
| `Nelim's Pickle Tools: I remove all animals` (When) | (no description yet) |
| `Nelim's Pickle Tools: all animals are removed` (Given) | (no description yet) |
| `Nelim's Pickle Tools: I send the colonists to the map corner` (When) | (no description yet) |
| `Nelim's Pickle Tools: the colonists are sent to the map corner` (Given) | (no description yet) |
| `Nelim's Pickle Tools: the power network is refreshed` (Given) | (no description yet) |
| `Nelim's Pickle Tools: no window of the type {string} is open` (Then) | (no description yet) **Parameters:** `typeName` (string): a def name of the type the step names; a wrong name fails with the list of valid ones. |
| `Nelim's Pickle Tools: the world component {string} holds at least {int} entries in its field {string}` (Then) | (no description yet) **Parameters:** `typeName` (string): a def name of the type the step names; a wrong name fails with the list of valid ones; `atLeast` (int): the smallest count accepted; `field` (string): a field name on the type. |
| `Nelim's Pickle Tools: all humans but {string} are removed` (Given) | (no description yet) **Parameters:** `keep` (string): the short name of the one human to keep; fails when no pawn has it. |
| `Nelim's Pickle Tools: all loose items are put away` (Given) | (no description yet) |
| `Nelim's Pickle Tools: the pawn {string} is fully fed` (Given) | (no description yet) **Parameters:** `name` (string): the short name of the pawn (colonist or animal) or of the thing. |
| `Nelim's Pickle Tools: all filth is cleaned` (Given) | (no description yet) |
| `Nelim's Pickle Tools: all research is reset` (Given) | (no description yet) |
| `Nelim's Pickle Tools: I hide the colonist bar` (When) | (no description yet) |
| `Nelim's Pickle Tools: the colonist bar is hidden` (Given) | (no description yet) |
| `Nelim's Pickle Tools: I hide the tooltips` (When) | (no description yet) |
| `Nelim's Pickle Tools: the tooltips are hidden` (Given) | (no description yet) |
| `Nelim's Pickle Tools: I hide the resource readout` (When) | (no description yet) |
| `Nelim's Pickle Tools: the resource readout is hidden` (Given) | (no description yet) |
| `Nelim's Pickle Tools: I hide the alerts` (When) | (no description yet) |
| `Nelim's Pickle Tools: the alerts are hidden` (Given) | (no description yet) |
| `Nelim's Pickle Tools: I hide the selection brackets` (When) | (no description yet) |
| `Nelim's Pickle Tools: the selection brackets are hidden` (Given) | (no description yet) |
| `Nelim's Pickle Tools: I hide the item and name labels` (When) | (no description yet) |
| `Nelim's Pickle Tools: the item and name labels are hidden` (Given) | (no description yet) |
| `Nelim's Pickle Tools: I hide the learning helper` (When) | (no description yet) |
| `Nelim's Pickle Tools: the learning helper is hidden` (Given) | (no description yet) |
| `Nelim's Pickle Tools: studio presentation mode is enabled` (When) | Turns on the game's screenshot mode for a presentation capture, remembering its previous state to put it back |
| `Nelim's Pickle Tools: the building status icons are kept` (When) | Opt-in: presentation mode hides the status icons over buildings (no power, power off, broken down, out of fuel). This keeps them drawn while names, counts and overlays stay hidden. Works before or after presentation mode; cleared after the scenario. |
| `Nelim's Pickle Tools: the temperature of the map is {float} degrees` (Given) | Holds the temperature of the whole map (outdoors, every room, every pawn's ambient temperature) at this value in degrees Celsius until the scenario ends, then gives it back. Meant for captures: at 20 degrees a pawn does not sweat or blush. Place it before the pawns are framed. Needs Harmony. **Parameters:** `degrees` (float): degrees Celsius. |
| `Nelim's Pickle Tools: the temperature of the map reads {float} degrees` (Then) | Asserts the temperature of the map reads this value to half a degree, by the game's own reading of the outdoors. **Parameters:** `degrees` (float): degrees Celsius. |
| `Nelim's Pickle Tools: the translation report has no problem for the mod {string}` (Then) | (no description yet) **Parameters:** `packageId` (string): the packageId of a mod, any case. |
| `Nelim's Pickle Tools: the translation report has no problem for the mod {string}, apart from {string}` (Then) | (no description yet) **Parameters:** `packageId` (string): the packageId of a mod, any case; `apartFrom` (string): a fragment of a message that is known and justified, not counted. |

## SoundCapture

Package `nelim.pickletools.soundcapture`. Not in the bundle: a companion staged by a pass map. [README](../SoundCapture/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the game is playing a sound` (Then) | Passes as soon as the game holds one sound that is playing, and waits up to ten real seconds for one: a menu's music and a click's sample do not start on the frame a scenario asks. The failure lists what the game held, so that "no sound" and "no way to look" are told apart. |
| `Nelim's Pickle Tools: the game is playing the sound {string}` (Then) | Passes when a live sustainer, or a playing one-shot, was started from the sound def of that name (for example `MIC_Ocarina_Play`). The menu's music is not a def, so it never satisfies this one. |
| `Nelim's Pickle Tools: I record the sound as {string}` (When) | Starts `ffmpeg` on the monitor of the audio sink and writes `sound.wav` in the report, under the name |
| `Nelim's Pickle Tools: I film with sound as {string}` (When) | A video WITH its sound: the recorder and the film start in the same step, so the sound and the picture begin together (to within ffmpeg's start, a fraction of a second). Pickle's own @film has no sound, and FilmTicks films by game ticks, whose length is not the length of the sound. |
| `Nelim's Pickle Tools: I let {int} real seconds go by` (When) | Waits real seconds, frame by frame (in the main menu no tick passes, so `I wait {int} ticks` cannot be used). 1 to 45 |
| `Nelim's Pickle Tools: I stop recording the sound` (When) | Ends the recording, checks the file, attaches `sound-file` and `sound-note` to the report |
| `Nelim's Pickle Tools: I stop filming with sound` (When) | Ends both, has Pickle's encoder make the video from the pictures at the rate they were taken (so it lasts as long as the sound), and puts the sound into it: `film-sound.mp4`, H.264 and AAC, which Windows plays as it is, in `screenshots/film/pickletools-sound--<name>/`; it also keeps `sound.wav` and Pickle's silent `film.webm`. |
| `Nelim's Pickle Tools: the sound recorded as {string} is not silent` (Then) | Measures the loudest sample with ffmpeg's `volumedetect`: not silent means above -60 dB, silent below -80 dB **Parameters:** `name` (string): the short name of the pawn (colonist or animal) or of the thing. |
| `Nelim's Pickle Tools: the sound recorded as {string} is silent` (Then) | The same measure, asserting the level is below -80 dB **Parameters:** `name` (string): the short name of the pawn (colonist or animal) or of the thing. |
| `Nelim's Pickle Tools: the game volume is {int} percent` (Given) | Sets the game's master volume for the scenario (the WSL staging writes 0, which mutes the game) and puts the value found back afterwards; nothing is saved to disk **Parameters:** `percent` (int): a percentage, a whole number. |
| `Nelim's Pickle Tools: the game music volume is {int} percent` (Given) | The game's background music and its ambience, apart from the master volume: a recording that must hear only what a mod plays cannot use the master volume, which would cut the effects it wants to hear. `Prefs.VolumeMusic` and `Prefs.VolumeAmbient` store and apply at once, are not saved to disk here, and are put back after the scenario. **Parameters:** `percent` (int): a percentage, a whole number. |
| `Nelim's Pickle Tools: the game ambient volume is {int} percent` (Given) | The same for the ambience **Parameters:** `percent` (int): a percentage, a whole number. |
| `Nelim's Pickle Tools: the game music and ambience are muted` (Given) | Both at 0: a recording then holds what a mod plays and not the menu or map music (Anima Song measured a peak of -14.3 dB from the background music alone on a whole film) |

## StageDecor

Package `nelim.pickletools.stagedecor`. Not in the bundle: a companion staged by a pass map. [README](../StageDecor/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: I place the decor {string} at \({int}, {int}\)` (Given) | Places a thing of the def at a cell, made of its default stuff, and remembers it for removal. Fails naming the cell if it is off the map or already holds a pawn or a building (the game would otherwise wipe what stood there). **Parameters:** `thingDefName` (string): a ThingDef name of the loaded game; `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge. |
| `Nelim's Pickle Tools: I place the decor {string} at \({int}, {int}\) fully grown` (Given) | Places a thing like "I place the decor" and, when it is a plant, brings it to full growth in the same step, so a flower or a bush shows at its adult size without a second step. A thing that is not a plant is placed as it is. **Parameters:** `thingDefName` (string): a ThingDef name of the loaded game; `x` (int): map cell, x (east); 0 at the west edge; `z` (int): map cell, z (north); 0 at the south edge. |
| `Nelim's Pickle Tools: I lay the floor {string} from \({int}, {int}\) to \({int}, {int}\)` (Given) | Lays a floor (a TerrainDef: a carpet, a tile, soil) on every cell of the rectangle from the first corner to the second, and remembers what each cell held, so the removal step puts it back. Fails naming the first cell off the map or under a wall. **Parameters:** `terrainDefName` (string): a TerrainDef name of the loaded game; `x1` (int): second corner, x; `z1` (int): second corner, z; `x2` (int): second corner, x; `z2` (int): second corner, z. |
| `Nelim's Pickle Tools: I lay the floor {string} from \({int}, {int}\) to \({int}, {int}\) painted {string}` (Given) | Lays a floor like the plain step, then paints it with a colour def (Structure_Cream, Structure_OrangePastel, ...): a painted floor of the studio loses its paint when another floor is laid on it, and this brings it back. **Parameters:** `terrainDefName` (string): a TerrainDef name of the loaded game; `x1` (int): second corner, x; `z1` (int): second corner, z; `x2` (int): second corner, x; `z2` (int): second corner, z; `colorDefName` (string): a ColorDef name of the loaded game. |
| `Nelim's Pickle Tools: the plants from \({int}, {int}\) to \({int}, {int}\) are fully grown` (Given) | Brings every plant on the rectangle to full growth, so a tree spawned by a step shows at its adult size instead of as a sapling. **Parameters:** `x1` (int): second corner, x; `z1` (int): second corner, z; `x2` (int): second corner, x; `z2` (int): second corner, z. |
| `Nelim's Pickle Tools: the decor {string} at \({int}, {int}\) is lit` (Given) | Makes a placed light-giving thing burn: fills its fuel when it is refuelable (a torch, a campfire) and switches it on when it has a switch, then waits up to 10 seconds for the game to say it glows. Fails if the thing at the cell has no light, or does not glow (a lamp that needs power on a network that gives none says so). |
| `Nelim's Pickle Tools: the roof is removed from \({int}, {int}\) to \({int}, {int}\)` (Given) | Takes the roof off a rectangle of cells (a test colony under a mountain roof is dark in a capture) and remembers each roof, so the removal step puts it back. A cell with no roof is left alone. **Parameters:** `x1` (int): second corner, x; `z1` (int): second corner, z; `x2` (int): second corner, x; `z2` (int): second corner, z. |
| `Nelim's Pickle Tools: the area from \({int}, {int}\) to \({int}, {int}\) is cleared` (Given) | Takes every thing off a rectangle of cells (plants, filth, items, buildings, blueprints; not pawns, motes or projectiles) so the capture shows bare ground, and remembers each one: the removal step spawns the same instances back at their cell and rotation. Floors and roofs stay (use the floor and roof steps). **Parameters:** `x1` (int): second corner, x; `z1` (int): second corner, z; `x2` (int): second corner, x; `z2` (int): second corner, z. |
| `Nelim's Pickle Tools: the decor is removed` (When) | Removes every thing the place step made and puts back every floor the lay step replaced, in one step. |

## TextureOwner

Package `nelim.pickletools.textureowner`. In the bundle (`Mod/Pickle/Assemblies`). [README](../TextureOwner/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the texture {string} is answered by the mod {string}` (Then) | passes when the **last** running mod that ships the path is the one whose packageId is given **Parameters:** `path` (string): a texture path, as a mod ships it (no extension); `packageId` (string): the packageId of a mod, any case. |
| `Nelim's Pickle Tools: the texture {string} is shipped by at least {int} running mod(s)` (Then) | passes when at least that many running mods ship the path **Parameters:** `path` (string): a texture path, as a mod ships it (no extension); `count` (int): a count, a whole number. |

## TradeSteps

Package `nelim.pickletools.tradesteps`. Not in the bundle: a companion staged by a pass map. [README](../TradeSteps/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: a trader of kind {string} has arrived` (Given) | Fires the trader-caravan incident with a forced trader kind (a TraderKindDef name such as Caravan_Outlander_BulkGoods) and waits up to 30 seconds for a pawn of that kind to stand on the map. Fails if the incident declines or nobody of that kind arrives. |
| `Nelim's Pickle Tools: the trade window is open` (When) | Opens the game's trade window between the first free colonist and the trader that arrived, and waits for the session to be active. |
| `Nelim's Pickle Tools: I buy {int} of {string} from the trader` (When) | Buys a number of a thing from the trader: finds the tradeable whose def is the named ThingDef (an animal's def is its race, for example Muffalo), sets the count so the game reads it as a purchase, and executes the deal. Fails naming what is wrong: no such tradeable, not enough in stock, too little silver, or the game refused the deal. **Parameters:** `count` (int): a count, a whole number; `defName` (string): a def name of the loaded game (any case). |

## VefFactionSteps

Package `nelim.pickletools.veffactions`. In the bundle (`Mod/Pickle/Assemblies`). [README](../VefFactionSteps/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the load has settled` (When) | Waits until the game has no long event running or waiting (VEF runs its check after the load), then three frames |
| `Nelim's Pickle Tools: a faction the world lacks is chosen` (Given) | Picks a faction the loaded world does not have and VEF would offer (not the player's, not hidden), and remembers it as the chosen one for the steps that follow |
| `Nelim's Pickle Tools: the chosen faction is marked required by its mod` (Given) | Gives the chosen faction VEF's own extension that marks it required, refusing if it already carries one, and takes it off again after the scenario |
| `Nelim's Pickle Tools: VEF runs its new faction check` (When) | Calls VEF's own on-game-loaded check by reflection, then waits three frames; fails, saying so, if VEF changed |
| `Nelim's Pickle Tools: no new faction window is open` (Then) | Asserts no new-faction window is open, and lists the factions of the ones that are |
| `Nelim's Pickle Tools: a new faction window is open for the chosen faction` (Then) | Asserts a new-faction window is open for the chosen faction, and lists the ones that are open |
| `Nelim's Pickle Tools: the chosen faction is ignored in this save` (Then) | Asserts the chosen faction is on VEF's ignored list |
| `Nelim's Pickle Tools: the chosen faction is not ignored` (Then) | Asserts the chosen faction is not on VEF's ignored list |
| `Nelim's Pickle Tools: the game log says the chosen faction was ignored` (Then) | Asserts the log holds a Quiet New Factions line for the chosen faction |
