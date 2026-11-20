Feature: PickleTools aggregate without Biotech

  @timeout:400
  Scenario: the bundle starts and discovers expansion steps without Biotech
    Given the main menu is open
    Then Nelim's Pickle Tools: the expansion "Ludeon.RimWorld.Biotech" is not active
