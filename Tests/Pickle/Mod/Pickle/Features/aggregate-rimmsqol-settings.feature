@requires:nelim.pickletools
@requires:MalteSchulze.RIMMSqol
Feature: PickleTools aggregate restores RIMMSQOL's test choice

  Scenario: RIMMSQOL writes a temporary visible choice for a normally hidden vanilla button
    Given the main menu is open
    Then RIMMSQOL is ready to be driven
    And RIMMSQOL's own list of main buttons offers "Inspect"
    And RIMMSQOL holds no choice for the main button "Inspect"
    And RIMMSQOL shows the main button "Inspect" as hidden
    When RIMMSQOL reveals the main button "Inspect"
    Then RIMMSQOL shows the main button "Inspect" as visible
    And RIMMSQOL's settings file records the main button "Inspect" as visible

  Scenario: the bundle's after-scenario hook forgets that choice
    Given the main menu is open
    Then RIMMSQOL is ready to be driven
    And RIMMSQOL holds no choice for the main button "Inspect"
    And RIMMSQOL shows the main button "Inspect" as hidden
    And RIMMSQOL's settings file records no choice for the main button "Inspect"
