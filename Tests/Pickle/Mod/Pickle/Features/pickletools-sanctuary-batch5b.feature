# Batch 5b (NSB owner verdict, 2026-11-07): plant-garden fence, enclosure-south flowers grown, enclosures enriched. Chained: loads Nelims-tribe-decor-mods-o (output of 5a), saves Nelims-tribe-decor-mods-p. The fence is LP_PlayFence (the only fence/hedge def of the map, see docs/SANCTUARY-DECOR-DEFS.md) one segment per cell around x 180-200, z 78-96 with gaps at the path ends. Blind placement, not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 5b

  Scenario: sanctuary-batch5b: plant-garden fenced, enclosures enriched, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-o" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    # plant-garden: a fence round the whole garden, gaps where the two stone paths leave (x 189-191 north and south, z 85-86 west and east)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (181, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (181, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (182, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (182, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (183, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (183, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (184, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (184, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (185, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (185, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (186, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (186, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (187, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (187, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (188, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (188, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (192, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (192, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (193, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (193, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (194, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (194, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (195, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (195, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (196, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (196, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (197, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (197, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (198, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (198, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (199, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (199, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 78)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 96)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 79)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 79)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 80)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 80)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 81)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 81)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 82)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 82)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 83)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 83)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 84)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 84)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 87)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 87)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 88)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 88)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 89)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 89)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 90)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 90)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 91)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 91)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 92)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 92)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 93)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 93)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 94)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 94)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (180, 95)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" near (200, 95)
    # enclosure-south: the flowers (and every plant of the pens) to full growth so the logo shows
    And Nelim's Pickle Tools: the plants from (130, 204) to (187, 245) are fully grown
    # enclosure (158, 224) and enclosure-north (166, 235): clear the inner bamboo, then paths, troughs, bundles, shelters, shade
    And Nelim's Pickle Tools: the area from (152, 219) to (165, 231) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorGranite" from (152, 226) to (165, 226)
    And Nelim's Pickle Tools: the area from (160, 232) to (172, 239) is cleared
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorGranite" from (160, 236) to (172, 236)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (156, 222)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (160, 224)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (158, 229)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (155, 227)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (154, 224)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (161, 222)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (163, 228)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (157, 220)
    And Nelim's Pickle Tools: I place the decor "Yuran_PenMarker" near (152, 224)
    And Nelim's Pickle Tools: I place the decor "Yuran_PenMarker" near (165, 224)
    And Nelim's Pickle Tools: I place the decor "LP_ShadeCanopy" near (162, 220)
    And Nelim's Pickle Tools: I place the decor "LP_Playhouse" near (154, 229)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeBirch" near (153, 230)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeWillow" near (165, 230)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (164, 234)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (168, 238)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (162, 238)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (163, 234)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (170, 238)
    And Nelim's Pickle Tools: I place the decor "Yuran_PenMarker" near (160, 234)
    And Nelim's Pickle Tools: I place the decor "Yuran_PenMarker" near (171, 234)
    And Nelim's Pickle Tools: I place the decor "LP_ShadeCanopy" near (168, 232)
    And Nelim's Pickle Tools: I place the decor "LP_Playhouse" near (166, 238)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeBirch" near (161, 238)
    # enclosure-south (149, 214): more feeders, bundles, a marker, shade
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (148, 213)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (150, 216)
    And Nelim's Pickle Tools: I place the decor "Yuran_PenMarker" near (147, 212)
    And Nelim's Pickle Tools: I place the decor "LP_ShadeCanopy" near (153, 214)
    And Nelim's Pickle Tools: the plants from (130, 204) to (187, 245) are fully grown
    And Nelim's Pickle Tools: the things within 12 cells of (190, 87) are listed
    And Nelim's Pickle Tools: the things within 12 cells of (158, 224) are listed
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "plant-garden"
    And I take a screenshot "after-plant-garden-p"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure"
    And I take a screenshot "after-enclosure-p"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I take a screenshot "after-enclosure-south-p"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-north"
    And I take a screenshot "after-enclosure-north-p"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-p"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-p" is copied to the run folder
