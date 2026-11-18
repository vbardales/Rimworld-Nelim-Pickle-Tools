# terrain of the river-bridge area of the Sanctuary fixture (CaT/SaB, 2026-11-18): which cells hold a bridge deck, which are water, where a fence can be placed.
@requires:nelim.pickletools.colonistrace
Feature: bridge terrain

  Scenario: bridge-terrain: terrain of x 122 to 141, z 122 to 126 and the placement of a fence
    Given the save "Nelims-tribe-decor-mods-z3" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the terrain of the area from (122, 122) to (141, 126) is logged with the placement of "Yuran_blackwoodfence"
    Then no errors were logged
