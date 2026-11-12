# Flavor Text Extended - Français's steps

Where: `FlavorText/FlavorTextExtendedFR/Tests/Pickle/Source/` (`SettingsSteps.cs`, `ShortcutSteps.cs`,
`LanguageSteps.cs`, `MealSteps.cs`, `CookingSteps.cs`, `CategorySteps.cs`, `Driver.cs`), one steps assembly staged by
companion mod in `Tests/Pickle/Mod/`. Written, built against shipped assemblies 2026-09-21; state as read
that day. Mod's own Git repo: `Rimworld-Flavor-Text-Extended-Francais`.

## Dedicated to the mod: nobody else has a use for these

| Family | File | What it does |
|---|---|---|
| Naming a meal | `MealSteps.cs` | `the meal at ({int}, {int}) is named by Flavor Text in the language this pass runs`: requires hekmo's `CompFlavor`, label shape `<dish> (<plain label>)`, no `{` `}`, and, per pass language, no English side-dish connector in French or no French complement in English. Logs name |
| A cooked meal | `CookingSteps.cs` | `a cooked meal lies in the colony and is named by Flavor Text in the language this pass runs`: same assertion on first spawned meal carrying `CompFlavor` |
| Category overrides | `CategorySteps.cs` | `the inflections override of category {string} reads {string}` / `does not read`: reads `FlavorCategoryDef`'s internal `inflectionsOverride` by reflection, joins with ` \| ` |
| The mod's settings | `SettingsSteps.cs` | hekmo's five static settings: `the Flavor Text ingredient cap is set to {int}` / `reads {int}`, `the Flavor Text quick search is set to {word}` / `reads {word}`, `the Flavor Text settings are at their documented defaults`, `the Flavor Text settings are written to disk` (calls `FlavorTextMod.WriteSettings()`, what restart then reads) |
| The mod's own label | `LanguageSteps.cs` | `the Flavor Text ingredient cap label reads as written for the language this pass runs`: `"numAllowedMissingIngredients".Translate(3)` against English or French text |

Every phrase above starts with `the Flavor Text`, `the meal ... Flavor Text` or `a cooked meal`, so none collides with another suite.

## Small, and possibly useful to another suite

**Unprefixed text is marked. Two suites declaring same text make every scenario using it "Ambiguous step".**

**1. The contract of a hidden MainButtons shortcut** (`ShortcutSteps.cs`, def name `FTFR_Settings` is constant there)
`the FTFR shortcut is hidden on a clean configuration` (`MainButtonDef.buttonVisible` false, then `Worker.Visible` false),
`... is revealed, as a customization mod would` / `... is hidden again` (sets `buttonVisible`, field RIMMSQOL moves,
without RIMMSQOL), `... is drawn in the bar` (`Worker.Visible` and not `Worker.Disabled`: MOD_SETTINGS.md forbids greyed
shortcut as firmly as shown one), `... is not drawn in the bar`, `... is activated` (`Worker.Activate()`).
*Overlap:* same criterion in TailorMade Waistlines' suite (`neither drawn nor greyed out`), in SkillIcons'
(`Tests/Pickle/.../09-mainbuttons-shortcut.feature`), in Fieldwork Companions' `ShortcutSteps.cs`: four
copies. `RimmsqolSteps/` asserts what bar draws after RIMMSQOL reveals it (`the main bar draws the button {string}`):
check whether it already covers "drawn" and "not drawn". *To lift:* take def name as parameter, prefix text
(`Nelim's Pickle Tools: ...`). Case for promotion.

**2. A settings dialog that belongs to this mod** (`SettingsSteps.cs`)
`I open the FTFR settings dialog`: `Find.WindowStack.Add(new Dialog_ModSettings(mod))`, then waits **frames**, because
dialog force-pauses game and tick wait can never be satisfied. `the FTFR settings dialog is open for this mod`:
finds first private field of `Dialog_ModSettings` whose type is `Mod` (name moved between game versions), compares with
this mod's instance, so shortcut opening *someone else's* page fails. Miss lists existing fields. *Overlap:* TailorMade's `the settings window open is {mod}'s own`, Fieldwork Companions' `I open the Fieldwork
Companions settings dialog`. *To lift:* take mod type or packageId as parameter, prefix text.

**3. Every key the mod owns exists in the language the pass runs** (`LanguageSteps.cs`)
`every FTFR text exists in the language this pass runs`: every key of English Keyed resources with mod's prefix must
have text in **active** language (`HaveTextForKey`), so key added without French entry fails even if suite never
heard of it. Counts keys first, so empty filter cannot pass. In-game half of l10n gate.
*Overlap:* Fieldwork Companions has same (`every Fieldwork Companions text exists in the language this pass runs`).
*To lift:* take key prefix and expected count as parameters.

**4. A cooking bench that works** (`CookingSteps.cs`)
`a fuelled stove stands at ({int}, {int})` (**unprefixed**): spawns `FueledStove`, gives player faction, fills its
`CompRefuelable` to capacity. No stock step does, and unfuelled stove never starts a bill, so every cooking scenario times
out. Used with Pickle's own `I add bill ... to the ...` and `I wait for bill ... to finish`. *Overlap:* none found in
PickleTools. *To lift:* prefix text; reads nothing of this mod.

**5. A meal of chosen ingredients, and looking at it** (`MealSteps.cs`)
`a fine meal made of {string} and {string} lies at ({int}, {int})` and `a lavish meal made of {string}, {string}, {string} and
{string} lies at ...` (**unprefixed**): `ThingMaker.MakeThing` a meal, `CompIngredients.RegisterIngredient` each def, `GenSpawn.Spawn`.
Anything naming or rating a meal from ingredients runs on it exactly as on cooked one, without colonist; lavish
meal has four ingredients side dishes need. `I select the meal at ({int}, {int})` (**unprefixed**): `Find.Selector.Select`, then
`MainTabsRoot.SetCurrentTab(Inspect)`, then five frames. `I open the info card of the meal at ({int}, {int})` (**unprefixed**):
`new Dialog_InfoCard(thing)`, because inspect pane cuts long name ("Burger à la viande d'écureuil, façon...") and shows no
description while card shows both in full; logs name and description. `the meal at ({int}, {int}) does not show the
internal name {string}` (**unprefixed**): neither label nor `DescriptionDetailed` contains def name.
*Overlap:* `InspectTabs/` opens named inspect tab; selecting thing first is the part it does not do. *To lift:* prefix
texts; "meal" can become "thing at a cell" for last three.

**6. Check-Steps.ps1** (`Tests/Pickle/Check-Steps.ps1`, script, not step)
Compiles every step pattern with Pickle's own Cucumber engine, matches every feature line against them, in two seconds,
because one invalid pattern makes whole run play zero scenarios. Copied from Fieldwork Companions' suite: same
file in at least two. *To lift:* belongs in `Headless/` or beside `Nelim's Pickle Tools`.

## What Pickle's own steps cannot see (found by a real run, 2026-09-21)

Not a step of this suite; worth knowing before anyone writes assertion the obvious way.

- **`def {string} was patched by mod {string}` cannot see patch applied through wrapper `PatchOperation`.** Mod wraps
  ordinary operations in custom class (`PatchOperationFrench`, holding `PatchOperationSequence`) deciding by language.
  For def that operation had certainly changed, step reported `patched by (no mod)`. So `no def {string} was
  patched` also passes for such def, so "isolation" scenario written with it **proves nothing**. Assert value def
  holds afterwards (step 3 of table above shows how).
- **Dotted field path takes no numeric index into list.** `def "X" field "inflectionsOverride.0" is ...` fails with `List has
  no field or property '0'`. List must be read whole, by step knowing its type.
- **Bug offline tests could not see, Pickle run did.** Mod compared stored language name to `"French"`; real
  game stores `French (Français)`, so language guard never matched. Every offline test fed it `"French"`. Any mod
  branching on `Prefs.LangFolderName` should have one scenario reading what running game holds, not what test double
  was given. Rule game itself uses to match mod's `Languages` folder is `LoadedLanguage.LegacyFolderName`: part
  before bracket.