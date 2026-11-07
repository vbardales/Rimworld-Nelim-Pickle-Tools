# Batch 5a (NSB owner verdict on 3a, 3b, 4a, 2026-11-07): house fixes. Chained: loads Nelims-tribe-decor-mods-n (output of 4b), saves Nelims-tribe-decor-mods-o in the run folder; batch 5b loads -o. Cells from the things-near listings of 3b (junit of sanctuary-batch3b). A cleared cell loses every thing on it, then the replacement is placed. Defs from docs/SANCTUARY-DECOR-DEFS.md. Blind placement, not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 5a

  Scenario: sanctuary-batch5a: sofa-corner, dining-nook, prestige-hall and sleeping-nook fixed, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-n" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    # sofa-corner: shelf upside down becomes a bookcase facing south (the room), plants into pots, vase off the lamp
    And Nelim's Pickle Tools: the area from (185, 124) to (185, 124) is cleared
    And Nelim's Pickle Tools: I place the decor "YR_SmallBookcase" near (185, 124) facing south
    And Nelim's Pickle Tools: the area from (184, 124) to (184, 124) is cleared
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "SCLavender" fully grown at (184, 124)
    And Nelim's Pickle Tools: the area from (189, 122) to (189, 122) is cleared
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_B" holding "Erin_Plant_Camellia" fully grown at (189, 122)
    And Nelim's Pickle Tools: the area from (187, 121) to (187, 121) is cleared
    And Nelim's Pickle Tools: I place the decor "milple_VaseB" near (187, 120)
    # dining-nook: orchid potted, sideboard, scroll, candles on the table and stands, chairs all round
    And Nelim's Pickle Tools: the area from (177, 106) to (177, 106) is cleared
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" holding "Erin_Plant_Orchid" fully grown at (177, 106)
    And Nelim's Pickle Tools: I place the decor "Yuran_LowCabinet" near (176, 106)
    And Nelim's Pickle Tools: I place the decor "Yuran_scroll_BDX" near (175, 106)
    And Nelim's Pickle Tools: I place the decor "ED_Candles" near (175, 108)
    And Nelim's Pickle Tools: I place the decor "Yuran_CandleStand_one" near (173, 108)
    And Nelim's Pickle Tools: I place the decor "Yuran_CandleStand_one" near (180, 108)
    And Nelim's Pickle Tools: I place the decor "Yuran_chair_two" near (176, 107)
    And Nelim's Pickle Tools: I place the decor "Yuran_chair_two" near (177, 109)
    And Nelim's Pickle Tools: I place the decor "Yuran_chair_two" near (174, 110)
    # prestige-hall: symmetric about x 196: scattered braziers cleared, grand throne, lions, columns, armchairs, flags, candle stands, gilded carpet, Camellia potted
    And Nelim's Pickle Tools: the area from (190, 114) to (190, 114) is cleared
    And Nelim's Pickle Tools: the area from (190, 116) to (190, 116) is cleared
    And Nelim's Pickle Tools: the area from (193, 106) to (193, 106) is cleared
    And Nelim's Pickle Tools: the area from (196, 114) to (196, 114) is cleared
    And Nelim's Pickle Tools: the area from (200, 116) to (200, 116) is cleared
    And Nelim's Pickle Tools: the area from (199, 112) to (199, 112) is cleared
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_B" holding "Erin_Plant_Camellia" fully grown at (199, 112)
    And Nelim's Pickle Tools: I lay the floor "RLE_SquareGoldTile" from (195, 108) to (198, 114)
    And Nelim's Pickle Tools: I place the decor "milple_GrandThrone" near (196, 106)
    And Nelim's Pickle Tools: I place the decor "Yuran_Statue_lion" near (192, 108)
    And Nelim's Pickle Tools: I place the decor "Yuran_Statue_lion" near (201, 108)
    And Nelim's Pickle Tools: I place the decor "Yuran_Column_one" near (192, 112)
    And Nelim's Pickle Tools: I place the decor "Yuran_Column_one" near (201, 112)
    And Nelim's Pickle Tools: I place the decor "milple_Armchair" near (193, 113)
    And Nelim's Pickle Tools: I place the decor "milple_Armchair" near (200, 113)
    And Nelim's Pickle Tools: I place the decor "Yuran_FlagFaction" near (194, 105)
    And Nelim's Pickle Tools: I place the decor "Yuran_FlagFaction" near (198, 105)
    And Nelim's Pickle Tools: I place the decor "Yuran_CandleStand_two" near (194, 114)
    And Nelim's Pickle Tools: I place the decor "Yuran_CandleStand_two" near (199, 114)
    And Nelim's Pickle Tools: I place the decor "Yuran_Statue_buddha" near (196, 116)
    # sleeping-nook: the lantern off the foot of the bed
    And Nelim's Pickle Tools: the area from (177, 120) to (177, 120) is cleared
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (179, 120)
    And Nelim's Pickle Tools: the plants from (170, 104) to (204, 126) are fully grown
    And Nelim's Pickle Tools: the things within 6 cells of (187, 122) are listed
    And Nelim's Pickle Tools: the things within 5 cells of (176, 108) are listed
    And Nelim's Pickle Tools: the things within 7 cells of (196, 111) are listed
    And Nelim's Pickle Tools: the things within 4 cells of (177, 121) are listed
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "sofa-corner"
    And I take a screenshot "after-sofa-corner-o"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "dining-nook"
    And I take a screenshot "after-dining-nook-o"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "prestige-hall"
    And I take a screenshot "after-prestige-hall-o"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And I take a screenshot "after-sleeping-nook-o"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-o"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-o" is copied to the run folder
