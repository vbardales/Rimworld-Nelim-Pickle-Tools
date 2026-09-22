Feature: Flower meadow screenshot studio

  Scenario: Build the meadow and verify that the studio survives a save reload
    Given the save "studio-base" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the flower meadow studio is prepared
    When I set the hour to 12
    And I set the weather to "Clear"
    Then Nelim's Pickle Tools: the flower meadow studio is intact
    When I save and reload
    Given game speed is paused
    And Nelim's Pickle Tools: the screen is clear
    Then Nelim's Pickle Tools: the flower meadow studio is intact
    When Nelim's Pickle Tools: I frame the studio "overview"
    And Nelim's Pickle Tools: I save the flower meadow studio
    And I take a screenshot "studio-overview-interface"
