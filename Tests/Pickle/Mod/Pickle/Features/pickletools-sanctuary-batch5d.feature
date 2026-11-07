# Batch 5d (NSB owner GO 2026-11-07): prestige-hall as an audience hall (visitors by the north door (196,118), Nelim by the east door (201,108) onto the dais) and the sleeping-nook light swap. Chained: loads Nelims-tribe-decor-mods-q (output of 5c), saves Nelims-tribe-decor-mods-r. Exact cells from NSB; a piece the game refuses is skipped and logged ([decor-skipped]). The marriage spot (196,115) is kept (the interior is cleared in rectangles that skip it). Floors stay under a clear, so the partial gold tile of 5a (x 195 and 198, z 109-114) is copied back from the plain floor of (194,110). Blind placement, not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 5d

  Scenario: sanctuary-batch5d: prestige-hall audience hall and sleeping-nook light swap, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-q" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    # prestige-hall: clear the interior (not walls, doors, nor the marriage spot at 196,115) and the 5a pieces outside the room
    And Nelim's Pickle Tools: the area from (193, 106) to (200, 114) is cleared
    And Nelim's Pickle Tools: the area from (193, 115) to (195, 115) is cleared
    And Nelim's Pickle Tools: the area from (197, 115) to (200, 115) is cleared
    And Nelim's Pickle Tools: the area from (193, 116) to (200, 117) is cleared
    And Nelim's Pickle Tools: the area from (191, 107) to (191, 107) is cleared
    And Nelim's Pickle Tools: the area from (202, 107) to (202, 107) is cleared
    And Nelim's Pickle Tools: the area from (191, 111) to (191, 111) is cleared
    And Nelim's Pickle Tools: the area from (202, 111) to (202, 111) is cleared
    And Nelim's Pickle Tools: the area from (193, 104) to (193, 104) is cleared
    And Nelim's Pickle Tools: the area from (198, 104) to (198, 104) is cleared
    # plain floor back under the old gold tile (copied from 194,110), then the dais and the aisle
    And Nelim's Pickle Tools: the floor of the cell (195, 109) is copied from the cell (194, 110)
    And Nelim's Pickle Tools: the floor of the cell (198, 109) is copied from the cell (194, 110)
    And Nelim's Pickle Tools: the floor of the cell (195, 110) is copied from the cell (194, 110)
    And Nelim's Pickle Tools: the floor of the cell (198, 110) is copied from the cell (194, 110)
    And Nelim's Pickle Tools: the floor of the cell (195, 111) is copied from the cell (194, 110)
    And Nelim's Pickle Tools: the floor of the cell (198, 111) is copied from the cell (194, 110)
    And Nelim's Pickle Tools: the floor of the cell (195, 112) is copied from the cell (194, 110)
    And Nelim's Pickle Tools: the floor of the cell (198, 112) is copied from the cell (194, 110)
    And Nelim's Pickle Tools: the floor of the cell (195, 113) is copied from the cell (194, 110)
    And Nelim's Pickle Tools: the floor of the cell (198, 113) is copied from the cell (194, 110)
    And Nelim's Pickle Tools: the floor of the cell (195, 114) is copied from the cell (194, 110)
    And Nelim's Pickle Tools: the floor of the cell (198, 114) is copied from the cell (194, 110)
    And Nelim's Pickle Tools: I lay the floor "RLE_SquareGoldTile" from (193, 106) to (200, 108)
    And Nelim's Pickle Tools: I lay the floor "RLE_HGSinpCarpetSynthread" from (196, 109) to (197, 117)
    And Nelim's Pickle Tools: I place the decor "milple_GrandThrone" exactly at (196, 107)
    And Nelim's Pickle Tools: the buildings "milple_GrandThrone" from (193, 106) to (193, 106) are turned to face 200
    And Nelim's Pickle Tools: I place the decor "YR_BigDrape_sakura" near (196, 106)
    And Nelim's Pickle Tools: I place the decor "Yuran_Column_one" exactly at (193, 108)
    And Nelim's Pickle Tools: I place the decor "Yuran_Column_one" exactly at (200, 108)
    And Nelim's Pickle Tools: I place the decor "Yuran_CandleStand_three" exactly at (194, 107)
    And Nelim's Pickle Tools: I place the decor "Yuran_CandleStand_three" exactly at (199, 107)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_B" holding "Erin_Plant_Camellia" fully grown at (193, 106)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_B" holding "Erin_Plant_Camellia" fully grown at (200, 106)
    And Nelim's Pickle Tools: I place the decor "Erin_Zabuton" near (194, 110) facing east
    And Nelim's Pickle Tools: I place the decor "Erin_Zabuton" near (199, 110) facing west
    And Nelim's Pickle Tools: I place the decor "Erin_Zabuton" near (194, 112) facing east
    And Nelim's Pickle Tools: I place the decor "Erin_Zabuton" near (199, 112) facing west
    And Nelim's Pickle Tools: I place the decor "Erin_Zabuton" near (194, 114) facing east
    And Nelim's Pickle Tools: I place the decor "Erin_Zabuton" near (199, 114) facing west
    And Nelim's Pickle Tools: I place the decor "Yuran_scroll_BDX" exactly at (193, 113)
    And Nelim's Pickle Tools: I place the decor "Yuran_scroll_BDX" exactly at (200, 113)
    And Nelim's Pickle Tools: I place the decor "Yuran_Statue_lion" near (194, 116) facing east
    And Nelim's Pickle Tools: I place the decor "Yuran_Statue_lion" near (199, 116) facing west
    And Nelim's Pickle Tools: I place the decor "Yuran_CandleStand_two" exactly at (193, 116)
    And Nelim's Pickle Tools: I place the decor "Yuran_CandleStand_two" exactly at (200, 116)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" holding "SCLavender" fully grown at (193, 117)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" holding "SCLavender" fully grown at (200, 117)
    And Nelim's Pickle Tools: the things within 8 cells of (196, 111) are listed
    # sleeping-nook: no stone lanterns in the bedroom (sofa-corner's stays): the two lanterns next to the bed out, andon, candles, a low candle stand
    And Nelim's Pickle Tools: the area from (179, 120) to (179, 120) is cleared
    And Nelim's Pickle Tools: the area from (180, 122) to (180, 122) is cleared
    And Nelim's Pickle Tools: I place the decor "RLE_ArialeAndonOil" near (179, 120)
    And Nelim's Pickle Tools: I place the decor "ED_Candles" near (176, 120)
    And Nelim's Pickle Tools: I place the decor "ED_Candles" near (179, 122)
    And Nelim's Pickle Tools: I place the decor "Yuran_CandleStand_one" near (178, 119)
    And Nelim's Pickle Tools: the things within 5 cells of (177, 121) are listed
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "prestige-hall"
    And I take a screenshot "after-prestige-hall-r"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And I take a screenshot "after-sleeping-nook-r"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-r"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-r" is copied to the run folder
