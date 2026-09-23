@requires:nelim.pickletools
@requires:MalteSchulze.RIMMSqol
Feature: PickleTools aggregate with optional RIMMSQOL

  Scenario: the bundle can use the RIMMSQOL bridge when RIMMSQOL is installed
    Given the main menu is open
    Then Nelim's Pickle Tools: the expansion "MalteSchulze.RIMMSqol" is active
    And RIMMSQOL is ready to be driven
