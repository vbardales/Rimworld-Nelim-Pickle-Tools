# Epona Instruments Renew

Live: every step below is in the repository named, in the file named. Nothing here is staged from PickleTools with a
`path:` line: a suite that wants a step **copies the method** and gives it its own prefix.

Repository: `vbardales/Rimworld-Epona-Instruments-Renew` (in the monorepo, `EponaInstrumentsRenew/`).
Steps: `Tests/Pickle/Source/InstrumentSteps.cs`, one class, 5 steps, built by
`Tests/Pickle/Source/EponaInstrumentsRenew.PickleSteps.csproj` into `Tests/Pickle/Mod/Pickle/Assemblies/` (committed:
the staging mirrors that folder). The assembly references the game, Harmony and Pickle only. The provider's types
(`MusicalInstruments.Comp_PlayingMusic`, `MusicalInstrumentsMod`) are reached by reflection through
`AccessTools.TypeByName`, so Musical Instruments (Continued) is not a build reference and a rename on its side fails a
scenario with the name it looked for.

All texts start with `Epona Instruments Renew `, left out of the table below.

Written 2026-09-23, **not yet played** when this note was written: the results of the first run are added below
when they exist. Until then the table says what each step reads, not that it works.

## What another suite may want

| Step | What it reads or does | Generic? |
|---|---|---|
| `the unfinished item on the bench is completed` | Sets `UnfinishedThing.debugCompleted = true` on every unfinished item of the map, the flag the game's own developer gizmo sets. The recipe code then makes the product, its quality and its art as it would for a player; only the waiting is skipped. Needs a colonist who has started the bill (the unfinished item exists once the ingredients are fetched). Pickle's `I wait for bill` allows 120 real seconds and a wait step five, so a craft of tens of thousands of work cannot be waited for. | **Yes**, for any mod whose recipe is too long to wait for. Only the prefix is ours. |
| `{string} is heard playing {string}` | Reads the provider's static `Comp_PlayingMusic.Notebook[pawn]`, then its private `soundPlaying` field, and asserts a live `Sustainer` (`!Ended`) whose `def.defName` is the one named. Waits up to 25 s. On failure it says whether the pawn is in the notebook at all and what job it has. The sustainer is started from `CompTick`, so this is what a `tickerType` regression breaks. It proves the game **started** the sound, not that a loudspeaker rendered it. | **Yes**, for any mod that adds instruments to Musical Instruments (Continued). |
| `{string} is not heard playing` | The same read, asserting no live sustainer. | **Yes**, same condition. |
| `the provider sound checkbox is {word}` | Writes `MusicalInstrumentsMod.instance.Settings.PlayMusic` (`on` or `off`) in memory and remembers the value it found; an `[AfterScenario]` puts it back whatever the scenario did. The provider starts an instrument's sound only when the checkbox is ticked **and** Royalty is active. | **Yes**, same condition. |
| `texts read as written for the language this pass runs` | Reads the language the game runs (`LanguageDatabase.activeLanguage.folderName`), then the mod's own files: `Languages/French/DefInjected/ThingDef/JoyPreservation.xml` for French, the `<label>`/`<description>` written in `Patches/EponaInstruments.xml` for everything else (a language the mod does not ship falls back to them), and compares each of the three defs' loaded `label` and `description`. One feature, run once per `-Language`, replaces one feature per language that had to be set aside by tag. | **The pattern is generic, the step is not**: the paths and def names are the mod's. Copy it and change them. |

The rest of the suite uses Pickle's own steps only. Recipes worth reading in the feature files:
- `20-craft-and-film.feature`: a crafting scene on the test colony (research finished, bench built, materials at the
  stockpile, a colonist with the work type on priority 1), two waits of 1,800 ticks so the colonist starts the bill,
  the step above, a capture of the product.
- `30-play-and-listen.feature`: a performance scene (colonist with a high Artistic skill and the Art work type on
  priority 1, the provider's `MusicSpot` built, the instrument spawned) and the two sound steps.
- `05-text-screens.feature`: names in whatever language the pass runs without writing them: centre the camera on the
  cell, the hover label at the bottom left names what is under the pointer.
