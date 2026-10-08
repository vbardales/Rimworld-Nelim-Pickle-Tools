@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
Feature: Fixed face parts of a colonist (mouth, brows, lids, skin) from Facial Animation and Vanilla Textures Expanded

  Scenario: face-parts: a smiling face, then a sad one, at 20 degrees
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "parts-before"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: "Nelim" face skin is "SkinRosyCheeks"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "parts-smile"
    Then Nelim's Pickle Tools: "Nelim" mouth reads "MouthSmile"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthSad"
    And Nelim's Pickle Tools: "Nelim" lids are "LidUnimpressed"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "parts-sad"
    Then Nelim's Pickle Tools: "Nelim" mouth reads "MouthSad"

  Scenario: face-kits: each whole-face kit on Nelim at 20 degrees
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    When Nelim's Pickle Tools: "Nelim" face kit is "smile"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "kit-smile"
    When Nelim's Pickle Tools: "Nelim" face kit is "calm"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "kit-calm"
    When Nelim's Pickle Tools: "Nelim" face kit is "sad"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "kit-sad"
    When Nelim's Pickle Tools: "Nelim" face kit is "angry"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "kit-angry"
    When Nelim's Pickle Tools: "Nelim" face kit is "smug"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "kit-smug"
    When Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "kit-neutral"
