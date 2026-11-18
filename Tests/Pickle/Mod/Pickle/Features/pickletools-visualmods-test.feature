# Visual mods test (Cat/BiB, 2026-11-18): Show Me Your Hands + Yayo's Animation Continued with WDI bodies and Facial Animation. Map wsl-deps.visualmods-test.map. NOT PLAYED when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: visual mods test

  Scenario: visualmods-test: a rifle aimed and a sword held
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" also wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 3
    When Nelim's Pickle Tools: "Nelim" wields "Gun_BoltActionRifle"
    And Nelim's Pickle Tools: "Nelim" aims at the cell (176, 126)
    And I wait 60 ticks
    And Nelim's Pickle Tools: the weapon render of "Nelim" is logged
    And I take a screenshot "visualmods-rifle"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_LongSword"
    And I wait 60 ticks
    And I take a screenshot "visualmods-sword"
    Then no errors were logged
