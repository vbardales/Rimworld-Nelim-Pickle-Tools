# The keyed click step of PickleTools/KeyedClick, played against stock Pickle.
#
# It is the copy of the step proposed as RimWorks/Rimworld-Pickle pull request 19 (`I click button keyed`), kept
# under the "Nelim's Pickle Tools:" prefix until that lands. Play it in English and again in French: in English
# the key and the literal label give the same text and prove nothing, so the French run is the one that counts.
#
# No save is loaded. The main menu is where the buttons are, and it is reached without a colony.
Feature: PickleTools keyed click step

  Scenario: a button is clicked by the key its label comes from
    Given the main menu is open
    When Nelim's Pickle Tools: I click button keyed "NewColony"
    Then window "Page_SelectScenario" is open
    When Nelim's Pickle Tools: I click button keyed "Next"
    Then window "Page_SelectStoryteller" is open
    When Nelim's Pickle Tools: I click button keyed "Back"
    Then window "Page_SelectScenario" is open
