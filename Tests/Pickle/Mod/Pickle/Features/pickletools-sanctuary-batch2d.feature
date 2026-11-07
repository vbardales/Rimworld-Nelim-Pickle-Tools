# Batch 2d (NSB verdict on 2948, 2026-11-07): ShadeCanopy and the plush "goblet" at (107, 119) removed, SpringFox moved into the canopy cell, loose Hay (217, 49) out of the infirmary bed, terrain probes (moss in the play area, the orange patches), a second play-area frame centred on the gate. Chained: loads Nelims-tribe-decor-mods-f, saves Nelims-tribe-decor-mods-g in the run folder; validated fixtures untouched. Not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 2d

  Scenario: sanctuary-batch2d: canopy out, fox moved, hay out, probes, gate frame, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-f" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    # probes first: the play-area floor (is it MossyTerrain?), the orange patch south of the fence (smiley-west carpet?), the orange patch east of the infirmary
    And Nelim's Pickle Tools: the terrain of the cell (92, 117) is logged
    And Nelim's Pickle Tools: the terrain of the cell (99, 120) is logged
    And Nelim's Pickle Tools: the terrain of the cell (98, 109) is logged
    And Nelim's Pickle Tools: the terrain of the cell (98, 108) is logged
    And Nelim's Pickle Tools: the terrain of the cell (222, 54) is logged
    And Nelim's Pickle Tools: the terrain of the cell (223, 50) is logged
    And Nelim's Pickle Tools: the terrain of the cell (221, 57) is logged
    And Nelim's Pickle Tools: the things within 2 cells of (107, 119) are listed
    # canopy and plush out, fox into the canopy cell, hay out of the bed
    And I destroy the "LP_ShadeCanopy" at (106, 117)
    And I destroy the "AKN_ComfortingPlush" at (107, 119)
    And I destroy the "LP_SpringFox" at (106, 114)
    And Nelim's Pickle Tools: I place the decor "LP_SpringFox" exactly at (106, 117)
    And I destroy the "Hay" at (217, 49)
    And Nelim's Pickle Tools: the things within 3 cells of (217, 50) are listed
    And Nelim's Pickle Tools: the things within 5 cells of (106, 117) are listed
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-animals"
    And I take a screenshot "after-infirmary-animals-f"
    And Nelim's Sanctuary: I frame the sanctuary "play-area"
    And I take a screenshot "after-play-area-d"
    And Nelim's Pickle Tools: I frame the area centred on (110, 118) at root size 10
    And I take a screenshot "after-play-area-gate-d"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-g"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-g" is copied to the run folder
