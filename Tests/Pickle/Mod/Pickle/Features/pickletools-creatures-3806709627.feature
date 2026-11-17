# Creature catalogue of workshop mod 3806709627 (one animal, one shot), hand-written like creatures-3716851548 (Generate-ThingGallery skips pawn races). Written 2026-11-17, NOT PLAYED when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.coatsteps
@requires:nelim.pickletools.camerazoom
Feature: creature catalogue 3806709627

  Scenario: creatures-3806709627-01: Teshi
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 148) to (154, 156) is cleared
    And Nelim's Pickle Tools: an adult animal of kind "Teshi" named "cat-01" is spawned at (147, 152)
    And Nelim's Pickle Tools: the animal "cat-01" faces south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the animal "cat-01" at zoom 2
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "creatures-3806709627-01"
    Then no errors were logged
