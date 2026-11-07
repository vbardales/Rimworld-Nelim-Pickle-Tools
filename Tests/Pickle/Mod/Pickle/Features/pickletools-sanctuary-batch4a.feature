# Batch 4a (NSB order, owner GO 2026-11-07): plant-garden, the three enclosures, the three workshops. Chained: loads Nelims-tribe-decor-mods-l (output of 3b), saves Nelims-tribe-decor-mods-m in the run folder; batch 4b loads -m. Blind placement with the defNames proven in 2g to 3b (no listing of new decor defs yet), not played when written: a decor that finds no cell is skipped and logged. Cells are inside the extents of NSB SANCTUAIRE-LIEUX.md.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 4a

  Scenario: sanctuary-batch4a: plant-garden, enclosures and workshops dressed, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-l" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    # plant-garden (190, 85): stone paths crossing, one specimen of each decorative plant proven so far, low hedge at the west edge, lantern, bench
    And Nelim's Pickle Tools: the floor of the area from (189, 79) to (191, 92) is set to the terrain "Yuran_flatstonefloorGranite"
    And Nelim's Pickle Tools: the floor of the area from (181, 85) to (199, 86) is set to the terrain "Yuran_flatstonefloorGranite"
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" near (184, 82)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" near (196, 82)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" near (184, 89)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" near (196, 89)
    And Nelim's Pickle Tools: I place the decor "Erin_Plant_Camellia" near (186, 83)
    And Nelim's Pickle Tools: I place the decor "Erin_Plant_Orchid" near (194, 83)
    And Nelim's Pickle Tools: I place the decor "SCLavender" near (186, 89)
    And Nelim's Pickle Tools: I place the decor "SCPinkhydrangea" near (194, 89)
    And Nelim's Pickle Tools: I place the decor "SCBluehydrangea" near (190, 82)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" near (183, 85)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" near (197, 85)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" near (188, 90)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_B" near (192, 80)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeBirch" near (183, 92)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeWillow" near (197, 92)
    And Nelim's Pickle Tools: I place the decor "Plant_Bush" near (181, 80)
    And Nelim's Pickle Tools: I place the decor "Plant_Bush" near (181, 82)
    And Nelim's Pickle Tools: I place the decor "Plant_Bush" near (181, 88)
    And Nelim's Pickle Tools: I place the decor "Plant_Bush" near (181, 90)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (190, 87)
    And Nelim's Pickle Tools: I place the decor "LP_GardenBench" near (187, 84)
    And Nelim's Pickle Tools: the plants from (178, 76) to (202, 98) are fully grown
    And Nelim's Pickle Tools: the things within 12 cells of (190, 85) are listed
    # enclosure (158, 224): feeders, bamboo bundles, pen markers, shade trees, a canopy; room left for the animals
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (156, 222)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (160, 226)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (158, 230)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (155, 224)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (161, 222)
    And Nelim's Pickle Tools: I place the decor "Yuran_PenMarker" near (152, 226)
    And Nelim's Pickle Tools: I place the decor "Yuran_PenMarker" near (165, 226)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeBirch" near (150, 220)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeWillow" near (168, 230)
    And Nelim's Pickle Tools: I place the decor "LP_ShadeCanopy" near (162, 220)
    # enclosure-south (149, 214)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (147, 212)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (151, 216)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (146, 214)
    And Nelim's Pickle Tools: I place the decor "Yuran_PenMarker" near (145, 216)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeWillow" near (152, 212)
    # enclosure-north (166, 235)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (164, 233)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (168, 237)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (163, 235)
    And Nelim's Pickle Tools: I place the decor "Yuran_PenMarker" near (170, 235)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeBirch" near (160, 238)
    And Nelim's Pickle Tools: I place the decor "LP_ShadeCanopy" near (168, 232)
    And Nelim's Pickle Tools: the things within 12 cells of (158, 224) are listed
    # workshops (214, 226), preindustrial-workshop (223, 237), postindustrial-workshop (229, 215): shelves, a tidy bench, fuel wall lamps, bamboo, a plant
    And Nelim's Pickle Tools: I place the decor "Shelf" near (212, 224)
    And Nelim's Pickle Tools: I place the decor "Shelf" near (216, 224)
    And Nelim's Pickle Tools: I place the decor "milple_Table1x2c" near (214, 228)
    And Nelim's Pickle Tools: I place the decor "milple_TorchWallLamp" near (211, 226)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (218, 226)
    And Nelim's Pickle Tools: I place the decor "PlantPot" near (213, 222)
    And Nelim's Pickle Tools: I place the decor "Shelf" near (221, 235)
    And Nelim's Pickle Tools: I place the decor "Shelf" near (225, 235)
    And Nelim's Pickle Tools: I place the decor "milple_Table1x2c" near (223, 239)
    And Nelim's Pickle Tools: I place the decor "milple_TorchWallLamp" near (220, 237)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (222, 240)
    And Nelim's Pickle Tools: I place the decor "Shelf" near (227, 213)
    And Nelim's Pickle Tools: I place the decor "Shelf" near (231, 213)
    And Nelim's Pickle Tools: I place the decor "milple_Table1x2c" near (229, 218)
    And Nelim's Pickle Tools: I place the decor "milple_TorchWallLamp" near (226, 215)
    And Nelim's Pickle Tools: I place the decor "PlantPot" near (232, 217)
    And Nelim's Pickle Tools: the things within 10 cells of (214, 226) are listed
    And Nelim's Pickle Tools: the things within 8 cells of (223, 237) are listed
    And Nelim's Pickle Tools: the things within 8 cells of (229, 215) are listed
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "plant-garden"
    And I take a screenshot "after-plant-garden-m"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure"
    And I take a screenshot "after-enclosure-m"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I take a screenshot "after-enclosure-south-m"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-north"
    And I take a screenshot "after-enclosure-north-m"
    And Nelim's Sanctuary: I am at the sanctuary "workshops"
    And I take a screenshot "after-workshops-m"
    And Nelim's Sanctuary: I am at the sanctuary "preindustrial-workshop"
    And I take a screenshot "after-preindustrial-workshop-m"
    And Nelim's Sanctuary: I am at the sanctuary "postindustrial-workshop"
    And I take a screenshot "after-postindustrial-workshop-m"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-m"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-m" is copied to the run folder
