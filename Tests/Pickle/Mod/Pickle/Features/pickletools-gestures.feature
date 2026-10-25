# Mid-gesture captures asked by Dalmatians Renew and Creatures of Ki: a colonist hauling and an animal walking, the paused game advanced by an exact number of ticks, then a female adult spawn. Steps written 2026-10-25, not played before this scenario.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Gestures caught mid-step

  Scenario: gestures-1: Nelim hauls a log and a cat walks, the paused game advanced by 20 ticks
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing East
    And Nelim's Pickle Tools: a female adult animal of kind "Cat" named "Mama" is spawned at (178, 122)
    And Nelim's Pickle Tools: "Nelim" is forced to haul 5 of the item "WoodLog" to (186, 120)
    And Nelim's Pickle Tools: "Mama" is forced to walk to (186, 124)
    When Nelim's Pickle Tools: I advance the paused game by exactly 20 ticks
    And Nelim's Pickle Tools: I frame the cell (181, 121) at zoom 6
    And I take a screenshot "gestures-1-frame-20"
    And Nelim's Pickle Tools: I advance the paused game by exactly 20 ticks
    And I take a screenshot "gestures-1-frame-40"
