# The pawn stays selected (inspect pane and its tab open) but the white selection brackets and the name label are not drawn.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.inspecttabs
Feature: Sanctuary: selection brackets and labels hidden

  Scenario: brackets-hidden: selected pawn without brackets or name
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the selection brackets are hidden
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I select the thing of def "Human" at (176, 120)
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 5
    And I take a screenshot "brackets-hidden"
