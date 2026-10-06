# Is VEF's "new faction" window answered by a scenario (Pickle's "a window ... is answered with" step), so that VEF records the answer?
# With the answer registered the window is let through, the "ignore" button is clicked and VEF stores the faction in NewFactionSpawningState.ignoredFactions;
# without it, suppression drops the window and VEF records nothing. Both scenarios load the same save, which has never seen the faction module.
@requires:nelim.pickletools.screenshotstudio
Feature: VEF window: answered, then recorded

  Scenario: vef-window: the window is answered with ignore and VEF records it
    Given a window "Dialog_NewFactionSpawning" is answered with "Don't ask for this faction again"
    And the save "Nelims-tribe" is loaded
    When I wait 300 ticks
    Then Nelim's Pickle Tools: no window of the type "Dialog_NewFactionSpawning" is open
    And Nelim's Pickle Tools: the world component "VEF.Factions.NewFactionSpawningState" holds at least 1 entries in its field "ignoredFactions"

  Scenario: vef-window: control, without an answer VEF records nothing
    Given the save "Nelims-tribe" is loaded
    When I wait 300 ticks
    Then Nelim's Pickle Tools: no window of the type "Dialog_NewFactionSpawning" is open
