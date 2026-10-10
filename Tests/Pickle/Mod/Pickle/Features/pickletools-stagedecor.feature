# Place a decor thing and a floor on open ground, check both, remove the set, check both are gone.
# (32, 32) is inside the thing-free 9 by 9 square from (30, 30) of test-colony (docs/FIXTURES.md); terrain was not decoded.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.stagedecor.map -Filter pickletools-stagedecor
@requires:nelim.pickletools.stagedecor
# 2026-10-10 (ticket 6bd5): the spots near (30, 30) hold natural rock (Slate) the save does not list; every coordinate moved by (+81, +158), around (113, 190), beside the colonists.
Feature: PickleTools stage decor

  Background:
    Given the save "test-colony" is loaded

  Scenario: a thing and a floor are placed, then removed in one step
    Given Nelim's Pickle Tools: I place the decor "Campfire" at (113, 190)
    And Nelim's Pickle Tools: I lay the floor "WoodPlankFloor" from (115, 190) to (117, 192)
    Then a "Campfire" is at (113, 190)
    When Nelim's Pickle Tools: the decor is removed
    Then no "Campfire" is at (113, 190)

  Scenario: an area is cleared, then its things come back
    Given I spawn a "Steel" at (112, 189)
    When Nelim's Pickle Tools: the area from (111, 188) to (114, 191) is cleared
    Then no "Steel" is at (112, 189)
    When Nelim's Pickle Tools: the decor is removed
    Then a "Steel" is at (112, 189)
    When I destroy the "Steel" at (112, 189)
