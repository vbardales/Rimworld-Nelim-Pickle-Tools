# Not part of the pull request. Every scenario here is EXPECTED to fail: they provoke a click that opens
# nothing so the report `window {string} is open` now adds can be read in a game. Read the failure messages
# in the report; a green scenario here would be the defect. English only: the buttons are named by label.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleToolsCheck -DepMap wsl-deps.lostclickprobe.map -Filter lost-click-probe.feature -PickleSrc <build>
Feature: lost click probe

  Scenario: probe, a window covers the button and an image button in it takes the click
    Given the main menu is open
    And Nelim's Pickle Tools probe: a window covers the left of the screen and an image button in it takes every click
    When I click button "New colony"
    Then window "Page_SelectScenario" is open

  Scenario: probe, a window that absorbs input elsewhere swallows the click
    Given the main menu is open
    And Nelim's Pickle Tools probe: a window that absorbs input sits in the top right corner
    When I click button "New colony"
    Then window "Page_SelectScenario" is open

  Scenario: probe, no click was made, so the message is the one it always was
    Given the main menu is open
    Then window "Page_SelectScenario" is open
