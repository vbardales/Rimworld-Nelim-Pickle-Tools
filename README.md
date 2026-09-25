# Nelim's Pickle Tools

**Writing a new suite? Start with the [authoring guide](Authoring/README.md)** for layout, pass maps,
dependency tags, step design, restart tests and evidence requirements.

Shared tooling for testing RimWorld mods with [Pickle](https://github.com/RimWorks/Rimworld-Pickle), the
Gherkin runner that plays scenarios in a real game. Each tool is a **companion mod that holds Pickle steps** (an
assembly under `Pickle/Assemblies/`, no Defs, no features) which any suite can stage in a test pass with one line
of its pass map, plus what we carry for Pickle itself.

**Developer tooling. GitHub and Workshop release preparation is documented in [Release](Release/README.md).**
The source `Mod/` is the Workshop payload as committed: metadata, artwork and the fourteen step DLLs (`Pickle/Assemblies`),
copied from each tool by `Release/Prepare-Release.ps1 -SyncMod` and checked by `-Check`; the publish workflow uploads it as it is, under one
Workshop identity. Pickle is required; mods targeted by optional integration tests remain optional.
See [TESTING.md](TESTING.md) for the bundle's validation plan and recorded offline results.

| Folder | What it gives a scenario | Packages |
| --- | --- | --- |
| [`RimmsqolSteps/`](RimmsqolSteps/README.md) | Reveal, hide and forget a main-bar button through RIMMSQOL's own settings, and assert what the bar draws | `nelim.pickletools.rimmsqol` |
| [`FilmTicks/`](FilmTicks/README.md) | Film a stretch of a scenario one picture every N game ticks instead of by the clock | `nelim.pickletools.filmticks` |
| [`ResearchSteps/`](ResearchSteps/README.md) | Open a tab of the research window by def, label or key, and read what it lists | `nelim.pickletools.research` |
| [`InspectTabs/`](InspectTabs/README.md) | Open one of a pawn's inspect tabs (Gear, Bio, Health, Social, Needs, Log) and check which one is open | `nelim.pickletools.inspecttabs` |
| [`ColonistRace/`](ColonistRace/README.md) | A colonist of a Biotech xenotype, of any humanlike pawn kind, or with a body type that is certain (Male, Female, Thin, Fat, Hulk) | `nelim.pickletools.colonistrace` |
| [`ExpansionSteps/`](ExpansionSteps/README.md) | Assert that an expansion, or any mod, is active in `ModsConfig`: the check a pass that leaves a DLC out needs | `nelim.pickletools.expansions` |
| [`ClearScreen/`](ClearScreen/README.md) | Close every window another mod owns and keep them closed for the rest of the scenario, so a click is not swallowed by a log viewer or a notice | `nelim.pickletools.clearscreen` |
| [`ClickDiagnostics/`](ClickDiagnostics/README.md) | Wait for a button to stand still, check nothing covers it, click it, and on a lost click print the pointer, the buttons under it and the window stack | `nelim.pickletools.clickdiagnostics` |
| [`TextureOwner/`](TextureOwner/README.md) | Assert which running mod answers for a texture path, and that a path is shipped by at least N mods: the check a retexture needs when its `loadAfter` is all that makes it win over another retexture | `nelim.pickletools.textureowner` |
| [`KeyedClick/`](KeyedClick/README.md) | Click a button by its translation key | `nelim.pickletools.keyedclick` |
| [`HoverSteps/`](HoverSteps/README.md) | Hover a tooltip region by the text of its tooltip (literal, keyed, or a part of it), wait for the game to draw it, and assert it: the check a page full of checkboxes and sliders needs, since Pickle only tags button labels | `nelim.pickletools.hoversteps` |
| [`SoundCapture/`](SoundCapture/README.md) | **Optional.** Record what the game plays between two steps and measure it, or assert that the game holds a playing sound; not in the bundle. Tests that record are run **alone and on Windows** (SoundCapture/Run-Windows.ps1, the owner's exception in AUDIT.md) | `nelim.pickletools.soundcapture` |
| [`InterfaceScale/`](InterfaceScale/README.md) | Set interface scale and repair recorded button rectangles for scaled clicks | `nelim.pickletools.interfacescale` |
| [`ScreenshotMode/`](ScreenshotMode/README.md) | Hide the HUD and Pickle-owned windows around an already-open subject window for a review capture | `nelim.pickletools.screenshotmode` |
| [`VefFactionSteps/`](VefFactionSteps/README.md) | Exercise Vanilla Expanded Framework's missing-faction offer, dialog and ignored-state workflow | `nelim.pickletools.veffactions` |
| [`Headless/`](Headless/README.md) | Not a tool: the guide to testing a mod in the headless WSL install without taking the screen (the launcher, the queue and lock, staging, passes, reports). The scripts it describes live in the monorepo's `scripts/` | none |
| [`Upstream/`](Upstream/README.md) | Not a tool: the ledger of the changes to Pickle itself that wait for a merge, and the patches that carry them | none |
| [`Elsewhere/`](Elsewhere/README.md) | Not a tool: the ledger of steps that live in one mod's own repository, or only in its history — what each reads, and where to find it before writing it a second time | none |

The optional [ScreenshotStudio](ScreenshotStudio/README.md) supplies the default saved fixture for Pickle
presentation and screenshot scenarios: `nelim-zen-meadow-studio`. Stage it explicitly with ClearScreen through
`wsl-deps.studio.map`; it is packaged separately with `Release/Prepare-Release.ps1 -IncludeScreenshotStudio`.
Functional scenarios retain an explicitly chosen fixture when their preconditions require one.

[Quiet New Factions](QuietNewFactions/README.md) is a second optional companion: it suppresses VEF's repeated
missing-faction dialog while preserving factions VEF marks required. It remains outside the aggregate payload because
VEF is a load-time dependency; its suite stages it explicitly with `PickleTools/QuietNewFactions`.

## Steps still owned by a suite

See [Elsewhere/](Elsewhere/README.md) for the single catalogue, one note per suite, historical code,
and the reproducible local inventory. Consult it before copying or promoting a step.

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
  Mod/            the Workshop payload as committed: metadata, artwork, the fourteen step DLLs (Prepare-Release.ps1 -SyncMod)
  Art/            the sources of the icon and the preview, and the page that engraves the preview
  <Tool>/         one folder per tool
    Mod/          what the staging copies: About/About.xml, Pickle/Assemblies/*.dll, LICENSE
    Source/       the C# project; intermediates go to .build/, outside Mod/
    README.md     what it does, what was checked and what was not
```

## Status, rights, AI

[`STATUS.md`](STATUS.md) says where the repository is in the workflow and what is not verified.
[`ATTRIBUTION.md`](ATTRIBUTION.md) says what it studied and what is open. MIT, see [`LICENSE`](LICENSE).
Code and documentation include work with Claude Code (Anthropic) and OpenAI Codex under human direction and
review. The icon and preview were generated with DALL-E (OpenAI). See `ATTRIBUTION.md`.
