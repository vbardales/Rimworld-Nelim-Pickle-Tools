# Farm ground catalogue for CoL: Core and Odyssey plants, fences, hay, one row per shot (owner rules, 2026-11-18, Rimworld-Catalog/docs/CAPTURE-RULES.md). Written by hand, not generated: edit here.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
Feature: things col-farm-ground

  Scenario: col-farm-ground-plant
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (138, 144) to (162, 156) is cleared
    And Nelim's Pickle Tools: I place the decor "Plant_Grass" at (144, 150) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_TallGrass" at (147, 150) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Haygrass" at (150, 150) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowGrass" at (153, 150) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_YellowTallGrass" at (156, 150) fully grown
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4.5
    And I take a screenshot "things-col-farm-ground-plant"
    Then no errors were logged

  Scenario: col-farm-ground-fence
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (138, 144) to (162, 156) is cleared
    And Nelim's Pickle Tools: the building "Fence" is spawned on the nearest free cell around (146, 150) facing south
    And Nelim's Pickle Tools: the building "FenceGate" is spawned on the nearest free cell around (150, 150) facing south
    And Nelim's Pickle Tools: 30 of the item "Hay" are spawned at (154, 150)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 3.5
    And I take a screenshot "things-col-farm-ground-fence"
    Then no errors were logged

  Scenario: col-farm-ground-floor-a
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (138, 144) to (162, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "StrawMatting" from (144, 147) to (149, 152)
    And Nelim's Pickle Tools: I lay the floor "PackedDirt" from (151, 147) to (156, 152)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4
    And I take a screenshot "things-col-farm-ground-floor-a"
    Then no errors were logged

  Scenario: col-farm-ground-floor-b
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (138, 144) to (162, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "SoilRich" from (144, 147) to (149, 152)
    And Nelim's Pickle Tools: I lay the floor "MossyTerrain" from (151, 147) to (156, 152)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4
    And I take a screenshot "things-col-farm-ground-floor-b"
    Then no errors were logged

  Scenario: col-farm-ground-floor-c
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (138, 144) to (162, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Soil" from (144, 147) to (149, 152)
    And Nelim's Pickle Tools: I lay the floor "GrasslandSoil" from (151, 147) to (156, 152)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4
    And I take a screenshot "things-col-farm-ground-floor-c"
    Then no errors were logged
