# Sound capture - Pickle steps (optional)

Nine Pickle steps: five that record **what the game plays** between two steps and measure it, one that sets the game's master volume, and three that assert what the **game itself** holds as playing (no audio device involved). It is an
optional companion: nothing runs unless a scenario asks for it, nothing in Pickle or in the launcher changes, and it is
not part of the aggregate bundle.

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: I record the sound as {string}` | Starts `ffmpeg` on the monitor of the audio sink and writes `sound.wav` in the report, under the name |
| `Nelim's Pickle Tools: I let {int} real seconds go by` | Waits real seconds, frame by frame (in the main menu no tick passes, so `I wait {int} ticks` cannot be used). 1 to 45 |
| `Nelim's Pickle Tools: I stop recording the sound` | Ends the recording, checks the file, attaches `sound-file` and `sound-note` to the report |
| `Nelim's Pickle Tools: the sound recorded as {string} is not silent` | Measures the loudest sample with ffmpeg's `volumedetect`: not silent means above -60 dB, silent below -80 dB |
| `Nelim's Pickle Tools: the sound recorded as {string} is silent` | The same measure, asserting the level is below -80 dB |
| `Nelim's Pickle Tools: the game volume is {int} percent` | Sets the game's master volume for the scenario (the WSL staging writes 0, which mutes the game) and puts the value found back afterwards; nothing is saved to disk |
| `Nelim's Pickle Tools: the game is playing a sound` | Passes as soon as the game holds a live sustainer, a playing one-shot sample or the main menu's music, waiting up to ten real seconds; the failure lists what the game held |
| `Nelim's Pickle Tools: the game is playing the sound {string}` | The same for one sound def by name: a live sustainer or a playing one-shot started from it |

## Where and how to run it: alone, and on Windows (the owner, 2026-09-25)

**Any test that uses SoundCapture is run ALONE, and on the Windows install**, not in the headless WSL install:

- **Alone**: no other Pickle test queued with it or around it. A recording listens to the machine's whole audio output, so
  anything else playing pollutes it, and the run takes the owner's machine and delays her.
- **On Windows**: the WSL install produced one measurement, silence at -91 dB, with no explanation (see below), and nothing
  proves the game plays into that sink at all. The Windows game is the one with real audio.
- **The mod list is changed for the run, then put back**: stage the test companion and this tool, note the list first, and
  restore exactly that list afterwards (`ModsConfig.xml`), the way any audit restores what it changed. The owner's mod list is
  not left as the test set it.

This is an **exception to the absolute rule of `AUDIT.md` that no session launches the Windows game**, given by the owner for
these tests only on 2026-09-25 and now written in `AUDIT.md` itself (protocols repository). **Nothing has been launched on
Windows for it, and none is to be until the owner asks for that run.**

**The launcher: `SoundCapture/Run-Windows.ps1`**, for this case only (and for the owner's own listening: `-Watch` plays the
waits in real time, `-Volume` sets the master volume). It does nothing without `-Go`; the default is a dry run that checks the
machine and prints the plan. What it does with `-Go -UnderLock`, and only through `scripts/Use-Wsl.ps1`, which queues, takes the
machine lock and logs it:

```powershell
powershell.exe -ExecutionPolicy Bypass -File scripts/Use-Wsl.ps1 -Reason 'SoundCapture on Windows (owner exception)' `
  -Command "powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:/Users/nelim/Documents/rimworld/PickleTools/SoundCapture/Run-Windows.ps1 -Go -UnderLock"
```

1. Refuses if the Windows game or the WSL game is running, or Steam is not (the Workshop copies of Harmony and Pickle must be
   installed; `-PickleSrc` puts a local Pickle build in their place).
2. **Changes the mod list without touching hers**: the game is started with `-savedatafolder` on a profile of its own
   (`.build/windows-sound/profile`), where it writes `Config/ModsConfig.xml` (Harmony, Core, the DLC, Pickle, the test companion and
   the map's mods, read from `Tests/Pickle/wsl-deps.soundcapture.map`) and `Config/Prefs.xml`. Her `ModsConfig.xml`, `Prefs.xml`,
   saves and settings are never opened. `-savedatafolder` is what the game documents for this; **not yet seen working here**.
3. Puts the test companion and the map's local mods in the game's `Mods/` folder as junctions named `zz-picklesound-*` and
   **removes them in a `finally`**, comparing the folder's listing before and after (exit 3 if they differ).
4. Runs Pickle's autorun with the filter, waits for the game to end by itself, and closes only the process it started if it
   outlives its timeout plus a margin. Copies the report to `-EvidenceDir`, and reads `exitReason` before the counts.

**Checked on 2026-09-25: the dry run only** (it printed the plan and listed the WSL game that was running as a reason it would
refuse). No junction was created and no game was launched.

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

and tag the feature `@requires:nelim.pickletools.soundcapture`. Muxing the sound into a Pickle `@film` video is not done: the
file sits beside the report, and a person can play both.
