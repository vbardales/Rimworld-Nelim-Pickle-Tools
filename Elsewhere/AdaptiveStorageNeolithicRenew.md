# Adaptive Storage Neolithic Renew

**Adaptive Storage Neolithic Renew** (`AdaptiveStorageNeolithicRenew/tests/Pickle/Source/ResearchTabSteps.cs`, built by `Build.ps1` beside it into
`tests/Pickle/Mod/Pickle/Assemblies/`, C# 5 with the .NET Framework `csc`). Five steps on research window, texts name mod. Four superseded by [`ResearchSteps/`](../ResearchSteps/README.md), same job, also choose by label or key; played in that suite 2026-09-21,
English 7 of 7, French 9 of 11 (2 skipped).

| Where | What it gives a scenario |
| --- | --- |
| `ResearchTabSteps.cs`, `OpenTab` | `I open the Adaptive Storage Neolithic Renew research tab {string}`: opens research window, runs `clickedAction` of tab record window built for that `ResearchTabDef`, by def name. `I click button` cannot: tabs are `TabRecord`s, record no button tag. Now `ResearchSteps/`. |
| `OnTab`, `LabelsTab`, `ListsProject` | Window on tab (and `TabInfoVisible` holds), label window built for tab, project among visible projects of selected tab at its cost. Now `ResearchSteps/`. |
| `NoOverlap` | **No two listed projects drawn on same spot**: `the Adaptive Storage Neolithic Renew research window draws no two of its projects on the same spot` compares `ResearchViewX`/`ResearchViewY`. **Only step with no shared version.** Says nothing on whether layout good; capture for that. To reuse, copy `NoOverlap`, change mod name in its text. |

## Publication screenshot steps

Source review, 2026-09-22: `tests/Pickle/Source/PublicationSteps.cs` adds two steps beside five research
steps above: `I hide the interface for the Adaptive Storage Neolithic Renew Workshop captures` and
`I bring the interface back after the Adaptive Storage Neolithic Renew Workshop captures`.
They keep previous screenshot-mode state, hide Pickle windows by assembly name, wait three frames,
restore from AfterScenario hook too. Same reusable family as Work Studio's capture
steps; ClearScreen does not replace it. Source presence verified here; steps not replayed
for catalogue cleanup. Earlier research run notes above are historical evidence, not new run.

## Things that took no step, in the Adaptive Storage Neolithic Renew suite

Save someone the search:

- **Reading a blueprint's label.** Pickle's def lookup does not see vanilla's implied `<defName>_Blueprint` defs. Place one instead:
  `I designate a "<def>" from (x, z) to (x, z)`, then `I select "<the label the game shows>"` and `the inspect pane shows "<label>"`. Building made of
  stuff shows stuff in label (`Grand pot en bois`), so use building built from cost list, or select what game displays.
- **Name shared by two defs of different types** cannot be read by `def "<X>" field ...`, only by `def "<X>" of type "<T>" exists`. Way out is the map,
  through inspect pane, which reads the thing not the def.
- **Second mod beside suite.** Pass map named `wsl-deps.<pass>.map` (`-DepMap wsl-deps.stones.map`) with mod's Workshop id, and
  `@requires:<packageId>` on feature so every other pass skips it. `AdaptiveStorageNeolithicRenew/Tests/Pickle/wsl-deps.stones.map` stages stone mod this way.
- **Opening a language.** `-Language French` on wrapper, and feature tagged `@wip` aimed by file name (`-Filter "<file>.feature" -IncludeWip`).