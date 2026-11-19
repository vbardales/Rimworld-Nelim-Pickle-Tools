# Def metadata journal, batch 2 (Paranormal and Space Station 14, the heavy ones): one line per mod, no photos, for the catalogue registry (Cat). Written 2026-11-19, NOT PLAYED when written. A mod that hangs the load goes to its own ticket.
@requires:nelim.pickletools.colonistrace
Feature: def metadata batch 2

  Scenario: metadata-batch-2: the def metadata of 2 mods
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the def metadata of the mod "touhou.merissu" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "Xenon.ss14onrim" is logged
    Then no errors were logged
