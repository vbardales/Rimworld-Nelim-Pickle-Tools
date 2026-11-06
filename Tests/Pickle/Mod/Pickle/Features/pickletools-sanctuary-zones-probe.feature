# Diagnostic, no change: bounds of the growing zones and of the dump zone in the decor-mods save (NSB 2026-11-06: rice zones 19 and 21, cotton needs a free growing zone, dump frame to recentre).
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary zones probe

  Scenario: sanctuary-zones-probe: bounds of the growing zones and the dump
    Given the save "Nelims-tribe-decor-mods-b" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the zones named "Zone agricole" are logged
    And Nelim's Pickle Tools: the zones named "Décharge" are logged
    And Nelim's Pickle Tools: the zones named "zzzz-no-such-zone" are logged
