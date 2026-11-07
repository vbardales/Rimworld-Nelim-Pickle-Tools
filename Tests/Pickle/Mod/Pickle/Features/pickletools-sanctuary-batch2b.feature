# Batch 2b (NSB director's notes on batch 2, 2026-11-06): play area filled in, infirmary carpet and plant fixed. Chained: loads Nelims-tribe-decor-mods-d, saves Nelims-tribe-decor-mods-e in the run folder; validated fixtures untouched.
# Play area: Little Playgrounds (owner choice 2026-11-06) replaces the vanilla ideas: oak fence round x86-100 z112-122 with the entrance east, swing, slide, seesaw, sandbox, spring fox, playhouse, hopscotch, benches, canopy, fountain; the two ED_Plushie "goblets" removed, mossy ring, toy boxes and plushes kept.
# Infirmary: the dark carpet block replaced by a narrow cream runner (CarpetBlue painted Structure_Cream, z 50-51 x 210-215), the missing potting plant in the north-west, one more painting. Not played when written.
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
    And Nelim's Pickle Tools: I lay the floor "CarpetBlue" from (210, 50) to (215, 51) painted "Structure_Cream"
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" near (210, 54)
    And Nelim's Pickle Tools: I place the decor "DecorativePainting_Landscape" near (211, 56)
    # play area with Little Playgrounds (owner choice): goblets out, mossy ring, oak fence round with the entrance on the east, play equipment, benches and canopy, fountain, toy boxes and plushes kept
    And Nelim's Pickle Tools: the area from (92, 118) to (92, 118) is emptied
    And Nelim's Pickle Tools: the area from (95, 118) to (95, 118) is emptied
    And Nelim's Pickle Tools: the floor of the area from (86, 112) to (100, 122) is set to the terrain "MossyTerrain"
    And Nelim's Pickle Tools: I lay the floor "Yuran_woodfloor" from (89, 114) to (97, 120)
    And Nelim's Pickle Tools: the decor def "LP_PlayFence" is described
    And Nelim's Pickle Tools: the decor def "LP_PlayEntrance" is described
    And Nelim's Pickle Tools: the decor def "LP_Swing" is described
    And Nelim's Pickle Tools: the decor def "LP_Slide" is described
    And Nelim's Pickle Tools: the decor def "LP_Seesaw" is described
    And Nelim's Pickle Tools: the decor def "LP_Sandbox" is described
    And Nelim's Pickle Tools: the decor def "LP_SpringFox" is described
    And Nelim's Pickle Tools: the decor def "LP_Playhouse" is described
    And Nelim's Pickle Tools: the decor def "LP_Hopscotch" is described
    And Nelim's Pickle Tools: the decor def "LP_GardenBench" is described
    And Nelim's Pickle Tools: the decor def "LP_ShadeCanopy" is described
    And Nelim's Pickle Tools: the decor def "LP_GardenFountain" is described
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (87, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (87, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (88, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (88, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (89, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (89, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (90, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (90, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (91, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (91, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (92, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (92, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (93, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (93, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (94, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (94, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (95, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (95, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (96, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (96, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (97, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (97, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (98, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (98, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (99, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (99, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (100, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (100, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 113)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (100, 113)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 114)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (100, 114)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 115)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (100, 115)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 116)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (100, 116)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 117)
    And Nelim's Pickle Tools: I place the decor "LP_PlayEntrance" exactly at (100, 117)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 118)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (100, 118)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 119)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (100, 119)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 120)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (100, 120)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 121)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (100, 121)
    And Nelim's Pickle Tools: I place the decor "LP_GardenFountain" near (93, 117)
    And Nelim's Pickle Tools: I place the decor "LP_Swing" near (91, 120)
    And Nelim's Pickle Tools: I place the decor "LP_Slide" near (96, 119)
    And Nelim's Pickle Tools: I place the decor "LP_Seesaw" near (91, 114)
    And Nelim's Pickle Tools: I place the decor "LP_Sandbox" near (98, 114)
    And Nelim's Pickle Tools: I place the decor "LP_SpringFox" near (88, 117)
    And Nelim's Pickle Tools: I place the decor "LP_Playhouse" near (88, 120)
    And Nelim's Pickle Tools: I place the decor "LP_Hopscotch" near (94, 114)
    And Nelim's Pickle Tools: I place the decor "LP_GardenBench" near (87, 121)
    And Nelim's Pickle Tools: I place the decor "LP_GardenBench" near (99, 121)
    And Nelim's Pickle Tools: I place the decor "LP_ShadeCanopy" near (98, 119)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (89, 114)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (97, 114)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (89, 120)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (97, 120)
    And Nelim's Pickle Tools: I place the decor "AKN_ComfortingPlush" near (91, 117)
    And Nelim's Pickle Tools: I place the decor "AKN_ComfortingPlush" near (94, 119)
    And Nelim's Pickle Tools: I place the decor "AKN_ComfortingPlush" near (96, 117)
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
