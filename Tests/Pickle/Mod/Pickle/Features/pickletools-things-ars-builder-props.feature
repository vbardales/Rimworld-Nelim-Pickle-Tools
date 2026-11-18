# Props catalogue for ArS: buildings and ground stacks, written by hand for ArS (Cat request 2026-11-18), vanilla defs of Core, Royalty and Ideology. Not generated: edit here.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
Feature: things ars-builder-props

  Scenario: things-ars-builder-props-building: 8 buildings and 3 stacks
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 144) to (159, 155) is cleared
    And Nelim's Pickle Tools: the building "Stool" is spawned on the nearest free cell around (142, 153) facing south
    And Nelim's Pickle Tools: the building "PlantPot" is spawned on the nearest free cell around (146, 153) facing south
    And Nelim's Pickle Tools: the building "PlantPot_Bonsai" is spawned on the nearest free cell around (150, 153) facing south
    And Nelim's Pickle Tools: the building "TorchLamp" is spawned on the nearest free cell around (154, 153) facing south
    And Nelim's Pickle Tools: the building "StandingLamp" is spawned on the nearest free cell around (158, 153) facing south
    And Nelim's Pickle Tools: the building "FermentingBarrel" is spawned on the nearest free cell around (142, 149) facing south
    And Nelim's Pickle Tools: the building "ShelfSmall" is spawned on the nearest free cell around (146, 149) facing south
    And Nelim's Pickle Tools: the building "CraftingSpot" is spawned on the nearest free cell around (150, 149) facing south
    And Nelim's Pickle Tools: 50 of the item "Steel" are spawned at (154, 149)
    And Nelim's Pickle Tools: 50 of the item "WoodLog" are spawned at (158, 149)
    And Nelim's Pickle Tools: 50 of the item "BlocksGranite" are spawned at (142, 145)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 149) at root size 8.5
    And I take a screenshot "things-ars-builder-props-building"
    Then no errors were logged

  Scenario: things-ars-builder-props-apparel: 14 garments on the ground
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (140, 148) to (154, 156) is cleared
    And Nelim's Pickle Tools: 1 of the item "Apparel_Jacket" are spawned at (141, 155)
    And Nelim's Pickle Tools: 1 of the item "Apparel_Duster" are spawned at (144, 155)
    And Nelim's Pickle Tools: 1 of the item "Apparel_Cape" are spawned at (147, 155)
    And Nelim's Pickle Tools: 1 of the item "Apparel_Pants" are spawned at (150, 155)
    And Nelim's Pickle Tools: 1 of the item "Apparel_Beret" are spawned at (153, 155)
    And Nelim's Pickle Tools: 1 of the item "Apparel_VestRoyal" are spawned at (141, 152)
    And Nelim's Pickle Tools: 1 of the item "Apparel_Broadwrap" are spawned at (144, 152)
    And Nelim's Pickle Tools: 1 of the item "VAE_Apparel_BuildersJacket" are spawned at (147, 152)
    And Nelim's Pickle Tools: 1 of the item "VAE_Apparel_Apron" are spawned at (150, 152)
    And Nelim's Pickle Tools: 1 of the item "VAE_Apparel_Overalls" are spawned at (153, 152)
    And Nelim's Pickle Tools: 1 of the item "VAE_Handwear_Gloves" are spawned at (141, 149)
    And Nelim's Pickle Tools: 1 of the item "VAE_Headgear_Scarf" are spawned at (144, 149)
    And Nelim's Pickle Tools: 1 of the item "Apparel_FSConstructionJacket" are spawned at (147, 149)
    And Nelim's Pickle Tools: 1 of the item "Apparel_FSOveralls" are spawned at (150, 149)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (148, 153) at root size 5.5
    And I take a screenshot "things-ars-builder-props-apparel"
    Then no errors were logged
