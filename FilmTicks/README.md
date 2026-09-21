# Film ticks - Pickle steps (shared)

Two Pickle steps that film **a stretch of a scenario, one picture every N game ticks**:

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: I film every {int} ticks as {string}` | starts filming; the name is the film's folder in the report |
| `Nelim's Pickle Tools: I stop filming` | waits ten frames for the last pictures to land, then encodes the video |

Development only. Never published, no Defs, no features: a suite stages the companion mod in `Mod/` and writes
its own scenarios.

## Why it exists

Pickle's own `@film` takes ten pictures a second **by the clock**, and films the scenario **from its first step**.
Two things follow. An effect that lives one game tick in fifteen is caught only by chance. And a long walk before
the interesting part uses up the 60-second cap first. These steps film only between the two of them, and the
picture is decided by the tick counter, not the stopwatch.

The same feature, as a scenario tag (`@film-ticks:N`), is written against Pickle itself on the branch
`feat/film-every-n-ticks` of a local clone, and is meant to go upstream as a pull request. **When it lands, this
mod's steps can go.** Until then these work on the Workshop build of Pickle as it is: everything they use
(`PickleDriver.AddFrameHook`, `CaptureFrameDetached`, `ReleaseFrameBuffers`, `ScreenshotCapture`, `FilmEncoder`)
is public.

## What it does and does not give you

- At **normal speed** the game runs about one tick per rendered frame, so `every 1 ticks` gives one picture per
  tick. The tick counter is read on each rendered frame.
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
2. Tag the scenarios that use it `@wip`, so a pass without the mod skips them, and run them with
   `-pickle-include-wip` **and a filter**: the launcher refuses the flag without one, because it has been seen to
   empty a selection while reporting success.
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
dotnet test  FilmTicks/Tests/FilmTicks.Tests.csproj -c Release                   # needs a .NET 10 SDK
```

Intermediates go to `FilmTicks/.build/`, never inside `Mod/`, since the staging copies `Mod/` verbatim.
