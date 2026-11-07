# Batch 3a (NSB order, Virginie 2026-11-07, third order places 8 to 10): hearth-hall with its four corners, fire-pit, sleeping-nook. Chained: loads Nelims-tribe-decor-mods-j (output of 2g, ticket 270a), saves Nelims-tribe-decor-mods-k in the run folder. No electricity (fuel light only), a decor that finds no cell is skipped and logged (near = within 4 cells, one free cell around). Blind placement from the SanctuarySites centres, not played when written: Virginie reviews place by place and each change is a small rework ticket.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 3a

  Scenario: sanctuary-batch3a: hearth-hall corners, fire-pit and sleeping-nook dressed, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-j" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    # hearth-hall: a plant in each corner, a fuel lamp on the long wall sides, small paintings
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" near (174, 107)
    And Nelim's Pickle Tools: I place the decor "Erin_Plant_Orchid" near (189, 107)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_B" near (174, 123)
    And Nelim's Pickle Tools: I place the decor "Erin_Plant_Camellia" near (189, 123)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (181, 107)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (181, 123)
    And Nelim's Pickle Tools: I place the decor "DecorativePainting_EasternClassic" near (178, 106)
    And Nelim's Pickle Tools: I place the decor "DecorativePainting_Landscape" near (185, 106)
    # fire-pit: four seats round the brick square, incense burner, logs, a brazier at each side
    And Nelim's Pickle Tools: I place the decor "Yuran_chair_one" near (178, 115)
    And Nelim's Pickle Tools: I place the decor "Yuran_chair_one" near (184, 115)
    And Nelim's Pickle Tools: I place the decor "Yuran_Treestump" near (181, 112)
    And Nelim's Pickle Tools: I place the decor "Yuran_Treestump" near (181, 118)
    And Nelim's Pickle Tools: I place the decor "YR_Bigthurible" near (181, 115)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (185, 118)
    And Nelim's Pickle Tools: I place the decor "Yuran_Brazier_two" near (177, 112)
    And Nelim's Pickle Tools: I place the decor "Yuran_Brazier_two" near (185, 112)
    # sleeping-nook: plush, plant, painting, fuel lamp by the beds
    And Nelim's Pickle Tools: I place the decor "AKN_ComfortingPlush" near (177, 122)
    And Nelim's Pickle Tools: I place the decor "ED_Plushie" near (179, 122)
    And Nelim's Pickle Tools: I place the decor "Erin_Plant_Camellia" near (176, 120)
    And Nelim's Pickle Tools: I place the decor "SCLavender" near (180, 120)
    And Nelim's Pickle Tools: I place the decor "DecorativePainting_Animal" near (178, 119)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (177, 120)
    And Nelim's Pickle Tools: the plants from (170, 104) to (200, 126) are fully grown
    And Nelim's Pickle Tools: the things within 9 cells of (181, 115) are listed
    And Nelim's Pickle Tools: the things within 5 cells of (178, 121) are listed
    And Nelim's Pickle Tools: the things within 3 cells of (118, 117) are listed
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "hearth-hall"
    And I take a screenshot "after-hearth-hall-k"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "fire-pit"
    And I take a screenshot "after-fire-pit-k"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And I take a screenshot "after-sleeping-nook-k"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-k"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-k" is copied to the run folder
