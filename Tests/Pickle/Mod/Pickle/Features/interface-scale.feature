# Plays the InterfaceScale tool: the step that sets the scale, and the repair that lets a click land at it.
#
# A tag is recorded in GUI space and multiplied by Prefs.UIScale when the pointer moves, so a click only
# exercises that conversion where the two spaces differ. At 100% they coincide, and a rect stored half in
# screen space still lands on its button - which is why Pickle's tag store, converting with
# GUIToScreenRect, passed every scenario for months. At 150% the click lands away from its button and the
# page never opens.
#
# This scenario passes ONLY with the repair in place. On a Pickle that does not have the fix and without
# this tool staged, it fails with "window 'Page_SelectScenario' should be open". It is the same scenario
# as the one proposed to Pickle itself in pull request 23, with the tool's prefix on the step.
Feature: PickleTools interface scale

  Scenario: a button is clickable at another interface scale
    Given the main menu is open
    And Nelim's Pickle Tools: the interface scale is 150 percent
    When I click button "New colony"
    Then window "Page_SelectScenario" is open
