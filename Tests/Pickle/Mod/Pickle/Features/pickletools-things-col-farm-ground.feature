# Farm ground catalogue for CoL (Cat request 2026-11-18), vanilla Core and Odyssey defs. Written by hand, not generated: edit here.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
Feature: things col-farm-ground

  Scenario: things-col-farm-ground-floor: 6 floors, one 6 x 6 patch each
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 142) to (157, 153) is cleared
    And Nelim's Pickle Tools: I lay the floor "StrawMatting" from (140, 148) to (145, 153)
    And Nelim's Pickle Tools: I lay the floor "PackedDirt" from (146, 148) to (151, 153)
    And Nelim's Pickle Tools: I lay the floor "SoilRich" from (152, 148) to (157, 153)
    And Nelim's Pickle Tools: I lay the floor "MossyTerrain" from (140, 142) to (145, 147)
    And Nelim's Pickle Tools: I lay the floor "Soil" from (146, 142) to (151, 147)
    And Nelim's Pickle Tools: I lay the floor "GrasslandSoil" from (152, 142) to (157, 147)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (148, 148) at root size 6.5
    And I take a screenshot "things-col-farm-ground-floor"
    Then no errors were logged

  Scenario: things-col-farm-ground-plant: 5 plants, 2 fences, a hay stack
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 148) to (154, 156) is cleared
    And Nelim's Pickle Tools: I place the decor "Plant_Grass" at (141, 155) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_TallGrass" at (144, 155) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Haygrass" at (147, 155) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowGrass" at (150, 155) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (153, 155) fully grown
    And Nelim's Pickle Tools: the building "Fence" is spawned on the nearest free cell around (141, 152) facing south
    And Nelim's Pickle Tools: the building "FenceGate" is spawned on the nearest free cell around (144, 152) facing south
    And Nelim's Pickle Tools: 30 of the item "Hay" are spawned at (147, 152)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (148, 153) at root size 5.5
    And I take a screenshot "things-col-farm-ground-plant"
    Then no errors were logged
