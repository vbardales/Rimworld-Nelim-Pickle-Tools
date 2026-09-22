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
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "studio-overview"
    And Nelim's Pickle Tools: I frame the studio "emblem"
    And I take a screenshot "studio-emblem"
    And Nelim's Pickle Tools: I frame the studio "workshop"
    And I take a screenshot "studio-workshop"
    And Nelim's Pickle Tools: I frame the studio "kitchen"
    And I take a screenshot "studio-kitchen"
    And Nelim's Pickle Tools: I frame the studio "home"
    And I take a screenshot "studio-home"
    And Nelim's Pickle Tools: I frame the studio "display"
    And I take a screenshot "studio-display"
    And Nelim's Pickle Tools: I frame the studio "flowers"
    And I take a screenshot "studio-flowers"
    And Nelim's Pickle Tools: I frame the studio "pond"
    And I take a screenshot "studio-pond"
    And Nelim's Pickle Tools: I frame the studio "zen"
    And I take a screenshot "studio-zen"
