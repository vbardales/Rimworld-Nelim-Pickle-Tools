Feature: Reuse the saved flower meadow studio
  Scenario: Load the exported fixture without rebuilding the scenery
    Given the save "nelim-zen-meadow-studio" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the screen is clear
    Then Nelim's Pickle Tools: the flower meadow studio is intact
    When Nelim's Pickle Tools: I frame the studio "overview"
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
