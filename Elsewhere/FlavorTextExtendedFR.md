# Flavor Text Extended - Français's steps

Where: `FlavorText/FlavorTextExtendedFR/Tests/Pickle/Source/` (`SettingsSteps.cs`, `ShortcutSteps.cs`,
`LanguageSteps.cs`, `MealSteps.cs`, `CookingSteps.cs`, `CategorySteps.cs`, `Driver.cs`), one steps assembly staged by the
companion mod in `Tests/Pickle/Mod/`. Written and built against the shipped assemblies on 2026-09-21; state as read
that day. The mod's own Git repository is `Rimworld-Flavor-Text-Extended-Francais`.

## Dedicated to the mod: nobody else has a use for these

| Family | File | What it does |
|---|---|---|
| Naming a meal | `MealSteps.cs` | `the meal at ({int}, {int}) is named by Flavor Text in the language this pass runs`: requires hekmo's `CompFlavor`, a label of the shape `<dish> (<plain label>)`, no `{` `}`, and, per the pass language, no English side-dish connector in French or no French complement in English. Logs the name |
| A cooked meal | `CookingSteps.cs` | `a cooked meal lies in the colony and is named by Flavor Text in the language this pass runs`: the same assertion on the first spawned meal that carries `CompFlavor` |
| Category overrides | `CategorySteps.cs` | `the inflections override of category {string} reads {string}` / `does not read`: reads `FlavorCategoryDef`'s internal `inflectionsOverride` by reflection and joins it with ` \| ` |
| The mod's settings | `SettingsSteps.cs` | hekmo's five static settings: `the Flavor Text ingredient cap is set to {int}` / `reads {int}`, `the Flavor Text quick search is set to {word}` / `reads {word}`, `the Flavor Text settings are at their documented defaults`, `the Flavor Text settings are written to disk` (calls `FlavorTextMod.WriteSettings()`, what a restart then reads) |
| The mod's own label | `LanguageSteps.cs` | `the Flavor Text ingredient cap label reads as written for the language this pass runs`: `"numAllowedMissingIngredients".Translate(3)` against the English or French text |

Every phrase above starts with `the Flavor Text`, `the meal ... Flavor Text` or `a cooked meal`, so none collides with another suite.

## Small, and possibly useful to another suite

**Unprefixed text is marked. Two suites declaring the same text make every scenario that uses it "Ambiguous step".**

**1. The contract of a hidden MainButtons shortcut** (`ShortcutSteps.cs`, the def name `FTFR_Settings` is a constant there)
`the FTFR shortcut is hidden on a clean configuration` (`MainButtonDef.buttonVisible` is false, then `Worker.Visible` is false),
`... is revealed, as a customization mod would` / `... is hidden again` (sets `buttonVisible`, the field RIMMSQOL moves,
without RIMMSQOL), `... is drawn in the bar` (`Worker.Visible` and not `Worker.Disabled`: MOD_SETTINGS.md forbids a greyed
shortcut as firmly as a shown one), `... is not drawn in the bar`, `... is activated` (`Worker.Activate()`).
*Overlap:* the same criterion is in TailorMade Waistlines' suite (`neither drawn nor greyed out`), in SkillIcons'
(`Tests/Pickle/.../09-mainbuttons-shortcut.feature`) and in Fieldwork Companions' `ShortcutSteps.cs`, which makes four
copies. `RimmsqolSteps/` asserts what the bar draws after RIMMSQOL reveals it (`the main bar draws the button {string}`):
check whether it already covers "drawn" and "not drawn". *To lift:* take the def name as a parameter and prefix the text
(`Nelim's Pickle Tools: ...`). This is the case for promotion.

**2. A settings dialog that belongs to this mod** (`SettingsSteps.cs`)
`I open the FTFR settings dialog`: `Find.WindowStack.Add(new Dialog_ModSettings(mod))`, then waits **frames**, because the
dialog force-pauses the game and a tick wait can never be satisfied. `the FTFR settings dialog is open for this mod`:
finds the first private field of `Dialog_ModSettings` whose type is `Mod` (its name has moved between game versions) and
compares it with this mod's instance, so a shortcut that opens *someone else's* page fails. A miss lists the fields that
exist. *Overlap:* TailorMade's `the settings window open is {mod}'s own`, Fieldwork Companions' `I open the Fieldwork
Companions settings dialog`. *To lift:* take the mod type or packageId as a parameter, prefix the text.

**3. Every key the mod owns exists in the language the pass runs** (`LanguageSteps.cs`)
`every FTFR text exists in the language this pass runs`: every key of the English Keyed resources with the mod's prefix must
have text in the **active** language (`HaveTextForKey`), so a key added without a French entry fails even if the suite never
heard of it. It counts the keys first, so an empty filter cannot pass. The in-game half of the l10n gate.
*Overlap:* Fieldwork Companions has the same (`every Fieldwork Companions text exists in the language this pass runs`).
*To lift:* take the key prefix and the expected count as parameters.

**4. A cooking bench that works** (`CookingSteps.cs`)
`a fuelled stove stands at ({int}, {int})` (**unprefixed**): spawns `FueledStove`, gives it the player faction and fills its
`CompRefuelable` to capacity. No stock step does, and an unfuelled stove never starts a bill, so every cooking scenario times
out. Used with Pickle's own `I add bill ... to the ...` and `I wait for bill ... to finish`. *Overlap:* none found in
PickleTools. *To lift:* prefix the text; it reads nothing of this mod.

**5. A meal of chosen ingredients, and looking at it** (`MealSteps.cs`)
`a fine meal made of {string} and {string} lies at ({int}, {int})` and `a lavish meal made of {string}, {string}, {string} and
{string} lies at ...` (**unprefixed**): `ThingMaker.MakeThing` a meal, `CompIngredients.RegisterIngredient` each def, `GenSpawn.Spawn`.
Anything that names or rates a meal from its ingredients runs on it exactly as on a cooked one, without a colonist; the lavish
meal has the four ingredients side dishes need. `I select the meal at ({int}, {int})` (**unprefixed**): `Find.Selector.Select`, then
`MainTabsRoot.SetCurrentTab(Inspect)`, then five frames. `I open the info card of the meal at ({int}, {int})` (**unprefixed**):
`new Dialog_InfoCard(thing)`, because the inspect pane cuts a long name ("Burger à la viande d'écureuil, façon...") and shows no
description while the card shows both in full; logs the name and the description. `the meal at ({int}, {int}) does not show the
internal name {string}` (**unprefixed**): neither the label nor `DescriptionDetailed` contains the def name.
*Overlap:* `InspectTabs/` opens a named inspect tab; selecting the thing first is the part it does not do. *To lift:* prefix
the texts; "meal" can become "thing at a cell" for the last three.

**6. Check-Steps.ps1** (`Tests/Pickle/Check-Steps.ps1`, a script, not a step)
Compiles every step pattern with Pickle's own Cucumber engine and matches every feature line against them, in two seconds,
because one invalid pattern makes a whole run play zero scenarios. Copied from Fieldwork Companions' suite, so it is the same
file in at least two. *To lift:* it belongs in `Headless/` or beside `Nelim's Pickle Tools`.

## What Pickle's own steps cannot see (found by a real run, 2026-09-21)

Not a step of this suite; worth knowing before anyone writes the assertion the obvious way.

- **`def {string} was patched by mod {string}` cannot see a patch applied through a wrapper `PatchOperation`.** This mod wraps
  ordinary operations in a custom class (`PatchOperationFrench`, holding a `PatchOperationSequence`) that decides by language.
  For a def that operation had certainly changed, the step reported `patched by (no mod)`. It follows that `no def {string} was
  patched` also passes for such a def, so an "isolation" scenario written with it **proves nothing**. Assert the value the def
  holds afterwards (step 3 of the table above shows how).
- **A dotted field path takes no numeric index into a list.** `def "X" field "inflectionsOverride.0" is ...` fails with `List has
  no field or property '0'`. A list has to be read whole, by a step that knows its type.
- **A bug the offline tests could not see, and a Pickle run did.** The mod compared the stored language name to `"French"`; a
  real game stores `French (Français)`, so the language guard never matched. Every offline test fed it `"French"`. Any mod that
  branches on `Prefs.LangFolderName` should have one scenario that reads what the running game holds, not what a test double
  was given. The rule the game itself uses to match a mod's `Languages` folder is `LoadedLanguage.LegacyFolderName`: the part
  before the bracket.
