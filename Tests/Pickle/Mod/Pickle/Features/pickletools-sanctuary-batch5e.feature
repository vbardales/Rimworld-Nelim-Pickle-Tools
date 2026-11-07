# Batch 5e (NSB, 2026-11-07, after 5d): the fence line at z 223 x 152-165 and its gate (163,223) restored (the 5b clear took them), and the dry grass tufts inside the Nelim logo zones of enclosure-south (zones 3 to 15, x 130-168, z 204-223): every wild plant of the zone cells (grass, tall grass, bushes, tree saplings) removed, then the cells replanted with the zone's own flower fully grown, filled cells logged ([zone-filled]). Chained: loads Nelims-tribe-decor-mods-r (output of 5d), saves Nelims-tribe-decor-mods-s. Wild plants outside the zones (the rest of the pen) are NOT touched. Not played when written.
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
    # the fence line between enclosure-south and enclosure-north (z 223, gates at 148 and 163) lost x 152-165 to the 5b clear (152,219)-(165,231): restored here, nothing else touches z 223
    And Nelim's Pickle Tools: I place the decor "Fence" exactly at (152, 223)
    And Nelim's Pickle Tools: I place the decor "Fence" exactly at (153, 223)
    And Nelim's Pickle Tools: I place the decor "Fence" exactly at (154, 223)
    And Nelim's Pickle Tools: I place the decor "Fence" exactly at (155, 223)
    And Nelim's Pickle Tools: I place the decor "Fence" exactly at (156, 223)
    And Nelim's Pickle Tools: I place the decor "Fence" exactly at (157, 223)
    And Nelim's Pickle Tools: I place the decor "Fence" exactly at (158, 223)
    And Nelim's Pickle Tools: I place the decor "Fence" exactly at (159, 223)
    And Nelim's Pickle Tools: I place the decor "Fence" exactly at (160, 223)
    And Nelim's Pickle Tools: I place the decor "Fence" exactly at (161, 223)
    And Nelim's Pickle Tools: I place the decor "Fence" exactly at (162, 223)
    And Nelim's Pickle Tools: I place the decor "Fence" exactly at (164, 223)
    And Nelim's Pickle Tools: I place the decor "Fence" exactly at (165, 223)
    And Nelim's Pickle Tools: I place the decor "FenceGate" exactly at (163, 223)
    # four Braziers of the pen (listing after 4a, absent after 5b: removed by the 5b clears, not from 4a): restored
    And Nelim's Pickle Tools: I place the decor "Brazier" exactly at (152, 231)
    And Nelim's Pickle Tools: I place the decor "Brazier" exactly at (159, 226)
    And Nelim's Pickle Tools: I place the decor "Brazier" exactly at (165, 221)
    And Nelim's Pickle Tools: I place the decor "Brazier" exactly at (165, 230)
    And Nelim's Pickle Tools: the things within 12 cells of (158, 223) are listed
    And Nelim's Pickle Tools: the growing zones in the area from (130, 204) to (168, 223) are cleared of wild plants and filled with "its own" fully grown
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I take a screenshot "after-enclosure-south-s"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-s"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-s" is copied to the run folder
