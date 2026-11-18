# def metadata journal of workshop mod 2670355481 (Kurin, Inoshishi3.KTTFDE) for the catalogue registry (CaT).
@requires:nelim.pickletools.colonistrace
Feature: def metadata 2670355481

  Scenario: metadata-2670355481: the def metadata of Kurin
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the def metadata of the mod "Inoshishi3.KTTFDE" is logged
    Then no errors were logged
