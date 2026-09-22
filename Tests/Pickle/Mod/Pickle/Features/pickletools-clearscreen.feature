# The clear screen steps of PickleTools/ClearScreen, played against stock Pickle.
#
# Windows are opened through the game's own main tabs, which need no step of Pickle's own. A tab
# keeps being the current one even when its window is dropped, so each check opens a DIFFERENT tab.
#
# "is closed" also holds when nothing ever tried to open the window, so every scenario that asserts
# a dropped window also asserts, in the same run, that a window of the same kind does open when
# suppression is off: without that control a broken tab step would pass as a working suppression.
#
# The last two scenarios depend on the order they are written in: the first leaves suppression on,
# and the second proves that the end of a scenario lifted it.
Feature: PickleTools clear screen steps

  Background:
    Given the save "test-colony" is loaded

  Scenario: a cleared screen closes what is open, and drops what opens next
    When I open the "Research" tab
    Then window "MainTabWindow_Research" is open
    Given Nelim's Pickle Tools: the screen is clear
    Then window "MainTabWindow_Research" is closed
    When I open the "Assign" tab
    Then window "MainTabWindow_Assign" is closed
    When Nelim's Pickle Tools: windows are allowed to open again
    And I open the "Work" tab
    Then window "MainTabWindow_Work" is open
    And no errors were logged

  Scenario: the explicit step hands windows back
    Given Nelim's Pickle Tools: the screen is clear
    When Nelim's Pickle Tools: windows are allowed to open again
    And I open the "Research" tab
    Then window "MainTabWindow_Research" is open
    And no errors were logged

  Scenario: suppression left on is lifted when the scenario ends
    Given Nelim's Pickle Tools: the screen is clear
    Then window "MainTabWindow_Research" is closed

  Scenario: the scenario after it opens windows as usual
    When I open the "Research" tab
    Then window "MainTabWindow_Research" is open
    And no errors were logged
