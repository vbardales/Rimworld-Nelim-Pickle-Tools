# Adaptive Storage Neolithic Renew

**Adaptive Storage Neolithic Renew** (`AdaptiveStorageNeolithicRenew/tests/Pickle/Source/ResearchTabSteps.cs`, built by `Build.ps1` beside it into
`tests/Pickle/Mod/Pickle/Assemblies/`, C# 5 with the .NET Framework `csc`). Five steps on the research window, texts naming the mod. Four of them are
superseded by [`ResearchSteps/`](../ResearchSteps/README.md), which does the same and also chooses by label or key; played in that suite 2026-09-21,
English 7 of 7 and French 9 of 11 (2 skipped).

| Where | What it gives a scenario |
| --- | --- |
| `ResearchTabSteps.cs`, `OpenTab` | `I open the Adaptive Storage Neolithic Renew research tab {string}`: opens the research window and runs the `clickedAction` of the tab record the window built for that `ResearchTabDef`, by def name. `I click button` cannot: the tabs are `TabRecord`s and record no button tag. Now `ResearchSteps/`. |
| `OnTab`, `LabelsTab`, `ListsProject` | The window is on the tab (and `TabInfoVisible` holds), the label the window built for the tab, the project is among the visible projects of the selected tab at its cost. Now `ResearchSteps/`. |
| `NoOverlap` | **No two listed projects drawn on the same spot**: `the Adaptive Storage Neolithic Renew research window draws no two of its projects on the same spot` compares `ResearchViewX`/`ResearchViewY`. **The one step with no shared version.** Says nothing about whether the layout is good; a capture is for that. To reuse it, copy `NoOverlap` and change the mod name in its text. |

## Publication screenshot steps

Source review, 2026-09-22: `tests/Pickle/Source/PublicationSteps.cs` adds two steps alongside the five research
steps above: `I hide the interface for the Adaptive Storage Neolithic Renew Workshop captures` and
`I bring the interface back after the Adaptive Storage Neolithic Renew Workshop captures`.
They preserve the previous screenshot-mode state, hide Pickle windows by assembly name, wait three frames,
and restore from an AfterScenario hook as well. This is the same reusable family as Work Studio's capture
steps; ClearScreen does not replace it. Source presence is verified here; these steps were not replayed
for the catalogue cleanup. The earlier research run notes above are historical evidence, not a new run.

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
