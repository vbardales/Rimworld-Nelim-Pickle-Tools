# Photograph of calm-zone-close, for the places page.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary: calm-zone-close

  Scenario: calm-zone-close: one photograph
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: I am at the sanctuary "calm-zone-close"
    And I take a screenshot "sanctuary-calm-zone-close"
