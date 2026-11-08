# Batch 5m-2 (NSB order SanctuaryBacklot/docs/BATCH-5M.md section "Owner fix tout", owner 2026-11-08). Loads Nelims-tribe-decor-mods-z (saved by 5m, MUST be installed in DecorBase before this ticket starts), saves Nelims-tribe-decor-mods-z2. NO map-wide despawn: the four named animals stay. Cells read in save y (5m only moves the vanometric block x 232-234 z 208-214, the lamp (124,127) and the stones x 125-134: kept off here). NOT PLAYED when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Sanctuary decor batch 5m-2

  Scenario: sanctuary-batch5m-2: second right-bank lamp and water path, pond patches back to ground, the playground scroll, fuller workshops and barn, each place photographed, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-z" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    Then Nelim's Pickle Tools: the animals named "Yuki" are counted
    And Nelim's Pickle Tools: the animals named "Shogun" are counted
    And Nelim's Pickle Tools: the animals named "Atticus" are counted
    And Nelim's Pickle Tools: the animals named "Rain" are counted
    Given Nelim's Pickle Tools: the cells of the growing zones in the area from (130, 204) to (168, 223) are kept free of decor
    # terrain read before any change (the water cells at the west end of the right-bank path, the pond patches, the lamp cell of 5m)
    And Nelim's Pickle Tools: the terrain of the cell (134, 125) is logged
    And Nelim's Pickle Tools: the terrain of the cell (135, 125) is logged
    And Nelim's Pickle Tools: the terrain of the cell (136, 125) is logged
    And Nelim's Pickle Tools: the terrain of the cell (137, 125) is logged
    And Nelim's Pickle Tools: the terrain of the cell (138, 125) is logged
    And Nelim's Pickle Tools: the terrain of the cell (139, 125) is logged
    And Nelim's Pickle Tools: the terrain of the cell (140, 125) is logged
    And Nelim's Pickle Tools: the terrain of the cell (134, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (135, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (136, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (137, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (138, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (139, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (140, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (134, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (135, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (136, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (137, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (138, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (139, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (140, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (134, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (135, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (136, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (137, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (138, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (139, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (140, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (134, 129) is logged
    And Nelim's Pickle Tools: the terrain of the cell (135, 129) is logged
    And Nelim's Pickle Tools: the terrain of the cell (136, 129) is logged
    And Nelim's Pickle Tools: the terrain of the cell (137, 129) is logged
    And Nelim's Pickle Tools: the terrain of the cell (138, 129) is logged
    And Nelim's Pickle Tools: the terrain of the cell (139, 129) is logged
    And Nelim's Pickle Tools: the terrain of the cell (140, 129) is logged
    And Nelim's Pickle Tools: the terrain of the cell (124, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (149, 135) is logged
    And Nelim's Pickle Tools: the terrain of the cell (150, 140) is logged
    And Nelim's Pickle Tools: the terrain of the cell (150, 137) is logged
    And Nelim's Pickle Tools: the terrain of the cell (152, 140) is logged
    And Nelim's Pickle Tools: the things within 10 cells of (140, 128) are listed
    And Nelim's Pickle Tools: the things within 6 cells of (112, 114) are listed

    # 0. the vanometric block of 5m: the cell is 1x2 (it covers z and z+1), so 9 of 15 placed and the pair at (233,214) and (234,214) covers z 215 next to the east door (235,215): that pair is taken off, then 8 cells go on the north wall (x 226-231, z 208-209, next to the placed (232,208)) and at (228,210) and (229,210); z 215 and the door stay free
    When Nelim's Pickle Tools: the area from (233, 214) to (234, 215) is cleared
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (226, 208)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (227, 208)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (228, 208)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (229, 208)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (230, 208)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (231, 208)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (228, 210)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (229, 210)

    # 1. right-bank: the stone lamp (137,127) out of the water, the path starts on land: the two west floor cells of row z 127 are bared, the lamp stands on the path east of x 138
    When Nelim's Pickle Tools: the area from (137, 127) to (137, 127) is cleared
    And Nelim's Pickle Tools: the floor of the area from (136, 127) to (137, 127) is bared
    And Nelim's Pickle Tools: I place the decor "Yuran_stonelamp" exactly at (139, 128)

    # 2. the two dark pond patches: natural ground copied from a neighbouring cell, then a few hydrangeas
    And Nelim's Pickle Tools: the floor of the area from (149, 136) to (151, 138) is bared
    And Nelim's Pickle Tools: the floor of the area from (151, 139) to (153, 141) is bared
    And Nelim's Pickle Tools: the floor of the cell (149, 136) is copied from the cell (149, 135)
    And Nelim's Pickle Tools: the floor of the cell (149, 137) is copied from the cell (149, 135)
    And Nelim's Pickle Tools: the floor of the cell (149, 138) is copied from the cell (149, 135)
    And Nelim's Pickle Tools: the floor of the cell (150, 136) is copied from the cell (149, 135)
    And Nelim's Pickle Tools: the floor of the cell (150, 137) is copied from the cell (149, 135)
    And Nelim's Pickle Tools: the floor of the cell (150, 138) is copied from the cell (149, 135)
    And Nelim's Pickle Tools: the floor of the cell (151, 136) is copied from the cell (149, 135)
    And Nelim's Pickle Tools: the floor of the cell (151, 137) is copied from the cell (149, 135)
    And Nelim's Pickle Tools: the floor of the cell (151, 138) is copied from the cell (149, 135)
    And Nelim's Pickle Tools: the floor of the cell (151, 139) is copied from the cell (150, 140)
    And Nelim's Pickle Tools: the floor of the cell (151, 140) is copied from the cell (150, 140)
    And Nelim's Pickle Tools: the floor of the cell (151, 141) is copied from the cell (150, 140)
    And Nelim's Pickle Tools: the floor of the cell (152, 139) is copied from the cell (150, 140)
    And Nelim's Pickle Tools: the floor of the cell (152, 140) is copied from the cell (150, 140)
    And Nelim's Pickle Tools: the floor of the cell (152, 141) is copied from the cell (150, 140)
    And Nelim's Pickle Tools: the floor of the cell (153, 139) is copied from the cell (150, 140)
    And Nelim's Pickle Tools: the floor of the cell (153, 140) is copied from the cell (150, 140)
    And Nelim's Pickle Tools: the floor of the cell (153, 141) is copied from the cell (150, 140)
    And Nelim's Pickle Tools: I place the decor "SCPinkhydrangea" at (149, 137) fully grown
    And Nelim's Pickle Tools: I place the decor "SCBluehydrangea" at (150, 138) fully grown
    And Nelim's Pickle Tools: I place the decor "SCWhitehydrangea" at (151, 136) fully grown
    And Nelim's Pickle Tools: I place the decor "SCPinkhydrangea" at (152, 140) fully grown
    And Nelim's Pickle Tools: I place the decor "SCBluehydrangea" at (153, 139) fully grown
    And Nelim's Pickle Tools: I place the decor "SCWhitehydrangea" at (151, 141) fully grown

    # 3. left-bank: the scroll shares the cell (112,114) with LP_PlayFence: the cell is cleared, the fence is put back
    And Nelim's Pickle Tools: the area from (112, 114) to (112, 114) is cleared
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (112, 114)

    # 4. workshop paths widened to 2 cells (bamboo cleared on the added cells only; (218,226) holds a thing and stays single)
    And Nelim's Pickle Tools: the area from (206, 232) to (216, 232) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (206, 232) to (216, 232)
    And Nelim's Pickle Tools: the area from (206, 242) to (216, 242) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (206, 242) to (216, 242)
    And Nelim's Pickle Tools: the area from (207, 226) to (217, 226) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (207, 226) to (217, 226)
    And Nelim's Pickle Tools: the area from (219, 226) to (222, 226) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (219, 226) to (222, 226)
    And Nelim's Pickle Tools: the area from (208, 225) to (208, 231) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (208, 225) to (208, 231)
    And Nelim's Pickle Tools: the area from (221, 221) to (221, 228) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (221, 221) to (221, 228)
    And Nelim's Pickle Tools: the area from (237, 215) to (237, 224) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (237, 215) to (237, 224)
    And Nelim's Pickle Tools: the area from (223, 225) to (236, 225) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (223, 225) to (236, 225)

    # 5. preindustrial workshop: the two skipped cabinets on free wall spots, more benches and crates, a lit work zone (aisle x 223 stays free)
    And Nelim's Pickle Tools: I place the decor "Yuran_LowCabinet" near (219, 242)
    And Nelim's Pickle Tools: I place the decor "Yuran_BigOldCabinet" near (226, 243)
    And Nelim's Pickle Tools: I place the decor "milple_HandTailoringBench" near (221, 234)
    And Nelim's Pickle Tools: I place the decor "Yuran_Table_a" near (221, 243)
    And Nelim's Pickle Tools: I place the decor "Yuran_StorageCrateWood" near (228, 241)
    And Nelim's Pickle Tools: I place the decor "Yuran_StorageCrateWood" near (219, 232)
    And Nelim's Pickle Tools: I place the decor "milple_FermentingBarrel" near (228, 244)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" exactly at (220, 236)
    And Nelim's Pickle Tools: the decor "milple_TorchLampR" at (220, 236) is lit
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" exactly at (227, 236)
    And Nelim's Pickle Tools: the decor "milple_TorchLampR" at (227, 236) is lit

    # 6. postindustrial workshop: machines and crates on the west side and the south half, aisles from each door kept (x 224 and z 210, z 215, z 221)
    And Nelim's Pickle Tools: I place the decor "Yuran_MechanicalForgingTable" near (227, 218)
    And Nelim's Pickle Tools: I place the decor "FueledSmithy" near (227, 212)
    And Nelim's Pickle Tools: I place the decor "Yuran_StorageCrateIron" near (226, 213)
    And Nelim's Pickle Tools: I place the decor "Yuran_StorageCrateSteel" near (228, 221)
    And Nelim's Pickle Tools: I place the decor "Yuran_LowCabinet" near (229, 220)

    # 7. barn east half (x 199-204): one more table group
    And Nelim's Pickle Tools: I place the decor "Yuran_LongTable_b" near (203, 237)
    And Nelim's Pickle Tools: I place the decor "DiningChair" near (202, 238)
    And Nelim's Pickle Tools: I place the decor "DiningChair" near (204, 238)
    And Nelim's Pickle Tools: I place the decor "Yuran_LowBigCabinet" near (203, 242)
    And Nelim's Pickle Tools: the things within 10 cells of (140, 128) are listed
    And Nelim's Pickle Tools: the things within 12 cells of (223, 237) are listed
    And Nelim's Pickle Tools: the things within 12 cells of (229, 215) are listed
    And Nelim's Pickle Tools: the things within 12 cells of (200, 237) are listed

    Then Nelim's Pickle Tools: the animals named "Yuki" are counted
    And Nelim's Pickle Tools: the animals named "Shogun" are counted
    And Nelim's Pickle Tools: the animals named "Atticus" are counted
    And Nelim's Pickle Tools: the animals named "Rain" are counted

    When Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "postindustrial-workshop"
    And I take a screenshot "after-postindustrial-workshop-z2"
    And Nelim's Sanctuary: I am at the sanctuary "preindustrial-workshop"
    And I take a screenshot "after-preindustrial-workshop-z2"
    And Nelim's Sanctuary: I am at the sanctuary "workshops"
    And I take a screenshot "after-workshops-z2"
    And Nelim's Sanctuary: I am at the sanctuary "barn"
    And I take a screenshot "after-barn-z2"
    And Nelim's Sanctuary: I am at the sanctuary "right-bank"
    And I take a screenshot "after-right-bank-z2"
    And Nelim's Sanctuary: I am at the sanctuary "left-bank"
    And I take a screenshot "after-left-bank-z2"
    And Nelim's Pickle Tools: I frame the area centred on (120, 124) at root size 7
    And I take a screenshot "after-telescope-close-z2"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-z2"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-z2" is copied to the run folder
