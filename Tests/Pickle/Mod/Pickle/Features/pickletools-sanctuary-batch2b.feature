# Batch 2b (NSB director's notes on batch 2, 2026-11-06): play area filled in, infirmary carpet and plant fixed. Chained: loads Nelims-tribe-decor-mods-d, saves Nelims-tribe-decor-mods-e in the run folder; validated fixtures untouched.
# Play area (deck x89-97 z114-120): the two ED_Plushie "goblets" at (92, 118) and (95, 118) removed, the bare ring covered with mossy ground and flowers, real play items (HorseshoesPin, ChessTable with stools, sand square, more plushes, a fuel lantern at each deck corner).
# Infirmary: the dark carpet block replaced by a narrow cream runner (Carpet painted Structure_Cream, z 50-51 x 210-215), the missing potting plant in the north-west, one more painting. Not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 2b

  Scenario: sanctuary-batch2b: play area filled in, infirmary carpet fixed, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-d" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And Nelim's Pickle Tools: the decor def "HorseshoesPin" is described
    And Nelim's Pickle Tools: the decor def "ChessTable" is described
    And Nelim's Pickle Tools: the decor def "Stool" is described
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    # infirmary: undo the flat block, lay a narrow cream runner, the missing plant, one more painting
    And Nelim's Pickle Tools: the floor of the cell (209, 50) is copied from the cell (209, 52)
    And Nelim's Pickle Tools: the floor of the cell (216, 50) is copied from the cell (216, 52)
    And Nelim's Pickle Tools: the floor of the cell (210, 50) is copied from the cell (210, 52)
    And Nelim's Pickle Tools: the floor of the cell (211, 50) is copied from the cell (211, 52)
    And Nelim's Pickle Tools: the floor of the cell (212, 50) is copied from the cell (212, 52)
    And Nelim's Pickle Tools: the floor of the cell (213, 50) is copied from the cell (213, 52)
    And Nelim's Pickle Tools: the floor of the cell (214, 50) is copied from the cell (214, 52)
    And Nelim's Pickle Tools: the floor of the cell (215, 50) is copied from the cell (215, 52)
    And Nelim's Pickle Tools: I lay the floor "Carpet" from (210, 50) to (215, 51) painted "Structure_Cream"
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" near (210, 54)
    And Nelim's Pickle Tools: I place the decor "DecorativePainting_Landscape" near (211, 56)
    # play area: goblets out, ground and flowers, then the play items
    And Nelim's Pickle Tools: the area from (92, 118) to (92, 118) is emptied
    And Nelim's Pickle Tools: the area from (95, 118) to (95, 118) is emptied
    And Nelim's Pickle Tools: the floor of the area from (86, 112) to (100, 122) is set to the terrain "MossyTerrain"
    And Nelim's Pickle Tools: I lay the floor "Yuran_woodfloor" from (89, 114) to (97, 120)
    And Nelim's Pickle Tools: I lay the floor "Sand" from (98, 112) to (100, 114)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (89, 114)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (97, 114)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (89, 120)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (97, 120)
    And Nelim's Pickle Tools: I place the decor "AKN_ComfortingPlush" near (91, 117)
    And Nelim's Pickle Tools: I place the decor "AKN_ComfortingPlush" near (94, 119)
    And Nelim's Pickle Tools: I place the decor "AKN_ComfortingPlush" near (96, 118)
    And Nelim's Pickle Tools: I place the decor "HorseshoesPin" near (92, 121)
    And Nelim's Pickle Tools: I place the decor "ChessTable" near (98, 118)
    And Nelim's Pickle Tools: I place the decor "Stool" near (96, 117)
    And Nelim's Pickle Tools: I place the decor "Stool" near (100, 118)
    And Nelim's Pickle Tools: a flower border is planted around the square from (87, 113) to (99, 121)
    And Nelim's Pickle Tools: the plants from (85, 111) to (101, 123) are fully grown
    And Nelim's Pickle Tools: the things within 9 cells of (212, 51) are listed
    And Nelim's Pickle Tools: the things within 10 cells of (93, 117) are listed
    And I wait 60 ticks
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-animals"
    And I take a screenshot "after-infirmary-animals-d"
    And Nelim's Sanctuary: I frame the sanctuary "play-area"
    And I take a screenshot "after-play-area-b"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-e"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-e" is copied to the run folder
