# Sanctuary decor families for the AlM gallery scenes (CaT request 2026-11-18): 18 defs of 6 decor mods + 2 base-game defs, 3 shots. A def sits at the centre of its 4 x 4 cell, 5 per row from the north-west corner (140, 148); key: Tests/Pickle/things-sanctuary-decor.key.md.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.colonistrace
Feature: sanctuary decor families

  Scenario: sanctuary-decor-01: defs of shot 1
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 148) to (159, 155) is cleared
    And Nelim's Pickle Tools: the building "Yuran_Treestump" is spawned on the nearest free cell around (142, 153) facing south
    And Nelim's Pickle Tools: the building "Yuran_campstool" is spawned on the nearest free cell around (146, 153) facing south
    And Nelim's Pickle Tools: the building "Yuran_Incenseburner_one" is spawned on the nearest free cell around (150, 153) facing south
    And Nelim's Pickle Tools: the building "Yuran_Incenseburner_two" is spawned on the nearest free cell around (154, 153) facing south
    And Nelim's Pickle Tools: the building "Yuran_Incenseburner_three" is spawned on the nearest free cell around (158, 153) facing south
    And Nelim's Pickle Tools: the building "Yuran_LowCabinet" is spawned on the nearest free cell around (142, 149) facing south
    And Nelim's Pickle Tools: the building "LP_GardenBench" is spawned on the nearest free cell around (146, 149) facing south
    And Nelim's Pickle Tools: the building "LP_SteppingStump" is spawned on the nearest free cell around (150, 149) facing south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 152) at root size 6.6
    And I take a screenshot "things-sanctuary-decor-01"
    Then no errors were logged

  Scenario: sanctuary-decor-02: defs of shot 2
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 148) to (159, 155) is cleared
    And Nelim's Pickle Tools: the building "Erin_Zabuton" is spawned on the nearest free cell around (142, 153) facing south
    And Nelim's Pickle Tools: the building "Erin_IncenseHolder" is spawned on the nearest free cell around (146, 153) facing south
    And Nelim's Pickle Tools: the building "Erin_BonsaiPot" is spawned on the nearest free cell around (150, 153) facing south
    And Nelim's Pickle Tools: the building "ED_PetBowl" is spawned on the nearest free cell around (154, 153) facing south
    And Nelim's Pickle Tools: the building "ED_SmallPlant" is spawned on the nearest free cell around (158, 153) facing south
    And Nelim's Pickle Tools: the building "ED_Candles" is spawned on the nearest free cell around (142, 149) facing south
    And Nelim's Pickle Tools: the building "milple_VaseB" is spawned on the nearest free cell around (146, 149) facing south
    And Nelim's Pickle Tools: the building "AtwoodCandles" is spawned on the nearest free cell around (150, 149) facing south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 152) at root size 6.6
    And I take a screenshot "things-sanctuary-decor-02"
    Then no errors were logged

  Scenario: sanctuary-decor-03: defs of shot 3
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 148) to (159, 155) is cleared
    And Nelim's Pickle Tools: the building "NatureShrine_Small" is spawned on the nearest free cell around (142, 153) facing south
    And Nelim's Pickle Tools: the building "Stool" is spawned on the nearest free cell around (146, 153) facing south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 152) at root size 6.6
    And I take a screenshot "things-sanctuary-decor-03"
    Then no errors were logged

  Scenario: sanctuary-decor-metadata: the def metadata of the six mods
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the def metadata of the mod "Caoyuanfei.YuranShrineJapaneseArchitecture" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "choco.littleplaygrounds" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "Erin.JapaneseFurniture" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "erin.decorations" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "milple.KoreanStyleFurniture" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "mgatwood.housedecor" is logged
    Then no errors were logged
