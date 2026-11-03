# Exploration of the steps written 2026-11-03 for RimScentExtended: trait degree, room temperature, fuelled burner, corpse and food rot, static read.
# Spots as in pickletools-stagedecor-room.feature (docs/FIXTURES.md); the expected values are what the steps should give.
#
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.worldprobe.map -Filter pickletools-colonistrace-worldprobe
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.stagedecor
Feature: PickleTools world probe steps

  Background:
    Given the save "test-colony" is loaded

  Scenario: a trait at a degree, a static read
    Given a colonist "Ash" exists
    And Nelim's Pickle Tools: "Ash" has the trait "Nerves" at degree 2
    Then Nelim's Pickle Tools: the static member "TicksPerDay" of the type "GenDate" is "60000"

  Scenario: a room held at a temperature, a corpse and spoiled food, a fuelled torch
    Given Nelim's Pickle Tools: a closed roofed room is built at (144, 149) of 5 by 3
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (145, 150)
    And Nelim's Pickle Tools: the building "TorchLamp" at (145, 150) is fuelled
    And Nelim's Pickle Tools: the room at (146, 150) is held at 45 degrees
    And Nelim's Pickle Tools: a rotting corpse of the kind "Muffalo" is placed at (147, 150)
    And Nelim's Pickle Tools: the thing "MealSimple" is placed at (146, 150) at 1 of its time to rot
    When Nelim's Pickle Tools: the decor is removed
    Then no "TorchLamp" is at (145, 150)
