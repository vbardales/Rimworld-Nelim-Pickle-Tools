# Creatures of Ki Renew

## Steps that live in a suite, and could be taken from there

Not tools yet: these are steps written for one suite that read as general, kept where they are until a second mod needs them.
Copy or promote them from there; a promoted step takes the `Nelim's Pickle Tools:` prefix.

| Where | What it gives a scenario |
| --- | --- |
| `CreaturesOfKiRenew/Tests/Pickle/Source/TeshiSteps.cs` (commit e69d20b) | **Two animals mate, frozen**: `Teshi Renew: the {word} adult teshi and the {word} adult teshi mate` turns the two toward each other (`FaceCell`) and throws the mating heart over each with `FleckMaker.ThrowMetaIcon(cell, map, FleckDefOf.Heart)`, as the game's `JobDriver_Mate` does. For two animals this is the right marker: Nuzzle is animal-to-human only. Generic for any pawn kind; the text is specific to teshi. Whether the fleck survives a paused game was being checked (ticket b63c) |
| the same file | **An animal carries an item, frozen**: `Teshi Renew: the {word} adult teshi carries {int} {string}` makes the thing and calls `pawn.carryTracker.TryStartCarry`; the carried meat shows in the animal's paws on `manual--workshop-4-the-meal--step0.png` (evidence `Tests/Pickle/Evidence/2026-10-06-gallery-story-6/screenshots`). Generic for any pawn kind |

Source: reported by the Creatures of Ki session on 2026-10-06, on Virginie's advice. Not read, compiled or run by this repository.
What is not available anywhere, checked 2026-10-06 in the game's debug actions and Pickle's `Docs/steps.md`: animal-to-animal Nuzzle,
giving an animal a job, hatching an egg (`CompHatcher.gestateProgress` is private; reflection needed).
