# Batch 2c (NSB choices 2026-11-07, owner validates the shots after): pediatrics beds turned SOUTH kept as fixture state, infirmary runner repainted Structure_Sage (the cream paint was invisible on the cream floor; the paint read-back of 2b passed), the loose Hay at (217, 50) removed (the Hay at (217, 49) is the straw drawn in the bed), area and zone overlays hidden before the frames. Chained: loads Nelims-tribe-decor-mods-e, saves Nelims-tribe-decor-mods-f in the run folder; validated fixtures untouched. Not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 2c

  Scenario: sanctuary-batch2c: beds south, runner sage, loose hay out, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-e" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the buildings "Bed" from (196, 57) to (216, 70) are turned to face south
    And Nelim's Pickle Tools: I lay the floor "CarpetBlue" from (210, 50) to (215, 51) painted "Structure_Sage"
    And Nelim's Pickle Tools: the area from (217, 50) to (217, 50) is emptied
    And Nelim's Pickle Tools: the things within 3 cells of (217, 50) are listed
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-animals"
    And I take a screenshot "after-infirmary-animals-e"
    And Nelim's Sanctuary: I frame the sanctuary "play-area"
    And I take a screenshot "after-play-area-c"
    And Nelim's Sanctuary: I frame the sanctuary "pediatrics"
    And I take a screenshot "beds-turned-south-c"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-f"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-f" is copied to the run folder
