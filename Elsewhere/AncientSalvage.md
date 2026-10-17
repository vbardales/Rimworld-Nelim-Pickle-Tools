# Nelim's Ancient Salvage

Source: `AncientSalvage/Tests/Pickle/Source/AncientSalvage.PickleSteps/` (compiled, committed, played by
features 18 to 20; declared by the AncientSalvage session through the Ticket Manager, 2026-10-18).

## GallerySteps.cs

- `Nelim's Ancient Salvage: I place the building {string} at ({int}, {int}) facing {word}`: places a building
  with a rotation. StageDecor places everything facing north, with no rotation, so buildings whose back shows
  to the north need this parameter. Most likely first candidate for promotion into StageDecor.
- `the door {string} at ({int}, {int}) is held open`: sets `openInt`, `holdOpenInt` and `visualTicksOpen` on
  `Building_Door` by reflection (a paused game never ticks an open door).

## RoomSteps.cs

- `the rectangle from (x1, z1) to (x2, z2) is walled, except from (...) to (...)` and
  `the rectangle ... is roofed`: a sealed room for a temperature test.

## Status

One consumer. Promote on the second use (see the README rule). Not read or replayed here.
