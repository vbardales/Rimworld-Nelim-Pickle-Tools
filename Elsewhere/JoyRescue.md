# Joy Rescue

Local inventory, 2026-09-22: `JoyRescue/Tests/Pickle/Source/SettingsSteps.cs` has steps for settings dialog, values, persistence, hidden MainButton. Two feature files cover native options and shortcut.

Setting keys and `JoyRescue_Settings` def local. Dialog and settings persistence mechanics overlap with Housebroken and several other suites. Extract generic part into PickleTools when those consumers migrate; keep Joy Rescue's assertions about own settings and shortcut local.

Inventory has not replayed scenarios or validated settings in game.