# Batch 5i (NSB, 2026-11-08, owner verdict on 5h prestige-hall: too dark): fuel and flame lights, no electricity. Chained: loads Nelims-tribe-decor-mods-u (output of 5g), saves Nelims-tribe-decor-mods-v in the run folder. Four milple_TorchLampR (stone lantern, fuel) at the hall sides, the four Yuran_CandleStand_one/two cells swapped for Yuran_CandleStand_three, all lit. Wall, doors, drape, throne facing, aisle carpet, zabutons, scrolls and marriage spot untouched. Shots at noon and at night, same frame as 5f. Defs from docs/SANCTUARY-DECOR-DEFS.md. Blind placement, not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Sanctuary decor batch 5i

  Scenario: sanctuary-batch5i: prestige-hall lit with torch lamps and stronger candle stands, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-u" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    # candle stands: the one/two stands swapped for the stronger three
    And Nelim's Pickle Tools: the things within 4 cells of (194, 107) are listed
    And Nelim's Pickle Tools: the area from (194, 107) to (194, 107) is cleared
    And Nelim's Pickle Tools: I place the decor "Yuran_CandleStand_three" exactly at (194, 107)
    And Nelim's Pickle Tools: the area from (199, 107) to (199, 107) is cleared
    And Nelim's Pickle Tools: I place the decor "Yuran_CandleStand_three" exactly at (199, 107)
    And Nelim's Pickle Tools: the area from (193, 116) to (193, 116) is cleared
    And Nelim's Pickle Tools: I place the decor "Yuran_CandleStand_three" exactly at (193, 116)
    And Nelim's Pickle Tools: the area from (200, 116) to (200, 116) is cleared
    And Nelim's Pickle Tools: I place the decor "Yuran_CandleStand_three" exactly at (200, 116)
    # four torch lamps off the aisle (x196-197) and the zabutons (x194, x199)
    And Nelim's Pickle Tools: the area from (193, 111) to (193, 111) is cleared
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" exactly at (193, 111)
    And Nelim's Pickle Tools: the area from (200, 111) to (200, 111) is cleared
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" exactly at (200, 111)
    And Nelim's Pickle Tools: the area from (193, 115) to (193, 115) is cleared
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" exactly at (193, 115)
    And Nelim's Pickle Tools: the area from (200, 115) to (200, 115) is cleared
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" exactly at (200, 115)
    And Nelim's Pickle Tools: the building "milple_TorchLampR" at (193, 111) is fuelled
    And Nelim's Pickle Tools: the building "milple_TorchLampR" at (200, 111) is fuelled
    And Nelim's Pickle Tools: the building "milple_TorchLampR" at (193, 115) is fuelled
    And Nelim's Pickle Tools: the building "milple_TorchLampR" at (200, 115) is fuelled
    And I wait 120 ticks
    And Nelim's Pickle Tools: the things within 12 cells of (196, 111) are listed
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "prestige-hall"
    And Nelim's Pickle Tools: I frame the cells (192, 104) to (201, 118) filling 92 percent of the screen
    And I take a screenshot "after-prestige-hall-v"
    # same frame at night: the lights are the point
    And I set the hour to 0
    And I wait 120 ticks
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And Nelim's Sanctuary: I am at the sanctuary "prestige-hall"
    And Nelim's Pickle Tools: I frame the cells (192, 104) to (201, 118) filling 92 percent of the screen
    And I take a screenshot "after-prestige-hall-v-night"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-v"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-v" is copied to the run folder
