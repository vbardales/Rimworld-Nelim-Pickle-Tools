# The hover steps of PickleTools/HoverSteps: a tooltip is named by its text, hovered, and asserted as drawn. The page is the game's
# own options dialog and the tooltip the game's own key, so the scenario needs no mod and no save, and its result does not depend on the
# language: the key is resolved with Translate(), and the button is clicked by its key.
#
# FIRST PLAY (2026-09-25) FAILED ON THE KEY, not on the step: the volume slider registers no tip region (the failure listed the ones on screen), so the key is now AutosaveIntervalTooltip, one that the list held. It assumes a tooltip region registered through
# TooltipHandler.TipRegion and that the key AutosaveIntervalTooltip is the text of it. If the first run says no region matched, the
# failure lists the regions on screen; take the key from that list.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.hoversteps.map -Filter pickletools-hoversteps
@requires:nelim.pickletools.hoversteps
@requires:nelim.pickletools.keyedclick
Feature: PickleTools hover steps

  Scenario: a tooltip of the options dialog is hovered by its key and is drawn
    Given the main menu is open
    When Nelim's Pickle Tools: I click button keyed "Options"
    Then window "Dialog_Options" is open
    When Nelim's Pickle Tools: I hover over the tooltip keyed "AutosaveIntervalTooltip"
    Then Nelim's Pickle Tools: the tooltip keyed "AutosaveIntervalTooltip" is drawn
    When I take a screenshot "the autosave interval tooltip"
