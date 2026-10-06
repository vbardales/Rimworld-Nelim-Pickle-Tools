# Does VEF's "ignore" answer survive a save and a reload? Scenario 1 answers the window, saves and reloads. Scenario 2 (Pickle 6.6.0, "the save file {string} is loaded") reopens the file scenario 1 wrote, with no answer registered, and checks the ignored factions come from the save, not from a registered answer.
@requires:nelim.pickletools.screenshotstudio
Feature: VEF window: the ignore answer is written into the save

  Scenario: vef-persist: answer, save, reload
    Given a window "Dialog_NewFactionSpawning" is answered with "Don't ask for this faction again"
    And the save "Nelims-tribe" is loaded
    When I wait 300 ticks
    Then Nelim's Pickle Tools: the world component "VEF.Factions.NewFactionSpawningState" holds at least 1 entries in its field "ignoredFactions"
    When I save and reload as "vef-persist-after"
    Then Nelim's Pickle Tools: the world component "VEF.Factions.NewFactionSpawningState" holds at least 1 entries in its field "ignoredFactions"


  Scenario: vef-persist: reopen the saved file
    Given the save file "vef-persist-after" is loaded
    When I wait 300 ticks
    Then Nelim's Pickle Tools: the world component "VEF.Factions.NewFactionSpawningState" holds at least 1 entries in its field "ignoredFactions"
