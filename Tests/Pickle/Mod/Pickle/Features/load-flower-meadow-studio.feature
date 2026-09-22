Feature: Reuse the saved flower meadow studio
  Scenario: Load the exported fixture without rebuilding the scenery
    Given the save "nelim-zen-meadow-studio" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the screen is clear
    Then Nelim's Pickle Tools: the flower meadow studio is intact
    When Nelim's Pickle Tools: I frame the studio "overview"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I take a screenshot "studio-reloaded-fixture"
