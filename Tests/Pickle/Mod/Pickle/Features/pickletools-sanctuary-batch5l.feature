# Batch 5l (NSB order SanctuaryBacklot/docs/BATCH-5L.md, owner go "ok 5l" 2026-11-08). Loads Nelims-tribe-decor-mods-x, saves Nelims-tribe-decor-mods-y. NO map-wide despawn: the four named animals stay (Yuki, Shogun, Atticus, Rain). Cells read in save x (ASCII map of walls, doors and bamboo, 2026-11-08). NOT PLAYED when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Sanctuary decor batch 5l

  Scenario: sanctuary-batch5l: workshop paths and fill, right-bank ponds fence and lamp, the telescope deck moved, each place photographed, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-x" is loaded
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
    # guard: from here nothing but a plant is placed on the logo flowers of enclosure-south
    Given Nelim's Pickle Tools: the cells of the growing zones in the area from (130, 204) to (168, 223) are kept free of decor
    # what stands now, for the report
    When Nelim's Pickle Tools: the things within 14 cells of (112, 111) are listed
    And Nelim's Pickle Tools: the things within 12 cells of (144, 132) are listed
    And Nelim's Pickle Tools: the things within 10 cells of (125, 124) are listed
    And Nelim's Pickle Tools: the terrain of the cell (108, 111) is logged
    And Nelim's Pickle Tools: the terrain of the cell (116, 111) is logged
    And Nelim's Pickle Tools: the terrain of the cell (112, 111) is logged

    # 1a. paths between the workshops, bamboo cleared on the path cells only (one row, one column at a time: the map read in save x shows only bamboo on these cells)
    # barn east doors (205,231) and (205,243) to the west doors of the preindustrial workshop (217,231) and (217,243)
    Given Nelim's Pickle Tools: the area from (206, 231) to (216, 231) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (206, 231) to (216, 231)
    And Nelim's Pickle Tools: the area from (206, 243) to (216, 243) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (206, 243) to (216, 243)
    # trunk along z 225 from x 207 to 222 and the branch x 207 up to the barn path
    And Nelim's Pickle Tools: the area from (207, 225) to (222, 225) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (207, 225) to (222, 225)
    And Nelim's Pickle Tools: the area from (207, 226) to (207, 230) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (207, 226) to (207, 230)
    # x 222 strip from the west door of the postindustrial workshop (223,221) down to the north door of the preindustrial workshop (223,229)
    And Nelim's Pickle Tools: the area from (222, 221) to (222, 228) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (222, 221) to (222, 228)
    And Nelim's Pickle Tools: the area from (223, 228) to (223, 228) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (223, 228) to (223, 228)
    # east door of the postindustrial workshop (235,215): out to x 236, south to z 224, west along z 224 to the strip
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (236, 215) to (236, 224)
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (223, 224) to (235, 224)

    # 1b. preindustrial-workshop: more things (the first six crates, racks and barrels of 5k did not place: Yuran ASF defs, logged again here)
    And Nelim's Pickle Tools: I place the decor "Yuran_LogRack" near (218, 232)
    And Nelim's Pickle Tools: I place the decor "Yuran_LeatherRack" near (218, 235)
    And Nelim's Pickle Tools: I place the decor "Yuran_FabricRack" near (218, 238)
    And Nelim's Pickle Tools: I place the decor "Yuran_OldCabinet" near (218, 240)
    And Nelim's Pickle Tools: I place the decor "Yuran_LowCabinet" near (218, 244)
    And Nelim's Pickle Tools: I place the decor "Yuran_Barrel" near (228, 232)
    And Nelim's Pickle Tools: I place the decor "Yuran_StorageCrateWood" near (228, 237)
    And Nelim's Pickle Tools: I place the decor "milple_FermentingBarrel" near (228, 241)
    And Nelim's Pickle Tools: I place the decor "Yuran_BigOldCabinet" near (228, 244)
    And Nelim's Pickle Tools: I place the decor "Yuran_LongTable_a" near (226, 232)

    # 1c. postindustrial-workshop: second machine, cabinets, crates, free floor east kept
    And Nelim's Pickle Tools: I place the decor "Yuran_MechanicalForgingTable" near (231, 211)
    And Nelim's Pickle Tools: I place the decor "Yuran_ReactionCabinet" near (225, 215)
    And Nelim's Pickle Tools: I place the decor "Yuran_LowBigCabinet" near (225, 208)
    And Nelim's Pickle Tools: I place the decor "Yuran_StorageCrateIron" near (225, 209)
    And Nelim's Pickle Tools: I place the decor "Yuran_StorageCrateSteel" near (225, 221)
    And Nelim's Pickle Tools: I place the decor "Yuran_ResearchTable" near (231, 220)

    # 1d. barn (hall west of x 205): shelving, crates and benches along the walls, between the braziers
    And Nelim's Pickle Tools: I place the decor "Yuran_LowCabinet" near (196, 233)
    And Nelim's Pickle Tools: I place the decor "Yuran_OldCabinet" near (196, 238)
    And Nelim's Pickle Tools: I place the decor "Yuran_LowBigCabinet" near (196, 242)
    And Nelim's Pickle Tools: I place the decor "Yuran_StorageCrateWood" near (203, 233)
    And Nelim's Pickle Tools: I place the decor "Yuran_StorageCrateIron" near (203, 241)
    And Nelim's Pickle Tools: I place the decor "Yuran_LongTable_a" near (200, 236)

    # 2. right-bank (144,132): keep only Yuran_pond_three, destroy four (150,137) and five (152,140), their cells to stone path
    And Nelim's Pickle Tools: the area from (150, 137) to (150, 137) is cleared
    And Nelim's Pickle Tools: the area from (152, 140) to (152, 140) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (149, 136) to (151, 138)
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (151, 139) to (153, 141)
    # the sticks on the bridge: Yuran_woodfence at (136,124) (138,124) (140,124), the deck under them stays
    And Nelim's Pickle Tools: the area from (136, 124) to (136, 124) is cleared
    And Nelim's Pickle Tools: the area from (138, 124) to (138, 124) is cleared
    And Nelim's Pickle Tools: the area from (140, 124) to (140, 124) is cleared
    # the lamp in the water (140,126) moves to the stone path (row z 127 laid by 5k), lit
    And Nelim's Pickle Tools: the area from (140, 126) to (140, 126) is cleared
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" exactly at (141, 128)
    And Nelim's Pickle Tools: the decor "milple_TorchLampR" at (141, 128) is lit

    # 3. left-bank: the wrong deck patch of 5k (110-114, 109-113) bared, its things taken (lamps (109,109) (115,109), scrolls (111,113) (113,113), bench (110,114), stepping stones (112,105-108)); the playground fence and the scroll on the fence row stay
    And Nelim's Pickle Tools: the floor of the area from (110, 109) to (114, 113) is bared
    And Nelim's Pickle Tools: the area from (109, 109) to (109, 109) is cleared
    And Nelim's Pickle Tools: the area from (115, 109) to (115, 109) is cleared
    And Nelim's Pickle Tools: the area from (111, 113) to (111, 113) is cleared
    And Nelim's Pickle Tools: the area from (113, 113) to (113, 113) is cleared
    And Nelim's Pickle Tools: the area from (110, 114) to (110, 114) is cleared
    And Nelim's Pickle Tools: the area from (112, 105) to (112, 108) is cleared
    # the real telescope (120,124): deck x 118-122, z 122-126, bench, lamps, scrolls, flowers, stepping-stone path east along z 124 to the bridge (135,124)
    And Nelim's Pickle Tools: I lay the floor "Yuran_woodfloor" from (118, 122) to (122, 126)
    And Nelim's Pickle Tools: I place the decor "LP_GardenBench" near (120, 121)
    And Nelim's Pickle Tools: I place the decor "Yuran_stonelamp" near (118, 127)
    And Nelim's Pickle Tools: I place the decor "Yuran_stonelamp" near (122, 127)
    And Nelim's Pickle Tools: I place the decor "Yuran_scroll_BDX" near (119, 123)
    And Nelim's Pickle Tools: I place the decor "Yuran_scroll_HJQJ" near (121, 125)
    And Nelim's Pickle Tools: I place the decor "Yuran_scroll_XSYR" near (120, 126)
    And Nelim's Pickle Tools: a flower border is planted around the square from (118, 122) to (122, 126)
    And Nelim's Pickle Tools: I place the decor "LP_SteppingStone" exactly at (123, 124)
    And Nelim's Pickle Tools: I place the decor "LP_SteppingStone" exactly at (124, 124)
    And Nelim's Pickle Tools: I place the decor "LP_SteppingStone" exactly at (125, 124)
    And Nelim's Pickle Tools: I place the decor "LP_SteppingStone" exactly at (126, 124)
    And Nelim's Pickle Tools: I place the decor "LP_SteppingStone" exactly at (127, 124)
    And Nelim's Pickle Tools: I place the decor "LP_SteppingStone" exactly at (128, 124)
    And Nelim's Pickle Tools: I place the decor "LP_SteppingStone" exactly at (129, 124)
    And Nelim's Pickle Tools: I place the decor "LP_SteppingStone" exactly at (130, 124)
    And Nelim's Pickle Tools: I place the decor "LP_SteppingStone" exactly at (131, 124)
    And Nelim's Pickle Tools: I place the decor "LP_SteppingStone" exactly at (132, 124)
    And Nelim's Pickle Tools: I place the decor "LP_SteppingStone" exactly at (133, 124)
    And Nelim's Pickle Tools: I place the decor "LP_SteppingStone" exactly at (134, 124)
    And Nelim's Pickle Tools: the things within 8 cells of (112, 111) are listed
    And Nelim's Pickle Tools: the things within 12 cells of (144, 132) are listed
    And Nelim's Pickle Tools: the things within 12 cells of (125, 124) are listed
    And Nelim's Pickle Tools: the things within 12 cells of (223, 237) are listed
    And Nelim's Pickle Tools: the things within 12 cells of (229, 215) are listed

    # the four animals are still here
    Then Nelim's Pickle Tools: the animals named "Yuki" are counted
    And Nelim's Pickle Tools: the animals named "Shogun" are counted
    And Nelim's Pickle Tools: the animals named "Atticus" are counted
    And Nelim's Pickle Tools: the animals named "Rain" are counted

    # photos, same frames as the 5k photos, noon, no despawn, plus a close shot of the telescope
    When Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "workshops"
    And I take a screenshot "after-workshops-y"
    And Nelim's Sanctuary: I am at the sanctuary "preindustrial-workshop"
    And I take a screenshot "after-preindustrial-workshop-y"
    And Nelim's Sanctuary: I am at the sanctuary "postindustrial-workshop"
    And I take a screenshot "after-postindustrial-workshop-y"
    And Nelim's Sanctuary: I am at the sanctuary "right-bank"
    And I take a screenshot "after-right-bank-y"
    And Nelim's Sanctuary: I am at the sanctuary "left-bank"
    And I take a screenshot "after-left-bank-y"
    And Nelim's Pickle Tools: I frame the area centred on (120, 124) at root size 7
    And I take a screenshot "after-telescope-close-y"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-y"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-y" is copied to the run folder
