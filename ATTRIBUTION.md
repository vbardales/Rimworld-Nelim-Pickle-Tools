# Attribution and rights

Nelim's Pickle Tools is original work, MIT (see `LICENSE`). This file says what it stands on, what it
studied without reusing, and what is not settled. It covers the repository root and `RimmsqolSteps/`; the
other folders (`FilmTicks/`, `ResearchSteps/`, `ColonistRace/`, `InspectTabs/`, `KeyedClick/`, `Upstream/`) were written in other sessions and
their own READMEs are where they say what they rest on. See "Open" below.

## Studied, not reused

- **RIMMSQOL** (`MalteSchulze.RIMMSqol`, [Workshop 1084452457](https://steamcommunity.com/sharedfiles/filedetails/?id=1084452457)),
  by Malte Schulze. Its shipped `Source/` was read to learn how it stores and applies the visibility of a main
  button, and the 1.6 `RIMMSqol.dll` was read with Mono.Cecil to confirm it. **No code of RIMMSQOL is copied into
  this repository.** `RimmsqolSteps` is compiled against the real DLL as a reference (`Private=false`, so it is
  not copied into the output) and calls its public members at run time, in a test game where RIMMSQOL is staged
  by the pass. The behaviour written up in `RimmsqolSteps/README.md` is a description of what was read, in our
  own words.
- **Licence of RIMMSQOL: none found.** Not in its `About.xml`, not in the shipped source (its `AssemblyInfo.cs`
  says only "Copyright 2017"), not as a file in the Workshop item. The Workshop page and its description were
  **not** consulted in the session that wrote this, so the absence of a licence there is unverified. Nothing here
  relies on a permission to redistribute RIMMSQOL, because nothing of it is redistributed.
- **`RimmsqolSteps/evidence/`** holds four screenshots of a test game in which RIMMSQOL's own window is open.
  They show its interface as evidence that a run happened. If its author objects to them, they go.
- **Pickle** ([RimWorks/Rimworld-Pickle](https://github.com/RimWorks/Rimworld-Pickle), `rimworks.pickle`,
  [Workshop 3791648678](https://steamcommunity.com/sharedfiles/filedetails/?id=3791648678)). The steps are written
  against its API (`RimWorks.Pickle.Ref` from NuGet) and are loaded by it; nothing of Pickle is redistributed.
- **The settings hand-off between two launches** (`RimmsqolSandbox.cs`: a step sets a flag, never a hook, and a
  marker beside the settings file names the process that wrote it) is the technique of
  `SkillIcons/Tests/Pickle/Source/SettingsSandbox.cs`, by the same author.
- **Development tools, not distributed:** Harmony and Lib.Harmony, Krafs.Rimworld.Ref, Mono.Cecil (used by the
  offline checks).

## Made with AI

The code, the checks and the documents were written with Claude (Anthropic) under human direction and review.
The two images (`Art/Preview.png`, the source of the preview, and `Art/ModIcon.png`) were generated with an AI
image model run by the owner, from a prompt written with Claude for the preview; the name of the image tool is
not recorded here. The 128 px icon and the engraved preview are reductions and overlays of those two images,
made by `Art/preview.html` and a bicubic resize.

## Open

- **`Upstream/` holds patches against Pickle's source.** A patch is derived from the code it patches. Pickle's
  licence has not been checked for this file, and it must be before this repository goes public.
- **Attribution of the other tools** (`FilmTicks/`, `ResearchSteps/`, `ColonistRace/`, `InspectTabs/`, `KeyedClick/`) is not established here.
- **The image tool** is not named above.

## Thanks

To Malte Schulze for shipping RIMMSQOL's source with it, without which none of this could have been checked; to
the authors of Pickle, for a test harness a mod can be driven through; and to the authors of Harmony.
