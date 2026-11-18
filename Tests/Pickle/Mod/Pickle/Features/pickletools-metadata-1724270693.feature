# def metadata journal of workshop mod 1724270693 (Simple Ivory, 3 things + 1 floor): first play of the step for the catalogue registry (CaT), cross-check against the offline scan.
@requires:nelim.pickletools.colonistrace
Feature: def metadata 1724270693

  Scenario: metadata-1724270693: the def metadata of Simple Ivory
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the def metadata of the mod "LegendaryMinuteman.SimpleIvory.fork" is logged
    Then no errors were logged
