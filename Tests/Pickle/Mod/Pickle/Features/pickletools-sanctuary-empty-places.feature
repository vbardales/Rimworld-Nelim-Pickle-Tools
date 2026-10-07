# Empty photographs of the places CreaturesOfKi may choose from: noon, clear, no animals, colonist sent away, presentation mode.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary: empty places

  Scenario: empty-places: eight daylight places
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: all animals are removed
    And Nelim's Pickle Tools: the colonists are sent to the map corner
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    And I take a screenshot "empty-water-garden"
    And Nelim's Sanctuary: I am at the sanctuary "left-bank"
    And I take a screenshot "empty-left-bank"
    And Nelim's Sanctuary: I am at the sanctuary "hut"
    And I take a screenshot "empty-hut"
    And Nelim's Sanctuary: I am at the sanctuary "calm-zone"
    And I take a screenshot "empty-calm-zone"
    And Nelim's Sanctuary: I am at the sanctuary "smiley-river"
    And I take a screenshot "empty-smiley-river"
    And Nelim's Sanctuary: I am at the sanctuary "smiley-bottom-centre"
    And I take a screenshot "empty-smiley-bottom-centre"
    And Nelim's Sanctuary: I am at the sanctuary "smiley-bottom-east"
    And I take a screenshot "empty-smiley-bottom-east"
    And Nelim's Sanctuary: I am at the sanctuary "smiley-north"
    And I take a screenshot "empty-smiley-north"
