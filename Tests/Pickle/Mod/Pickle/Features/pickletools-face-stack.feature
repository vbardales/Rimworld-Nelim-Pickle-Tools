@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
Feature: Stacked facial animations of Nals Facial Animation (the last one that defines a part wins)

  Scenario: face-stack: neutral base, then smile, sad, blush and open on top, in the heat of the room
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the thermal state and thoughts of "Nelim" are logged
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "stack-normal"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+NLR-Smile"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "stack-smile"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+NLR-Sad"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "stack-sad"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+NLR-Blush"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "stack-blush"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+NLR-Open"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "stack-open"

  Scenario: face-list: every facial animation the loaded mods define, by mod
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    When Nelim's Pickle Tools: the facial animations are listed
    Then Nelim's Pickle Tools: "Nelim" facial expression is "normal"
