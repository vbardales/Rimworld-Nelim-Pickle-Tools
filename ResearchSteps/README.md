# Research window steps for Pickle (shared)

Reusable Pickle steps that **open a tab of the research window by def name, by the label a player reads, or by a
translation key**, and read what the window then lists.

Development only. Never published, no Defs, no features: a suite stages the companion mod in `Mod/` with one line in a
pass map and writes its own features. The demonstration is `AdaptiveStorageNeolithicRenew/Tests/Pickle/Mod/Pickle/Features/`
`08` to `10-pickletools-research*.feature`.

**Temporary.** These steps exist while [RimWorks/Rimworld-Pickle#33](https://github.com/RimWorks/Rimworld-Pickle/pull/33) is
open. It carries the same idea by def name only (`I open the research tab {string}`). When it is merged, move the features to
its texts and delete this folder. The texts here say "PickleTools" so the two never make a line ambiguous while both are loaded.

## Why a step at all

The research window draws its tabs as `TabRecord`s through `TabDrawer.DrawTabsOverflow`, read off the game's
`MainTabWindow_Research`. That records no button tag, so `I click button "Storage"` fails with
`tag 'btn:Storage' not found; known tags: no tags recorded this frame` (2026-09-21, English and French). These steps do not
click: they open the window (`MainTabsRoot.SetCurrentTab`) and run the `clickedAction` of the tab record the window built for
that `ResearchTabDef`, which is what a click on the tab runs.

## Using it from a suite

1. A pass map (`<Mod>/Tests/Pickle/wsl-deps.avec-pickletools.map`), repeating the mod's own line if it has one, because a
   named map replaces the default:

   ```
   adaptive.storage.framework   3033901359
   nelim.pickletools.research   path:PickleTools/ResearchSteps/Mod
   ```

2. Tag the features `@wip @pickletools` so a pass without the steps skips them, and play them in that pass:
   `-DepMap wsl-deps.avec-pickletools.map -Filter <feature> -IncludeWip`.
3. Write features with the vocabulary below. Every text is unique across the repository and Pickle
   (`Check-Steps.ps1` proves it).

### Vocabulary

A name is a **def name first** (any case), then **the label the tab is drawn with**, in the language the game runs in. A label
shared by two tabs fails the step and names both; an unknown name lists every tab with its def name and label.

| Step | What it does |
| --- | --- |
| `I open the PickleTools research tab {string}` | Opens the window and selects the tab, by def name or label |
| `I open the PickleTools research tab keyed {string}` | Translates the key and selects the tab whose label it reads |
| `the PickleTools research window is on the tab {string}` | `CurTab` is that tab, the window drew a selected record for it, and `ResearchManager.TabInfoVisible` holds |
| `the PickleTools research window labels the tab {string} as {string}` | The label the window built for the tab's record (`LabelCap` when it opened) |
| `the PickleTools research window lists the project {string}` | The project, by def name or label, is among the visible projects of the selected tab (the list `ListProjects` draws from) and is not hidden |
| `the PickleTools research window lists the project {string} costing {int}` | The same, and its `Cost` |

**The keyed step reaches only a tab whose label comes from a Keyed string.** Main, Anomaly and a mod's own tab are Def labels,
translated by DefInjected, and a DefInjected key is not resolved by `.Translate()`. For those, use the def name, which reads
the same in every language. A suite that wants to test the keyed step ships a Keyed string of its own whose text is the tab's
label, as `AdaptiveStorageNeolithicRenew/Tests/Pickle/Mod/Languages/*/Keyed/PickleTests.xml` does.

`the ... is on the tab` fails for a tab that is not visible yet (Anomaly is hidden until its monolith level): the window would
draw "not discovered" in place of its projects, and the step says so.

## Verification

Offline, 2026-09-21:

| Check | Command | Result |
| --- | --- | --- |
| Builds against the game's and Pickle's reference assemblies | `dotnet build Source/ResearchSteps.csproj -c Release` | 0 warnings, 0 errors |
| The six patterns compile with Pickle's own engine, none declared twice, none ambiguous against 611 others (Pickle, 12 suites), every line of the `pickletools-research` features resolves | `powershell.exe -ExecutionPolicy Bypass -File PickleTools/ResearchSteps/Check-Steps.ps1` | pass |

### In the game: played once, 2026-09-21

Pass `avec-pickletools` of `AdaptiveStorageNeolithicRenew` (the framework and this assembly staged, 13 mods, all loaded), two launches
per language under one hold of the lock, **every launch `exitReason: passed`, scenarios played = scenarios written**. Reports in
`AdaptiveStorageNeolithicRenew/tests/pickle-run-2026-09-21-pickletools-{en-08,en-09,fr-08,fr-10}/`.

- English, `08`: 3 of 3. A tab by def name in another case (`asfadaptivestorage`), the vanilla Main tab with `Stonecutting` listed, and
  a tab by a translation key. English, `09`: 1 of 1, `Storage` and `Neolithic storage` by their labels.
- French, `08`: 3 of 3, the key now reading `Stockage` and reaching the same tab. French, `10`: 2 of 2, `Stockage`, `Stockage néolithique`,
  and `Principal` reaching `Main`, the case where the label and the def name differ.
- The captures of the keyed scenario were opened in both languages: the framework's tab selected, its two projects at 400.

Not shown: a label shared by two tabs, an unknown name, a tab whose info is not visible (Anomaly), a key with no translation. Those are
the failure paths of the steps; they were not exercised in a game.

This is the version kept beside [RimWorks/Rimworld-Pickle#33](https://github.com/RimWorks/Rimworld-Pickle/pull/33); `../Upstream/PENDING.md`
has the row.

## Files

- `Source/ResearchTabSteps.cs` the vocabulary. `Source/ResearchSteps.csproj` builds it into `Mod/Pickle/Assemblies/`.
- `Mod/` the companion mod the staging copies (`About/About.xml`, `Pickle/Assemblies/Nelim.PickleTools.ResearchSteps.dll`, built).
  Nothing else may be put here: the staging copies it verbatim.
- `Check-Steps.ps1` the offline check of the patterns (adapted from `../Check-Steps.ps1`).
- `.build/` intermediates, not part of anything. Rebuild after any change to `Source/`, then run the check; the DLLs of steps are
  loaded at game start, so a report produced without a restart after a rebuild does not test the rebuild.
