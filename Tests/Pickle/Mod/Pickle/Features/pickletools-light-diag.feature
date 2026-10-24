@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
@requires:nelim.sanctuarybacklot
@requires:nelim.pickletools.clickdiagnostics
Feature: The white veil on outdoor captures (diagnostic, 2026-10-25): the light of the map, with and without presentation mode, by day and by night

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: all filth is cleaned
    And Nelim's Pickle Tools: all humans but "Nelim" are removed
    And I set the weather to "Clear"

  Scenario: veil-1-day-presentation: hour 10 on the bridge as the story shoots it
    Given I set the hour to 10
    And Nelim's Sanctuary: the animals are kept out of the sanctuary "river-bridge"
    And Nelim's Sanctuary: I am at the sanctuary "river-bridge"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Pickle Tools: the selection brackets are hidden
    And Nelim's Pickle Tools: I move the mouse to (10, 10)
    And Nelim's Pickle Tools: "Nelim" stands at (135, 124) facing East
    And Nelim's Pickle Tools: the camera is centered on "Nelim" at root size 7
    When Nelim's Pickle Tools: I let 5 frames pass
    Then Nelim's Pickle Tools: the light of the map is logged
    And I take a screenshot "veil-1-day-presentation"

  Scenario: veil-2-day-plain: the same shot without presentation mode
    Given I set the hour to 10
    And Nelim's Sanctuary: the animals are kept out of the sanctuary "river-bridge"
    And Nelim's Sanctuary: I am at the sanctuary "river-bridge"
    And Nelim's Pickle Tools: "Nelim" stands at (135, 124) facing East
    And Nelim's Pickle Tools: the camera is centered on "Nelim" at root size 7
    When Nelim's Pickle Tools: I let 5 frames pass
    Then Nelim's Pickle Tools: the light of the map is logged
    And I take a screenshot "veil-2-day-plain"

  Scenario: veil-3-night-outdoor: hour 23 on the bridge, presentation mode
    Given I set the hour to 23
    And Nelim's Sanctuary: the animals are kept out of the sanctuary "river-bridge"
    And Nelim's Sanctuary: I am at the sanctuary "river-bridge"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I move the mouse to (10, 10)
    And Nelim's Pickle Tools: "Nelim" stands at (135, 124) facing East
    And Nelim's Pickle Tools: the camera is centered on "Nelim" at root size 7
    When Nelim's Pickle Tools: I let 5 frames pass
    Then Nelim's Pickle Tools: the light of the map is logged
    And I take a screenshot "veil-3-night-outdoor"
