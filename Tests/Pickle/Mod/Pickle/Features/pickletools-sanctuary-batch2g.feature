# Batch 2g (NSB 2026-11-07, Virginie: dress the play area, not only place the pieces). Chained: loads Nelims-tribe-decor-mods-i, saves Nelims-tribe-decor-mods-j in the run folder; validated fixtures untouched. Not played when written.
# What is NOT done and why: the benches (LP_GardenBench) and the SpringFox (LP_SpringFox) are rotatable=False in their def (decor-def log of 2b): no step can turn them, so they stay as they are, and no third bench was added (no gap wide enough for 3x1 without touching a piece). No electric light (a fuel brazier at the gate). Sand under the swings and slide is one block x87-93 z113-121 (the 3x ground of both pieces and the gap column between them).
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 2g

  Scenario: sanctuary-batch2g: play area dressed (path, sand, trees, flowers, toys, braziers), then the fixture saved
    Given the save "Nelims-tribe-decor-mods-i" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    # ground: limestone path from the gate west along the free row z118, soft sand under the swings and the slide
    And Nelim's Pickle Tools: I lay the floor "FlagstoneLimestone" from (101, 118) to (111, 118)
    And Nelim's Pickle Tools: I lay the floor "FlagstoneLimestone" from (111, 117) to (111, 117)
    And Nelim's Pickle Tools: I lay the floor "Sand" from (87, 113) to (93, 121)
    # green: two birches for shade near the benches and the playhouse, bushes in the free column cells
    And Nelim's Pickle Tools: I place the decor "Plant_TreeBirch" exactly at (105, 114)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeBirch" exactly at (102, 121)
    And Nelim's Pickle Tools: I place the decor "Plant_Bush" exactly at (99, 114)
    And Nelim's Pickle Tools: I place the decor "Plant_Bush" exactly at (99, 116)
    And Nelim's Pickle Tools: I place the decor "Plant_Bush" exactly at (111, 113)
    And Nelim's Pickle Tools: I place the decor "Plant_Bush" exactly at (111, 121)
    # flowers in the colours of the outer border (red roses, orange daylilies) along the east inside of the fence and in the free cells of the north row
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" exactly at (101, 121)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" exactly at (107, 121)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" exactly at (111, 114)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" exactly at (111, 120)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" exactly at (106, 121)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" exactly at (111, 115)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" exactly at (101, 120)
    # small life: a toy box by the playhouse, a plush on the ground, fuel braziers at the gate
    And Nelim's Pickle Tools: I place the decor "ToyBox" exactly at (102, 119)
    And Nelim's Pickle Tools: I place the decor "AKN_ComfortingPlush" exactly at (99, 118)
    And Nelim's Pickle Tools: I place the decor "Yuran_Brazier_two" exactly at (111, 119)
    And Nelim's Pickle Tools: I place the decor "Yuran_Brazier_two" exactly at (111, 116)
    And Nelim's Pickle Tools: the plants from (86, 112) to (112, 122) are fully grown
    And Nelim's Pickle Tools: the things within 16 cells of (99, 117) are listed
    And Nelim's Pickle Tools: the things within 6 cells of (130, 113) are listed
    And Nelim's Pickle Tools: the things within 6 cells of (130, 121) are listed
    And Nelim's Pickle Tools: the animals are kept out of the area from (78, 104) to (124, 130)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Pickle Tools: I frame the area centred on (100, 117) at root size 11
    And I take a screenshot "after-play-area-whole-j"
    And Nelim's Pickle Tools: I frame the area centred on (105, 116) at root size 6
    And I take a screenshot "after-play-area-benches-j"
    # owner (2026-11-07, via NSB): the vanometric power cell at (205, 152-153), east edge of emerald-clearing, is removed from the fixture; the infirmary cell stays
    And Nelim's Pickle Tools: the things "VanometricPowerCell" within 2 cells of (205, 152) are hidden when present
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-j"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-j" is copied to the run folder
