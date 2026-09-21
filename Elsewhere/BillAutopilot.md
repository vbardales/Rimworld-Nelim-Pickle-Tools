# Bill Autopilot

Repository `BillAutopilot`, folder `Tests/Pickle/Source/`, 87 steps over eight files. Nineteen features, written
2026-09-21, **no verdict yet**: three runs, the best of them `exitReason: watchdog-timeout` at 26 scenarios of 65.
Three features are green (loading, activation, the marker in the bill label).

Every phrase carries `Bill Autopilot` somewhere, or the name of the neighbour it drives (`Better Workbench
Management …`, `Nice Bill Tab's row cache …`, `a Dubs Mint Menus bench template …`). Checked, not assumed: the
suite's `Check-Steps.ps1` matches all 87 against 568 other expressions — 205 read out of Pickle's assemblies, 363
from 20 step sources in the collection — and reports none ambiguous.

## Small and generic, candidates to move if a second mod wants them

| File | Steps | What they do, and what to know before copying |
| --- | --- | --- |
| `StockSteps.cs` | `the Bill Autopilot test stockpile holds {int} {string}` | **An exact colony stock of a thing, on any map, proved to be counted.** Finds its own room (spiral from map centre, skipping zoned, built-on and unstandable cells), labels its zone so a reload finds it again, destroys every existing stack of that def so the number is the scenario's and not the fixture's, then **re-reads the count through the game's own `ResourceCounter` and fails if it disagrees**. The most reusable thing here: any mod whose behaviour hangs on a stock threshold needs it. Two lessons are paid for and baked in — `GenPlace.TryPlaceThing` **refuses** a cell and returns `false`, and ignoring that answer spawned nothing and surfaced three steps later as "the autopilot counts 0, not 30", which reads as a broken threshold in the mod; and a stack outside storage exists and counts for nothing, so the step must verify, not assume. Refuses a def made from stuff. |
| `BillSteps.cs` | `the bills tab of the Bill Autopilot bench {string} at \({int}, {int}\) is opened` | Select a thing **by cell** and open one of its `ITab`s (`InspectPaneUtility.OpenTab`), waiting frames rather than ticks. By cell because `I select {string}` matches a displayed name, which is translated: a scenario spelling "hand tailoring bench" finds nothing in a French pass. `InspectTabs/` covers a **pawn's** tabs and is preferred for those; this is the thing-ITab case. |
| `ActivationSteps.cs` | `Bill Autopilot asks before taking the recipes it would take on {string}` | **Assert a `Dialog_MessageBox` by rebuilding its whole sentence from the mod's own translation keys**, rather than searching it for a number. Three reasons worth stealing: an argument inside a translated sentence makes a substring search for "25" also match 250; rebuilding through `.Translate()` holds in whatever language the pass runs in; and taking the expected count from the mod's own calculation turns the check into "the number shown IS the number about to be taken". |
| `ActivationSteps.cs` | `the Bill Autopilot confirmation is accepted` / `… is refused` | Run a `Dialog_MessageBox`'s own `buttonAAction` instead of clicking it. Deliberate: the button is labelled in the game's language, and a Pickle click goes to whatever window owns the point, so another mod's window over the dialog would report a dead button rather than a covered one. |
| `LetterSteps.cs` | `Bill Autopilot has announced {string} on {string}`, `… has not announced …` | Assert a letter by **rebuilding the line the mod puts in it** from its own key, and waiting for it rather than counting ticks. The negative form is the one that cost something: it first asserted "the letter stack is empty" and failed two scenarios on `Fallen monolith`, because the fixture is a played colony under Anomaly and the game raises letters whenever it likes. Name your recipe; never demand an empty stack. |
| `StateSteps.cs` | `Bill Autopilot's integration report matches the mods this pass loaded` | **One assertion that is correct in every pass.** A mod with soft integrations cannot assert "found" (the minimal pass fails) nor "not found" (the pass with the optionals fails) without two copies of the same feature. What holds in both is a correspondence: the mod reports a neighbour found exactly when `ModLister` says it is loaded. Each half of a divergence means something different and the failure says which — loaded but not found is a bridge gone dead, the neighbour renamed what the reflection reaches, the feature is lost in silence and nothing crashes. |
| `StateSteps.cs` | `Bill Autopilot's memory is counted` then `… is holding something for one bill fewer than before` | Remember a count, act, compare. Written because an absolute number would have asserted against the fixture's furniture as much as against the mod, and would go red the day someone adds a workbench to the save. The shape fits any "this entry was dropped" check on a fixture you do not control. |

## Dedicated to Bill Autopilot, no reuse expected

| File | What they cover |
| --- | --- |
| `ProfileSteps.cs` | The bench profiles and the three global settings: default mode, target and floor, uncountable mode, bill cap, marking. All of it is this mod's own `BenchProfile`/`AutoMode`. Two are worth knowing about anyway — `Bill Autopilot only takes {string} on {string}` narrows a bench to one recipe by excluding the others, because a played colony's tailoring bench offers dozens and an autopilot on its defaults fills its allowance with hats, so a scenario about ONE recipe was really asserting against a queue it had not chosen; and `… default mode for {string} is a repeat mode no longer in this game` sets a `defName` no mod owns, so the missing-provider fallback is exercised in every pass, including the minimal one. |
| `BillSteps.cs` | The bill stack: what the autopilot has up, what the player does to it in the tab (retarget, forever, repeat-count, rename, delete, unsuspend), the `(auto)` marker read through `LabelCap`, and the room left under the live bill ceiling. The edits go through the same calls the tab makes (`BillStack.Delete` is what raises `Notify_BillDeleted`); driving the widgets with real clicks would test RimWorld's number buttons rather than this mod. |
| `StateSteps.cs` | The per-game state grafted into the save's `<game>` node: which recipes are known, which are announced and unanswered, what is remembered for a bill taken down. Worth asserting rather than inferring, because an absent bill has five possible reasons that look identical on a bench. |
| `ShortcutSteps.cs` | The hidden `MainButtonDef` contract. **Overlaps `RimmsqolSteps/` and SkillIcons' `MainButtonBarSteps.cs`; prefer those.** Mine only moves `buttonVisible` and reads `Worker.Visible`/`Worker.Disabled`, where RimmsqolSteps works from the bar's own layout and drives RIMMSQOL itself. The one row that is not duplicated: `a settings dialog is open for Bill Autopilot` reads the private field of `Dialog_ModSettings` to name the mod it was built for — SkillIcons has the same idea as `sees a {string} window open for mod {string}`, and either is better than a screenshot, in which another mod's settings window looks identical. |
| `IntegrationSteps.cs` | Reflection into Better Workbench Management (`ExtendedBillDataStorage`, `LinkBills`, `GetBillSetContaining`), Nice Bill Tab (`TabBillsDrawer.shouldRefreshFilter`), Dubs Mint Menus (`Patch_BillStack_DoListing.MakeBenchTemplate`, `Settings.fbenchTemplates`) and Nice Bill Tab - Expansion's hidden-recipe store. Nothing is referenced at compile time: the minimal pass loads this assembly with none of them present, and a real reference would fail to load the suite in the very pass meant to prove the mod stands alone. Scenarios carry `@requires:` so they skip rather than fail. |

## What the runs taught, beyond the steps

- **Parentheses in a Cucumber Expression are optional text.** `at ({int}, {int})` is an optional group containing
  parameters, which is illegal, and Pickle builds its whole step table before running anything: one bad pattern of
  87 played zero scenarios of nineteen and reported `infrastructure-error`. Escape them, `\(` and `\)`, written
  `\\(` and `\\)` in a C# literal. This is the failure `PickleTools`' own `Check-Steps` was written against.
- **The keyword is decoration.** A `Given` setter and a `Then` assertion spelled identically are one ambiguous
  step, not two. Three pairs got in before anything compiled them.
- **The game ticks between two steps.** The mod's own pass runs on those ticks, so a scenario that switches a
  bench on and then lowers a cap finds the allowance already spent. Order the setup so the configuration precedes
  the activation.
- **A fixture is a played colony.** `test-colony` has `ComplexClothing` researched, so a scenario about a recipe
  unlocked later had nothing new to show; its research list is readable offline in `Pickle/Fixtures/test-colony.rws`
  (`<progress>` keys against values), and `Pemmican` is at zero there.
- **The suite's own checker** is `BillAutopilot/Tests/Pickle/Check-Steps.ps1`. It is the file `PickleTools`' tool
  checkers grew out of, and it has since taken their ambiguity half back: Pickle's vocabulary read with Mono.Cecil
  from its assemblies rather than from its documentation, compared against every other step source in the collection.
