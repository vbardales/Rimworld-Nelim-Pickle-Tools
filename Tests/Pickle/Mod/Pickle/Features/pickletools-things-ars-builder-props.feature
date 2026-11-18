# Props catalogue for ArS: vanilla and workshop buildings, stacks, garments, one row per shot (owner rules, 2026-11-18, Rimworld-Catalog/docs/CAPTURE-RULES.md). Written by hand, not generated: edit here.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
Feature: things ars-builder-props

  Scenario: ars-builder-props-building-a
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (138, 144) to (162, 156) is cleared
    And Nelim's Pickle Tools: the building "Stool" is spawned on the nearest free cell around (144, 150) facing south
    And Nelim's Pickle Tools: the building "PlantPot" is spawned on the nearest free cell around (148, 150) facing south
    And Nelim's Pickle Tools: the building "PlantPot_Bonsai" is spawned on the nearest free cell around (152, 150) facing south
    And Nelim's Pickle Tools: the building "TorchLamp" is spawned on the nearest free cell around (156, 150) facing south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4.5
    And I take a screenshot "things-ars-builder-props-building-a"
    Then no errors were logged

  Scenario: ars-builder-props-building-b
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (138, 144) to (162, 156) is cleared
    And Nelim's Pickle Tools: the building "StandingLamp" is spawned on the nearest free cell around (144, 150) facing south
    And Nelim's Pickle Tools: the building "FermentingBarrel" is spawned on the nearest free cell around (148, 150) facing south
    And Nelim's Pickle Tools: the building "ShelfSmall" is spawned on the nearest free cell around (152, 150) facing south
    And Nelim's Pickle Tools: the building "CraftingSpot" is spawned on the nearest free cell around (156, 150) facing south
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4.5
    And I take a screenshot "things-ars-builder-props-building-b"
    Then no errors were logged

  Scenario: ars-builder-props-stacks
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (138, 144) to (162, 156) is cleared
    And Nelim's Pickle Tools: 50 of the item "Steel" are spawned at (146, 150)
    And Nelim's Pickle Tools: 50 of the item "WoodLog" are spawned at (150, 150)
    And Nelim's Pickle Tools: 50 of the item "BlocksGranite" are spawned at (154, 150)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 3.5
    And I take a screenshot "things-ars-builder-props-stacks"
    Then no errors were logged

  Scenario: ars-builder-props-apparel-a
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (138, 144) to (162, 156) is cleared
    And Nelim's Pickle Tools: 1 of the item "Apparel_Jacket" are spawned at (144, 150)
    And Nelim's Pickle Tools: 1 of the item "Apparel_Duster" are spawned at (146, 150)
    And Nelim's Pickle Tools: 1 of the item "Apparel_Cape" are spawned at (148, 150)
    And Nelim's Pickle Tools: 1 of the item "Apparel_Pants" are spawned at (150, 150)
    And Nelim's Pickle Tools: 1 of the item "Apparel_Beret" are spawned at (152, 150)
    And Nelim's Pickle Tools: 1 of the item "Apparel_VestRoyal" are spawned at (154, 150)
    And Nelim's Pickle Tools: 1 of the item "Apparel_Broadwrap" are spawned at (156, 150)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4
    And I take a screenshot "things-ars-builder-props-apparel-a"
    Then no errors were logged

  Scenario: ars-builder-props-apparel-b
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (138, 144) to (162, 156) is cleared
    And Nelim's Pickle Tools: 1 of the item "VAE_Apparel_BuildersJacket" are spawned at (144, 150)
    And Nelim's Pickle Tools: 1 of the item "VAE_Apparel_Apron" are spawned at (146, 150)
    And Nelim's Pickle Tools: 1 of the item "VAE_Apparel_Overalls" are spawned at (148, 150)
    And Nelim's Pickle Tools: 1 of the item "VAE_Handwear_Gloves" are spawned at (150, 150)
    And Nelim's Pickle Tools: 1 of the item "VAE_Headgear_Scarf" are spawned at (152, 150)
    And Nelim's Pickle Tools: 1 of the item "Apparel_FSConstructionJacket" are spawned at (154, 150)
    And Nelim's Pickle Tools: 1 of the item "Apparel_FSOveralls" are spawned at (156, 150)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 4
    And I take a screenshot "things-ars-builder-props-apparel-b"
    Then no errors were logged
