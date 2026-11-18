# Hearth furniture catalogue for BAp (Cat request 2026-11-18), vanilla Core defs and one Ideology floor. Written by hand, not generated: edit here.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
Feature: things bap-hearth-furniture

  Scenario: things-bap-hearth-furniture: 12 furniture and a carpet patch
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 143) to (159, 155) is cleared
    And Nelim's Pickle Tools: the building "HandTailoringBench" is spawned on the nearest free cell around (142, 153) facing south
    And Nelim's Pickle Tools: the building "FueledStove" is spawned on the nearest free cell around (146, 153) facing south
    And Nelim's Pickle Tools: the building "Table2x2c" is spawned on the nearest free cell around (150, 153) facing south
    And Nelim's Pickle Tools: the building "Table1x2c" is spawned on the nearest free cell around (154, 153) facing south
    And Nelim's Pickle Tools: the building "Stool" is spawned on the nearest free cell around (158, 153) facing south
    And Nelim's Pickle Tools: the building "DiningChair" is spawned on the nearest free cell around (142, 149) facing south
    And Nelim's Pickle Tools: the building "Armchair" is spawned on the nearest free cell around (146, 149) facing south
    And Nelim's Pickle Tools: the building "Shelf" is spawned on the nearest free cell around (150, 149) facing south
    And Nelim's Pickle Tools: the building "ShelfSmall" is spawned on the nearest free cell around (154, 149) facing south
    And Nelim's Pickle Tools: the building "Bookcase" is spawned on the nearest free cell around (158, 149) facing south
    And Nelim's Pickle Tools: the building "Dresser" is spawned on the nearest free cell around (142, 145) facing south
    And Nelim's Pickle Tools: the building "EndTable" is spawned on the nearest free cell around (146, 145) facing south
    And Nelim's Pickle Tools: I lay the floor "Carpet_MindbendA" from (154, 144) to (159, 147)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 149) at root size 8.5
    And I take a screenshot "things-bap-hearth-furniture"
    Then no errors were logged
