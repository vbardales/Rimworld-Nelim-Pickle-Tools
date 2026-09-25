# The two ways a click is lost that the lost-click report is written for, asserted as SYMPTOMS so that green is green: a window
# covers the button and takes the click, or a window that absorbs input elsewhere swallows it. In both, the click on "New colony"
# must open nothing: window "Page_SelectScenario" is closed afterwards. The third scenario is the control: with no probe window
# in the way, the same click opens it.
#
# What this does NOT show is the text of the report that a failing `window {string} is open` prints (Upstream PR, `-PickleSrc`
# build). That text is read from the deliberately failing copy of these scenarios in Upstream/tests/lost-click-probe.feature.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.lostclickprobe.map -Filter lost-click-probe
@requires:nelim.pickletools.lostclickprobe
@requires:nelim.pickletools.keyedclick
Feature: lost click probe

  Scenario: a window covers the button and an image button in it takes the click
    Given the main menu is open
    And Nelim's Pickle Tools probe: a window covers the left of the screen and an image button in it takes every click
    When Nelim's Pickle Tools: I click button keyed "NewColony"
    Then window "Page_SelectScenario" is closed

  Scenario: a window that absorbs input elsewhere swallows the click
    Given the main menu is open
    And Nelim's Pickle Tools probe: a window that absorbs input sits in the top right corner
    When Nelim's Pickle Tools: I click button keyed "NewColony"
    Then window "Page_SelectScenario" is closed

  Scenario: control, with nothing in the way the same click opens the page
    Given the main menu is open
    When Nelim's Pickle Tools: I click button keyed "NewColony"
    Then window "Page_SelectScenario" is open
