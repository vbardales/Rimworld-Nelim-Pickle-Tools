# Plays the InterfaceScale step: set the scale, then click a button at it.
#
# On Pickle 6 a click is taken at the widget, not through an OS pointer, so this passes if clicks still land at another scale.
# It no longer depends on a repair of the tag store (removed 2026-10-02, see InterfaceScale/README.md). Not played on Pickle 6 yet.
#
# The button is clicked by the key its label comes from (KeyedClick): a click on the English label "New colony" cannot find its button in a French game.
Feature: PickleTools interface scale

  Scenario: a button is clickable at another interface scale
    Given the main menu is open
    And Nelim's Pickle Tools: the interface scale is 150 percent
    When Nelim's Pickle Tools: I click button keyed "NewColony"
    Then window "Page_SelectScenario" is open
