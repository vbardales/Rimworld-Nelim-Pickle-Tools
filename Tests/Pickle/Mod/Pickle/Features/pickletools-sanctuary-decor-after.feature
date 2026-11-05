# Embellishing the Sanctuary (NSB plan SanctuaryBacklot/docs/EMBELLISSEMENT-LIEUX.md, 2026-11-04): decor placed on the fixture, then the AFTER photograph of each place at the frame of the before shots, then the fixture saved.
# Cells are read on the before shots (docs/EMBELLISSEMENT-LIEUX.md positions are indicative). Base game and DLC defs only.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
Feature: Sanctuary decor: after

  Scenario: sanctuary-decor-after: the places with the decor, then the fixture saved
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    # terrace: warm sandstone, four pots at the corners, two lamps; the portrait centre (196-197, 121) stays free
    When Nelim's Pickle Tools: I lay the floor "TileSandstone" from (193, 118) to (200, 124) painted "Structure_Cream"
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (193, 119)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (200, 120)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (200, 124)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (194, 124)
    And Nelim's Pickle Tools: I place the decor "StandingLamp" at (193, 121)
    And Nelim's Pickle Tools: I place the decor "StandingLamp" at (200, 121)
    # infirmary (pawns): two pots inside, two torches against the walls (the two between the beds removed), no power cell or conduit; the bare patch at the south door gets the room floor
    And Nelim's Pickle Tools: the area from (201, 48) to (203, 48) is emptied
    And Nelim's Pickle Tools: the area from (202, 55) to (202, 55) is emptied
    And Nelim's Pickle Tools: the area from (202, 51) to (202, 51) is emptied
    And Nelim's Pickle Tools: the floor of the cell (202, 47) is copied from the cell (202, 52)
    And Nelim's Pickle Tools: the floor of the cell (201, 48) is copied from the cell (202, 52)
    And Nelim's Pickle Tools: the floor of the cell (202, 48) is copied from the cell (202, 52)
    And Nelim's Pickle Tools: the floor of the cell (203, 48) is copied from the cell (202, 52)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (197, 54)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (197, 50)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (197, 52)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (206, 52)
    # pediatrics: three cribs, two toy boxes, two pots, two torches
    And Nelim's Pickle Tools: the area from (207, 63) to (207, 63) is emptied
    And Nelim's Pickle Tools: the area from (207, 59) to (207, 59) is emptied
    And Nelim's Pickle Tools: I place the decor "Crib" at (200, 62)
    And Nelim's Pickle Tools: I place the decor "Crib" at (202, 62)
    And Nelim's Pickle Tools: I place the decor "Crib" at (204, 62)
    And Nelim's Pickle Tools: I place the decor "ToyBox" at (212, 62)
    And Nelim's Pickle Tools: I place the decor "ToyBox" at (214, 62)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (200, 59)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (214, 59)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (203, 58)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (213, 58)
    # ritual hall: two braziers either side of the axis, a drum by the harp
    And Nelim's Pickle Tools: I place the decor "Brazier" at (205, 121)
    And Nelim's Pickle Tools: I place the decor "Brazier" at (208, 121)
    And Nelim's Pickle Tools: I place the decor "Drum" at (208, 117)
    # hut: two torches either side of the table, a lily pot
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (136, 73)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (144, 73)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Daylily" fully grown at (143, 74)
    # river banks: two willows and reeds on each bank near the bridge
    And Nelim's Pickle Tools: I place the decor "Plant_TreeWillow" at (126, 121) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_TreeWillow" at (126, 127) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_TreeWillow" at (142, 121) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_TreeWillow" at (142, 127) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Reeds" at (127, 119) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Reeds" at (127, 129) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Reeds" at (141, 119) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Reeds" at (141, 129) fully grown
    # water garden: six lotus among the lily pads
    And Nelim's Pickle Tools: I place the decor "Plant_Lotus" at (168, 172) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Lotus" at (170, 172) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Lotus" at (171, 171) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Lotus" at (165, 170) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Lotus" at (169, 170) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Lotus" at (166, 172) fully grown
    # statue garden: a rose border along the alley, two birches at the back
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (158, 98) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (158, 97) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (158, 96) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (158, 95) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (158, 94) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (158, 93) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_TreeBirch" at (144, 109) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_TreeBirch" at (144, 104) fully grown
    # cloister: a rose pot between each pair of columns, river side
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (175, 126)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (177, 126)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (179, 126)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (181, 126)
    And Nelim's Pickle Tools: I place the decor "PlantPot" holding "Plant_Rose" fully grown at (183, 126)
    # barn: left as it is (NSB 2026-11-05: the half soil, half straw split looked odd)
    # light what needs it, then the same frames as the before shots
    And Nelim's Pickle Tools: the building "StandingLamp" at (193, 121) is powered
    And Nelim's Pickle Tools: the building "StandingLamp" at (200, 121) is powered
    And Nelim's Pickle Tools: the decor "TorchLamp" at (197, 52) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (206, 52) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (203, 58) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (213, 58) is lit
    And Nelim's Sanctuary: the buildings of the sanctuary "infirmary" are repaired
    And Nelim's Sanctuary: the buildings of the sanctuary "terrace" are repaired
    And Nelim's Sanctuary: the buildings of the sanctuary "ritual-hall" are repaired
    And Nelim's Sanctuary: the buildings of the sanctuary "hut" are repaired
    And Nelim's Sanctuary: the buildings of the sanctuary "cloister" are repaired
    And Nelim's Sanctuary: the buildings of the sanctuary "barn" are repaired
    And Nelim's Pickle Tools: the decor "TorchLamp" at (136, 73) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (144, 73) is lit
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "terrace"
    And I take a screenshot "after-terrace"
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-pawns"
    And I take a screenshot "after-infirmary-pawns"
    And Nelim's Sanctuary: I frame the sanctuary "pediatrics"
    And I take a screenshot "after-pediatrics"
    And Nelim's Sanctuary: I frame the sanctuary "ritual-hall"
    And I take a screenshot "after-ritual-hall"
    And Nelim's Sanctuary: I frame the sanctuary "hut"
    And I take a screenshot "after-hut"
    And Nelim's Sanctuary: I frame the sanctuary "river-bridge"
    And I take a screenshot "after-river-bridge"
    And Nelim's Sanctuary: I frame the sanctuary "left-bank"
    And I take a screenshot "after-left-bank"
    And Nelim's Sanctuary: I frame the sanctuary "right-bank"
    And I take a screenshot "after-right-bank"
    And Nelim's Sanctuary: I frame the sanctuary "water-garden"
    And I take a screenshot "after-water-garden"
    And Nelim's Sanctuary: I frame the sanctuary "statue-garden"
    And I take a screenshot "after-statue-garden"
    And Nelim's Sanctuary: I frame the sanctuary "flower-garden"
    And I take a screenshot "after-flower-garden"
    And Nelim's Sanctuary: I frame the sanctuary "cloister"
    And I take a screenshot "after-cloister"
    And Nelim's Sanctuary: I frame the sanctuary "barn"
    And I take a screenshot "after-barn"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor" is copied to the run folder
