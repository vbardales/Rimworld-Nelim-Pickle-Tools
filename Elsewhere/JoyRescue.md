# Joy Rescue

Local inventory, 2026-09-22: `JoyRescue/Tests/Pickle/Source/SettingsSteps.cs` contains steps for its settings dialog, values, persistence and hidden MainButton. Two feature files cover native options and the shortcut.

The setting keys and `JoyRescue_Settings` def are local. The dialog and settings persistence mechanics overlap with Housebroken and several other suites, so extract the generic part into PickleTools when those consumers migrate; keep Joy Rescue's assertions about its own settings and shortcut local.

This inventory has not replayed the scenarios or validated the settings in game.
