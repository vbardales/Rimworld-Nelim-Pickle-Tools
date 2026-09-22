Feature: PickleTools inspect tab steps

  Background:
    Given the save "test-colony" is loaded

  Scenario: the inspect tabs open on a selected pawn, by short name, type name and label key
    Given a colonist "Tabby" exists
    When I select "Tabby"
    And Nelim's Pickle Tools: I open the "Gear" inspect tab
    Then Nelim's Pickle Tools: the "Gear" inspect tab is open
    And Nelim's Pickle Tools: the "ITab_Pawn_Gear" inspect tab is open
    And Nelim's Pickle Tools: the "TabGear" inspect tab is open
    When Nelim's Pickle Tools: I open the "Health" inspect tab
    Then Nelim's Pickle Tools: the "Health" inspect tab is open
    When Nelim's Pickle Tools: I open the "Character" inspect tab
    Then Nelim's Pickle Tools: the "Character" inspect tab is open
    And no errors were logged
