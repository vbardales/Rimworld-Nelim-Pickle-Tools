# Checks the colonist is sent to a map corner and the place is photographed without her.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary: colonists away

  Scenario: colonists-away: enclosure-south without Nelim
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the colonists are sent to the map corner
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I take a screenshot "colonists-away-enclosure-south"
