# Decor second pass, batch 1b (NSB 2026-11-06, Virginie: "tous ces lieux, je veux l'embellissement"): richer animal infirmary, then the left bank.
# Chained: loads Nelims-tribe-decor-mods-b (= the saved result of ticket cda6, installed under this candidate name; the validated fa7a fixture is untouched), saves Nelims-tribe-decor-mods-c in the run folder.
# Decor-mods map items only, no electric decor, fuel lights, nothing on the ten animal beds, doors free, nothing in water, the orange smiley (left bank) and the river free. Not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 1b

  Scenario: sanctuary-batch1b: infirmary-animals richer, left-bank, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-b" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And Nelim's Pickle Tools: the decor def "ED_PetBowl" is described
    And Nelim's Pickle Tools: the decor def "milple_TorchLampR" is described
    And Nelim's Pickle Tools: the decor def "Yuran_Treestump" is described
    And Nelim's Pickle Tools: the decor def "Plant_TreeWillow" is described
    And Nelim's Pickle Tools: the decor def "Plant_Reeds" is described
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-animals"
    And I take a screenshot "before-infirmary-animals-b"
    And Nelim's Sanctuary: I frame the sanctuary "left-bank"
    And I take a screenshot "before-left-bank"
    # infirmary: a soft blue carpet strip between the two bed rows (z 50-51, clear of both doors), pet bowls near the beds, hay in the east corner, an herb shelf on the north wall, more potted plants
    And Nelim's Pickle Tools: I lay the floor "CarpetBlue" from (209, 50) to (216, 51)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (210, 52)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (214, 49)
    And Nelim's Pickle Tools: I place the decor "ED_PetBowl" near (215, 52)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_B" near (215, 47)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" near (209, 47)
    And Nelim's Pickle Tools: I place the decor "Shelf" near (214, 55)
    And Nelim's Pickle Tools: 20 of the item "MedicineHerbal" are spawned at (214, 55)
    And Nelim's Pickle Tools: 60 of the item "Hay" are spawned at (217, 50)
    And Nelim's Pickle Tools: 60 of the item "Hay" are spawned at (217, 49)
    # left bank: willows and reeds along the water, two stone lanterns, two stumps to sit on, a flower border, off the orange smiley (x 83-99, z 93-110) and out of the river
    And Nelim's Pickle Tools: I place the decor "Plant_TreeWillow" near (123, 117)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeWillow" near (125, 113)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeWillow" near (121, 108)
    And Nelim's Pickle Tools: I place the decor "Plant_Reeds" near (126, 116)
    And Nelim's Pickle Tools: I place the decor "Plant_Reeds" near (124, 111)
    And Nelim's Pickle Tools: I place the decor "Plant_Reeds" near (122, 106)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (118, 114)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (120, 108)
    And Nelim's Pickle Tools: I place the decor "Yuran_Treestump" near (119, 112)
    And Nelim's Pickle Tools: I place the decor "Yuran_Treestump" near (116, 116)
    And Nelim's Pickle Tools: a flower border is planted around the square from (114, 111) to (118, 115)
    And Nelim's Pickle Tools: the plants from (113, 105) to (127, 119) are fully grown
    And Nelim's Pickle Tools: the things within 9 cells of (212, 51) are listed
    And Nelim's Pickle Tools: the things within 12 cells of (120, 111) are listed
    And Nelim's Sanctuary: the buildings of the sanctuary "infirmary" are repaired
    And I wait 60 ticks
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-animals"
    And I take a screenshot "after-infirmary-animals-b"
    And Nelim's Sanctuary: I frame the sanctuary "left-bank"
    And I take a screenshot "after-left-bank"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-c"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-c" is copied to the run folder
