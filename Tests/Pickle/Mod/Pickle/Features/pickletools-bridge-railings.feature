# railing candidates for the Sanctuary bridge (CaT request 2026-11-18): 4 fence defs, each a straight line of 5 linked cells, 1 shot.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.colonistrace
Feature: bridge railings candidates

  Scenario: bridge-railings-01: four fences in lines of 5 cells
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 146) to (152, 156) is cleared
    And Nelim's Pickle Tools: the building "Yuran_Enclosure" is spawned on the nearest free cell around (143, 154) facing south
    And Nelim's Pickle Tools: the building "Yuran_Enclosure" is spawned on the nearest free cell around (144, 154) facing south
    And Nelim's Pickle Tools: the building "Yuran_Enclosure" is spawned on the nearest free cell around (145, 154) facing south
    And Nelim's Pickle Tools: the building "Yuran_Enclosure" is spawned on the nearest free cell around (146, 154) facing south
    And Nelim's Pickle Tools: the building "Yuran_Enclosure" is spawned on the nearest free cell around (147, 154) facing south
    And Nelim's Pickle Tools: the building "Yuran_blackwoodfence" is spawned on the nearest free cell around (143, 151) facing south
    And Nelim's Pickle Tools: the building "Yuran_blackwoodfence" is spawned on the nearest free cell around (144, 151) facing south
    And Nelim's Pickle Tools: the building "Yuran_blackwoodfence" is spawned on the nearest free cell around (145, 151) facing south
    And Nelim's Pickle Tools: the building "Yuran_blackwoodfence" is spawned on the nearest free cell around (146, 151) facing south
    And Nelim's Pickle Tools: the building "Yuran_blackwoodfence" is spawned on the nearest free cell around (147, 151) facing south
    And Nelim's Pickle Tools: the building "Yuran_Flowerwoodfence" is spawned on the nearest free cell around (143, 148) facing south
    And Nelim's Pickle Tools: the building "Yuran_Flowerwoodfence" is spawned on the nearest free cell around (144, 148) facing south
    And Nelim's Pickle Tools: the building "Yuran_Flowerwoodfence" is spawned on the nearest free cell around (145, 148) facing south
    And Nelim's Pickle Tools: the building "Yuran_Flowerwoodfence" is spawned on the nearest free cell around (146, 148) facing south
    And Nelim's Pickle Tools: the building "Yuran_Flowerwoodfence" is spawned on the nearest free cell around (147, 148) facing south
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned on the nearest free cell around (143, 145) facing south
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned on the nearest free cell around (144, 145) facing south
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned on the nearest free cell around (145, 145) facing south
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned on the nearest free cell around (146, 145) facing south
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned on the nearest free cell around (147, 145) facing south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (145, 150) at root size 5.5
    And I take a screenshot "things-3671664434-fences-01"
    Then no errors were logged

  Scenario: bridge-railings-metadata: the def metadata of the two mods
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the def metadata of the mod "Caoyuanfei.YuranShrineJapaneseArchitecture" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "choco.littleplaygrounds" is logged
    Then no errors were logged
