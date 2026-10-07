# The three workshops after they were spread out (barn enlarged to 17 x 15, preindustrial and postindustrial moved east, gaps between them):
# each frame must show only its own building.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary: the barn and the two workshops, apart

  Scenario: workshops-apart: each workshop alone in its frame
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: I frame the sanctuary "workshops"
    And I take a screenshot "workshops-all"
    And Nelim's Pickle Tools: I frame the sanctuary "barn"
    And I take a screenshot "barn"
    And Nelim's Pickle Tools: I frame the sanctuary "preindustrial-workshop"
    And I take a screenshot "preindustrial"
    And Nelim's Pickle Tools: I frame the sanctuary "postindustrial-workshop"
    And I take a screenshot "postindustrial"
