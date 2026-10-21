# Place a decor thing and a floor on open ground, check both, remove the set, check both are gone.
# (32, 32) is inside the thing-free 9 by 9 square from (30, 30) of test-colony (docs/FIXTURES.md); terrain was not decoded.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.stagedecor.map -Filter pickletools-stagedecor
@requires:nelim.pickletools.stagedecor
# 2026-10-10 (ticket 6bd5): the spots near (30, 30) hold natural rock (Slate) the save does not list; every coordinate moved by (+81, +158), around (113, 190), beside the colonists. Replay 12c5: (113, 190) holds Granite too; moved again by (+33, -35) to around (146, 155), where Epona's suites placed decor without a failure (docs/FIXTURES.md).
Feature: PickleTools stage decor

  Background:
    Given the save "test-colony" is loaded

  Scenario: a thing and a floor are placed, then removed in one step
    Given Nelim's Pickle Tools: I place the decor "Campfire" at (146, 155)
    And Nelim's Pickle Tools: I lay the floor "WoodPlankFloor" from (148, 155) to (150, 157)
    Then a "Campfire" is at (146, 155)
    When Nelim's Pickle Tools: the decor is removed
    Then no "Campfire" is at (146, 155)

  Scenario: an area is cleared, then its things come back
    Given I spawn a "Steel" at (145, 154)
    When Nelim's Pickle Tools: the area from (144, 153) to (147, 156) is cleared
    Then no "Steel" is at (145, 154)
    When Nelim's Pickle Tools: the decor is removed
    Then a "Steel" is at (145, 154)
    When I destroy the "Steel" at (145, 154)

  Scenario: a pot holding a fully grown plant stays whole, then is removed
    Given Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (148, 153)
    Then a "PlantPot" is at (148, 153)
    And a "Plant_Daylily" is at (148, 153)
    When Nelim's Pickle Tools: the decor is removed
    Then no "PlantPot" is at (148, 153)
    And no "Plant_Daylily" is at (148, 153)
