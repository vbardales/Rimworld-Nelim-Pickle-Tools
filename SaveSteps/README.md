# SaveSteps

Pickle steps that save the running game under a name and hand the saved file to a mod as a Pickle fixture. Developer test companion; stage it with one line in a pass map: `nelim.pickletools.savesteps   path:PickleTools/SaveSteps/Mod`. Not in the Workshop bundle.

Written 2026-10-11 from the same pair of steps that three mods had written alike (Animal Apparel Collars, Drum Bath Hygiene, Anima Song). **Not played yet.**

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the game is saved as {string}` | Saves the game with the game's own saver under that name; fails when the file is not written |
| `Nelim's Pickle Tools: the saved game {string} is handed to the mod {string}` | Copies the saved game into `Pickle/Fixtures` of the active mod with that packageId (any case) as `<name>.rws`, so a later launch loads it as a fixture |

Reading what the save holds (a check of the mod's words in it, for example) stays in the mod's own suite.
