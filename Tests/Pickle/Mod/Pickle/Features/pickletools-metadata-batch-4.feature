# Def metadata journal, batch 4 (furniture, race and small mods): one line per mod, no photos, for the catalogue registry (Cat). Written 2026-11-19, NOT PLAYED when written. A mod that hangs the load goes to its own ticket.
@requires:nelim.pickletools.colonistrace
Feature: def metadata batch 4

  Scenario: metadata-batch-4: the def metadata of 8 mods
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the def metadata of the mod "velcroboy333.ElvasatsFurniture" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "nerdwonder.mixedblock" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "co.uk.epicguru.disco" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "Chemora.Valkyria" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "speedentron.SkullThrone" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "Mlie.DestroyedCity" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "cyco.WorshipOfMoloch" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "riko.forgenest" is logged
    Then no errors were logged
