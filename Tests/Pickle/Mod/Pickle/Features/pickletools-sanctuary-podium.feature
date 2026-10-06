# On request of CreaturesOfKi: the podium (emerald-clearing, centre (197, 152)) at the default zoom and at zoom 6, at 18 h, clear weather.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary: podium views

  Scenario: podium-views: default zoom and zoom 6 at 18 h
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I set the hour to 18
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: I am at the sanctuary "emerald-clearing"
    And Nelim's Pickle Tools: the camera root size is set to 12
    And I take a screenshot "podium-zoom-12"
    And Nelim's Pickle Tools: the camera root size is set to 6
    And I take a screenshot "podium-zoom-6"
