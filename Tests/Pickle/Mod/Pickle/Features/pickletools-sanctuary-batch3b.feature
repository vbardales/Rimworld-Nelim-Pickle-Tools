# Batch 3b (NSB order, third order places 11 to 13): sofa-corner, dining-nook, prestige-hall. Chained: loads Nelims-tribe-decor-mods-k (output of 3a), saves Nelims-tribe-decor-mods-l in the run folder. Same rules as 3a; blind placement, not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 3b

  Scenario: sanctuary-batch3b: sofa-corner, dining-nook and prestige-hall dressed, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-k" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    # sofa-corner: low table with a vase, plants, shelf, painting
    And Nelim's Pickle Tools: I place the decor "milple_Table1x2c" near (187, 121)
    And Nelim's Pickle Tools: I place the decor "milple_VaseB" near (187, 121)
    And Nelim's Pickle Tools: I place the decor "SCLavender" near (184, 124)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_B" near (190, 124)
    And Nelim's Pickle Tools: I place the decor "Shelf" near (186, 125)
    And Nelim's Pickle Tools: I place the decor "DecorativePainting_Animal" near (189, 119)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (184, 120)
    # dining-nook: vase on the table, two more seats, a fuel lamp, a plant
    And Nelim's Pickle Tools: I place the decor "milple_VaseB" near (176, 108)
    And Nelim's Pickle Tools: I place the decor "Yuran_chair_two" near (174, 108)
    And Nelim's Pickle Tools: I place the decor "Yuran_chair_two" near (178, 108)
    And Nelim's Pickle Tools: I place the decor "milple_CStoolS" near (176, 110)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (173, 110)
    And Nelim's Pickle Tools: I place the decor "Erin_Plant_Orchid" near (178, 106)
    # prestige-hall: fuel lamps, classic paintings, two large plants, a fuel lantern
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (194, 108)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (199, 108)
    And Nelim's Pickle Tools: I place the decor "DecorativePainting_EasternClassic" near (195, 106)
    And Nelim's Pickle Tools: I place the decor "DecorativePainting_EasternClassic" near (198, 106)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" near (194, 116)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_B" near (199, 116)
    And Nelim's Pickle Tools: I place the decor "RLE_ArialeAndonOil" near (196, 113)
    And Nelim's Pickle Tools: I place the decor "Erin_Plant_Camellia" near (199, 112)
    And Nelim's Pickle Tools: the plants from (170, 104) to (200, 126) are fully grown
    And Nelim's Pickle Tools: the things within 6 cells of (187, 122) are listed
    And Nelim's Pickle Tools: the things within 5 cells of (176, 108) are listed
    And Nelim's Pickle Tools: the things within 6 cells of (196, 111) are listed
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "sofa-corner"
    And I take a screenshot "after-sofa-corner-l"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "dining-nook"
    And I take a screenshot "after-dining-nook-l"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "prestige-hall"
    And I take a screenshot "after-prestige-hall-l"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-l"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-l" is copied to the run folder
