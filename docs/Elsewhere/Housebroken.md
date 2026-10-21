# Housebroken

Local inventory, 2026-09-22: `Housebroken/Tests/Pickle/Source/` has Housebroken settings and shortcut steps plus settings sandbox. Four feature files cover settings, MainButtons, language, RIMMSQOL.

Setting names, defaults, shortcut def belong to Housebroken. Generic parts (opening `Dialog_ModSettings`, writing/reading setting, restoring user settings) have other consumers (including Joy Rescue); review together for promotion into PickleTools before adding another copy. Shared step must accept target mod and setting as parameters, preserve sandbox cleanup contract.

Source and feature inventory only, not claim scenarios passed in game.