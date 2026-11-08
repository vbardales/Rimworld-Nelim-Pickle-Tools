# Batch 5k (NSB order SanctuaryBacklot/docs/BATCH-5K.md, owner go 2026-11-08). Loads Nelims-tribe-decor-mods-w, saves Nelims-tribe-decor-mods-x. NO map-wide despawn: the four named animals stay (Yuki, Shogun, Atticus, Rain), counted before the first edit and after the last. WRITTEN BLIND, NOT PLAYED (map wsl-deps.sanctuary-decor-mods.map gained adaptive.storage.framework 3033901359: the Yuran racks, barrels and crates live in YuranASF_StorageBuilding, loaded only with it): cells outside the ones NSB gave (workshops walls and insides) are indicative, a 'near' placement that finds no cell is skipped and logged ([decor-skipped]); defs that NSB did not name or that are not things (Yuran_Rockgroove is a designator group, not a building; Yuran_Steam*, Spidercamps plants, Decorative Trees, Yuran_mossstonefloor*, LP_SteppingStone border, Yuran_scroll_*) are NOT placed, the report asks NSB for exact defNames. Floors named by NSB are laid exactly (a wrong floor def fails the ticket on purpose: it names the def). Rule kept: nothing on the Nelim logo flowers (zones 3 to 15 of enclosure-south, x 130-168 z 204-223); validated places (enclosure, playground, smiley-west) are not touched.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Sanctuary decor batch 5k

  Scenario: sanctuary-batch5k: workshops redone, right-bank, gravel-yard and the left-bank telescope staged, each place photographed, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-w" is loaded
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
    # what stands now where the order is staged, for the report
    When Nelim's Pickle Tools: the things within 14 cells of (112, 111) are listed
    And Nelim's Pickle Tools: the things within 12 cells of (170, 143) are listed
    And Nelim's Pickle Tools: the things within 12 cells of (144, 132) are listed

    # 1a. preindustrial-workshop: interior (x 218-228, z 230-244) to bare floor, walls, doors, barn and bamboo outside untouched (the roof holders stay)
    Given Nelim's Pickle Tools: the area from (218, 230) to (228, 244) is emptied, the roof holders kept
    And Nelim's Pickle Tools: I lay the floor "Yuran_woodfloor" from (218, 230) to (228, 244)
    # one craft per zone, aisle x 223 free (z 230-244): west wall = wood and leather and cloth racks plus tools, east wall = barrels and crates, benches either side of the aisle
    And Nelim's Pickle Tools: I place the decor "Yuran_LogRack" near (218, 232)
    And Nelim's Pickle Tools: I place the decor "Yuran_LeatherRack" near (218, 235)
    And Nelim's Pickle Tools: I place the decor "Yuran_FabricRack" near (218, 238)
    And Nelim's Pickle Tools: I place the decor "Yuran_ToolsCabinet" near (218, 242)
    And Nelim's Pickle Tools: I place the decor "Yuran_Barrel" near (228, 232)
    And Nelim's Pickle Tools: I place the decor "milple_FermentingBarrel" near (228, 234)
    And Nelim's Pickle Tools: I place the decor "Yuran_StorageCrateWood" near (228, 237)
    And Nelim's Pickle Tools: I place the decor "milple_HandTailoringBench" near (221, 239)
    And Nelim's Pickle Tools: I place the decor "FueledSmithy" near (225, 242)
    And Nelim's Pickle Tools: I place the decor "Yuran_SignLamp_Smith" near (224, 230)
    And Nelim's Pickle Tools: I place the decor "Yuran_SignLamp_tailor" near (222, 230)

    # 1b. postindustrial-workshop: interior (x 224-234, z 208-222), door east (235,215): machines on the west wall, one central table, free floor east
    And Nelim's Pickle Tools: the area from (224, 208) to (234, 222) is emptied, the roof holders kept
    And Nelim's Pickle Tools: I place the decor "Yuran_SteamLoom" near (225, 218)
    And Nelim's Pickle Tools: I place the decor "Yuran_PharmaceuticalWorkbench" near (225, 212)
    And Nelim's Pickle Tools: I place the decor "Table2x2c" near (229, 215)
    And Nelim's Pickle Tools: I place the decor "Yuran_StorageCrateIron" near (225, 209)
    And Nelim's Pickle Tools: I place the decor "Yuran_StorageCrateSteel" near (225, 221)

    # 1c. stone path through the bamboo between the barn and the workshops (cells indicative: the report lists the terrain it covered)
    And Nelim's Pickle Tools: the terrain of the cell (214, 237) is logged
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (210, 237) to (217, 237)

    # 2. right-bank, frame (144,132) zoom 11: garden promenade (pavilion, table, cushions, path, ponds, statue, bench, fence)
    And Nelim's Pickle Tools: I place the decor "Yuran_ClearSpringPavilion" near (144, 132)
    And Nelim's Pickle Tools: I place the decor "Erin_LowTable" near (144, 131)
    And Nelim's Pickle Tools: I place the decor "Erin_Zabuton" near (143, 130)
    And Nelim's Pickle Tools: I place the decor "Erin_Zabuton" near (146, 130)
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (136, 127) to (152, 127)
    And Nelim's Pickle Tools: I place the decor "Yuran_stonelamp" near (138, 128)
    And Nelim's Pickle Tools: I place the decor "Yuran_stonelamp" near (146, 128)
    And Nelim's Pickle Tools: I place the decor "Yuran_stonelamp" near (152, 128)
    And Nelim's Pickle Tools: I place the decor "Yuran_pond_one" near (138, 136)
    And Nelim's Pickle Tools: I place the decor "Yuran_pond_two" near (141, 139)
    And Nelim's Pickle Tools: I place the decor "Yuran_pond_three" near (146, 138)
    And Nelim's Pickle Tools: I place the decor "Yuran_pond_four" near (150, 137)
    And Nelim's Pickle Tools: I place the decor "Yuran_pond_five" near (152, 140)
    And Nelim's Pickle Tools: I place the decor "Yuran_Statue_pagodasmall" near (149, 132)
    And Nelim's Pickle Tools: I place the decor "LP_GardenBench" near (140, 130)
    And Nelim's Pickle Tools: I place the decor "LP_GardenBench" near (150, 134)
    And Nelim's Pickle Tools: I place the decor "Yuran_woodfence" near (136, 124)
    And Nelim's Pickle Tools: I place the decor "Yuran_woodfence" near (138, 124)
    And Nelim's Pickle Tools: I place the decor "Yuran_woodfence" near (140, 124)

    # 3. gravel-yard, frame (170,143) zoom 11.2: karesansui court, clear then raked gravel, rock gardens, lamps, pagoda statue on the torii axis, nothing tall in the centre
    And Nelim's Pickle Tools: the area from (162, 136) to (178, 150) is emptied
    And Nelim's Pickle Tools: the terrain of the cell (170, 143) is logged
    And Nelim's Pickle Tools: I lay the floor "RLE_CultivatedGravel" from (162, 136) to (178, 150)
    And Nelim's Pickle Tools: I place the decor "Yuran_RockGarden_one" near (165, 139)
    And Nelim's Pickle Tools: I place the decor "Yuran_RockGarden_two" near (167, 146)
    And Nelim's Pickle Tools: I place the decor "Yuran_RockGarden_three" near (174, 139)
    And Nelim's Pickle Tools: I place the decor "Yuran_RockGarden_four" near (175, 147)
    And Nelim's Pickle Tools: I place the decor "Yuran_RockGarden_five" near (164, 143)
    And Nelim's Pickle Tools: I place the decor "Yuran_RockGarden_six" near (176, 143)
    And Nelim's Pickle Tools: I place the decor "Yuran_RockGarden_seven" near (170, 138)
    And Nelim's Pickle Tools: I place the decor "Yuran_RockGarden_eight" near (170, 148)
    And Nelim's Pickle Tools: I place the decor "Yuran_RockGarden_nine" near (172, 145)
    And Nelim's Pickle Tools: I place the decor "Yuran_woodfence" near (162, 135)
    And Nelim's Pickle Tools: I place the decor "Yuran_woodfence" near (164, 135)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (162, 142)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (178, 142)
    And Nelim's Pickle Tools: I place the decor "Yuran_stonelamp" near (170, 136)
    And Nelim's Pickle Tools: I place the decor "Yuran_Statue_pagoda" near (170, 151)

    # 4. left-bank telescope, frame (112,111): the base-game Telescope listed above, a wooden deck centred on the frame, bench, lamp, path from the bridge (cells indicative, the report lists the Telescope cell)
    And Nelim's Pickle Tools: I lay the floor "Yuran_woodfloor" from (110, 109) to (114, 113)
    And Nelim's Pickle Tools: I place the decor "LP_GardenBench" near (110, 114)
    And Nelim's Pickle Tools: I place the decor "Yuran_stonelamp" near (115, 109)
    And Nelim's Pickle Tools: I place the decor "Yuran_stonelamp" near (109, 109)
    And Nelim's Pickle Tools: the things within 8 cells of (112, 111) are listed
    And Nelim's Pickle Tools: the things within 8 cells of (170, 143) are listed
    And Nelim's Pickle Tools: the things within 8 cells of (144, 132) are listed
    And Nelim's Pickle Tools: the things within 12 cells of (223, 237) are listed
    And Nelim's Pickle Tools: the things within 12 cells of (229, 215) are listed

    # the four animals are still here
    Then Nelim's Pickle Tools: the animals named "Yuki" are counted
    And Nelim's Pickle Tools: the animals named "Shogun" are counted
    And Nelim's Pickle Tools: the animals named "Atticus" are counted
    And Nelim's Pickle Tools: the animals named "Rain" are counted

    # photos, same frames as the photos feature (place registered by `I am at the sanctuary`), noon, no despawn
    When Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "workshops"
    And I take a screenshot "after-workshops-x"
    And Nelim's Sanctuary: I am at the sanctuary "preindustrial-workshop"
    And I take a screenshot "after-preindustrial-workshop-x"
    And Nelim's Sanctuary: I am at the sanctuary "postindustrial-workshop"
    And I take a screenshot "after-postindustrial-workshop-x"
    And Nelim's Sanctuary: I am at the sanctuary "right-bank"
    And I take a screenshot "after-right-bank-x"
    And Nelim's Sanctuary: I am at the sanctuary "gravel-yard"
    And I take a screenshot "after-gravel-yard-x"
    And Nelim's Sanctuary: I am at the sanctuary "left-bank"
    And I take a screenshot "after-left-bank-x"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-x"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-x" is copied to the run folder
