# The three steps of PickleTools/ClickDiagnostics, played in the main menu, where a click opens a window without
# needing a save: the stand-still wait, the reachability check and the click that waits for its window.
# Buttons are named by translation key, so the same feature is played in English and in French.
#
# What it shows: the steps work on a healthy click. What it cannot show is their failure reports (a window that
# was already open must not count, the wait gives up on the clock): those need a click that fails, and a failing
# scenario cannot be part of a green pass. The deliberately failing probes are in lost-click-probe.feature.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.aggregate-minimal.map -Filter pickletools-clickdiagnostics
#
# The aggregate payload must have been built from the tree being tested: the steps are in its ClickDiagnostics DLL.
Feature: PickleTools click diagnostics steps

  Scenario: the main menu's New colony button stands still and its click opens the scenario page
    Given the main menu is open
    When Nelim's Pickle Tools: the button keyed "NewColony" has stood still
    And Nelim's Pickle Tools: I click the button keyed "NewColony" and the window "Page_SelectScenario" opens

  Scenario: the button of the page that opened stands still and is reachable in it
    Given the main menu is open
    When Nelim's Pickle Tools: I click the button keyed "NewColony" and the window "Page_SelectScenario" opens
    And Nelim's Pickle Tools: the button keyed "Next" has stood still
    Then Nelim's Pickle Tools: the button keyed "Next" is reachable in "Page_SelectScenario"
