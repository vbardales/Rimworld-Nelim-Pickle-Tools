# TailorMade Waistlines

Repository `TailorMadeWaistlines` (`nelim.tailormade.waistlines`), suite under `Tests/Pickle/`.

**Nothing listed here is live.** The suite has no step assembly today: its four assertion features
and the steps that served them were written on 2026-09-20 and removed the same evening, the suite
being left to captures only. The code is in that repository's history at commit **`9988515`**,
under `Tests/Pickle/Source/`, and it built warning-free against the stock Pickle.

They are recorded anyway, because the deletion did not make the questions go away: what a
running game alone can answer about a Harmony mod is the same list for the next mod that asks.
Every text below carried the mod's own name, so a copy needs no renaming beyond its own.

## Small and generic, candidates to move if a second mod wants them

| Steps | What they do, and what to know before copying |
| --- | --- |
| `TailorMade Waistlines patched {string}` | Splits `Type::Member`, resolves both with `AccessTools`, and asserts the mod's Harmony id is among `Harmony.GetPatchInfo(...).Owners`. On failure it names the owners it *did* find, which is what turns "the sliders do nothing" into "the method was renamed upstream". The id is a `const` in the step class; promoting it means passing an id. Work Studio has the same step with a hierarchy walk for a method a class does not declare — that version is the better base |
| `the TailorMade Waistlines shortcut is neither drawn nor greyed out` | Reads `MainButtonDef.buttonVisible`, then `Worker.Visible` **and** `Worker.Disabled`, because "hidden by default" is a drawn state and a greyed button fails that requirement as plainly as a shown one. This is the *before* to `RimmsqolSteps/`'s after: no customisation mod involved, nothing revealed. SkillIcons' `MainButtonBarSteps.cs` covers the same ground and its own note prefers `RimmsqolSteps` for the bar's layout; between the three, the only part unique here is asserting `Disabled` |
| `the settings window open is TailorMade Waistlines' own` | Reads the private `mod` field of `RimWorld.Dialog_ModSettings` and checks its type, so a shortcut that opens *someone else's* settings page fails instead of passing on "a settings window is open". Generalises to a packageId in one line |
| `every settings key resolves in the language the game runs in` | `key.CanTranslate()` over the keys the settings window draws, against `LanguageDatabase.activeLanguage`. This is the one half of the l10n gate that no file-level check can do: comparing the two `Keyed` folders on disk cannot know which language loaded, nor whether the game found the folder at all — on ext4 a mistyped folder name loses it silently. The key list is hard-coded in the step; a promoted version would read the mod's own Keyed file |

## Dedicated to this mod, no reuse expected

| Steps | What they do |
| --- | --- |
| `the band patch route is settled` | Reads the static flag the mod sets at startup after testing its own patch, attaches which of two routes is live, and fails if the startup self-test never logged — so the route is never reported from an untested default. The two-route fallback (a postfix, and a prefix for when Mono inlines the postfixed method) is this mod's design |
| `I let TailorMade bake what the map draws`, `TailorMade's fitted textures were swept`, `the pawns on the map are drawn again` | Counts TailorMade's own `TexBake.Stats()` before and after the settings window closes, to show the cache was emptied and refilled rather than a value merely changing. Reaches into another mod's internals |
| `the fitting that claims {string} is recorded`, `the band decides the fit of {string}` | Resolves `TailorMade.PatternRegistry.Resolve(race, bodyType, layer, def, femaleBody)` and reports which pattern claimed the garment — no pattern, one with `autoFit` true, or one with `autoFit` false, which means the band was never consulted. Written so a capture says on its own face which state produced it |
| `the settings file on disk holds {float} for the pants band`, `the mod reads its settings file again` | Writes through the mod's own `WriteSettings`, reads the file the game wrote, parses the value with an invariant culture, and reloads the way a restart does. SkillIcons' `VerificationSteps.cs` has the same round trip, generalised further |
| A `[BeforeScenario]`/`[AfterScenario]` settings sandbox | Copies the mod's settings file aside **as a file**, resets to defaults, and restores afterwards, so a run does not leave her sliders where a test left them; a game that dies mid-scenario leaves the backup, and the next scenario restores it before doing anything else. Deliberately avoids the mod's own `WriteSettings` for the reset, which would sweep TailorMade's texture cache and repaint a map that may not exist |

## Screenshot mode: historical code, not replaced by ClearScreen

`I hide the interface around the windows on screen` / `I bring the interface back` turned on the
game's screenshot mode and cleared `drawInScreenshotMode` on Pickle's own runner windows, restoring
from an `[AfterScenario]` as well. [`ClearScreen/`](../ClearScreen/README.md) closes non-Pickle windows;
it does not hide the HUD while keeping the window being photographed. For a live version of this screenshot
technique, inspect Work Studio's `ModSteps.cs` or Adaptive Storage Neolithic Renew's `PublicationSteps.cs`.

## Also worth knowing from this suite, without being steps

- Two sessions wrote this suite at once and split it: captures with vanilla steps only, assertions
  with an assembly. The assembly went; the split is why `Tests/Pickle/README.md` there reads as it
  does.
- The suite's passes are selected by `-DepMap wsl-deps.<pass>.map`, and a pass that names **no**
  map reads none at all — `Run-PickleWsl.ps1` sets `PICKLE_DEPMAP=none`, so there is no default
  file to put a line in. A tool needed by the bare pass goes in a map of its own
  (`wsl-deps.tools.map` there).
- AB's Visible Pants is inert on a profile with no settings file: its category list is filled only
  when that file is read or its Reset is pressed. Any suite that stages AB and photographs a pawn
  needs a seeded config, or it gets a green run of a bare pawn. That seed lives in
  `Tests/Pickle/config/`.
