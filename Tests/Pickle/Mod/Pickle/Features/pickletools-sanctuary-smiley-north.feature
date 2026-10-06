# On request of CreaturesOfKi: control view of smiley-north (centre (176, 202)) at 18 h, clear weather, zoom 12 and zoom 6, nothing set.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary: smiley-north views

  Scenario: smiley-north-views: zoom 12 and zoom 6 at 18 h
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I set the hour to 18
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: I am at the sanctuary "smiley-north"
    And Nelim's Pickle Tools: the camera root size is set to 12
    And I take a screenshot "smiley-north-zoom-12"
    And Nelim's Pickle Tools: the camera root size is set to 6
    And I take a screenshot "smiley-north-zoom-6"
