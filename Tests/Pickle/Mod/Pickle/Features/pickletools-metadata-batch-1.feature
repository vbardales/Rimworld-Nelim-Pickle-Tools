# Def metadata journal, batch 1 (three Ratkin mods): one line per mod, no photos, for the catalogue registry (Cat). Written 2026-11-19, NOT PLAYED when written. A mod that hangs the load goes to its own ticket.
@requires:nelim.pickletools.colonistrace
Feature: def metadata batch 1

  Scenario: metadata-batch-1: the def metadata of 3 mods
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the def metadata of the mod "Solaris.RatkinRaceMod" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "fxz.ratkinanomaly.update" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "RKK.RatKnights.Core" is logged
    Then no errors were logged
