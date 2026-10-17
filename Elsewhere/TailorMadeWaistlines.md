# TailorMade Waistlines

Repository `TailorMadeWaistlines` (`nelim.tailormade.waistlines`), suite under `Tests/Pickle/`.

**Nothing listed here live.** Suite has no step assembly today: four assertion features and steps serving them written 2026-09-20, removed same evening, suite left to captures only. Code in repo history at commit **`9988515`**, under `Tests/Pickle/Source/`, built warning-free against stock Pickle.

Recorded anyway, because deletion did not remove the questions: what running game alone can answer about Harmony mod is same list for next mod that asks. Every text below carried mod's own name, so copy needs no renaming beyond its own.

## Small and generic, candidates to move if a second mod wants them

| Steps | What they do, and what to know before copying |
| --- | --- |
| `TailorMade Waistlines patched {string}` | Split `Type::Member`, resolve both with `AccessTools`, assert mod's Harmony id among `Harmony.GetPatchInfo(...).Owners`. On failure name owners it *did* find, turning "sliders do nothing" into "method renamed upstream". Id is `const` in step class; promoting means passing an id. Work Studio has same step with hierarchy walk for method class does not declare: that version better base |
| `the TailorMade Waistlines shortcut is neither drawn nor greyed out` | Read `MainButtonDef.buttonVisible`, then `Worker.Visible` **and** `Worker.Disabled`, because "hidden by default" is a drawn state and greyed button fails requirement as plainly as shown one. This is *before* to `RimmsqolSteps/`'s after: no customisation mod involved, nothing revealed. SkillIcons' `MainButtonBarSteps.cs` covers same ground, its own note prefers `RimmsqolSteps` for bar layout; among the three, only unique part here is asserting `Disabled` |
| `the settings window open is TailorMade Waistlines' own` | Read private `mod` field of `RimWorld.Dialog_ModSettings`, check its type, so shortcut opening *someone else's* settings page fails instead of passing on "a settings window is open". Generalises to packageId in one line |
| `every settings key resolves in the language the game runs in` | `key.CanTranslate()` over keys settings window draws, against `LanguageDatabase.activeLanguage`. Only half of l10n gate no file-level check can do: comparing two `Keyed` folders on disk cannot know which language loaded, nor whether game found folder at all: on ext4 mistyped folder name loses it silently. Key list hard-coded in step; promoted version would read mod's own Keyed file |

## Dedicated to this mod, no reuse expected

| Steps | What they do |
| --- | --- |
| `the band patch route is settled` | Read static flag mod sets at startup after testing own patch, attach which of two routes live, fail if startup self-test never logged: route never reported from untested default. Two-route fallback (postfix, and prefix for when Mono inlines postfixed method) is this mod's design |
| `I let TailorMade bake what the map draws`, `TailorMade's fitted textures were swept`, `the pawns on the map are drawn again` | Count TailorMade's own `TexBake.Stats()` before and after settings window closes, show cache emptied and refilled rather than value merely changing. Reach into another mod's internals |
| `the fitting that claims {string} is recorded`, `the band decides the fit of {string}` | Resolve `TailorMade.PatternRegistry.Resolve(race, bodyType, layer, def, femaleBody)`, report which pattern claimed garment: no pattern, one with `autoFit` true, or one with `autoFit` false, meaning band never consulted. Written so capture says on own face which state produced it |
| `the settings file on disk holds {float} for the pants band`, `the mod reads its settings file again` | Write through mod's own `WriteSettings`, read file game wrote, parse value with invariant culture, reload the way restart does. SkillIcons' `VerificationSteps.cs` has same round trip, generalised further |
| A `[BeforeScenario]`/`[AfterScenario]` settings sandbox | Copy mod's settings file aside **as a file**, reset to defaults, restore afterwards, so run does not leave her sliders where test left them; game dying mid-scenario leaves backup, next scenario restores it before anything else. Deliberately avoids mod's own `WriteSettings` for reset, which would sweep TailorMade's texture cache and repaint map that may not exist |

## Screenshot mode: historical code, not replaced by ClearScreen

`I hide the interface around the windows on screen` / `I bring the interface back` turned on game's screenshot mode and cleared `drawInScreenshotMode` on Pickle's own runner windows, restoring from `[AfterScenario]` too. [`ClearScreen/`](../ClearScreen/README.md) closes non-Pickle windows; does not hide HUD while keeping window being photographed. For live version of this screenshot technique, inspect Work Studio's `ModSteps.cs` or Adaptive Storage Neolithic Renew's `PublicationSteps.cs`.

## Also worth knowing from this suite, without being steps

- Two sessions wrote suite at once and split it: captures with vanilla steps only, assertions with assembly. Assembly went; split is why `Tests/Pickle/README.md` there reads as it does.
- Suite's passes selected by `-DepMap wsl-deps.<pass>.map`, and pass naming **no** map reads none at all: `Run-PickleWsl.ps1` sets `PICKLE_DEPMAP=none`, so no default file to put a line in. Tool needed by bare pass goes in map of its own (`wsl-deps.tools.map` there).
- AB's Visible Pants inert on profile with no settings file: category list filled only when that file read or its Reset pressed. Any suite staging AB and photographing pawn needs seeded config, or gets green run of bare pawn. Seed lives in `Tests/Pickle/config/`.