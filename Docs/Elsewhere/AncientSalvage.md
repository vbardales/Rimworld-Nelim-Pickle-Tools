# Nelim's Ancient Salvage

Source: `AncientSalvage/Tests/Pickle/Source/AncientSalvage.PickleSteps/` (compiled, committed, played by features 18 to 20; declared by AncientSalvage session through Ticket Manager, 2026-10-18).

## GallerySteps.cs

- `Nelim's Ancient Salvage: I place the building {string} at ({int}, {int}) facing {word}`: places building with rotation. StageDecor places everything facing north, no rotation, so buildings whose back shows to north need this parameter. Likely first candidate for promotion into StageDecor.
- `the door {string} at ({int}, {int}) is held open`: sets `openInt`, `holdOpenInt`, `visualTicksOpen` on `Building_Door` by reflection (paused game never ticks open door).

## RoomSteps.cs

- `the rectangle from (x1, z1) to (x2, z2) is walled, except from (...) to (...)` and `the rectangle ... is roofed`: sealed room for temperature test.

## Status

One consumer. Promote on second use (see README rule). Not read or replayed here.