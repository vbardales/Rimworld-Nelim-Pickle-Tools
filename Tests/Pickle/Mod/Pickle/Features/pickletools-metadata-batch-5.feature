# Def metadata journal, batch 5 (the rest, with three own mods): one line per mod, no photos, for the catalogue registry (Cat). Written 2026-11-19, NOT PLAYED when written. A mod that hangs the load goes to its own ticket.
@requires:nelim.pickletools.colonistrace
Feature: def metadata batch 5

  Scenario: metadata-batch-5: the def metadata of 9 mods
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the def metadata of the mod "ATMnou.aooni" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "sliderxs.greekrelics" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "kanid99.entertainingideas" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "Choco.RelicBlessings" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "NassWorld.NassIndustries" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "Yukiyuki.MonmusuCollection1" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "nelim.creaturesofki.teshi" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "nelim.aslothmod" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "nelim.animalcosmeticgenes" is logged
    Then no errors were logged
