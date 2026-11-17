# Non-regression of the steps written on 2026-11-15 (ColonistRace, StageDecor, HoverSteps). Each step asserts inside itself (it fails when its effect is missing),
# so a scenario passes only if the effect happened. Map: Tests/Pickle/wsl-deps.steps-regression.map. Written 2026-11-16. NOT PLAYED when written.
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.hoversteps
Feature: steps of 2026-11-15

  Background:
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: a colonist "Jet" exists

  Scenario: filth is spread on natural ground
    Given Nelim's Pickle Tools: the area from (140, 148) to (146, 154) is cleared
    When Nelim's Pickle Tools: the filth "Filth_Dirt" is spread from (141, 149) to (143, 151)
    Then no errors were logged

  Scenario: a colonist builds a placed blueprint
    Given Nelim's Pickle Tools: the area from (140, 148) to (146, 154) is cleared
    And Nelim's Pickle Tools: I place a blueprint of "Wall" at (143, 151)
    When Nelim's Pickle Tools: "Jet" builds the blueprint at (143, 151)
    And Nelim's Pickle Tools: the game is advanced by 30 ticks
    Then no errors were logged

  Scenario: a colonist aims a rifle at a cell
    Given Nelim's Pickle Tools: "Jet" wields "Gun_BoltActionRifle"
    And Nelim's Pickle Tools: "Jet" stands at (144, 152) facing West
    When Nelim's Pickle Tools: "Jet" aims at the cell (138, 152)
    Then no errors were logged

  Scenario: the render nodes and the apparel detail are logged
    When Nelim's Pickle Tools: the render nodes and layers of "Jet" are logged
    Then no errors were logged

  Scenario: a gizmo of the Architect is hovered by its label
    Given Nelim's Pickle Tools: I open the architect tab "Furniture"
    When Nelim's Pickle Tools: I hover over the gizmo labelled "Bed..."
    Then no errors were logged

  Scenario: a colonist is ordered to go somewhere many times at a set mood (vanilla refuses none)
    Given Nelim's Pickle Tools: the mood of "Jet" is set to 0.5
    And Nelim's Pickle Tools: "Jet" is ordered to go to (143, 151) 20 times
    Then Nelim's Pickle Tools: the orders of "Jet" were refused between 0 and 0 times
    And no errors were logged

  Scenario: a colonist is named by its number and then found by that name
    Given Nelim's Pickle Tools: the colonist number 1 is named "Zed"
    And Nelim's Pickle Tools: the mood of "Zed" is set to 0.5
    Then no errors were logged

  Scenario: the gender of a colonist is logged and asserted
    Given Nelim's Pickle Tools: "Jet" gender is female
    When Nelim's Pickle Tools: the gender of "Jet" is written to the log
    Then Nelim's Pickle Tools: the gender of "Jet" is female
    And no errors were logged

  Scenario: the reach of a colonist to a cell is logged and asserted
    When Nelim's Pickle Tools: the reach of "Jet" to (143, 151) is written to the log
    Then Nelim's Pickle Tools: "Jet" can reach (143, 151)
    And no errors were logged

  Scenario: a batch of ticks is watched for the things of a def
    Given Nelim's Pickle Tools: the area from (140, 148) to (146, 154) is cleared
    And Nelim's Pickle Tools: I place the decor "Wall" at (143, 151)
    When Nelim's Pickle Tools: the game is advanced by 30 ticks watching the field "def" of the things of def "Wall"
    Then Nelim's Pickle Tools: the watched things of def "Wall" showed the value "Wall"
    And Nelim's Pickle Tools: the watched things of def "Wall" never showed the value "Door"
    And Nelim's Pickle Tools: at most 1 of the watched things of def "Wall" stood at once
    And Nelim's Pickle Tools: between 1 and 1 distinct things of def "Wall" were seen while watching
    And no errors were logged
