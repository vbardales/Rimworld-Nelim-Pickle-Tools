# Steps of Nelim's Pickle Tools

The Pickle steps this repository ships, one table per tool. **Pickle's own steps are in its catalogue:
[Docs/steps.md](https://github.com/RimWorks/Rimworld-Pickle/blob/main/Docs/steps.md)** (defs, mods, fixtures, pawns,
simulation, interface...); look there first, and here for what Pickle does not have. Every step here starts with
`Nelim's Pickle Tools:` so it can never be ambiguous with one of Pickle's, and is staged with one line of a pass map
("Using a tool from a suite" in the [README](../README.md)).

This file is **generated** from the `[Given]`, `[When]` and `[Then]` attributes of each tool's `Source/` and the first
sentences of the summary above them: do not edit it, run `docs/Generate-Steps.ps1` (`-Check` verifies that it is current).
80 steps. The keyword in brackets is the one the source declares; Pickle matches on the text alone, so a scenario may
use `Given`, `When`, `Then` or `And` as it reads best. What a step does not say here (its limits, what was played and what
was not) is in the tool's README.

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
| `Nelim's Pickle Tools: the button keyed {string} has stood still` (When) | Waits until the button has been drawn at the same place for a dozen frames in a row. |
| `Nelim's Pickle Tools: the button keyed {string} is reachable in {string}` (Then) | Hovers the button and asserts the window under the pointer is the named one, and that it receives input. |
| `Nelim's Pickle Tools: I click the button keyed {string} and the window {string} opens` (When) | Clicks the button and waits for the named window to open; when it does not, says what the click met. |

## ColonistRace

Package `nelim.pickletools.colonistrace`. In the bundle (`Mod/Pickle/Assemblies`). [README](../ColonistRace/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: {string} xenotype is {string}` (Given) | Gives a pawn a Biotech xenotype and redraws it. ) sets the body type as it goes. The endogenes the pawn was born with are kept, so a pawn already carrying one of those keeps it alongside the new ones. |
| `Nelim's Pickle Tools: {string} body type is {word}` (Given) | Gives a pawn a body type the game cannot draw at random: `Thin`, `Fat` or `Hulk`, or `Male` / `Female` (the plain body of that gender). The game keeps every body-type gene a pawn has and picks one at random each time the genes change, so a pawn with two of them (Hussar: Body_Standard and Body_Hulk) has no fixed body type. |
| `Nelim's Pickle Tools: a colonist {string} of kind {string} exists` (Given) | Generates a colonist from a humanlike PawnKindDef, the way "a colonist exists" does from the plain colonist kind, and does nothing if a colonist by that nickname already exists. The race is the kind's, so a kind from a race mod gives a pawn of that race, with that race's body types. |
| `Nelim's Pickle Tools: {string} has gender {word}` (Then) | Asserts a pawn's gender, `male` or `female`, case insensitive. |
| `Nelim's Pickle Tools: {string} has body type {word}` (Then) | Asserts a pawn's body type by def name, case insensitive. |
| `Nelim's Pickle Tools: {string} has xenotype {string}` (Then) | Asserts a pawn's xenotype by def name, case insensitive. A pawn with a custom xenotype reads as the def it was built from, and the failure names the custom one. |
| `Nelim's Pickle Tools: {string} is of race {string}` (Then) | Asserts a pawn's race by def name, case insensitive: `Human`, or a race a mod adds. |
| `Nelim's Pickle Tools: {string} is at the {word} stage of life` (Then) | Asserts a pawn's stage of life: `Baby`, `Newborn`, `Child` or `Adult`, case insensitive. Needs Biotech for the first three. |

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

## InspectTabs

Package `nelim.pickletools.inspecttabs`. In the bundle (`Mod/Pickle/Assemblies`). [README](../InspectTabs/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: I open the {string} inspect tab` (When) | Opens an inspect tab on the selected thing, naming it by type or label key. |
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

## ResearchSteps

Package `nelim.pickletools.research`. In the bundle (`Mod/Pickle/Assemblies`). [README](../ResearchSteps/README.md).  

| Step | Does |
| --- | --- |
| `Nelim's Pickle Tools: I open the research tab {string}` (When) | By def name first, then by the label the tab is drawn with, in the language the game runs in. |
| `Nelim's Pickle Tools: I open the research tab keyed {string}` (When) | By translation key: the key is translated and the result is matched against the tabs' labels, so a scenario naming the key runs in any language. Translate()` resolves. |
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
| `the main bar draws the button {string}` (Then) | Visible, hence a cell) and the worker is not Disabled, which is what turns the cell grey. md forbids a greyed shortcut as firmly as a visible one. |
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
| `Nelim's Pickle Tools: I stop filming with sound` (When) | Ends both, has Pickle's encoder make the video from the pictures at the rate they were taken (so it lasts as long as the sound), and puts the sound into it: `film-sound.mp4`, H.264 and AAC, which Windows plays as it is, in `screenshots/film/pickletools-sound--<name>/`; it also keeps `sound.wav` and Pickle's silent `film.webm`. The soun... |
| `Nelim's Pickle Tools: the sound recorded as {string} is not silent` (Then) | Measures the loudest sample with ffmpeg's `volumedetect`: not silent means above -60 dB, silent below -80 dB |
| `Nelim's Pickle Tools: the sound recorded as {string} is silent` (Then) | The same measure, asserting the level is below -80 dB |
| `Nelim's Pickle Tools: the game volume is {int} percent` (Given) | Sets the game's master volume for the scenario (the WSL staging writes 0, which mutes the game) and puts the value found back afterwards; nothing is saved to disk |

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
