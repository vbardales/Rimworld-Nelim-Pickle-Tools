# Window backdrops for fullscreen interface captures: a green bamboo field with a smiley sticking out of a corner. Estimated framings, to be checked by eye.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary: window backdrops

  Scenario Outline: window-backdrop: <place>
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: all animals are removed
    And Nelim's Sanctuary: I am at the sanctuary "<place>"
    And I take a screenshot "<place>"

    Examples:
      | place                      |
      | window-backdrop-for-width  |
      | window-backdrop-for-height |
