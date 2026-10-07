# Checks the presentation mode hides stack counts and name labels: terrace (logs top-left) with the colonist standing in frame.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary: overlays hidden

  Scenario: overlays-hidden: terrace without stack counts or names
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I am at the sanctuary "terrace"
    And Nelim's Pickle Tools: "Nelim" stands at (197, 123)
    And I take a screenshot "overlays-hidden-terrace"
