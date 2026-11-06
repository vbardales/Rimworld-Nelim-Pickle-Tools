# Decor second pass, batch 2 (NSB 2026-11-06): infirmary-animals fixes, rice paddies replanted, children's play area. Chained: loads Nelims-tribe-decor-mods-c (saved by batch 1b), saves Nelims-tribe-decor-mods-d in the run folder; the validated fa7a fixture is untouched.
# Infirmary fixes read on after-infirmary-animals-b: the two potting plants stood OUTSIDE the south wall at (208, 45) and (214, 45), the shelf stood at (214-215, 54) instead of against the north wall, the carpet strip was a flat dark block (keep one row of it).
# Rice (NSB): rice on the growing zones 2, 18, 19 and 21, wild grass and the 20 potatoes of zone 2 replaced. NOTE the label match is a text match: "Zone agricole 2" also matches zones 20 to 29 (small, same paddy area), which is wanted.
# Play area (Virginie via NSB): just north of the west smiley, x 85-101, z 111-123, land only. Not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 2

  Scenario: sanctuary-batch2: infirmary fixes, rice paddies, play area, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-c" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And Nelim's Pickle Tools: the decor def "ToyBox" is described
    And Nelim's Pickle Tools: the decor def "AKN_ComfortingPlush" is described
    And Nelim's Pickle Tools: the decor def "ED_Plushie" is described
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "rice-paddies"
    And I take a screenshot "before-rice-paddies"
    And Nelim's Pickle Tools: I frame the area centred on (93, 117) at root size 10
    And I take a screenshot "before-play-area"
    # infirmary fixes
    And Nelim's Pickle Tools: the area from (208, 45) to (208, 45) is emptied
    And Nelim's Pickle Tools: the area from (214, 45) to (214, 45) is emptied
    And Nelim's Pickle Tools: the area from (213, 54) to (216, 55) is emptied
    And Nelim's Pickle Tools: the floor of the cell (209, 51) is copied from the cell (209, 52)
    And Nelim's Pickle Tools: the floor of the cell (210, 51) is copied from the cell (210, 52)
    And Nelim's Pickle Tools: the floor of the cell (211, 51) is copied from the cell (211, 52)
    And Nelim's Pickle Tools: the floor of the cell (212, 51) is copied from the cell (212, 52)
    And Nelim's Pickle Tools: the floor of the cell (213, 51) is copied from the cell (213, 52)
    And Nelim's Pickle Tools: the floor of the cell (214, 51) is copied from the cell (214, 52)
    And Nelim's Pickle Tools: the floor of the cell (215, 51) is copied from the cell (215, 52)
    And Nelim's Pickle Tools: the floor of the cell (216, 51) is copied from the cell (216, 52)
    And Nelim's Pickle Tools: I place the decor "Shelf" exactly at (214, 55)
    And Nelim's Pickle Tools: 20 of the item "MedicineHerbal" are spawned at (214, 55)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" exactly at (211, 49)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_B" exactly at (216, 52)
    # rice paddies: the zones of the paddy area, sown with fully grown rice over everything that is not a tree
    And Nelim's Pickle Tools: the zones named "Zone agricole 2" are resown with "Plant_Rice" fully grown
    And Nelim's Pickle Tools: the zones named "Zone agricole 18" are resown with "Plant_Rice" fully grown
    And Nelim's Pickle Tools: the zones named "Zone agricole 19" are resown with "Plant_Rice" fully grown
    # play area: the ground cleared, a wood deck, two toy boxes, plushies, two stumps to sit on, a flower hedge around
    And Nelim's Pickle Tools: the area from (86, 112) to (100, 122) is emptied
    And Nelim's Pickle Tools: I lay the floor "Yuran_woodfloor" from (89, 114) to (97, 120)
    And Nelim's Pickle Tools: I place the decor "ToyBox" near (90, 116)
    And Nelim's Pickle Tools: I place the decor "ToyBox" near (96, 116)
    And Nelim's Pickle Tools: I place the decor "AKN_ComfortingPlush" near (92, 118)
    And Nelim's Pickle Tools: I place the decor "AKN_ComfortingPlush" near (95, 118)
    And Nelim's Pickle Tools: I place the decor "ED_Plushie" near (93, 115)
    And Nelim's Pickle Tools: I place the decor "ED_Plushie" near (91, 119)
    And Nelim's Pickle Tools: I place the decor "Yuran_Treestump" near (89, 121)
    And Nelim's Pickle Tools: I place the decor "Yuran_Treestump" near (97, 121)
    And Nelim's Pickle Tools: a flower border is planted around the square from (86, 112) to (100, 122)
    And Nelim's Pickle Tools: the plants from (85, 111) to (101, 123) are fully grown
    And Nelim's Pickle Tools: the things within 9 cells of (212, 51) are listed
    And Nelim's Pickle Tools: the things within 10 cells of (93, 117) are listed
    And Nelim's Sanctuary: the buildings of the sanctuary "infirmary" are repaired
    And I wait 60 ticks
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-animals"
    And I take a screenshot "after-infirmary-animals-c"
    And Nelim's Sanctuary: I frame the sanctuary "rice-paddies"
    And I take a screenshot "after-rice-paddies"
    And Nelim's Pickle Tools: I frame the area centred on (93, 117) at root size 10
    And I take a screenshot "after-play-area"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-d"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-d" is copied to the run folder
