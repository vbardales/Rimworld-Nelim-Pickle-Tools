# Why this folder exists

This folder is not a translation. It exists so that RimWorld stops logging

    Mod Nelim's Pickle Tools - Film ticks did not load any content.

at every start. `LoadedModManager.LoadModContent` (1.6) logs that error for any active mod whose
`ModContentPack.AnyContentLoaded()` returns false, and that method counts any file at all under a
`Languages/` folder. This companion ships only `About/` and a steps assembly under `Pickle/`, which
RimWorld does not load itself - Pickle does - so nothing else would satisfy it.

`LanguageDatabase` enumerates *directories* under `Languages/`, never loose files, so this file is never
parsed and no key enters any database. Do not add a language subfolder here: the moment
`Languages/<Language>/` exists its files are loaded for real.
