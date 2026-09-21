# Nelim's Pickle Tools

Shared tooling for testing RimWorld mods with [Pickle](https://github.com/RimWorks/Rimworld-Pickle), the
Gherkin runner that plays scenarios in a real game. Each tool is a **companion mod that holds Pickle steps** (an
assembly under `Pickle/Assemblies/`, no Defs, no features) which any suite can stage in a test pass with one line
of its pass map, plus what we carry for Pickle itself.

**Development only. Never published to the Workshop.** The mod as a whole (`Mod/`) carries only its identity, an
icon and a preview; the tools are the folders beside it.

| Folder | What it gives a scenario | Packages |
| --- | --- | --- |
| [`RimmsqolSteps/`](RimmsqolSteps/README.md) | Reveal, hide and forget a main-bar button through RIMMSQOL's own settings, and assert what the bar draws | `nelim.pickletools.rimmsqol` |
| [`FilmTicks/`](FilmTicks/README.md) | Film a stretch of a scenario one picture every N game ticks instead of by the clock | `nelim.pickletools.filmticks` |
| [`ResearchSteps/`](ResearchSteps/README.md) | Open a tab of the research window by def, label or key, and read what it lists | `nelim.pickletools.research` |
| [`InspectTabs/`](InspectTabs/README.md) | Open one of a pawn's inspect tabs (Gear, Bio, Health, Social, Needs, Log) and check which one is open | `nelim.pickletools.inspecttabs` |
| [`ColonistRace/`](ColonistRace/README.md) | A colonist of a Biotech xenotype, or of any humanlike pawn kind | `nelim.pickletools.colonistrace` |
| [`ExpansionSteps/`](ExpansionSteps/README.md) | Assert that an expansion, or any mod, is active in `ModsConfig`: the check a pass that leaves a DLC out needs | `nelim.pickletools.expansions` |
| [`ClearScreen/`](ClearScreen/README.md) | Close every window another mod owns and keep them closed for the rest of the scenario, so a click is not swallowed by a log viewer or a notice | `nelim.pickletools.clearscreen` |
| [`ClickDiagnostics/`](ClickDiagnostics/README.md) | Wait for a button to stand still, check nothing covers it, click it, and on a lost click print the pointer, the buttons under it and the window stack | `nelim.pickletools.clickdiagnostics` |
| [`Headless/`](Headless/README.md) | Not a tool: the guide to testing a mod in the headless WSL install without taking the screen (the launcher, the queue and lock, staging, passes, reports). The scripts it describes live in the monorepo's `scripts/` | none |
| [`Upstream/`](Upstream/README.md) | Not a tool: the ledger of the changes to Pickle itself that wait for a merge, and the patches that carry them | none |
| [`Elsewhere/`](Elsewhere/README.md) | Not a tool: the ledger of steps that live in one mod's own repository, or only in its history — what each reads, and where to find it before writing it a second time | none |

## Steps that live in a suite, and could be taken from there

Not tools yet: these are steps written for one suite that read as general, kept where they are until a second mod needs them.
Copy or promote them from there; a promoted step takes the `Nelim's Pickle Tools:` prefix.

| Where | What it gives a scenario |
| --- | --- |
| `FlavorText/FlavorTextExtended/Tests/Pickle/Source/FlavorTextExtendedSteps.cs` | **Cook a meal without simulating the walk**: `a colonist cooks {recipe} at the {station} from {ingredients}, {n} times` calls `GenRecipe.MakeRecipeProducts` on a colonist and a work table of the loaded save, so every postfix on the recipe (Flavor Text's meal naming, a mod that changes what a meal carries) runs for real, and records each product's label. Assertions on the names drawn, a step that puts the products on the map and one that checks they kept their names across `I save and reload`. As written it keeps only the products that carry Flavor Text's `CompFlavor` and asserts on its dish defNames, so promoting it means recording every product's label and moving those assertions out. |
| the same file | **Where a ThingDef is filed in a category tree**: `{def} is filed under {category}` and its negation, read from Flavor Text's `FlavorCategoryDef.DescendantThingDefs`. Specific to Flavor Text's categories, but the shape (assert membership of a def in a derived category tree, with the list of categories it IS under on failure) fits any mod that builds one. |

Their step texts start with `Flavor Text Extended:`.

**Work Studio** (`WorkStudio/Tests/Pickle/Source/`, texts without a prefix, most of them naming the mod). Step classes
`ColonySteps.cs`, `ModSteps.cs`, `EditorSteps.cs`; the last one (about 40 steps that drive Work Studio's work type editor:
create, rename, hide, drag, arrows, order assertions) is specific to that window and not worth promoting.

| Where | What it gives a scenario |
| --- | --- |
| `ColonySteps.cs` | **A colonist that cannot be blamed for a work type**: `{nick} is given backstories that disable no work type` replaces the generated backstories with ones that forbid no work, and `{nick} can do the work types {a} and {b}` asserts it, asking `Pawn.WorkTypeIsDisabled` after dropping the disabled-work-type caches, because the cached answer said "no problem" for a colonist who could not clean (2026-09-20). Any mod that names a work type in a scenario has that coin flip: the fixture's colonists are generated with random backstories. Uses this suite's `Driver.WorkType`, which resolves a defName or the label of a type Work Studio created; promoting it means keeping the defName half and dropping the other. |
| `ColonySteps.cs` | **Set and read a colonist's work priority by work type**: `I set {nick} to priority {n} for {type}`, `{nick} has priority {n} for {type}`, `{nick} does nothing but the work type {type}`. The setter turns on `useWorkPriorities`, writes through `Pawn_WorkSettings.SetPriority`, reads the value back through `GetPriority` and again from the private `DefMap` by reflection, so a write that never landed is told apart from a getter another mod answers for (Enhanced Work Tab keeps its own per-pawn store, 2026-09-17). A priority watcher (`PriorityProbe`) records who writes a zero. Any work-priority mod needs the same three. |
| `ModSteps.cs` | **Hide the interface around a mod's own windows for a capture**: `I hide the interface around Work Studio's windows` puts the game in screenshot mode and takes Pickle's own windows (found by assembly name, since it draws more than one) out of it, so the corner runner panel is not in every `@review` capture; `I bring the interface back around ...` and an `[AfterScenario]` restore it even if a scenario dies between the two. Only the text names Work Studio; the code does not. Close to `ClearScreen/` in purpose but the opposite in mechanism: that one closes other mods' windows, this one leaves them and hides the chrome. |
| `ModSteps.cs` | **Wait for a destructive confirmation to become clickable**: `I wait for Work Studio's confirmation to become clickable` reads `Dialog_MessageBox.TimeUntilInteractive` by reflection and waits on the dialog's own countdown, which beats a guessed number of frames; `Work Studio asks to confirm first` asserts a `Dialog_MessageBox` is open. Generic to any mod whose action asks first. |
| `ModSteps.cs` | **Assert a Harmony patch is there**: `Work Studio patched {Type::Member}` and `... patched the draw method of the window the Work tab really uses` read `Harmony.GetPatchInfo(...).Owners` for one's own Harmony id; the second walks up the hierarchy to the class that declares `DoWindowContents`, because a patch on a class that does not declare the method never runs. The id is `WorkStudioMod.HarmonyId`, so promoting it means passing an id. |
| `ModSteps.cs` | **The game log holds nothing from a mod since startup**: `the game log holds nothing from Work Studio since startup`. It matches `[Work Studio]` or the `WorkStudio.` namespace prefix, because RimLogging attributes by the mod's display name, which is also why Pickle's `no warnings from mod {string}` passed vacuously by packageId (PR #28). Close to the idea in `Upstream/PENDING.md` about errors logged since startup. |
| `ModSteps.cs` | **Open the settings of a mod through Vanilla's Mod options window and check which mod it is hosting**: `I open Work Studio's settings through Mod options` builds `Dialog_ModSettings` with the mod instance, so closing it runs `PreClose` (which writes the settings), and `the Mod options window is drawing Work Studio's own settings` compares the hosted instance by reference. Generic to any mod with a settings page; the mod class is the only specific part. |
| `ColonySteps.cs` | **Save mid-scenario under a prefixed name and load it later** (`I save the Work Studio test game as`, `I load the Work Studio test game`, with a 130 s timeout): the case Pickle's own `I save and reload` does not cover, a save written under one set of defs and read under another. Check Pickle's step first; this one exists for the set-changing case. |
| `ModSteps.cs`, `ColonySteps.cs` | **Specific, do not look here**: export and import of a setup file, the drift warning after a work type vanished, the raw-save check that custom types sit at the end of a colonist's priority list, remembering a whole setup, the settings-window steps. |

Kept here on purpose, not promoted, because they are short or tied to the mod's own types: the steps above that name
`WorkStudioMod`, `ConfigFile`, `SettingsSandbox`, `Driver`. Whoever needs one copies it and takes the `Nelim's Pickle Tools:`
prefix. `ClickDiagnostics/` already came out of this suite (the button probe, the wait for a button to stand still and the
window-stack dump); `WarnIfCovered` and `DescribeStack` still stay in `ModSteps.cs` for the keyed click.

**Adaptive Storage Neolithic Renew** (`AdaptiveStorageNeolithicRenew/tests/Pickle/Source/ResearchTabSteps.cs`, built by `Build.ps1` beside it into
`tests/Pickle/Mod/Pickle/Assemblies/`, C# 5 with the .NET Framework `csc`). Five steps on the research window, texts naming the mod. Four of them are
superseded by [`ResearchSteps/`](ResearchSteps/README.md), which does the same and also chooses by label or key; played in that suite 2026-09-21,
English 7 of 7 and French 9 of 11 (2 skipped).

| Where | What it gives a scenario |
| --- | --- |
| `ResearchTabSteps.cs`, `OpenTab` | `I open the Adaptive Storage Neolithic Renew research tab {string}`: opens the research window and runs the `clickedAction` of the tab record the window built for that `ResearchTabDef`, by def name. `I click button` cannot: the tabs are `TabRecord`s and record no button tag. Now `ResearchSteps/`. |
| `OnTab`, `LabelsTab`, `ListsProject` | The window is on the tab (and `TabInfoVisible` holds), the label the window built for the tab, the project is among the visible projects of the selected tab at its cost. Now `ResearchSteps/`. |
| `NoOverlap` | **No two listed projects drawn on the same spot**: `the Adaptive Storage Neolithic Renew research window draws no two of its projects on the same spot` compares `ResearchViewX`/`ResearchViewY`. **The one step with no shared version.** Says nothing about whether the layout is good; a capture is for that. To reuse it, copy `NoOverlap` and change the mod name in its text. |

**Anima Song** (`AnimaSong/Tests/Pickle/Source/AnimaSongSteps.cs`, one file, 21 steps, texts starting `Anima Song:`).
Nearly all of it is tied to the mod's own types (`CompAnimaSong`, `AnimaSongSeats`, `AnimaSongDefOf`) and stays there.
A few read as general, and are listed so that a mod which needs one knows where to copy it from; whoever promotes one
takes the `Nelim's Pickle Tools:` prefix.

| Where | What it gives a scenario |
| --- | --- |
| `AnimaSongSteps.cs` | **A deaf colonist**: `Anima Song: {nick} is made deaf` gives a missing-body-part hediff to every body part named `Ear` and asserts that the Hearing capacity is gone. Short, and it hard-codes the part's defName. |
| `AnimaSongSteps.cs` | **Order a colonist through a thing's float menu, and read what the menu offers**: `{nick} is ordered to listen to the tree at x=.. z=..` calls the comp's `CompFloatMenuOptions`, refuses a greyed-out entry and runs the entry with `Chosen(true, null)`; `the order offered to {nick} ... is available` and `... is refused because {key}` read `Disabled` and compare the label with the **translation of a key**, so the assertion holds in any language. The pattern is general; the calls name `CompAnimaSong`. Pickle has no step for a float menu (checked in its shipped step list, 2026-09-21). |
| `AnimaSongSteps.cs` | **Find a toggle gizmo by the translation of its label key and press it**: `I select the tree at x=.. z=..`, `I press the toggle of the selected tree`, `the toggle of the selected tree is on` / `is off`. It reads the selected thing's `GetGizmos()` for a `Command_Toggle` whose label equals a translated key, and calls its `toggleAction` (it does not simulate the click). |
| `AnimaSongSteps.cs` | **Follow an effect that lives a tick or two, tick by tick**: `the halo of the tree at x=.. z=.. is followed tick by tick for {n} ticks` reads, after every tick, whether a private `Mote` field is null, destroyed or alive and how long ago the owner last pinged it, attaches the distribution to the report, and asserts 90 % alive. It reads two private fields of `CompAnimaSong` by reflection, so the idea travels and the code does not. This is what showed the halo is alive only on the tick of a ping. |
| `AnimaSongSteps.cs` | **A group of pawns spread over distinct cells in a ring around a thing**: `{n} listeners sit on {m} different cells around the tree`. Tied to the mod's job and ring; kept only for the way it waits for the pawns to arrive before it counts. |
| `AnimaSongSteps.cs` | **Specific, do not look here**: `the song and the toggle icon come from the loaded mods` (reads `ModsConfig` to expect Phytokin's sound and icon, or Royalty's, and compares the def and the texture the mod resolved), `the tree ... carries the song comp`, `... allows` / `forbids listening`, `... is singing`, `the halo ... is alive` / `stays alive`. |

The film of the halo does not live there any more: `FilmTicks/` came out of this suite. The one scenario that uses it is
`AnimaSong/Tests/Pickle/Mod/Pickle/Features/02-review-captures.feature`, tagged `@wip` and played with
`-DepMap wsl-deps.film.map`.

## Using a tool from a suite

Name the tool in the suite's pass map (`<Mod>/Tests/Pickle/wsl-deps.<pass>.map`), after the mods it needs, and
play the features in that pass only. The staging script copies a folder of this repository with `path:`:

```
MalteSchulze.RIMMSqol            1084452457
nelim.pickletools.rimmsqol       path:PickleTools/RimmsqolSteps/Mod
```

The path is relative to the collection's root, so this repository has to be cloned there under the name
`PickleTools`. The folder's own `About.xml` `packageId` must equal the one written in the map. Every step text a tool
declares is unique across Pickle and the suites; each tool's README says how that is checked.

## Things that took no step, in the Adaptive Storage Neolithic Renew suite

In case they save someone the search:

- **Reading a blueprint's label.** Pickle's def lookup does not see vanilla's implied `<defName>_Blueprint` defs. Place one instead:
  `I designate a "<def>" from (x, z) to (x, z)`, then `I select "<the label the game shows>"` and `the inspect pane shows "<label>"`. A building made of
  stuff shows the stuff in its label (`Grand pot en bois`), so use a building built from a cost list, or select what the game displays.
- **A name shared by two defs of different types** cannot be read by `def "<X>" field ...`, only by `def "<X>" of type "<T>" exists`. The way out is the map,
  through the inspect pane, which reads the thing and not the def.
- **A second mod beside the suite.** A pass map named `wsl-deps.<pass>.map` (`-DepMap wsl-deps.stones.map`) with the mod's Workshop id, and
  `@requires:<packageId>` on the feature so every other pass skips it. `AdaptiveStorageNeolithicRenew/Tests/Pickle/wsl-deps.stones.map` stages a stone mod this way.
- **Opening a language.** `-Language French` on the wrapper, and a feature tagged `@wip` aimed by file name (`-Filter "<file>.feature" -IncludeWip`).

## Layout

```
PickleTools/
  Mod/            the identity of the mod as a whole: About, icon, preview, licence
  Art/            the sources of the icon and the preview, and the page that engraves the preview
  <Tool>/         one folder per tool
    Mod/          what the staging copies: About/About.xml, Pickle/Assemblies/*.dll, LICENSE
    Source/       the C# project; intermediates go to .build/, outside Mod/
    README.md     what it does, what was checked and what was not
```

## Status, rights, AI

[`STATUS.md`](STATUS.md) says where the repository is in the workflow and what is not verified.
[`ATTRIBUTION.md`](ATTRIBUTION.md) says what it studied and what is open. MIT, see [`LICENSE`](LICENSE). The code,
the checks and the documents were written with Claude (Anthropic) under human direction and review; the images were
generated with an AI image model. See `ATTRIBUTION.md`.
