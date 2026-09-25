# Sound capture - Pickle steps (optional)

Fourteen Pickle steps: seven that record **what the game plays** between two steps (two of them as a video with its sound) and measure it, four that set the game's volumes (master, music, ambience, and both muted), and three that assert what the **game itself** holds as playing (no audio device involved). It is an
optional companion: nothing runs unless a scenario asks for it, nothing in Pickle or in the launcher changes, and it is
not part of the aggregate bundle.

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: I record the sound as {string}` | Starts `ffmpeg` on the monitor of the audio sink and writes `sound.wav` in the report, under the name |
| `Nelim's Pickle Tools: I let {int} real seconds go by` | Waits real seconds, frame by frame (in the main menu no tick passes, so `I wait {int} ticks` cannot be used). 1 to 45 |
| `Nelim's Pickle Tools: I stop recording the sound` | Ends the recording, checks the file, attaches `sound-file` and `sound-note` to the report |
| `Nelim's Pickle Tools: I film with sound as {string}` | **A video with its sound.** Starts the recorder (CD quality, stereo) and a film by the clock, ten pictures a second, in the same step, so the picture and the sound begin together (to within ffmpeg's start, a fraction of a second). Pickle's own `@film` has no sound, and `FilmTicks` films by game ticks, whose length is not the sound's. Works from the main menu, where there are no ticks |
| `Nelim's Pickle Tools: I stop filming with sound` | Ends both, has Pickle's encoder make the video from the pictures at the rate they were taken (so it lasts as long as the sound), and puts the sound into it: `film-sound.mp4`, H.264 and AAC, which Windows plays as it is, in `screenshots/film/pickletools-sound--<name>/`; it also keeps `sound.wav` and Pickle's silent `film.webm`. The sound is cut to the picture's length. Attaches `film-file` and `film-note`. The name can then go to `the sound recorded as ... is not silent`. Up to 600 pictures (a minute) |
| `Nelim's Pickle Tools: the sound recorded as {string} is not silent` | Measures the loudest sample with ffmpeg's `volumedetect`: not silent means above -60 dB, silent below -80 dB |
| `Nelim's Pickle Tools: the sound recorded as {string} is silent` | The same measure, asserting the level is below -80 dB |
| `Nelim's Pickle Tools: the game volume is {int} percent` | Sets the game's master volume for the scenario (the WSL staging writes 0, which mutes the game) and puts the value found back afterwards; nothing is saved to disk |
| `Nelim's Pickle Tools: the game music volume is {int} percent` | The game's background music, apart from the master volume (which would cut the effects a recording wants to hear as well). Put back after the scenario, nothing saved to disk |
| `Nelim's Pickle Tools: the game ambient volume is {int} percent` | The same for the ambience |
| `Nelim's Pickle Tools: the game music and ambience are muted` | Both at 0: a recording then holds what a mod plays and not the menu or map music (Anima Song measured a peak of -14.3 dB from the background music alone on a whole film) |
| `Nelim's Pickle Tools: the game is playing a sound` | Passes as soon as the game holds a live sustainer, a playing one-shot sample or the main menu's music, waiting up to ten real seconds; the failure lists what the game held |
| `Nelim's Pickle Tools: the game is playing the sound {string}` | The same for one sound def by name: a live sustainer or a playing one-shot started from it |

## Where to run it: the WSL, like any test (the owner, 2026-09-25)

A test that uses SoundCapture runs in the headless WSL install as a small ticket, like the others. Earlier on 2026-09-25 a rule
said "alone, and on Windows"; **it was withdrawn the same day**, because the WSL records fine (peak -16.2 dB, see below), and
`AUDIT.md` says so. Two things to know:

- **The WSL profile mutes the game** (`volumeMaster 0`), so a scenario that records starts with
  `Nelim's Pickle Tools: the game volume is 80 percent`; without it the recording reads silence (-91 dB).
- **The sound also plays on the owner's speakers** for the few seconds of the recording, while being recorded: the recorder taps
  the monitor of the WSLg sink, which does not take the sound away from it (the owner heard the menu music during the recorded
  run of 2026-09-25). Keep a recording to a few seconds.

**The Windows game is still the owner's, and no session launches it.** `SoundCapture/Run-Windows.ps1` exists for the owner's own
use, to listen in a profile of its own (`-savedatafolder`, so her `ModsConfig.xml` and `Prefs.xml` are never opened; it adds two
junctions `zz-picklesound-*` to the game's `Mods/` folder and removes them in a `finally`, comparing the listing before and after).
It does nothing without `-Go`; the default is a dry run that checks the machine and prints the plan (checked that way only).
`-Watch` plays the waits in real time and `-Volume` sets the master volume. It is not a session's launcher, and recording on
Windows (no loopback device for ffmpeg there) is not needed for the tests.

## Why the WSL run was silent, now measured, and what Windows lacks

- **The WSL staging writes `volumeMaster 0`** into the profile's `Prefs.xml` (`scripts/stage-pickle-wsl.sh`), so the game is
  muted there by design, and that was the -91 dB of 2026-09-24. **Confirmed on 2026-09-25**: with the step `the game volume is 80 percent`,
  the same scenario, in the WSL install, recorded a **peak of -16.2 dB** (threshold -60), `exitReason: passed`, 1 of 1, and the owner heard
  the main menu's music on her Windows speakers while it ran (the WSLg sink is the way out). So the headless game does open an audio
  output and the recorder does capture it; nothing needed a Windows game for that. Whether the rule of the owner (alone, on Windows)
  still holds is hers to say. What the recording does not say is that it is the RIGHT sound: the `sound.wav` of that run is kept in
  `evidence/aggregate/2026-09-25-v4.9.1-soundcapture-volume-en/` to be listened to. The launcher above writes a volume of 0.8.
- **On Windows, ffmpeg has nothing to record the output with.** `ffmpeg -list_devices true -f dshow -i dummy` lists the webcam and
  "Microphone Array (Realtek(R) Audio)" only: no "Stereo Mix", no loopback device, and this ffmpeg has no WASAPI input. Recording
  the mix takes either enabling a loopback device in Windows' sound settings or a small recorder on the Core Audio loopback API
  (a console tool on NAudio's `WasapiLoopbackCapture`). **Neither is written or tried.**

**What remains to be tested there: the recording.** The tool records through PulseAudio (-f pulse, source RDPSink.monitor), which is a WSL thing, and its input format is not yet a setting (PICKLETOOLS_SOUND_SOURCE names only the source). The game-side steps (	he game is playing a sound, ... the sound {string}) need none of this and run anywhere.

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

and tag the feature `@requires:nelim.pickletools.soundcapture`. A video with its sound is `I film with sound as "name"` ... `I stop
filming with sound` (feature `pickletools-soundfilm.feature`). Muxing the sound into a Pickle `@film` video itself (a scenario tag)
is not done: it would take a change in Pickle, and these two steps need none.

**When the audio server stalls, the recording is short and silent (seen 2026-09-25).** The first play of the video (ticket `56ae`, 21 s of scenario) left a `sound.wav` of 1.5 s, all
at -91 dB, while the volume step had run: WSLg's PulseAudio had begun logging `[rdp-sink] q overrun, queuing locally` every few seconds at the moment the run started,
which is a sink whose channel to Windows drains nothing, and even `ffmpeg -sources pulse` returned nothing. A first version of this note said that an idle sink also sends
the recorder no data; **that was wrong**: after the restart, a 5 s recording of the idle sink ended in 5.9 s and held 5.1 s of silence, so a healthy idle sink delivers silence in real time. What hung the
earlier test was the stalled sink. The steps now compare the length of the file with the real time of the
recording and attach `sound-short` (and repeat it in the failure of `is not silent`) when the file holds much less than the real time. The cure is on the machine: restart WSL's audio
(`wsl --shutdown` between runs, which stops every session's run) after checking Windows' output device.

**What a run of the video proves, and what it does not.** That the mp4 exists and that its sound is not silent (the peak is measured on
`sound.wav`). Whether the picture and the sound are **in step**, and whether the sound is the right one, only a person watching the mp4
says: the two start in one step, but no clapperboard has been filmed to measure the offset. The mux runs on the game's main thread
(a few seconds), like the encode of FilmTicks.
