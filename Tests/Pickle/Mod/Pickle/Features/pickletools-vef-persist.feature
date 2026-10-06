# Does VEF's "ignore" answer survive a save and a reload? The first scenario answers the window, saves and reloads. The save file itself was read by hand (the faction ids of the module are in ignoredFactions); Pickle loads fixtures only, so a second scenario cannot load it.
@requires:nelim.pickletools.screenshotstudio
Feature: VEF window: the ignore answer is written into the save

  Scenario: vef-persist: answer, save, reload
    Given a window "Dialog_NewFactionSpawning" is answered with "Don't ask for this faction again"
    And the save "Nelims-tribe" is loaded
    When I wait 300 ticks
    Then Nelim's Pickle Tools: the world component "VEF.Factions.NewFactionSpawningState" holds at least 1 entries in its field "ignoredFactions"
    When I save and reload as "vef-persist-after"
    Then Nelim's Pickle Tools: the world component "VEF.Factions.NewFactionSpawningState" holds at least 1 entries in its field "ignoredFactions"

