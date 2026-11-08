# Batch 5m (NSB order SanctuaryBacklot/docs/BATCH-5M.md, owner 2026-11-08). Loads Nelims-tribe-decor-mods-y, saves Nelims-tribe-decor-mods-z. NO map-wide despawn: the four named animals stay (Yuki, Shogun, Atticus, Rain). Cells read in save y (awk over the .rws, 2026-11-08): VanometricPowerCell at z 227 x 213-218 (6), z 246 x 213-218 and 220 (7), strays (219,228) and (219,245) (2), all with no rotation; the two others (211,122) and (195,56) are NOT touched. LP_SteppingStone at z 124 x 123-134. milple_TorchLampR at (127,125). NOT PLAYED when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Sanctuary decor batch 5m

  Scenario: sanctuary-batch5m: the vanometric cells moved to the postindustrial workshop, the left-bank lantern out of the water, the stepping stones off the bridge deck, each place photographed, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-y" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    # the four animals must be here before and after: no despawn in this batch
    Then Nelim's Pickle Tools: the animals named "Yuki" are counted
    And Nelim's Pickle Tools: the animals named "Shogun" are counted
    And Nelim's Pickle Tools: the animals named "Atticus" are counted
    And Nelim's Pickle Tools: the animals named "Rain" are counted
    # guard: nothing but a plant is placed on the logo flowers of enclosure-south
    Given Nelim's Pickle Tools: the cells of the growing zones in the area from (130, 204) to (168, 223) are kept free of decor
    # what stands now, for the report and the terrain read of the lantern and stone cells
    When Nelim's Pickle Tools: the things within 12 cells of (127, 125) are listed
    And Nelim's Pickle Tools: the things within 10 cells of (229, 215) are listed
    And Nelim's Pickle Tools: the terrain of the cell (123, 124) is logged
    And Nelim's Pickle Tools: the terrain of the cell (124, 124) is logged
    And Nelim's Pickle Tools: the terrain of the cell (125, 124) is logged
    And Nelim's Pickle Tools: the terrain of the cell (127, 124) is logged
    And Nelim's Pickle Tools: the terrain of the cell (127, 125) is logged
    And Nelim's Pickle Tools: the terrain of the cell (124, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (130, 124) is logged
    And Nelim's Pickle Tools: the terrain of the cell (134, 124) is logged

    # 1a. the vanometric cells leave the barn and workshop rows: 6 + 7 in the two rows, 2 strays next to them (the two cells at (211,122) and (195,56) stay)
    Given Nelim's Pickle Tools: the area from (213, 227) to (218, 227) is cleared
    And Nelim's Pickle Tools: the area from (213, 246) to (218, 246) is cleared
    And Nelim's Pickle Tools: the area from (220, 246) to (220, 246) is cleared
    And Nelim's Pickle Tools: the area from (219, 228) to (219, 228) is cleared
    And Nelim's Pickle Tools: the area from (219, 245) to (219, 245) is cleared

    # 1b. the block against the east wall of the postindustrial workshop: columns x 233 and 234 from z 208 down to z 214 (14 places), the 15th at (232, 208); z 215 and the east door (235,215) stay free; no conduit
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (233, 208)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (233, 209)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (233, 210)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (233, 211)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (233, 212)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (233, 213)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (233, 214)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (234, 208)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (234, 209)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (234, 210)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (234, 211)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (234, 212)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (234, 213)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (234, 214)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (232, 208)

    # 2. the lit lantern (127,125) onto dry land beside the telescope deck, then lit again
    And Nelim's Pickle Tools: the area from (127, 125) to (127, 125) is cleared
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" exactly at (124, 127)
    And Nelim's Pickle Tools: the decor "milple_TorchLampR" at (124, 127) is lit

    # 3. the stepping stones on the bridge deck: the cells x 125 to 134 at z 124 are cleared, the two on land (123,124) and (124,124) stay beside the telescope deck
    And Nelim's Pickle Tools: the area from (125, 124) to (134, 124) is cleared
    And Nelim's Pickle Tools: the things within 12 cells of (127, 125) are listed
    And Nelim's Pickle Tools: the things within 10 cells of (229, 215) are listed
    And Nelim's Pickle Tools: the things within 8 cells of (216, 246) are listed

    # the four animals are still here
    Then Nelim's Pickle Tools: the animals named "Yuki" are counted
    And Nelim's Pickle Tools: the animals named "Shogun" are counted
    And Nelim's Pickle Tools: the animals named "Atticus" are counted
    And Nelim's Pickle Tools: the animals named "Rain" are counted

    # photos, same frames as the 5l photos, noon, no despawn
    When Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "postindustrial-workshop"
    And I take a screenshot "after-postindustrial-workshop-z"
    And Nelim's Sanctuary: I am at the sanctuary "workshops"
    And I take a screenshot "after-workshops-z"
    And Nelim's Sanctuary: I am at the sanctuary "barn"
    And I take a screenshot "after-barn-z"
    And Nelim's Sanctuary: I am at the sanctuary "right-bank"
    And I take a screenshot "after-right-bank-z"
    And Nelim's Sanctuary: I am at the sanctuary "left-bank"
    And I take a screenshot "after-left-bank-z"
    And Nelim's Pickle Tools: I frame the area centred on (120, 124) at root size 7
    And I take a screenshot "after-telescope-close-z"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-z"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-z" is copied to the run folder
