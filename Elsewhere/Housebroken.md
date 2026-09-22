# Housebroken

Local inventory, 2026-09-22: `Housebroken/Tests/Pickle/Source/` contains Housebroken settings and shortcut steps plus a settings sandbox. Four feature files cover settings, MainButtons, language and RIMMSQOL.

The setting names, defaults and shortcut def belong to Housebroken. The generic parts of opening `Dialog_ModSettings`, writing and reading a setting, and restoring the user's settings have other consumers (including Joy Rescue); review these together for promotion into PickleTools before adding another copy. A shared step must accept the target mod and setting as parameters and preserve the sandbox cleanup contract.

This is source and feature inventory, not a claim that these scenarios passed in game.
