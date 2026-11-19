# def metadata journal of workshop mod 3820851894 (Kraltech, dingzhen.kra) for the catalogue registry (Cat).
@requires:nelim.pickletools.colonistrace
Feature: def metadata 3820851894

  Scenario: metadata-3820851894: the def metadata of Kraltech
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the def metadata of the mod "dingzhen.kra" is logged
    Then no errors were logged
