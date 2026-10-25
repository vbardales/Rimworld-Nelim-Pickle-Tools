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

  Scenario: gestures-2: a female and a male adult cat and a female kitten, sex asserted by the step
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: a female adult animal of kind "Cat" named "Mere" is spawned at (197, 152)
    And Nelim's Pickle Tools: a male adult animal of kind "Cat" named "Pere" is spawned at (199, 152)
    And Nelim's Pickle Tools: a female animal of kind "Cat" named "Chaton" is spawned at (201, 152) at life stage 0
    When Nelim's Pickle Tools: I frame the animal "Mere" at zoom 4
    And I take a screenshot "gestures-2-sexes"

  Scenario: gestures-3: Nelim leaves a jug of Milk on the ground, a cat is forced to eat it, caught after 30 ticks
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing East
    And Nelim's Pickle Tools: an adult animal of kind "Cat" named "Minou" is spawned at (188, 121)
    And Nelim's Pickle Tools: "Nelim" is forced to haul 1 of the item "Milk" to (186, 121)
    When Nelim's Pickle Tools: I advance the paused game by exactly 400 ticks
    And Nelim's Pickle Tools: the animal "Minou" is forced into the job "Ingest" on the item "Milk" at (186, 121)
    And Nelim's Pickle Tools: I advance the paused game by exactly 30 ticks
    And Nelim's Pickle Tools: I frame the cell (186, 121) at zoom 4
    And I take a screenshot "gestures-3-ingest"
