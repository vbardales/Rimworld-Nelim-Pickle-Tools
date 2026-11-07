# Batch 4b (NSB order, owner GO 2026-11-07): dump, rice paddies (two frames), cotton field. Chained: loads Nelims-tribe-decor-mods-m (output of 4a), saves Nelims-tribe-decor-mods-n in the run folder. The dump is shot BEFORE the overlays are hidden, so the pink stockpile square shows in its frame (NSB asked to check it). Rice was sown in batch 2 (zones 2, 18, 19): kept, decor only; cotton is sown fully grown on zone 16. Blind placement with proven defNames, not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 4b

  Scenario: sanctuary-batch4b: dump, rice paddies and cotton field dressed, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-m" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    # dump (49, 238), storage zone "Décharge 1" x 42-56, z 233-243: tidy, shelves and bundles in order, a stump to sit on; no overlay hidden
    And Nelim's Pickle Tools: the zones named "Décharge 1" are logged
    And Nelim's Pickle Tools: I place the decor "Shelf" near (44, 235)
    And Nelim's Pickle Tools: I place the decor "Shelf" near (47, 235)
    And Nelim's Pickle Tools: I place the decor "Shelf" near (50, 235)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (53, 235)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (53, 241)
    And Nelim's Pickle Tools: I place the decor "Yuran_Treestump" near (45, 241)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (49, 244)
    And Nelim's Pickle Tools: the things within 9 cells of (49, 238) are listed
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "dump"
    And I take a screenshot "after-dump-n"
    # cotton field, zone 16 (x 200-222, z 95-117): cotton mature, light edge decor
    And Nelim's Pickle Tools: the zones named "Zone agricole 16" are resown with "Plant_Cotton" fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" near (199, 100)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" near (223, 100)
    And Nelim's Pickle Tools: I place the decor "Yuran_Treestump" near (199, 106)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (211, 94)
    And Nelim's Pickle Tools: I place the decor "Plant_Bush" near (199, 112)
    # rice paddies (zones 2, 18, 19, 21; x 221-236, z 113-128): shrine with offerings, lanterns at the crossings, trees at the forest edge, a bench, flower borders
    And Nelim's Pickle Tools: I place the decor "Yuran_komainu_one" near (235, 121)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (234, 121)
    And Nelim's Pickle Tools: I place the decor "bambooBundle" near (236, 123)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (228, 112)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (228, 129)
    And Nelim's Pickle Tools: I place the decor "milple_TorchLampR" near (220, 121)
    And Nelim's Pickle Tools: I place the decor "LP_GardenBench" near (222, 119)
    And Nelim's Pickle Tools: I place the decor "Yuran_Treestump" near (222, 124)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeBirch" near (237, 126)
    And Nelim's Pickle Tools: I place the decor "Plant_TreeWillow" near (220, 126)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" near (221, 112)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" near (236, 112)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" near (225, 112)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" near (232, 112)
    And Nelim's Pickle Tools: the plants from (198, 93) to (238, 130) are fully grown
    And Nelim's Pickle Tools: the things within 9 cells of (229, 121) are listed
    And Nelim's Pickle Tools: the things within 8 cells of (211, 106) are listed
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "rice-paddies"
    And I take a screenshot "after-rice-paddies-n"
    And Nelim's Sanctuary: I am at the sanctuary "rice-paddy"
    And I take a screenshot "after-rice-paddy-n"
    And Nelim's Sanctuary: I am at the sanctuary "cotton-field"
    And I take a screenshot "after-cotton-field-n"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-n"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-n" is copied to the run folder
