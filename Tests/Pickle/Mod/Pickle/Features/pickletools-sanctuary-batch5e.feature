# Batch 5e (NSB, 2026-11-07, after 5d): the dry grass tufts inside the Nelim logo zones of enclosure-south (zones 3 to 15, x 130-168, z 204-223): every wild plant of the zone cells (grass, tall grass, bushes, tree saplings) removed, then the cells replanted with the zone's own flower fully grown, filled cells logged ([zone-filled]). Chained: loads Nelims-tribe-decor-mods-r (output of 5d), saves Nelims-tribe-decor-mods-s. Wild plants outside the zones (the rest of the pen) are NOT touched. Not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 5e

  Scenario: sanctuary-batch5e: enclosure-south logo zones cleared of wild plants and replanted, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-r" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the growing zones in the area from (130, 204) to (168, 223) are cleared of wild plants and filled with "its own" fully grown
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I take a screenshot "after-enclosure-south-s"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-s"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-s" is copied to the run folder
