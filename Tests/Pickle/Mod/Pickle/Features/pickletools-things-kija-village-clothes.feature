# Village clothes catalogue for CoKK: garments as ground items, one row per shot, on a Concrete floor (owner rules 2026-11-18, Rimworld-Catalog/docs/CAPTURE-RULES.md). Written by Docs/Generate-HandSets.js: edit there.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
Feature: things kija-village-clothes

  Scenario: kija-village-clothes-a
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
    And Nelim's Pickle Tools: 1 of the item "VAE_Apparel_Tunic" are spawned at (147, 150)
    And Nelim's Pickle Tools: 1 of the item "VAE_Apparel_TribalKilt" are spawned at (149, 150)
    And Nelim's Pickle Tools: 1 of the item "VAE_Apparel_Skirt" are spawned at (151, 150)
    And Nelim's Pickle Tools: 1 of the item "VAE_Apparel_Shorts" are spawned at (153, 150)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 3
    And I take a screenshot "things-kija-village-clothes-a"
    Then no errors were logged

  Scenario: kija-village-clothes-b
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
    And Nelim's Pickle Tools: 1 of the item "VAE_Apparel_TribalPoncho" are spawned at (147, 150)
    And Nelim's Pickle Tools: 1 of the item "VAE_Apparel_Trousers" are spawned at (149, 150)
    And Nelim's Pickle Tools: 1 of the item "Apparel_TribalA" are spawned at (151, 150)
    And Nelim's Pickle Tools: 1 of the item "Apparel_BasicShirt" are spawned at (153, 150)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 3
    And I take a screenshot "things-kija-village-clothes-b"
    Then no errors were logged

  Scenario: kija-village-clothes-c
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
    And Nelim's Pickle Tools: 1 of the item "Apparel_Robe" are spawned at (148, 150)
    And Nelim's Pickle Tools: 1 of the item "Apparel_CollarShirt" are spawned at (150, 150)
    And Nelim's Pickle Tools: 1 of the item "Apparel_FSGardeningVest" are spawned at (152, 150)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 3
    And I take a screenshot "things-kija-village-clothes-c"
    Then no errors were logged

  Scenario: kija-village-clothes-d
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
    And Nelim's Pickle Tools: 1 of the item "VAE_Apparel_Apron" are spawned at (150, 150)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 3
    And I take a screenshot "things-kija-village-clothes-d"
    Then no errors were logged
