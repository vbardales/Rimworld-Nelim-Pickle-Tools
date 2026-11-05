# Modded decor of the Sanctuary, placement (NSB plan "variante mods", 2026-11-05; 19 mods staged by wsl-deps.sanctuary-decor-mods.map, base = the base-game decor fixture,
# container cap 7g, run alone: Audit's conditions). Cells are chosen from the base fixture's shots; the `near` steps take the nearest cell the game's own rules accept and log
# where it went ([decor-placed]). Two scenarios apply the same decor: one run of 13 frames is too close to the 300 s watchdog; the first saves the fixture.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
Feature: Sanctuary modded decor: after

  Scenario: sanctuary-decor-mods-after: the near places, then the modded fixture saved
    Given the save "Nelims-tribe-decor" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    # entrance: the torii (3x1, a door) across the path into the cloister, a komainu either side, the ablution pavilion off the walking line
    And Nelim's Pickle Tools: I place the decor "Yuran_OldTorie" near (176, 132)
    And Nelim's Pickle Tools: I place the decor "Yuran_komainu_one" near (173, 132)
    And Nelim's Pickle Tools: I place the decor "Yuran_komainu_two" near (179, 132)
    And Nelim's Pickle Tools: I place the decor "Yuran_ClearSpringPavilion" near (183, 132)
    And Nelim's Pickle Tools: I place the decor "Yuran_BlessingRack" near (181, 134)
    # terrace: carved sandstone floor, the two electric standing lamps of the base decor removed (no electricity), two stone lanterns and two big pots on free cells that face nothing
    And Nelim's Pickle Tools: I lay the floor "Yuran_flatstonefloorSandstone" from (193, 118) to (200, 124) painted "Structure_Cream"
    And Nelim's Pickle Tools: the area from (193, 121) to (193, 121) is emptied
    And Nelim's Pickle Tools: the area from (200, 121) to (200, 121) is emptied
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (195, 120)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (199, 120)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_B" near (196, 119)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_B" near (199, 119)
    # hut: tatami floor, the table and stools replaced by a low Korean table and cushions, andon lamp, incense burner, moon jar, a painting on the wall
    And Nelim's Pickle Tools: I lay the floor "RLE_TatamiSeamless" from (135, 69) to (145, 77)
    And Nelim's Pickle Tools: the area from (137, 72) to (141, 73) is emptied
    And Nelim's Pickle Tools: I place the decor "milple_Table1x2c" near (139, 72)
    And Nelim's Pickle Tools: I place the decor "milple_CStoolS" near (138, 71)
    And Nelim's Pickle Tools: I place the decor "milple_CStoolS" near (141, 74)
    And Nelim's Pickle Tools: I place the decor "RLE_ArialeAndonOil" near (143, 73)
    And Nelim's Pickle Tools: I place the decor "RLE_Kouro" near (143, 71)
    And Nelim's Pickle Tools: I place the decor "milple_VaseB" near (139, 72)
    And Nelim's Pickle Tools: I place the decor "DecorativePainting_EasternClassic" near (140, 77)
    # cloister: black wood floor, lanterns on the columns, an ema rack in the open floor at the end of the gallery, no pot
    And Nelim's Pickle Tools: I place the decor "milple_TorchWallLamp" near (174, 126)
    And Nelim's Pickle Tools: I place the decor "milple_TorchWallLamp" near (178, 126)
    And Nelim's Pickle Tools: I place the decor "milple_TorchWallLamp" near (182, 126)
    # ritual hall: the two braziers become square black-wood braziers, the drum a taiko, a temple bell at the back, a big incense burner, two wall drapes
    And Nelim's Pickle Tools: the area from (205, 121) to (205, 121) is emptied
    And Nelim's Pickle Tools: the area from (208, 121) to (208, 121) is emptied
    And Nelim's Pickle Tools: the area from (208, 117) to (208, 117) is emptied
    And Nelim's Pickle Tools: I place the decor "Yuran_Brazier_two" near (205, 121)
    And Nelim's Pickle Tools: I place the decor "Yuran_Brazier_two" near (208, 121)
    And Nelim's Pickle Tools: I place the decor "Yuran_TaikoDrum" near (208, 117)
    And Nelim's Pickle Tools: I place the decor "YR_Bigthurible" near (208, 120)
    And Nelim's Pickle Tools: I place the decor "Yuran_TempleBell" near (207, 126)
    And Nelim's Pickle Tools: I place the decor "WMFF_WallDrape" near (203, 123)
    And Nelim's Pickle Tools: I place the decor "WMFF_WallDrape" near (208, 123)
    # infirmary (pawns): two wall vitals monitors on the north wall, on a real power net: a vanometric cell OUTSIDE the west wall (195, 56) and hidden conduits under the wall and the floor along z 56 (Virginie: "dehors, conduite cachée"); two pots in the middle, a landscape on the wall
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" near (202, 53)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" near (202, 50)
    And Nelim's Pickle Tools: I place the decor "VanometricPowerCell" exactly at (195, 56)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (196, 56)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (197, 56)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (198, 56)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (199, 56)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (200, 56)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (201, 56)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (202, 56)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (203, 56)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (204, 56)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (205, 56)
    And Nelim's Pickle Tools: I place the decor "WMFF_WallMountedVitalsmonitor" near (203, 56)
    And Nelim's Pickle Tools: I place the decor "WMFF_WallMountedVitalsmonitor" near (205, 56)

    And Nelim's Pickle Tools: the power links of the area from (194, 54) to (206, 58) are logged
    And Nelim's Pickle Tools: the power links of the area from (200, 112) to (212, 126) are logged
    And Nelim's Pickle Tools: the area from (197, 54) to (197, 54) is emptied
    And Nelim's Pickle Tools: the area from (197, 50) to (197, 50) is emptied
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (199, 52)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (204, 52)
    And Nelim's Pickle Tools: I place the decor "DecorativePainting_Landscape" near (200, 56)
    # pediatrics: the cribs become woven cribs, plush on the beds and the toy boxes, an animal painting on the wall
    And Nelim's Pickle Tools: the area from (200, 62) to (200, 62) is emptied
    And Nelim's Pickle Tools: the area from (202, 62) to (202, 62) is emptied
    And Nelim's Pickle Tools: the area from (204, 62) to (204, 62) is emptied
    And Nelim's Pickle Tools: I place the decor "milple_CribB" near (200, 62)
    And Nelim's Pickle Tools: I place the decor "milple_CribB" near (202, 62)
    And Nelim's Pickle Tools: I place the decor "milple_CribB" near (204, 62)
    And Nelim's Pickle Tools: I place the decor "AKN_ComfortingPlush" near (198, 63)
    And Nelim's Pickle Tools: I place the decor "AKN_ComfortingPlush" near (212, 62)
    And Nelim's Pickle Tools: I place the decor "ED_Plushie" near (214, 62)
    And Nelim's Pickle Tools: I place the decor "ED_Plushie" near (212, 61)
    And Nelim's Pickle Tools: I place the decor "DecorativePainting_Animal" near (207, 58)
    # statue and flower gardens: hydrangeas and lavender along the alley, two stone lanterns at its end, a silver tree at the back, camellias and orchids in the flower garden
    And Nelim's Pickle Tools: I place the decor "SCPinkhydrangea" near (159, 98)
    And Nelim's Pickle Tools: I place the decor "SCPinkhydrangea" near (159, 96)
    And Nelim's Pickle Tools: I place the decor "SCPinkhydrangea" near (159, 94)
    And Nelim's Pickle Tools: I place the decor "SCBluehydrangea" near (160, 97)
    And Nelim's Pickle Tools: I place the decor "SCBluehydrangea" near (160, 95)
    And Nelim's Pickle Tools: I place the decor "SCBluehydrangea" near (160, 93)
    And Nelim's Pickle Tools: I place the decor "SCLavender" near (157, 97)
    And Nelim's Pickle Tools: I place the decor "SCLavender" near (157, 95)
    And Nelim's Pickle Tools: I place the decor "SCLavender" near (157, 93)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (155, 90)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (157, 90)
    And Nelim's Pickle Tools: I place the decor "Erin_Plant_Camellia" near (148, 104)
    And Nelim's Pickle Tools: I place the decor "Erin_Plant_Camellia" near (150, 106)
    And Nelim's Pickle Tools: I place the decor "Erin_Plant_Camellia" near (152, 108)
    And Nelim's Pickle Tools: I place the decor "Erin_Plant_Orchid" near (153, 104)
    And Nelim's Pickle Tools: I place the decor "Erin_Plant_Orchid" near (155, 106)
    And Nelim's Pickle Tools: I place the decor "Erin_Plant_Orchid" near (157, 108)
    # water garden: nothing in the water; a stone lantern and a stump on the south shore
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (172, 163)
    And Nelim's Pickle Tools: I place the decor "Yuran_Treestump" near (170, 161)
    # river bridge: a stone lantern at each end, a beached boat, oars and a fish crate on the bank
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (128, 126)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (140, 126)
    And Nelim's Pickle Tools: I place the decor "MUS_Fishing_DecorativeF" near (125, 124)
    And Nelim's Pickle Tools: I place the decor "MUS_Fishing_DecorativeC" near (125, 122)
    And Nelim's Pickle Tools: I place the decor "MUS_Fishing_DecorativeA" near (127, 122)
    # barn: a pen sign, bowls by the straw, two bamboo bundles on the east outside (no fence: the enclosure pieces would not stand along the existing fence)
    And Nelim's Pickle Tools: I place the decor "Yuran_PenMarker" near (186, 238)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (199, 236)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (199, 239)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (185, 241)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (185, 233)
    # ritual hall: Virginie keeps the original vanometric cell (211, 122) outside the east wall and its LightBall and loudspeakers, with NO visible wire: hidden conduits from the cell under the east wall to each powered item, then each item reconnects to the conduit under it
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (210, 122)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (209, 122)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (208, 122)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (207, 122)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (206, 122)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (205, 122)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (204, 122)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (209, 121)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (209, 120)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (205, 121)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (205, 120)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (205, 119)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (204, 123)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (206, 121)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (206, 120)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (206, 119)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (206, 118)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (206, 117)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (206, 116)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (206, 115)
    And Nelim's Pickle Tools: I place the decor "HiddenConduit" exactly at (206, 114)
    And Nelim's Pickle Tools: the power connection of the building "LightBall" at (205, 119) is remade
    And Nelim's Pickle Tools: the power connection of the building "Loudspeaker" at (209, 120) is remade
    And Nelim's Pickle Tools: the power connection of the building "Loudspeaker" at (204, 123) is remade
    And Nelim's Pickle Tools: the power connection of the building "Loudspeaker" at (206, 114) is remade
    And Nelim's Pickle Tools: the power connection of the building "WMFF_WallMountedVitalsmonitor" at (203, 56) is remade
    And Nelim's Pickle Tools: the power connection of the building "WMFF_WallMountedVitalsmonitor" at (205, 56) is remade
    # the original vitals monitors beside the infirmary beds reached the new hidden conduits by a visible wire (c71f, 6176): log them, then cut their connection (they stay unpowered, as in the original)
    And Nelim's Pickle Tools: the power links of the area from (197, 48) to (206, 55) are logged
    And Nelim's Pickle Tools: the power connections of the area from (197, 48) to (206, 55) are cut
    And Nelim's Pickle Tools: the power links of the area from (197, 48) to (206, 55) are logged
    And Nelim's Pickle Tools: the building "LightBall" at (205, 119) is on a power net with a power source
    And Nelim's Pickle Tools: the building "LightBall" at (205, 119) is connected with no visible wire
    And Nelim's Pickle Tools: the building "Loudspeaker" at (209, 120) is on a power net with a power source
    And Nelim's Pickle Tools: the building "Loudspeaker" at (209, 120) is connected with no visible wire
    And Nelim's Pickle Tools: the building "Loudspeaker" at (204, 123) is on a power net with a power source
    And Nelim's Pickle Tools: the building "Loudspeaker" at (204, 123) is connected with no visible wire
    And Nelim's Pickle Tools: the building "Loudspeaker" at (206, 114) is on a power net with a power source
    And Nelim's Pickle Tools: the building "Loudspeaker" at (206, 114) is connected with no visible wire
    And Nelim's Pickle Tools: the building "WMFF_WallMountedVitalsmonitor" at (203, 56) is on a power net with a power source
    And Nelim's Pickle Tools: the building "WMFF_WallMountedVitalsmonitor" at (203, 56) is connected with no visible wire
    And Nelim's Pickle Tools: the building "WMFF_WallMountedVitalsmonitor" at (205, 56) is on a power net with a power source
    And Nelim's Pickle Tools: the building "WMFF_WallMountedVitalsmonitor" at (205, 56) is connected with no visible wire
    And Nelim's Pickle Tools: the decor "milple_TorchWallLamp" at (174, 126) is lit
    And Nelim's Pickle Tools: the decor "milple_TorchWallLamp" at (178, 126) is lit
    And Nelim's Pickle Tools: the decor "milple_TorchWallLamp" at (182, 126) is lit
    And Nelim's Sanctuary: the buildings of the sanctuary "infirmary" are repaired
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "terrace"
    And I take a screenshot "after-terrace"
    And Nelim's Sanctuary: I frame the sanctuary "hut"
    And I take a screenshot "after-hut"
    And Nelim's Sanctuary: I frame the sanctuary "cloister"
    And I take a screenshot "after-cloister"
    And Nelim's Sanctuary: I frame the sanctuary "ritual-hall"
    And I take a screenshot "after-ritual-hall"
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-pawns"
    And I take a screenshot "after-infirmary-pawns"
    And Nelim's Sanctuary: I frame the sanctuary "pediatrics"
    And I take a screenshot "after-pediatrics"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods" is copied to the run folder
