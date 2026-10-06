# Why were the final3 captures dark although the hour was set to 12? Logs the light before and after the hour and the weather are set, asserts the sky glow, and photographs the whole map and the grand place.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuaire light: noon must be bright, and the framings must hold

  Scenario: light-shot: noon is bright, the overview and the grand place are framed
    Given the save "Nelims-tribe-draft" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the light of the map is logged
    And Nelim's Pickle Tools: the eclipse of the map is ended
    When I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    Then Nelim's Pickle Tools: the light of the map is logged
    And Nelim's Pickle Tools: the sun glow of the map is at least 0.8
    When Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I am at the sanctuary "overview-north"
    And I take a screenshot "light-overview-north"
    And Nelim's Pickle Tools: I am at the sanctuary "overview-south"
    And I take a screenshot "light-overview-south"
    And Nelim's Pickle Tools: I am at the sanctuary "grand-place"
    And I take a screenshot "light-grand-place"
