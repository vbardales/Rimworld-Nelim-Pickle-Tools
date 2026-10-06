# Lists the free cells, the buildings and items and the stockpile zones of the places the galleries use (log and attachment).
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary: place listing

  Scenario: sanctuary-list: the gallery places
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    Given Nelim's Pickle Tools: the sanctuary "sofa-corner" is listed
    And Nelim's Pickle Tools: the sanctuary "sleeping-nook" is listed
    And Nelim's Pickle Tools: the sanctuary "dining-nook" is listed
    And Nelim's Pickle Tools: the sanctuary "fire-pit" is listed
    And Nelim's Pickle Tools: the sanctuary "terrace" is listed
    And Nelim's Pickle Tools: the sanctuary "emerald-clearing" is listed
    And Nelim's Pickle Tools: the sanctuary "cloister" is listed
    And Nelim's Pickle Tools: the sanctuary "hearth-hall" is listed
    And Nelim's Pickle Tools: the sanctuary "prestige-hall" is listed
    And Nelim's Pickle Tools: the sanctuary "ritual-hall" is listed
    And Nelim's Pickle Tools: the sanctuary "calm-zone" is listed
