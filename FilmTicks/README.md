# Film ticks - Pickle steps (shared)

Two Pickle steps that film **a stretch of a scenario, one picture every N game ticks**:

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: I film every {int} ticks as {string}` | starts filming; the name is the film's folder in the report |
| `Nelim's Pickle Tools: I stop filming` | waits ten frames for the last pictures to land, then encodes the video |

Developer tooling. GitHub and Workshop release preparation in progress; no Defs, no features: a suite stages the companion mod in `Mod/` and writes
its own scenarios.

## Why it exists

Pickle's own `@film` takes ten pictures a second **by the clock**, and films the scenario **from its first step**.
Two things follow. An effect that lives one game tick in fifteen is caught only by chance. And a long walk before
the interesting part uses up the 60-second cap first. These steps film only between the two of them, and the
picture is decided by the tick counter, not the stopwatch.

The same feature, as a scenario tag (`@film-ticks:N`), is written against Pickle itself on the branch
`feat/film-every-n-ticks` of a local clone, and is meant to go upstream as a pull request. Migrate only after
the installed build provides equivalent behavior: a whole-scenario tag does not replace a mid-scenario start.
These steps use public Workshop Pickle APIs:
(`PickleDriver.AddFrameHook`, `CaptureFrameDetached`, `ReleaseFrameBuffers`, `ScreenshotCapture`, `FilmEncoder`)
is public.

## What it does and does not give you

- The tick counter is read on each rendered frame. Even at **normal speed**, one picture per tick is not
  guaranteed: rendering may lag behind simulation (see the measured result below).
- Where **several ticks run between two frames** - Pickle's fast mode, which drives sixty ticks a frame - a
  picture lands on the first frame after the interval and cannot show the ticks in between. Use `@watch` so waits
  pass real time, and do not set the game above normal speed for the filmed stretch.
- The alignment of pictures to ticks **inside a running game has not been checked against a tick counter written
  on the frame**: what is tested is the rule (`Tests/`, seven cases, plain .NET). A film is a picture of the
  screen, not a proof of a tick.
- A film stops at **900 pictures** (a frame count, not seconds) and says so in the `film-note` attachment.
- Pictures are 960 pixels wide jpegs; the video is encoded when `ffmpeg` is on the PATH, and the frames are then
  deleted. The film sits in `screenshots/film/pickletools--<name>/`.

## Using it from a suite

1. A pass map, in the suite's `Tests/Pickle/`, that stages the mod from this repository:

   ```
   nelim.pickletools.filmticks   path:PickleTools/FilmTicks/Mod
   ```

   Select it with `-DepMap <the map>`. The folder's own `About.xml` packageId must match the one written.
2. Tag scenarios `@requires:nelim.pickletools.filmticks` so a pass without the tool skips them.
   Use `@wip` only for unfinished scenarios and opt in with `-IncludeWip`; a narrow `-Filter` is useful
   during development but the launcher does not require one. See the [authoring guide](../Authoring/README.md).
3. Write the scenario, with the filmed stretch between the two steps:

   ```gherkin
   And game speed is normal
   And I zoom all the way in
   And I move the camera to (70, 132)
   And I wait 60 ticks
   And Nelim's Pickle Tools: I film every 1 ticks as "halo"
   And I wait 90 ticks
   And Nelim's Pickle Tools: I stop filming
   ```

## Build and test

```powershell
dotnet build FilmTicks/Source/Nelim.PickleTools.FilmTicks.csproj -c Release      # net48, output in Mod/Pickle/Assemblies
dotnet test  FilmTicks/Tests/FilmTicks.Tests.csproj -c Release                   # net8.0, runs on the default SDK
```

Intermediates go to `FilmTicks/.build/`, never inside `Mod/`, since the staging copies `Mod/` verbatim.

## Measured, once (2026-09-21, WSL under Xvfb, Workshop Pickle)

`every 1 ticks` around `I wait 90 ticks` at normal speed took **56 pictures in 5.7 s**, encoded to a webm with 53
frames (three pictures were lost between the capture and the encode, which is not explained). The game was
running about 16 ticks a second in that time, well under normal speed, because the software renderer draws
frames slowly: roughly **one picture per 1.6 ticks, not per tick**. The steps did what they say - the gate fires
on every rendered frame, and each frame carries at least one tick - but on this rig a picture per tick is not
reachable. A machine that renders at 60 frames a second would give one per tick; this one does not.

## Checks

```powershell
powershell.exe -ExecutionPolicy Bypass -File PickleTools/FilmTicks/Check-Steps.ps1
```

Offline, a few seconds, no game: both patterns compile with Pickle's own expression engine, none is declared
twice, none is ambiguous against Pickle's 202 patterns or the 12 suites' 409, and every line in the repository that
uses these two verbs resolves. Passed on 2026-09-21. The filter for "every line resolves" is the two verbs, not the
prefix, because the sibling tools share the `Nelim's Pickle Tools:` prefix and this script does not read their
patterns.

## What it rests on

Written with Claude Code (Anthropic) under Nelim's direction and review, in the session that was finding why
Anima Song's halo would not show. `../ATTRIBUTION.md` leaves the attribution of this folder to its own README, and
this is it.

- **Pickle** ([RimWorks/Rimworld-Pickle](https://github.com/RimWorks/Rimworld-Pickle), `rimworks.pickle`), which
  GitHub reports under the **MIT licence** (`gh repo view`, 2026-09-21). The steps call only what it makes public
  (`PickleDriver.AddFrameHook`, `CaptureFrameDetached`, `ReleaseFrameBuffers`, `ScreenshotCapture.FrameDirectory` and
  `BuildFramePath`, `FilmEncoder`) and are loaded by it; nothing of Pickle is redistributed by this folder.
- **Pickle's own film**, whose source (`Source/Pickle/Evidence/FilmstripRecorder.cs`) was read to see how it samples
  and where its frames go. The steps follow its conventions - 960-pixel jpegs, a `<name>` folder under
  `screenshots/film/`, encoding to `film.webm` - so that the report finds the result. **No source line of it is
  copied**; the sampling rule (`FilmTickGate`) is new.
- **`Upstream/patches/0002-pickle-film-every-n-ticks.patch`** carries the same rule as a change to Pickle's source, and
  is therefore derived from that source. That answers **only** the first open item of `../ATTRIBUTION.md` in one
  respect - Pickle declares MIT - and I did not edit that file. It is a licence field read on GitHub, not a legal
  opinion, and whether a copy of the licence notice has to travel with a patch is left to the owner.
- **Dependencies of the mod**: `rimworks.pickle` only, read from `Mod/About/About.xml`. The steps assembly
  compiles against `Krafs.Rimworld.Ref` and `RimWorks.Pickle.Ref` (NuGet, compile-time stubs, not shipped).
