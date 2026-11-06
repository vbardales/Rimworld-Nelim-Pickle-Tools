# Animal infirmary rework (NSB request 2026-11-06, Virginie: "très nu, peu décoré, il manque une dalle à la porte"), from the validated fixture (ritual hall, fa7a).
# Room: x 208..217, z 47..55 (read on the shot now-infirmary-animals of ticket 5197): ten beds at x 209,211,213,215,217 on z 48 and z 53 (NOTHING on them), torches in the four corners (they stay),
# doors on the south wall (212, 46), the north wall (212, 56) and the west wall. The bare patch is the cell row z 47 around the south door: it gets the room floor, as the pawn infirmary did (decor-after).
# No electric decor; only defs the validated decor-mods map already uses. The doors' cells (212, 47) and (212, 55) stay free.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
Feature: Sanctuary animal infirmary: rework

  Scenario: sanctuary-infirmary-animals: before, door floor and decor, after, then the fixture saved
    Given the save "Nelims-tribe-decor-mods" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And Nelim's Pickle Tools: the things within 9 cells of (212, 51) are listed
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-animals"
    And I take a screenshot "before-infirmary-animals"
    # the missing tile at the south door: the room floor on the doorway cell and the three cells in front of it
    And Nelim's Pickle Tools: the floor of the cell (212, 46) is copied from the cell (212, 50)
    And Nelim's Pickle Tools: the floor of the cell (211, 47) is copied from the cell (212, 50)
    And Nelim's Pickle Tools: the floor of the cell (212, 47) is copied from the cell (212, 50)
    And Nelim's Pickle Tools: the floor of the cell (213, 47) is copied from the cell (212, 50)
    # potted roses along the west wall and the east side, a potting bench, two paintings on the north wall: no power, no light
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (208, 53)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (208, 49)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (217, 51)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" near (208, 51)
    And Nelim's Pickle Tools: I place the decor "DecorativePainting_Animal" near (210, 56)
    And Nelim's Pickle Tools: I place the decor "DecorativePainting_Landscape" near (215, 56)
    And Nelim's Pickle Tools: the things within 9 cells of (212, 51) are listed
    And Nelim's Sanctuary: the buildings of the sanctuary "infirmary" are repaired
    And I wait 60 ticks
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-animals"
    And I take a screenshot "after-infirmary-animals"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods" is copied to the run folder
