# Steps that live in a mod's own repository

**Not a tool.** This is the ledger of Pickle steps that exist, are written and are *not* here:
they sit in one mod's own `Tests/Pickle/Source/`, or only in its history, because they were judged
specific to that mod or too small to be worth a package of their own.

It exists for one reason: **a step that nobody can find gets written twice.** A mod that needs one
of the things below should come here first, read what it did, and then either lift it from the
repository named or ask for it to be promoted into a package beside this file.

A step is promoted when a second mod needs it. Until then, keeping it in the mod that needed it
first is cheaper than maintaining a package — but saying so out loud is what makes that choice
reversible rather than a loss.

## TailorMade Waistlines

Repository: `TailorMadeWaistlines` (`nelim.tailormade.waistlines`), suite under `Tests/Pickle/`.

Its four assertion features and the step assembly that served them were written on 2026-09-20 and
**removed the same evening**, the suite being left to captures only. Nothing of this is live: the
code is in that repository's history at commit `9988515`, `Tests/Pickle/Source/`, and it built
warning-free against the stock Pickle at the time.

| Step | What it did | Generic? |
| --- | --- | --- |
| `TailorMade Waistlines patched {string}` | Reads `Harmony.GetPatchInfo` on a `Type::Member` written as one string and asserts the mod's Harmony id is among the owners. Names the owners it did find when it fails, which is what turns "the sliders do nothing" into "the method was renamed upstream" | **Yes** — any mod that patches another mod's internals wants this, and a renamed target fails silently otherwise |
| `the band patch route is settled` | Reads a static flag the mod sets at startup after testing its own patch, attaches which of two routes is live, and fails if the startup self-test never logged — so the route is never reported from an untested default | No. The two-route fallback is this mod's design |
| `the TailorMade Waistlines shortcut is neither drawn nor greyed out` | Reads `MainButtonDef.buttonVisible`, then `Worker.Visible` and `Worker.Disabled`, because "hidden by default" is a drawn state and a greyed button fails the same requirement as a shown one | **Yes** — every mod with a hidden MainButtons shortcut has this exact criterion. `RimmsqolSteps/` asserts what the bar draws after RIMMSQOL reveals it; this is the before, without RIMMSQOL |
| `the settings window open is {mod}'s own` | Reads the private `mod` field of `Dialog_ModSettings` and checks the type, so a shortcut that opens *someone else's* settings page fails | **Yes**, trivially generalised to a packageId |
| `every settings key resolves in the language the game runs in` | `key.CanTranslate()` over the keys the settings window draws, against the language actually loaded — which a file-level check outside the game cannot know, and which a mistyped `Languages` folder name silently loses | **Yes** — the one in-game half of the l10n gate |
| `I let TailorMade bake what the map draws` / `TailorMade's fitted textures were swept` / `the pawns on the map are drawn again` | Counts TailorMade's own `TexBake.Stats()` before and after closing the settings window, to prove the cache was emptied and refilled rather than a value merely changing | No. Reaches into TailorMade |
| `the fitting that claims {string} is recorded` / `the band decides the fit of {string}` | Resolves `TailorMade.PatternRegistry.Resolve` for a garment and reports which pattern claimed it, so a capture says on its own face whether the band or a native-fit pattern produced the image | No. Reaches into TailorMade |
| `the settings file on disk holds {float} for {field}` / `the mod reads its settings file again` | Writes through the mod's own `WriteSettings`, reads the file the game wrote, and reloads it the way a restart does | Half. The shape is generic; the field names are not |
| `I hide the interface around the windows on screen` / `I bring the interface back` | Turns on the game's screenshot mode and clears `drawInScreenshotMode` on Pickle's own runner windows, which otherwise sit in the corner of every capture. Restored from an `[AfterScenario]` too, so a scenario that dies does not leave the game without its interface | **Superseded** — `ClearScreen/` carries Pickle PR #21 and does this properly |

The four marked **Yes** are the ones worth asking for. None has a second taker yet, which is why
none is a package.

## How to add a mod here

One section per repository, one row per step: the step text as a scenario writes it, what it
actually reads (the field, the method, the file — not the intention), and whether it is generic.
Say where it lives: a path if it is live, a commit if it is only in the history. A row that cannot
name what its step reads is a row nobody can act on.
