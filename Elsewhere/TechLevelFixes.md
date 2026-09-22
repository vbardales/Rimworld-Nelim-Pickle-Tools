# Nelim's Tech Level Fixes

Inventory review, 2026-09-22: `TechLevelFixes/Tests/Pickle/` has feature files and no local C# source
in `Tests/Pickle/Source/`. There are no local step methods to recover from this checkout.

`01-alone.feature` and `02-with-sources.feature` separate the bare pass from the pass carrying the
source mods (`wsl-deps.sources.map`). The reusable part is the scenario/pass arrangement, not a new
step assembly. Read `Tests/Pickle/README.md` and its dated `results/` for the actual assertions and
recorded outcomes. Their presence is not a new validation of those outcomes.
