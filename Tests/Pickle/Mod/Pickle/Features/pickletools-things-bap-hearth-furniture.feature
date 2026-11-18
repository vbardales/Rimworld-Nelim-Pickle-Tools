# Hearth furniture catalogue for BAp: Core furniture, one row per shot (owner rules, 2026-11-18, Rimworld-Catalog/docs/CAPTURE-RULES.md). Written by hand, not generated: edit here.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
Feature: things bap-hearth-furniture

  Scenario: bap-hearth-furniture-a
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (138, 144) to (162, 156) is cleared
    And Nelim's Pickle Tools: the building "HandTailoringBench" is spawned on the nearest free cell around (144, 150) facing south
    And Nelim's Pickle Tools: the building "FueledStove" is spawned on the nearest free cell around (148, 150) facing south
    And Nelim's Pickle Tools: the building "Table2x2c" is spawned on the nearest free cell around (152, 150) facing south
    And Nelim's Pickle Tools: the building "Table1x2c" is spawned on the nearest free cell around (156, 150) facing south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4.5
    And I take a screenshot "things-bap-hearth-furniture-a"
    Then no errors were logged

  Scenario: bap-hearth-furniture-b
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (138, 144) to (162, 156) is cleared
    And Nelim's Pickle Tools: the building "Stool" is spawned on the nearest free cell around (144, 150) facing south
    And Nelim's Pickle Tools: the building "DiningChair" is spawned on the nearest free cell around (148, 150) facing south
    And Nelim's Pickle Tools: the building "Armchair" is spawned on the nearest free cell around (152, 150) facing south
    And Nelim's Pickle Tools: the building "Shelf" is spawned on the nearest free cell around (156, 150) facing south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4.5
    And I take a screenshot "things-bap-hearth-furniture-b"
    Then no errors were logged

  Scenario: bap-hearth-furniture-c
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (138, 144) to (162, 156) is cleared
    And Nelim's Pickle Tools: the building "ShelfSmall" is spawned on the nearest free cell around (144, 150) facing south
    And Nelim's Pickle Tools: the building "Bookcase" is spawned on the nearest free cell around (148, 150) facing south
    And Nelim's Pickle Tools: the building "Dresser" is spawned on the nearest free cell around (152, 150) facing south
    And Nelim's Pickle Tools: the building "EndTable" is spawned on the nearest free cell around (156, 150) facing south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4.5
    And I take a screenshot "things-bap-hearth-furniture-c"
    Then no errors were logged

  Scenario: bap-hearth-furniture-carpet
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (138, 144) to (162, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Carpet_MindbendA" from (147, 147) to (152, 152)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4
    And I take a screenshot "things-bap-hearth-furniture-carpet"
    Then no errors were logged
