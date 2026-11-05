# Modded decor of the Sanctuary (NSB plan "variante mods", 2026-11-05). Ticket A: what each decorative def is (size, kind), and the before shots of the places that change,
# from the base-game decor fixture. Two scenarios: one run of 13 frames takes 290 s, close to the 300 s watchdog.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
Feature: Sanctuary modded decor: before

  Scenario: sanctuary-decor-mods-before: the defs and the near places
    Given the save "Nelims-tribe-decor" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the decor def "Yuran_OldTorie" is described
    And Nelim's Pickle Tools: the decor def "Yuran_komainu_one" is described
    And Nelim's Pickle Tools: the decor def "Yuran_komainu_two" is described
    And Nelim's Pickle Tools: the decor def "Yuran_ClearSpringPavilion" is described
    And Nelim's Pickle Tools: the decor def "Yuran_flatstonefloorSandstone" is described
    And Nelim's Pickle Tools: the decor def "milple_TorchLampR" is described
    And Nelim's Pickle Tools: the decor def "KCB_Potting_B" is described
    And Nelim's Pickle Tools: the decor def "RLE_TatamiSingle" is described
    And Nelim's Pickle Tools: the decor def "milple_Table1x2c" is described
    And Nelim's Pickle Tools: the decor def "milple_CStoolS" is described
    And Nelim's Pickle Tools: the decor def "milple_VaseB" is described
    And Nelim's Pickle Tools: the decor def "RLE_ArialeAndonOil" is described
    And Nelim's Pickle Tools: the decor def "RLE_Kouro" is described
    And Nelim's Pickle Tools: the decor def "DecorativePainting_EasternClassic" is described
    And Nelim's Pickle Tools: the decor def "Yuran_woodfloor" is described
    And Nelim's Pickle Tools: the decor def "Yuran_BlessingRack" is described
    And Nelim's Pickle Tools: the decor def "milple_TorchWallLamp" is described
    And Nelim's Pickle Tools: the decor def "Yuran_Brazier_two" is described
    And Nelim's Pickle Tools: the decor def "Yuran_TaikoDrum" is described
    And Nelim's Pickle Tools: the decor def "Yuran_TempleBell" is described
    And Nelim's Pickle Tools: the decor def "YR_Bigthurible" is described
    And Nelim's Pickle Tools: the decor def "WMFF_WallDrape" is described
    And Nelim's Pickle Tools: the decor def "Wall_M_VitalsMonitor" is described
    And Nelim's Pickle Tools: the decor def "KCB_Potting_A" is described
    And Nelim's Pickle Tools: the decor def "DecorativePainting_Landscape" is described
    And Nelim's Pickle Tools: the decor def "AtwoodCurtains" is described
    And Nelim's Pickle Tools: the decor def "milple_CribB" is described
    And Nelim's Pickle Tools: the decor def "AKN_ComfortingPlush" is described
    And Nelim's Pickle Tools: the decor def "ED_Plushie" is described
    And Nelim's Pickle Tools: the decor def "DecorativePainting_Animal" is described
    And Nelim's Pickle Tools: the decor def "SCBluehydrangea" is described
    And Nelim's Pickle Tools: the decor def "SCPinkhydrangea" is described
    And Nelim's Pickle Tools: the decor def "SCLavender" is described
    And Nelim's Pickle Tools: the decor def "SiverTree" is described
    And Nelim's Pickle Tools: the decor def "Erin_Plant_Camellia" is described
    And Nelim's Pickle Tools: the decor def "Erin_Plant_Orchid" is described
    And Nelim's Pickle Tools: the decor def "Yuran_Treestump" is described
    And Nelim's Pickle Tools: the decor def "MUS_Fishing_DecorativeF" is described
    And Nelim's Pickle Tools: the decor def "MUS_Fishing_DecorativeC" is described
    And Nelim's Pickle Tools: the decor def "MUS_Fishing_DecorativeH" is described
    And Nelim's Pickle Tools: the decor def "Yuran_Enclosure" is described
    And Nelim's Pickle Tools: the decor def "Yuran_EnclosureDoor" is described
    And Nelim's Pickle Tools: the decor def "Yuran_PenMarker" is described
    And Nelim's Pickle Tools: the decor def "bambooBundle" is described
    And Nelim's Pickle Tools: the decor def "ED_PetBowl" is described
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "terrace"
    And I take a screenshot "before-terrace"
    And Nelim's Sanctuary: I frame the sanctuary "hut"
    And I take a screenshot "before-hut"
    And Nelim's Sanctuary: I frame the sanctuary "cloister"
    And I take a screenshot "before-cloister"
    And Nelim's Sanctuary: I frame the sanctuary "ritual-hall"
    And I take a screenshot "before-ritual-hall"
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-pawns"
    And I take a screenshot "before-infirmary-pawns"
    And Nelim's Sanctuary: I frame the sanctuary "pediatrics"
    And I take a screenshot "before-pediatrics"

  Scenario: sanctuary-decor-mods-before-far: the far places
    Given the save "Nelims-tribe-decor" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "statue-garden"
    And I take a screenshot "before-statue-garden"
    And Nelim's Sanctuary: I frame the sanctuary "flower-garden"
    And I take a screenshot "before-flower-garden"
    And Nelim's Sanctuary: I frame the sanctuary "water-garden"
    And I take a screenshot "before-water-garden"
    And Nelim's Sanctuary: I frame the sanctuary "river-bridge"
    And I take a screenshot "before-river-bridge"
    And Nelim's Sanctuary: I frame the sanctuary "barn"
    And I take a screenshot "before-barn"
