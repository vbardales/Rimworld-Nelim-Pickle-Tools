# Facial animations on a colonist (Nals Facial Animation)

Draft of 2026-10-08, filled as the gallery photos are read. Only groups seen on a photo are described as seen; the others say "not seen yet".
Photos: Nelim of the save `Nelims-tribe`, temperature held at 20 degrees, every animation played as `normal+<name>` (a neutral face with the animation on top), zoom 4.

## How to play one

```gherkin
Given Nelim's Pickle Tools: the temperature of the map is 20 degrees
And Nelim's Pickle Tools: I let 10 ticks pass
And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
When Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
```

- The name is a `FaceAnimationDef` name. A wrong name fails and prints the valid ones. Names joined by `+` play together; for each part of the face the last one wins.
- Start with `normal`: it clears the heat face (sweat) that the room temperature would otherwise leave on the pawn.
- Let ticks pass BEFORE placing the pawn: the scene is paused, and without ticks nothing is recalculated. The pawn wanders during the ticks, so place her afterwards.
- The temporary animation ends when its frames have run out (it counts game ticks, it holds while the game is paused).
- To list the animations your mod list defines: step `Nelim's Pickle Tools: the facial animations are listed` (log lines `[face-animations]`).

## The 55 animations of the standard set, by group

Defined by `[NL] Facial Animation - Experimentals` (43), `[NL] Facial Animation - WIP` (9) and 3 without a mod name (`Lovin3`, `MVE_UnconsciousDowned`, `Thought_Tired`).

| Group | Animations | What the photo shows |
|---|---|---|
| Fight | `AttackMelee`, `AttackMelee2`, `AttackStatic`, `AttackStatic2` | Slanted brows, hard look; flat mouth (`...2`) or small open mouth. |
| Work and movement, calm face | `blink`, `DoBill`, `DoBill2`, `eyeFlicker`, `eyeMoving`, `eyeMoving2`, `Goto`, `Haul`, `Haul2` | Calm face, small smile. The difference between them is the eyes and brows only, subtle: a still photo does not tell them apart well; they are made for the movement. |
| Fear | `FleeAndCower` | Open mouth, shadow on the forehead. Reads as fear. |
| Not seen yet | `HaulSub`, `HaulSub2`, `Lovin*`, `mood*`, `NLR-*`, `painHigh`, `Reading*`, `ReceivedAnAttack01`, `Thought_*`, `Wait*`, `Ingest`, `laydown*`, `Mine`, `Research*`, `SocialRelax`, `StandAndBeSociallyActive` | Gallery parts 2 to 4. |

## Known traps

- `NLR-Smile` and `NLR-Sad` stacked on `normal` showed no change on the photos (run `669b`); `NLR-Blush` and `NLR-Open` did.
- Heat: the sweat is gone with the temperature held, ticks passed and the pawn placed afterwards (run `7682`, read by the owner); a soft blush on the cheeks stays, cause not established (maybe the blush animation).
- Face parts and kits (`mouth is`, `lids are`, `face kit is`) use def names that depend on the loaded mods; a mod list that lacks the def makes the step fail and print the valid names.
- Eye colour by `eye colour is rgb (...)` changes what the controller stores but not what is drawn on Nelim: use the genes.

![Part 1](img/animations-part1.png)
