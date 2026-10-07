# The infirmary and the pediatric zone (x 196-218, z 47-65): soft colours, three rooms under one roof.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary: infirmary and pediatrics

  Scenario: infirmary-views: the three rooms and the whole building
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the resource readout is hidden
    And Nelim's Sanctuary: I frame the sanctuary "infirmary"
    And I take a screenshot "infirmary-all"
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-pawns"
    And I take a screenshot "infirmary-pawns"
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-animals"
    And I take a screenshot "infirmary-animals"
    And Nelim's Sanctuary: I frame the sanctuary "pediatrics"
    And I take a screenshot "pediatrics"
