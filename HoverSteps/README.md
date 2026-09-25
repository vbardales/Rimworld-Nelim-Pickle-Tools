# Hover steps - Pickle steps (shared)

Pickle can click a button by its label and hover a tagged widget, but it only tags **button labels**. A
checkbox, a slider or a plain label with a tooltip has no name a scenario can point at, so a tooltip could not
be looked at or asserted. These steps name a region **by the text of its tooltip**.

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: I hover over the tooltip keyed {string}` | Resolves the key with the game's own `Translate()`, hovers the region whose tooltip reads that, and waits for the tooltip to be drawn |
| `Nelim's Pickle Tools: I hover over the tooltip reading {string}` | Hovers the region whose tooltip reads exactly this text, and waits for the tooltip to be drawn |
| `Nelim's Pickle Tools: I hover over the tooltip containing {string}` | Hovers the region whose tooltip contains this text, and waits for it to be drawn; fails and lists the regions on screen if none or several match |
| `Nelim's Pickle Tools: the tooltip keyed {string} is drawn` | Asserts the tooltip whose text is the translation of this key is on screen now |
| `Nelim's Pickle Tools: the tooltip containing {string} is drawn` | Asserts a tooltip containing this text is on screen now |
| `Nelim's Pickle Tools: no tooltip is drawn` | Asserts no tooltip is on screen |

Take the capture with the usual `I take a screenshot "..."` step **after** the hover step: the tooltip is drawn
by then and stays as long as the pointer stays.

Developer tooling: a companion mod that holds Pickle steps, no Defs, no features.

## How it works

The game calls `TooltipHandler.TipRegion(Rect, TipSignal)` for every region with a tooltip on every repaint,
hovered or not, and only inside it checks whether the pointer is over the rect. A Harmony prefix, put in place by
a `[BeforeScenario]` hook (RimWorld itself never loads an assembly from `Pickle/Assemblies/`), hands each region
to Pickle's tag store as `tip:` plus its text. The ordinary `Hover` then finds it, and a step waits until the
game's active tips hold an entry for that text past its display delay.

It reaches Pickle's internal `TagStore.Record` and `TagStore.KnownTags` by reflection. A Pickle build that moves
them makes the first scenario say so, by name, instead of hovering nothing.

## Using it from a suite

1. A pass map line, after the mods it needs:

   ```
   nelim.pickletools.hoversteps   path:PickleTools/HoverSteps/Mod
   ```

2. The scenario:

   ```gherkin
   When I open the settings dialog
   And Nelim's Pickle Tools: I hover over the tooltip keyed "MyMod.Settings.SomethingTip"
   Then Nelim's Pickle Tools: the tooltip keyed "MyMod.Settings.SomethingTip" is drawn
   When I take a screenshot "something tooltip"
   ```

## Checked, and not

Compiled against the reference assemblies with no warning. `Check-Steps.ps1` (2026-09-25): the six patterns compile,
none is declared twice, none is ambiguous against 1207 other expressions (Pickle's, the suites' and the sibling tools'),
and every hover line of the features in the repository resolves. **In the bundle since the 1.1.0 preparation** (the owner,
2026-09-25). **Played in this repository, 2026-09-25, in English, once: 1 of 1** (`pickletools-hoversteps`, pass map `wsl-deps.hoversteps.map`, Pickle 4.9.1;
`docs/runs/aggregate.md`, row `2026-09-25-v4.9.1-hoversteps-en3`). The scenario opens the options dialog by key, hovers the tooltip of
the autosave interval (`AutosaveIntervalTooltip`) and asserts it drawn; the capture shows the tooltip under the row, with the game's text. An earlier
play failed on a key that the game's volume slider does not register (`MasterVolumeTooltip`): the failure listed the tooltips on screen and one of them was taken,
which is what the step's failure is for. **Not played in French**, and not with the suite that uses it most (Housebroken,
`Tests/Pickle/.../32-language-review.feature`, where no run of it is recorded yet).

Known limits: two regions with the same tooltip text are the same tag, and Pickle reports it as ambiguous; a
tooltip whose text changes every frame cannot be named; at an interface scale other than 100 the region rect
depends on the InterfaceScale tool's tag store repair, which a suite should stage with this one.
