# Place a decor thing and a floor on open ground, check both, remove the set, check both are gone.
# (32, 32) is inside the thing-free 9 by 9 square from (30, 30) of test-colony (docs/FIXTURES.md); terrain was not decoded.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.stagedecor.map -Filter pickletools-stagedecor
@requires:nelim.pickletools.stagedecor
Feature: PickleTools stage decor

  Background:
    Given the save "test-colony" is loaded

  Scenario: a thing and a floor are placed, then removed in one step
    Given Nelim's Pickle Tools: I place the decor "Campfire" at (32, 32)
    And Nelim's Pickle Tools: I lay the floor "WoodPlankFloor" from (34, 32) to (36, 34)
    Then a "Campfire" is at (32, 32)
    When Nelim's Pickle Tools: the decor is removed
    Then no "Campfire" is at (32, 32)

  Scenario: an area is cleared, then its things come back
    Given I spawn a "Steel" at (31, 31)
    When Nelim's Pickle Tools: the area from (30, 30) to (33, 33) is cleared
    Then no "Steel" is at (31, 31)
    When Nelim's Pickle Tools: the decor is removed
    Then a "Steel" is at (31, 31)
    When I destroy the "Steel" at (31, 31)
