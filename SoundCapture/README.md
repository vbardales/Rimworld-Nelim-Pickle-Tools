# Sound capture - Pickle steps (optional)

Four Pickle steps that record **what the game plays** between two steps, and assert that something was heard. It is an
optional companion: nothing runs unless a scenario asks for it, nothing in Pickle or in the launcher changes, and it is
not part of the aggregate bundle.

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: I record the sound as {string}` | Starts `ffmpeg` on the monitor of the audio sink and writes `sound.wav` in the report, under the name |
| `Nelim's Pickle Tools: I let {int} real seconds go by` | Waits real seconds, frame by frame (in the main menu no tick passes, so `I wait {int} ticks` cannot be used). 1 to 45 |
| `Nelim's Pickle Tools: I stop recording the sound` | Ends the recording, checks the file, attaches `sound-file` and `sound-note` to the report |
| `Nelim's Pickle Tools: the sound recorded as {string} is not silent` / `... is silent` | Measures the loudest sample with ffmpeg's `volumedetect`: not silent means above -60 dB, silent below -80 dB |

## What it needs

- `ffmpeg` on the PATH of the game, and an audio server to record from. On the WSL test install the game plays into the
  sink WSLg provides, and `ffmpeg -sources pulse` lists its monitor as `RDPSink.monitor`, the default source. Another source
  can be set with the environment variable `PICKLETOOLS_SOUND_SOURCE`.
- **The sound also reaches the Windows speakers**, because that sink is the way out of WSL. Keep a recording to a few seconds.

## What it shows, and what it does not

The level is measured, not the content. A recording that is not silent shows that the game's sound reached the sink; it does
not show that it is the right sound. A person listening to `sound.wav` still says that. The measured levels on the WSL
install (2026-09-24): an idle monitor reads -91.0 dB and a 440 Hz test tone -18.1 dB.

## Tests

- `Tests/` (xunit, net8.0): the reading of ffmpeg's report, the thresholds, the command lines, and a real ffmpeg run on a
  generated tone and a generated silence. 13 tests, no game. `dotnet test` in `SoundCapture/Tests`.
- `Check-Steps.ps1`: the patterns compile with Pickle's own engine, none is declared twice or ambiguous.
- In game: `Tests/Pickle/.../pickletools-soundcapture.feature`, pass map `wsl-deps.soundcapture.map`. It answers whether the
  headless game opens an audio output at all; see `docs/runs/` for its result.

## Using it from a suite

```
nelim.pickletools.soundcapture   path:PickleTools/SoundCapture/Mod
```

and tag the feature `@requires:nelim.pickletools.soundcapture`. Muxing the sound into a Pickle `@film` video is not done: the
file sits beside the report, and a person can play both.
