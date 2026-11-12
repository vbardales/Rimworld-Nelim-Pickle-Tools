# Epona Instruments Renew

Live: every step below in named repo, named file. Nothing here staged from PickleTools with `path:` line: suite wanting step **copies method**, gives own prefix.

Repository: `vbardales/Rimworld-Epona-Instruments-Renew` (in monorepo, `EponaInstrumentsRenew/`).
Steps: `Tests/Pickle/Source/InstrumentSteps.cs`, one class, 6 steps, built by
`Tests/Pickle/Source/EponaInstrumentsRenew.PickleSteps.csproj` into `Tests/Pickle/Mod/Pickle/Assemblies/` (committed:
staging mirrors that folder). Assembly references game, Harmony, Pickle only. Provider types
(`MusicalInstruments.Comp_PlayingMusic`, `MusicalInstrumentsMod`) reached by reflection via
`AccessTools.TypeByName`, so Musical Instruments (Continued) not build reference; rename on its side fails
scenario with name it looked for.

All texts start with `Epona Instruments Renew `, left out of table below.

Written 2026-09-23, **not yet played** when note written: first run results added below
when exist. Until then table says what each step reads, not that it works.

## What another suite may want

| Step | What it reads or does | Generic? |
|---|---|---|
| `the unfinished item on the bench is completed` | Sets `UnfinishedThing.debugCompleted = true` on every unfinished item of map, flag game's own developer gizmo sets. Recipe code then makes product, quality, art as for player; only waiting skipped. Needs colonist who started bill (unfinished item exists once ingredients fetched). Pickle's `I wait for bill` allows 120 real seconds, wait step five, so craft of tens of thousands of work cannot be waited for. | **Yes**, any mod whose recipe too long to wait for. Only prefix ours. |
| `{string} is heard playing {string}` | Reads provider's static `Comp_PlayingMusic.Notebook[pawn]`, then private `soundPlaying` field, asserts live `Sustainer` (`!Ended`) whose `def.defName` is one named. Waits up to 25 s. On failure says whether pawn in notebook at all and what job it has. Sustainer started from `CompTick`, so this is what `tickerType` regression breaks. Proves game **started** sound, not that loudspeaker rendered it. | **Yes**, any mod adding instruments to Musical Instruments (Continued). |
| `{string} is not heard playing` | Same read, asserting no live sustainer. | **Yes**, same condition. |
| `the provider sound checkbox is {word}` | Writes `MusicalInstrumentsMod.instance.Settings.PlayMusic` (`on` or `off`) in memory, remembers value found; `[AfterScenario]` restores it whatever scenario did. Provider starts instrument sound only when checkbox ticked **and** Royalty active. | **Yes**, same condition. |
| `the recipe {string} is {word}` | `RecipeDef.AvailableNow` (`available` or `unavailable`), question bench's bill menu asks: false while `researchPrerequisite` not finished. Combined with Pickle's `research {string} is finished` shows recipe appearing with research. | **Yes**, any mod whose recipes wait for research. Only prefix ours. |
| `texts read as written for the language this pass runs` | Reads language game runs (`LanguageDatabase.activeLanguage.folderName`), then mod's own files: `Languages/French/DefInjected/ThingDef/JoyPreservation.xml` for French, `<label>`/`<description>` written in `Patches/EponaInstruments.xml` for everything else (language mod does not ship falls back to them), compares each of three defs' loaded `label` and `description`. One feature, run once per `-Language`, replaces one feature per language that had to be set aside by tag. | **Pattern generic, step not**: paths and def names are mod's. Copy it, change them. |

Rest of suite uses Pickle's own steps only. Recipes worth reading in feature files:
- `20-craft-and-film.feature`: crafting scene on test colony (research finished, bench built, materials at
  stockpile, colonist with work type priority 1), two waits of 1,800 ticks so colonist starts bill,
  step above, capture of product.
- `30-play-and-listen.feature`: performance scene (colonist with high Artistic skill, provider's `MusicSpot`
  built, instrument spawned), step `{string} is offered the music joy and starts it` (asks provider's own
  `JoyGiverDef` `MusicPlay` for its job and starts it; WORK route only serves venues that are instruments) and
  two sound steps.
- `05-text-screens.feature`: names in whatever language pass runs without writing them: centre camera on
  cell, hover label at bottom left names what is under pointer.