# Def metadata journal, batch 3 (style packs): one line per mod, no photos, for the catalogue registry (Cat). Written 2026-11-19, NOT PLAYED when written. A mod that hangs the load goes to its own ticket.
@requires:nelim.pickletools.colonistrace
Feature: def metadata batch 3

  Scenario: metadata-batch-3: the def metadata of 7 mods
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the def metadata of the mod "DSP.HalituisAmaricanous" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "ASP.HalituisAmaricanous" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "ObsidiaExpansion.Ideology.StylePack" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "GM.Nautian.Style" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "Gerrymon.GreekcoreStyle" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "Anthitei.ATHsStyleDraconic.Style" is logged
    And Nelim's Pickle Tools: the def metadata of the mod "void.szstonesandterrains" is logged
    Then no errors were logged
