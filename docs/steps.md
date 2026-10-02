# Steps of Nelim's Pickle Tools

The Pickle steps this repository ships, one table per tool. **Pickle's own steps are in its catalogue:
[Docs/steps.md](https://github.com/RimWorks/Rimworld-Pickle/blob/main/Docs/steps.md)** (defs, mods, fixtures, pawns,
simulation, interface...); look there first, and here for what Pickle does not have. Every step starts with `Nelim's Pickle Tools:`, which keeps it from being ambiguous with one of Pickle's, **except 17 of them: RimmsqolSteps (17)**. Those texts have no prefix, so nothing in the text protects them: each tool's `Check-Steps.ps1` matches every step line of every feature of the repository against Pickle's own vocabulary and the other tools', and fails on an ambiguity. It is staged with one line
of a pass map ("Using a tool from a suite" in the [README](../README.md)).

This file is **generated** from the `[Given]`, `[When]` and `[Then]` attributes of each tool's `Source/` and the first
sentences of the summary above them: do not edit it, run `docs/Generate-Steps.ps1` (`-Check` verifies that it is current).
161 steps. The keyword in brackets is the one the source declares; Pickle matches on the text alone, so a scenario may
use `Given`, `When`, `Then` or `And` as it reads best. What a step does not say here (its limits, what was played and what
was not) is in the tool's README.

## CameraZoom

Package `nelim.pickletools.camerazoom`. Not in the bundle: a companion staged by a pass map. [README](../CameraZoom/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the camera root size is set to {float}` (When) | Sets the camera root size directly (smaller is closer: Pickle's closest is 12, the studio presets use 12 to 16) and waits 90 frames, since the game smooths the zoom over several frames. Does not check the size reached: use the read-back step. |
| `Nelim's Pickle Tools: I frame the cells \({int}, {int}\) to \({int}, {int}\) filling {int} percent of the screen` (When) | Centres the camera on the middle of a rectangle of cells and sets the zoom so the rectangle fills the given percentage of the screen: of the height or of the width, whichever the rectangle fills more. |
| `Nelim's Pickle Tools: the camera is centered on {string} at root size {float}` (When) | Centres the camera on a named pawn (colonist or animal) at a root size and reads it back, as the cell version does. |
| `Nelim's Pickle Tools: the framed cells fill at least {int} percent of the screen` (Then) | After a rectangle was framed, asserts from the camera as it IS now (the root size read back, not the one asked for) that the rectangle fills at least this percentage of the screen's height or of its width, whichever it fills more. The failure prints both shares. Fails if no rectangle was framed in this scenario. |
| `Nelim's Pickle Tools: I frame the cell \({int}, {int}\) at zoom {float}` (When) | Centres the camera on one cell at the given root size (smaller is closer), then reads it back like the step that sets the size. |
| `Nelim's Pickle Tools: the camera root size is {float}` (Then) | Asserts that the camera root size reads the value asked for, to 0.05. The failure prints the value read, which tells whether the game bounds the zoom (the size stops short and stays there) or the zoom had not finished. |

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
| `Nelim's Pickle Tools: {int} animals of kind {string} are spawned` (Given) | Generates N animals of the kind, player faction, at random age, named `coat-1`... and places each in a clear area around the map centre: a cell counts only when the cells around it are free too, for big animals. Fails saying which animal could not be placed, never a silent short count |
| `Nelim's Pickle Tools: {int} adult animals of kind {string} are spawned` (Given) | The same, at the kind's last life stage. Use it when the alternate graphics may differ by stage |
| `Nelim's Pickle Tools: {int} animals of kind {string} are spawned close together` (Given) | The same, but every animal within four cells of the map centre so one frame can hold them: for a `@review` capture. A batch that does not fit fails saying which animal could not be placed. Wording and radius from the Cats and Dogs suite |
| `Nelim's Pickle Tools: {int} adult animals of kind {string} are spawned close together` (Given) | The same, at the kind's last life stage |
| `Nelim's Pickle Tools: I frame the animals of kind {string}` (When) | Pauses the game, clears the selection, centres the camera on the `coat-N` animals of the kind, two cells past them so the tooltip under the pointer stays off the batch, sets the zoom to 9, and waits five frames. Zoom from the Dalmatians suite (8) and Cats and Dogs (9) |
| `Nelim's Pickle Tools: {int} adult animals of kind {string} are spawned around \({int}, {int}\)` (Given) | Like `close together`, but centred on a cell and within 16 cells, a clear 3 by 3 around each so a large animal fits; names continue after the `coat-N` already there |
| `Nelim's Pickle Tools: {int} adult animals of kind {string} are spawned in a row from \({int}, {int}\), spacing {int}` (Given) | One animal every N cells towards +x on the first cell's z; every cell is checked before any animal is made |
| `Nelim's Pickle Tools: the animals of kind {string} have food at {int} percent` (Given) | Sets the food need of the `coat-N` animals of the kind, e.g. a hungry bear for a mod that digs for food when hungry |
| `Nelim's Pickle Tools: the animal {string} is given coat {int}` (Given) | Gives a named animal an alternate coat (-1 = the original). The coat is computed from the thing ID, so the step searches an ID that gives the index and reads it back; fails if the kind has too few coats or none of 20000 IDs gives it |
| `Nelim's Pickle Tools: the pawn kind {string} keeps {int} alternate graphics at a chance of {string}` (Then) | Asserts the kind's number of `alternateGraphics` and its `alternateGraphicChance` (a number with a dot, `0.8`). Names the def type, for a defName shared by a ThingDef and a PawnKindDef, which Pickle's own field step refuses as ambiguous |
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
| `Nelim's Pickle Tools: {string} xenotype is {string}` (Given) | Gives a pawn a Biotech xenotype and redraws it. The game removes the pawn's xenogenes and adds the xenotype's genes one by one, so a gene that carries a body type (Body_Thin, Body_Hulk...) sets the body type as it goes. The endogenes the pawn was born with are kept, so a pawn already carrying one of those keeps it alongside the new ones. |
| `Nelim's Pickle Tools: {string} body type is {word}` (Given) | Gives a pawn a body type the game cannot draw at random: `Thin`, `Fat` or `Hulk`, or `Male` / `Female` (the plain body of that gender). The game keeps every body-type gene a pawn has and picks one at random each time the genes change, so a pawn with two of them (Hussar: Body_Standard and Body_Hulk) has no fixed body type. |
| `Nelim's Pickle Tools: a colonist {string} of kind {string} exists` (Given) | Generates a colonist from a humanlike PawnKindDef, the way "a colonist exists" does from the plain colonist kind, and does nothing if a colonist by that nickname already exists. The race is the kind's, so a kind from a race mod gives a pawn of that race, with that race's body types. |
| `Nelim's Pickle Tools: I let the hairstyle of {string} show its own colours` (When) | Sets the colonist's hair colour to white and redraws the pawn, so its hairstyle is drawn in its own colours. The colour is the pawn's for the rest of the scenario (the scenario's pawn is not saved unless the scenario saves). |
| `Nelim's Pickle Tools: the hairstyle of {string} is drawn in its own colours` (Then) | Asserts that the colonist's hair colour reads white, to 0.01; the failure prints the colour and the hairstyle. |
| `Nelim's Pickle Tools: {string} hairstyle is {string}` (Given) | Gives a colonist a hairstyle by `HairDef` name and redraws it. The hair colour is left as it is. |
| `Nelim's Pickle Tools: {string} hair colour is rgb \({int}, {int}, {int}\)` (Given) | Gives a colonist any hair colour, RGB 0 to 255, and redraws it. The game multiplies the hairstyle texture by this colour; the step that lets a hairstyle show its own colours is the white case. A colour forced on top by an effect such as a gene is not undone: the step reads the colour back and fails saying what the game reports. |
| `Nelim's Pickle Tools: {string} face tattoo is {string}` (Given) | Gives a colonist a face tattoo by `TattooDef` name, or `none` to remove it, and redraws it. Needs Ideology. The tattoo must belong to the face: the game's own face tattoos are the ones whose `tattooType` is Face. |
| `Nelim's Pickle Tools: {string} body tattoo is {string}` (Given) | Gives a colonist a body tattoo by `TattooDef` name, or `none` to remove it, and redraws it. Needs Ideology. |
| `Nelim's Pickle Tools: the {string} worn by {string} is dyed rgb \({int}, {int}, {int}\)` (Given) | Dyes a garment the colonist wears, by apparel def name, in an RGB colour 0 to 255, and redraws the pawn. Fails if the colonist does not wear it, or if the garment cannot be coloured (no colour comp, as for apparel drawn from its stuff alone). |
| `Nelim's Pickle Tools: {string} wears {string} dyed rgb \({int}, {int}, {int}\)` (Given) | Dresses a colonist in a garment of the def, dyed in an RGB colour 0 to 255: makes it of its default stuff, moves the garments that cannot be worn with it (same layer and body parts) to the inventory, wears it and dyes it, then reads the colour back. What the colonist wore is remembered once, for the step that gives it back. |
| `Nelim's Pickle Tools: {string} gets back the clothes it had` (When) | Takes off what the dyed-clothes step made and puts back what the colonist wore before. Does nothing for a colonist that step never dressed. Also run after every scenario, so a failed one leaves the colonist as it found it. |
| `Nelim's Pickle Tools: {string} stands at \({int}, {int}\)` (Given) | Puts a colonist on a cell of the current map, stops its job and its walking, and keeps it where it stands: the pawn stays put as long as the game is paused (Pickle's own `game speed is paused`) and as long as nothing gives it a job. Fails if the cell is off the map or not standable. |
| `Nelim's Pickle Tools: {string} stands at \({int}, {int}\) facing {word}` (Given) | The same, and turns the colonist to face North, East, South or West (what the renderer draws it looking at). |
| `Nelim's Pickle Tools: the animal {string} stands at \({int}, {int}\)` (Given) | Puts an ANIMAL (any spawned pawn that is not a free colonist, found by its short name, e.g. the `coat-N` names) on a standable cell, stops it and keeps it there while the game is paused. Same checks and read-back as the colonist step. |
| `Nelim's Pickle Tools: the animal {string} stands at \({int}, {int}\) facing {word}` (Given) | The same, turned North, East, South or West. |
| `Nelim's Pickle Tools: {string} faces {word}` (Given) | Turns a pawn (colonist or animal, found by its short name) where it stands, without moving it. |
| `Nelim's Pickle Tools: the colonist {string} is removed from the map` (Given) | Takes a colonist off the map (despawns it) so it is not in the picture, e.g. the actors a studio fixture puts on the camera cell. The pawn is not destroyed; a reload brings the fixture back as it was. Fails if the colonist is not on a map. |
| `Nelim's Pickle Tools: {string} wears {string}` (Given) | Dresses a colonist in a new garment of the apparel def, undyed, in the same way as the dyed step: the garments that cannot be worn with it go to the inventory, and the clothes it had come back with the step that gives them back. |
| `Nelim's Pickle Tools: {string} head type is {string}` (Given) | Gives a colonist a head (a `HeadTypeDef` name, e.g. Male_AverageNormal) and redraws it. The def must suit the colonist's gender. |
| `Nelim's Pickle Tools: {string} beard is {string}` (Given) | Gives a colonist a beard (a `BeardDef` name) or `none`, and redraws it. Refuses a beard for a pawn that has no style tracker. The failure lists the valid beard defs. |
| `Nelim's Pickle Tools: the other colonists are out of frame` (Given) | Moves every colonist that no "stands at" step has placed in this scenario to a standable cell far from the camera (the corner of the map farthest from the first subject, or the map's far corner when there is none), so the studio's actors are out of the picture. Each is put back where it stood after the scenario. |
| `Nelim's Pickle Tools: {string} has gender {word}` (Then) | Asserts a pawn's gender, `male` or `female`, case insensitive. |
| `Nelim's Pickle Tools: {string} has body type {word}` (Then) | Asserts a pawn's body type by def name, case insensitive. |
| `Nelim's Pickle Tools: {string} has xenotype {string}` (Then) | Asserts a pawn's xenotype by def name, case insensitive. A pawn with a custom xenotype reads as the def it was built from, and the failure names the custom one. |
| `Nelim's Pickle Tools: {string} is of race {string}` (Then) | Asserts a pawn's race by def name, case insensitive: `Human`, or a race a mod adds. |
| `Nelim's Pickle Tools: {string} is at the {word} stage of life` (Then) | Asserts a pawn's stage of life: `Baby`, `Newborn`, `Child` or `Adult`, case insensitive. Needs Biotech for the first three. |

## DefFieldSteps

Package `nelim.pickletools.deffields`. Not in the bundle: a companion staged by a pass map. [README](../DefFieldSteps/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: def {string} of type {string} field {string} is {string}` (Then) | Finds the def of that type and name (`ThingDef`, `PawnKindDef`, any def type the game knows), walks the dotted path over its public fields and properties, and compares the value's text with the expected text, ignoring case |

## ExpansionSteps

Package `nelim.pickletools.expansions`. In the bundle (`Mod/Pickle/Assemblies`). [README](../ExpansionSteps/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the expansion {string} is active` (Then) | passes when `ModsConfig.IsActive(<packageId>)` is true |
| `Nelim's Pickle Tools: the expansion {string} is not active` (Then) | passes when it is false |

## FilmTicks

Package `nelim.pickletools.filmticks`. In the bundle (`Mod/Pickle/Assemblies`). [README](../FilmTicks/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: I film every {int} ticks as {string}` (When) | starts filming; the name is the film's folder in the report |
| `Nelim's Pickle Tools: I stop filming` (When) | waits ten frames for the last pictures to land, then encodes the video |

## HoverSteps

Package `nelim.pickletools.hoversteps`. In the bundle (`Mod/Pickle/Assemblies`). [README](../HoverSteps/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: I hover over the tooltip keyed {string}` (When) | Resolves the key with the game's own `Translate()`, hovers the region whose tooltip reads that, and waits for the tooltip to be drawn |
| `Nelim's Pickle Tools: I hover over the tooltip reading {string}` (When) | Hovers the region whose tooltip reads exactly this text, and waits for the tooltip to be drawn |
| `Nelim's Pickle Tools: I hover over the tooltip containing {string}` (When) | Hovers the region whose tooltip contains this text, and waits for it to be drawn; fails and lists the regions on screen if none or several match |
| `Nelim's Pickle Tools: the tooltip keyed {string} is drawn` (Then) | Asserts the tooltip whose text is the translation of this key is on screen now |
| `Nelim's Pickle Tools: the tooltip containing {string} is drawn` (Then) | Asserts a tooltip containing this text is on screen now |
| `Nelim's Pickle Tools: no tooltip is drawn` (Then) | Asserts no tooltip is on screen |

## IdeologySteps

Package `nelim.pickletools.ideologysteps`. Not in the bundle: a companion staged by a pass map. [README](../IdeologySteps/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the colony adopts an ideoligion with the memes {string} and the precepts {string}` (Given) | Builds an ideoligion from the memes (comma-separated MemeDef names) and the precepts (comma-separated PreceptDef names, added to the ones the memes require), gives it to every free colonist and makes it the primary ideoligion of the player faction. |
| `Nelim's Pickle Tools: the colonist {string} follows an ideoligion with the precepts {string}` (Given) | Gives one pawn (a colonist or a prisoner) an ideoligion of its own, built from the memes of the colony's primary ideoligion and the precepts asked for, so it follows a different faith from the colony's. Fails if the game would then change the colony's primary ideoligion, which happens when too few colonists follow the colony's. |
| `Nelim's Pickle Tools: the colonist {string} follows an ideoligion with the memes {string} and the precepts {string}` (Given) | Like the step without memes, for a faith whose memes differ from the colony's: the pawn follows an ideoligion made from exactly these memes and precepts. |
| `Nelim's Pickle Tools: the colony ideoligion has the precept {string}` (Then) | Asserts that the primary ideoligion of the colony holds a precept. |
| `Nelim's Pickle Tools: the colony ideoligion does not have the precept {string}` (Then) | Asserts that the primary ideoligion of the colony does not hold a precept. |
| `Nelim's Pickle Tools: the colonist {string} has the precept {string}` (Then) | Asserts that the ideoligion a colonist (or a prisoner) follows holds a precept. |
| `Nelim's Pickle Tools: the prisoner {string} is offered the interaction mode {string}` (Then) | Asserts that the prisoner tab lists the interaction mode for this prisoner. The test is the game's own: the local function of ITab_Pawn_Visitor.DoPrisonerTab that decides which rows the tab draws, called by reflection, not a copy. |
| `Nelim's Pickle Tools: the prisoner {string} is not offered the interaction mode {string}` (Then) | Asserts that the prisoner tab does not list the interaction mode for this prisoner (same test as the step that asserts it is offered). |
| `Nelim's Pickle Tools: a message {string} appeared` (Then) | Asserts that the game posted a message whose text is the translation of the key, since the scenario began. The key is compared, not an English sentence: the fixed text around the placeholders of the translation must appear in the message, in order, whatever the language and whatever fills the placeholders. |
| `Nelim's Pickle Tools: the colonist {string} is doing the job {string}` (Then) | Asserts that the job a colonist is doing now is this JobDef, by defName, waiting up to 30 seconds for it. |
| `Nelim's Pickle Tools: a prison cell is built at \({int}, {int}\) with a bed and a door` (Given) | Builds a prison cell whose south-west inside cell is (x, z): walls around a 3 by 3 inside, a door in the middle of the south wall, a prisoner bed, and a roof, then waits for the game to class the room as a prison cell. Plants and filth in the way are cleared. |
| `Nelim's Pickle Tools: a prisoner {string} exists in the cell at \({int}, {int}\), in restraints` (Given) | Spawns a prisoner of the colony in the cell built at (x, z), assigns it the bed, and leaves it in restraints: `RestraintsUtility.InRestraints` is true, and the step fails if it is not. |
| `Nelim's Pickle Tools: a prisoner {string} exists in the cell at \({int}, {int}\), not in restraints` (Given) | The negative control of the step in restraints: the prisoner is released to roam (the "free" setting of the prisoner tab), so `RestraintsUtility.InRestraints` is false, and the step fails if it is not. |
| `Nelim's Pickle Tools: the prisoner {string} interaction mode is {string}` (Given) | Sets the exclusive interaction mode of a prisoner of the colony (Ideology's Convert, Reduce resistance, Recruit, Release, or a mode a mod adds) by PrisonerInteractionModeDef name, then reads it back. It sets the same field the prisoner tab sets, without the tab's warnings. |
| `Nelim's Pickle Tools: the colonist {string} has the work type {string} enabled` (Given) | Enables one work type of a colonist (priority 3, or 1 when the colony does not use priorities) and leaves the others as they are. |
| `Nelim's Pickle Tools: the colonist {string} has the work type {string} disabled` (Given) | Disables one work type of a colonist (priority 0) and leaves the others as they are. |

## InspectTabs

Package `nelim.pickletools.inspecttabs`. In the bundle (`Mod/Pickle/Assemblies`). [README](../InspectTabs/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: I open the {string} inspect tab` (When) | Opens an inspect tab on the selected thing, naming it by type or label key. |
| `Nelim's Pickle Tools: I select the thing of def {string} at \({int}, {int}\)` (When) | Selects the one thing of a def on a cell, language independent: Pickle's own `I select {string}` takes a label, which is text in the language of the run. Clears the selection first. A cell with none, or with two of that def, is refused, and the message lists what the cell holds, so the scenario never selects "one of them" by luck. |
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
| `Nelim's Pickle Tools: I click the gizmo keyed {string}` (When) | Runs the gizmo of the current selection whose label is the translation of a key, the way Pickle's `I click gizmo {string}` runs the one whose label it is given as text (same lookup, same `ProcessInput`), so a scenario passes in every language. |

## LoadAudit

Package `nelim.pickletools.loadaudit`. Not in the bundle: a companion staged by a pass map. [README](../LoadAudit/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the load of the mod {string} is clean` (Then) | `{string}` is the mod's packageId. Reads the game log **from the start of the game to now** and fails, listing the lines, when it holds what the four checks below find; also compares the mod's keyed translations with the active language. Attaches `load-audit`, a line saying what was read |
| `Nelim's Pickle Tools: the load of the mod {string} is clean, apart from {string}` (Then) | The same, leaving out every message whose text or stack contains the second text (ignoring case): a known message the owner justifies. Say why in the feature, next to the step |

## NewColony

Package `nelim.pickletools.newcolony`. Not in the bundle: a companion staged by a pass map. [README](../NewColony/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the new colony's seed is {string}` (Given) | The seed of the world; also seeds the draw of the starting tile and of the colonists. Default `picklecolony` |
| `Nelim's Pickle Tools: the new colony's map size is {int}` (Given) | Cells a side, 25 to 500. Default 75 |
| `Nelim's Pickle Tools: the new colony's scenario is {string}` (Given) | A `ScenarioDef` by name. Default `Crashlanded`; an unknown name fails and lists the scenarios the game has |
| `Nelim's Pickle Tools: the new colony's storyteller is {string}` (Given) | A `StorytellerDef`. Default `Cassandra` |
| `Nelim's Pickle Tools: the new colony's difficulty is {string}` (Given) | A `DifficultyDef`. Default `Rough` |
| `Nelim's Pickle Tools: a new colony is started` (Given) | From the main menu: sets the game up as the developer quick start does, with the choices below, generates the world (5 percent of the planet), picks a starting tile, then takes the last new-colony page's path (`PageUtility.InitGameStart`): the scene "Play" is loaded, the map is generated, the game is put on pause. |
| `Nelim's Pickle Tools: any open message dialog is accepted` (When) | Accepts every open dialog of the two kinds a scenario's own intro can be, the way a click on its first option or button would: `Dialog_MessageBox` (its accept action if it has one, then closed) and `Dialog_NodeTree` (its current node's first, non-disabled option: its action if it has one, closed if the option resolves the tree, moved... |
| `Nelim's Pickle Tools: the new colony's colonists have landed` (When) | The start step counts the colonists the map holds (`FreeColonistsCount`), which includes pawns still in a drop pod or a container. This one lets the game run, at the fast speed, until every one of them is spawned on the map, then pauses again. |

## ResearchSteps

Package `nelim.pickletools.research`. In the bundle (`Mod/Pickle/Assemblies`). [README](../ResearchSteps/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: I open the research tab {string}` (When) | By def name first, then by the label the tab is drawn with, in the language the game runs in. |
| `Nelim's Pickle Tools: I open the research tab keyed {string}` (When) | By translation key: the key is translated and the result is matched against the tabs' labels, so a scenario naming the key runs in any language. It only reaches a tab whose label comes from a Keyed string; a def's label injected by DefInjected has no key that `.Translate()` resolves. |
| `Nelim's Pickle Tools: the research window is on the tab {string}` (Then) | The window is on that tab, it drew a selected record for it, and its contents are revealed. |
| `Nelim's Pickle Tools: the research window labels the tab {string} as {string}` (Then) | The label of the tab's record, which the window built from `LabelCap` when it opened. |
| `Nelim's Pickle Tools: the research window lists the project {string}` (Then) | The project is one the window lists on its current tab: among the visible projects whose tab is the selected one, the very list `ListProjects` draws from, and not hidden. By def name or by label. |
| `Nelim's Pickle Tools: the research window lists the project {string} costing {int}` (Then) | The same, and its `Cost` |

## RimmsqolSteps

Package `nelim.pickletools.rimmsqol`. In the bundle (`Mod/Pickle/Assemblies`). [README](../RimmsqolSteps/README.md).  

| Step | Does |
| --- | --- |
| `RIMMSQOL's choices are kept for the next launch` (Given) | restart chain, see below |
| `the choices RIMMSQOL kept in the previous launch are in place` (Given) | First step of a launch that reads what the previous one kept. It refuses to pass when the writer ran in THIS process: that would be a restart test that never restarted, with the values still sitting in memory. It takes ownership of the kept choices, so the teardown of this launch puts them back unless this launch keeps them again. |
| `RIMMSQOL is ready to be driven` (Then) | RIMMSQOL loaded, its `SettingsInit` run, its `mainButtons` property set present |
| `RIMMSQOL's own list of main buttons offers {string}` (Then) | The claim is that a player, opening RIMMSQOL's "Main Buttons" list, finds the button. The list is built from every MainButtonDef whatever its visibility, so this is expected to hold; the entry's own label is logged because it is what the player reads there. |
| `RIMMSQOL shows the main button {string} as {word}` (Then) | What the Visible checkbox on the button's edit page reads, {word} being visible or hidden. |
| `RIMMSQOL holds no choice for the main button {string}` (Then) | the instance is not active (would not be saved or applied) |
| `RIMMSQOL reveals the main button {string}` (When) | `OnStartEditing`, `set("Visible", true)`, `OnStopEditing`, `WriteSettings`. Refuses if it already reads visible |
| `RIMMSQOL hides the main button {string}` (When) | the same with `false`. Refuses if it already reads hidden |
| `RIMMSQOL forgets its choice for the main button {string}` (When) | The reset cross beside the list entry: the choice is dropped and the def goes back to what its mod shipped. |
| `RIMMSQOL's settings file records the main button {string} as {word}` (Then) | reads the **file**, not memory: `visible`, or `hidden` (configured, not true) |
| `RIMMSQOL's settings file records no choice for the main button {string}` (Then) | no file, no entry, or no Visible choice in the entry |
| `the main bar draws the button {string}` (Then) | Both halves, because a def can be in the bar and dead: the bar visits it (Worker.Visible, hence a cell) and the worker is not Disabled, which is what turns the cell grey. MOD_SETTINGS.md forbids a greyed shortcut as firmly as a visible one. |
| `the main bar does not draw the button {string}` (Then) | it has no cell |
| `the main bar's button {string} is activated` (When) | What the bar's own click ends up calling. InterfaceTryActivate, not Activate: it is the method DoButton invokes, tutorial checks included. |
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
| `Nelim's Pickle Tools: the flower meadow studio is prepared` (Given) | Builds the flower meadow studio on the current map: the terrain, the plants (bonsai among them), the dry garden and the props the presentation captures are taken in |
| `Nelim's Pickle Tools: I frame the studio {string}` (When) | Points the camera at one named shot of the studio and sets its zoom |
| `Nelim's Pickle Tools: the flower meadow studio is intact` (Then) | Asserts the studio is still what it was built as: its plants and terrain are present |
| `Nelim's Pickle Tools: studio presentation mode is enabled` (When) | Turns on the game's screenshot mode for a presentation capture, remembering its previous state to put it back |
| `Nelim's Pickle Tools: I save the flower meadow studio` (When) | Saves the studio as the fixture `Nelim-Zen-Meadow-Studio` |

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
| `Nelim's Pickle Tools: the sound recorded as {string} is not silent` (Then) | Measures the loudest sample with ffmpeg's `volumedetect`: not silent means above -60 dB, silent below -80 dB |
| `Nelim's Pickle Tools: the sound recorded as {string} is silent` (Then) | The same measure, asserting the level is below -80 dB |
| `Nelim's Pickle Tools: the game volume is {int} percent` (Given) | Sets the game's master volume for the scenario (the WSL staging writes 0, which mutes the game) and puts the value found back afterwards; nothing is saved to disk |
| `Nelim's Pickle Tools: the game music volume is {int} percent` (Given) | The game's background music and its ambience, apart from the master volume: a recording that must hear only what a mod plays cannot use the master volume, which would cut the effects it wants to hear. `Prefs.VolumeMusic` and `Prefs.VolumeAmbient` store and apply at once, are not saved to disk here, and are put back after the scenario. |
| `Nelim's Pickle Tools: the game ambient volume is {int} percent` (Given) | The same for the ambience |
| `Nelim's Pickle Tools: the game music and ambience are muted` (Given) | Both at 0: a recording then holds what a mod plays and not the menu or map music (Anima Song measured a peak of -14.3 dB from the background music alone on a whole film) |

## StageDecor

Package `nelim.pickletools.stagedecor`. Not in the bundle: a companion staged by a pass map. [README](../StageDecor/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: I place the decor {string} at \({int}, {int}\)` (Given) | Places a thing of the def at a cell, made of its default stuff, and remembers it for removal. Fails naming the cell if it is off the map or already holds a pawn or a building (the game would otherwise wipe what stood there). |
| `Nelim's Pickle Tools: I lay the floor {string} from \({int}, {int}\) to \({int}, {int}\)` (Given) | Lays a floor (a TerrainDef: a carpet, a tile, soil) on every cell of the rectangle from the first corner to the second, and remembers what each cell held, so the removal step puts it back. Fails naming the first cell off the map or under a wall. |
| `Nelim's Pickle Tools: the decor {string} at \({int}, {int}\) is lit` (Given) | Makes a placed light-giving thing burn: fills its fuel when it is refuelable (a torch, a campfire) and switches it on when it has a switch, then waits up to 10 seconds for the game to say it glows. Fails if the thing at the cell has no light, or does not glow (a lamp that needs power on a network that gives none says so). |
| `Nelim's Pickle Tools: the roof is removed from \({int}, {int}\) to \({int}, {int}\)` (Given) | Takes the roof off a rectangle of cells (a test colony under a mountain roof is dark in a capture) and remembers each roof, so the removal step puts it back. A cell with no roof is left alone. |
| `Nelim's Pickle Tools: the area from \({int}, {int}\) to \({int}, {int}\) is cleared` (Given) | Takes every thing off a rectangle of cells (plants, filth, items, buildings, blueprints; not pawns, motes or projectiles) so the capture shows bare ground, and remembers each one: the removal step spawns the same instances back at their cell and rotation. Floors and roofs stay (use the floor and roof steps). |
| `Nelim's Pickle Tools: the decor is removed` (When) | Removes every thing the place step made and puts back every floor the lay step replaced, in one step. |

## TextureOwner

Package `nelim.pickletools.textureowner`. In the bundle (`Mod/Pickle/Assemblies`). [README](../TextureOwner/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: the texture {string} is answered by the mod {string}` (Then) | passes when the **last** running mod that ships the path is the one whose packageId is given |
| `Nelim's Pickle Tools: the texture {string} is shipped by at least {int} running mod(s)` (Then) | passes when at least that many running mods ship the path |

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
