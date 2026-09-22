Feature: PickleTools aggregate bundle

  Scenario: The generated aggregate exposes a distributed step in a minimal game
    Given the main menu is open
    Then Nelim's Pickle Tools: the expansion "Ludeon.RimWorld.Biotech" is active
    And Nelim's Pickle Tools: the expansion "MalteSchulze.RIMMSqol" is not active
