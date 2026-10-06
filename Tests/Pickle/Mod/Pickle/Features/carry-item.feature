# On request of Work Studio: a colonist (Nelim) visibly hauling a log, in a sanctuary place.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
Feature: Colonist carries an item

  Scenario: carry-item: Nelim hauls a log
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: I am at the sanctuary "sleeping-nook"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing West
    And Nelim's Pickle Tools: "Nelim" carries the item "WoodLog"
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 5
    And I take a screenshot "carry-item"
