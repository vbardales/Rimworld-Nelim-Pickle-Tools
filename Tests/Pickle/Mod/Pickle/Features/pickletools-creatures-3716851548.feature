# Creature catalogue of workshop mod 3716851548 (7 animal races, one shot each), hand-written from the Generate-RacesGallery.js pattern: Generate-ThingGallery skips pawn races.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.coatsteps
@requires:nelim.pickletools.camerazoom
Feature: creature catalogue 3716851548

  Scenario: creatures-3716851548-01: YAEMU
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 148) to (154, 156) is cleared
    And Nelim's Pickle Tools: an adult animal of kind "YAEMU" named "cat-01" is spawned at (147, 152)
    And Nelim's Pickle Tools: the animal "cat-01" faces south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the animal "cat-01" at zoom 2
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "creatures-3716851548-01"
    Then no errors were logged

  Scenario: creatures-3716851548-02: ASEBI
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 148) to (154, 156) is cleared
    And Nelim's Pickle Tools: an adult animal of kind "ASEBI" named "cat-02" is spawned at (147, 152)
    And Nelim's Pickle Tools: the animal "cat-02" faces south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the animal "cat-02" at zoom 2
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "creatures-3716851548-02"
    Then no errors were logged

  Scenario: creatures-3716851548-03: BORUM
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 148) to (154, 156) is cleared
    And Nelim's Pickle Tools: an adult animal of kind "BORUM" named "cat-03" is spawned at (147, 152)
    And Nelim's Pickle Tools: the animal "cat-03" faces south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the animal "cat-03" at zoom 2
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "creatures-3716851548-03"
    Then no errors were logged

  Scenario: creatures-3716851548-04: SANKA
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 148) to (154, 156) is cleared
    And Nelim's Pickle Tools: an adult animal of kind "SANKA" named "cat-04" is spawned at (147, 152)
    And Nelim's Pickle Tools: the animal "cat-04" faces south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the animal "cat-04" at zoom 2
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "creatures-3716851548-04"
    Then no errors were logged

  Scenario: creatures-3716851548-05: SOSIN
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 148) to (154, 156) is cleared
    And Nelim's Pickle Tools: an adult animal of kind "SOSIN" named "cat-05" is spawned at (147, 152)
    And Nelim's Pickle Tools: the animal "cat-05" faces south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the animal "cat-05" at zoom 2
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "creatures-3716851548-05"
    Then no errors were logged

  Scenario: creatures-3716851548-06: ABYSS
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 148) to (154, 156) is cleared
    And Nelim's Pickle Tools: an adult animal of kind "ABYSS" named "cat-06" is spawned at (147, 152)
    And Nelim's Pickle Tools: the animal "cat-06" faces south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the animal "cat-06" at zoom 2
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "creatures-3716851548-06"
    Then no errors were logged

  Scenario: creatures-3716851548-07: FS_FLESHIA
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 148) to (154, 156) is cleared
    And Nelim's Pickle Tools: an adult animal of kind "FS_FLESHIA" named "cat-07" is spawned at (147, 152)
    And Nelim's Pickle Tools: the animal "cat-07" faces south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: I frame the animal "cat-07" at zoom 2
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "creatures-3716851548-07"
    Then no errors were logged
