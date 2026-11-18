# Water garden catalogue for BiB: fires, shrine, bonsai, floors, water, one row per shot, on a Concrete floor (owner rules 2026-11-18, Rimworld-Catalog/docs/CAPTURE-RULES.md). Written by Docs/Generate-HandSets.js: edit there.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
Feature: things bib-water-garden

  Scenario: bib-water-garden-fire-a
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
    And Nelim's Pickle Tools: the building "Brazier" is spawned on the nearest free cell around (149, 150) facing south
    And Nelim's Pickle Tools: the building "Campfire" is spawned on the nearest free cell around (151, 150) facing south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 3
    And I take a screenshot "things-bib-water-garden-fire-a"
    Then no errors were logged

  Scenario: bib-water-garden-bonsai
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeBonsai" at (149, 150) fully grown
    And Nelim's Pickle Tools: the building "PlantPot_Bonsai" is spawned on the nearest free cell around (151, 150) facing south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 3
    And I take a screenshot "things-bib-water-garden-bonsai"
    Then no errors were logged

  Scenario: bib-water-garden-shrine
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
    And Nelim's Pickle Tools: the building "NatureShrine_Small" is spawned on the nearest free cell around (148, 150) facing south
    And Nelim's Pickle Tools: the building "StylingStation" is spawned on the nearest free cell around (152, 150) facing south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 3.5
    And I take a screenshot "things-bib-water-garden-shrine"
    Then no errors were logged

  Scenario: bib-water-garden-floor-a
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
    And Nelim's Pickle Tools: I lay the floor "FlagstoneGranite" from (144, 147) to (149, 152)
    And Nelim's Pickle Tools: I lay the floor "FlagstoneSlate" from (151, 147) to (156, 152)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4
    And I take a screenshot "things-bib-water-garden-floor-a"
    Then no errors were logged

  Scenario: bib-water-garden-floor-b
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
    And Nelim's Pickle Tools: I lay the floor "FlagstoneSandstone" from (144, 147) to (149, 152)
    And Nelim's Pickle Tools: I lay the floor "FlagstoneMarble" from (151, 147) to (156, 152)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4
    And I take a screenshot "things-bib-water-garden-floor-b"
    Then no errors were logged

  Scenario: bib-water-garden-floor-c
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
    And Nelim's Pickle Tools: I lay the floor "TileSandstone" from (144, 147) to (149, 152)
    And Nelim's Pickle Tools: I lay the floor "FineTileSandstone" from (151, 147) to (156, 152)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4
    And I take a screenshot "things-bib-water-garden-floor-c"
    Then no errors were logged

  Scenario: bib-water-garden-water
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
    And Nelim's Pickle Tools: I lay the floor "WaterShallow" from (145, 145) to (154, 154)
    And Nelim's Pickle Tools: I lay the floor "WaterDeep" from (148, 148) to (151, 151)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 5.5
    And I take a screenshot "things-bib-water-garden-water"
    Then no errors were logged
