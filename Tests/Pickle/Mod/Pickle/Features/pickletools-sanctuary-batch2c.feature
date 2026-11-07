# Batch 2c (NSB choices 2026-11-07, owner validates the shots after): pediatrics beds turned SOUTH kept as fixture state, infirmary runner repainted Structure_Sage (the cream paint was invisible on the cream floor; the paint read-back of 2b passed), the loose Hay at (217, 50) removed (the Hay at (217, 49) is the straw drawn in the bed), area and zone overlays hidden before the frames. Chained: loads Nelims-tribe-decor-mods-e, saves Nelims-tribe-decor-mods-f in the run folder; validated fixtures untouched. Not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 2c

  Scenario: sanctuary-batch2c: beds south, runner sage, loose hay out, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-e" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the buildings "Bed" from (196, 57) to (216, 70) are turned to face south
    And Nelim's Pickle Tools: I lay the floor "CarpetBlue" from (210, 50) to (215, 51) painted "Structure_Sage"
    And Nelim's Pickle Tools: the area from (217, 50) to (217, 50) is emptied
    And Nelim's Pickle Tools: the things within 3 cells of (217, 50) are listed
    # play area redone (NSB 2026-11-07): old fence, equipment and border cleared; wider oak fence x86-112 z112-122, entrance east; every piece one empty cell from the next; flower border moved outside the fence
    And Nelim's Pickle Tools: the area from (83, 109) to (115, 125) is emptied
    And Nelim's Pickle Tools: the floor of the area from (86, 112) to (112, 122) is set to the terrain "MossyTerrain"
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
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (101, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (101, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (102, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (102, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (103, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (103, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (104, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (104, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (105, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (105, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (106, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (106, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (107, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (107, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (108, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (108, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (109, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (109, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (110, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (110, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (111, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (111, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (112, 112)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (112, 122)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 113)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (112, 113)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 114)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (112, 114)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 115)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (112, 115)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 116)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (112, 116)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 117)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 118)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (112, 118)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 119)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (112, 119)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 120)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (112, 120)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (86, 121)
    And Nelim's Pickle Tools: I place the decor "LP_PlayFence" exactly at (112, 121)
    And Nelim's Pickle Tools: I place the decor "LP_PlayEntrance" exactly at (112, 117)
    And Nelim's Pickle Tools: I place the decor "LP_Slide" exactly at (90, 115)
    And Nelim's Pickle Tools: I place the decor "LP_Sandbox" exactly at (96, 115)
    And Nelim's Pickle Tools: I place the decor "LP_Hopscotch" exactly at (101, 115)
    And Nelim's Pickle Tools: I place the decor "LP_SpringFox" exactly at (106, 114)
    And Nelim's Pickle Tools: I place the decor "LP_GardenBench" exactly at (109, 114)
    And Nelim's Pickle Tools: I place the decor "LP_GardenBench" exactly at (109, 116)
    And Nelim's Pickle Tools: I place the decor "LP_Swing" exactly at (90, 120)
    And Nelim's Pickle Tools: I place the decor "LP_Seesaw" exactly at (97, 120)
    And Nelim's Pickle Tools: I place the decor "LP_Playhouse" exactly at (104, 120)
    And Nelim's Pickle Tools: I place the decor "LP_GardenFountain" exactly at (109, 120)
    And Nelim's Pickle Tools: I place the decor "LP_ShadeCanopy" exactly at (106, 117)
    And Nelim's Pickle Tools: I place the decor "AKN_ComfortingPlush" exactly at (107, 119)
    And Nelim's Pickle Tools: a flower border is planted around the square from (84, 110) to (114, 124)
    # gate path (NSB 2026-11-07): no path on the west bank, so the floor of (144, 116) (east-bank path, def unknown) is copied along z117 to x126, then north on x126 to (126, 123), the bridge west end; no step logs terrain
    And Nelim's Pickle Tools: the area from (113, 117) to (126, 117) is emptied
    And Nelim's Pickle Tools: the area from (126, 118) to (126, 123) is emptied
    And Nelim's Pickle Tools: the floor of the cell (113, 117) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (114, 117) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (115, 117) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (116, 117) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (117, 117) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (118, 117) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (119, 117) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (120, 117) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (121, 117) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (122, 117) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (123, 117) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (124, 117) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (125, 117) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (126, 117) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (126, 118) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (126, 119) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (126, 120) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (126, 121) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (126, 122) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (126, 123) is copied from the cell (144, 116)
    # bridge-east link (Virginie via NSB 2026-11-07): joins the bridge east end (142, 122) to the existing path at (144, 117)
    And Nelim's Pickle Tools: the area from (143, 120) to (143, 121) is emptied
    And Nelim's Pickle Tools: the area from (144, 118) to (144, 119) is emptied
    And Nelim's Pickle Tools: the floor of the cell (143, 121) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (143, 120) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (144, 119) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the floor of the cell (144, 118) is copied from the cell (144, 116)
    And Nelim's Pickle Tools: the plants from (83, 109) to (127, 125) are fully grown
    And Nelim's Pickle Tools: the things within 16 cells of (99, 117) are listed
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-animals"
    And I take a screenshot "after-infirmary-animals-e"
    And Nelim's Sanctuary: I frame the sanctuary "play-area"
    And I take a screenshot "after-play-area-c"
    And Nelim's Sanctuary: I frame the sanctuary "pediatrics"
    And I take a screenshot "beds-turned-south-c"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-f"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-f" is copied to the run folder
