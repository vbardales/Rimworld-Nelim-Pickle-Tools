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
| [`ClearScreen/`](ClearScreen/README.md) | Close every window another mod owns and keep them closed for the rest of the scenario, so a click is not swallowed by a log viewer or a notice | `nelim.pickletools.clearscreen` |
| [`ClickDiagnostics/`](ClickDiagnostics/README.md) | Wait for a button to stand still, check nothing covers it, click it, and on a lost click print the pointer, the buttons under it and the window stack | `nelim.pickletools.clickdiagnostics` |
| [`Headless/`](Headless/README.md) | Not a tool: the guide to testing a mod in the headless WSL install without taking the screen (the launcher, the queue and lock, staging, passes, reports). The scripts it describes live in the monorepo's `scripts/` | none |
| [`Upstream/`](Upstream/README.md) | Not a tool: the ledger of the changes to Pickle itself that wait for a merge, and the patches that carry them | none |

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
