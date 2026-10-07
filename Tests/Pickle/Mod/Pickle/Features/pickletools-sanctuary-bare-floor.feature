# Checks the step that bares the floor of a place: the green podium square of emerald-clearing must show bare ground.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary: bare floor

  Scenario: bare-floor: emerald-clearing without the green square
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: the floor of the sanctuary "emerald-clearing" is bared
    And Nelim's Sanctuary: I am at the sanctuary "emerald-clearing"
    And I take a screenshot "bare-floor-emerald-clearing"
