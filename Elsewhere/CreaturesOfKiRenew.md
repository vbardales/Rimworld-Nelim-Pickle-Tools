# Creatures of Ki Renew

## Steps that live in a suite, and could be taken from there

Not tools yet: steps written for one suite, read as general. Kept in place until second mod needs them.
Copy or promote from there; promoted step takes `Nelim's Pickle Tools:` prefix.

| Where | What it gives a scenario |
| --- | --- |
| `CreaturesOfKiRenew/Tests/Pickle/Source/TeshiSteps.cs` (commit e69d20b) | **Two animals mate, frozen**: `Teshi Renew: the {word} adult teshi and the {word} adult teshi mate` turns two toward each other (`FaceCell`), throws mating heart over each with `FleckMaker.ThrowMetaIcon(cell, map, FleckDefOf.Heart)`, like game's `JobDriver_Mate`. Right marker for two animals: Nuzzle is animal-to-human only. Generic for any pawn kind; text specific to teshi. Whether fleck survives paused game being checked (ticket b63c) |
| the same file | **An animal carries an item, frozen**: `Teshi Renew: the {word} adult teshi carries {int} {string}` makes thing, calls `pawn.carryTracker.TryStartCarry`; carried meat shows in animal's paws on `manual--workshop-4-the-meal--step0.png` (evidence `Tests/Pickle/Evidence/2026-10-06-gallery-story-6/screenshots`). Generic for any pawn kind |

Source: reported by Creatures of Ki session 2026-10-06, on Virginie's advice. Not read, compiled or run by this repository.
Not available anywhere, checked 2026-10-06 in game's debug actions and Pickle's `Docs/steps.md`: animal-to-animal Nuzzle,
giving animal a job, hatching egg (`CompHatcher.gestateProgress` private; reflection needed).