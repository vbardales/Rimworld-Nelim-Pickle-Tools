# Core filths side by side on a Concrete floor, one shot, for DustBunnies (Cat request 2026-11-20, set things/core-filth-dust): Trash and Dirt at thickness 3, Ash and Sand at the default dense thickness 5. Written by hand, NOT PLAYED when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.colonistrace
Feature: things core-filth-dust

  Scenario: core-filth-dust-01
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
    And Nelim's Pickle Tools: the filth "Filth_Trash" is spread from (146, 149) to (147, 151) at thickness 3
    And Nelim's Pickle Tools: the filth "Filth_Dirt" is spread from (148, 149) to (149, 151) at thickness 3
    And Nelim's Pickle Tools: the filth "Filth_Ash" is spread from (150, 149) to (151, 151)
    And Nelim's Pickle Tools: the filth "Filth_Sand" is spread from (152, 149) to (153, 151)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 3.3
    And I take a screenshot "things-core-filth-dust-01"
    Then no errors were logged

  Scenario: core-filth-dust-02
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
    And Nelim's Pickle Tools: 1 of the item "VRecyclingE_Trash" are spawned at (148, 150)
    And Nelim's Pickle Tools: 3 of the item "VRecyclingE_Trash" are spawned at (150, 150)
    And Nelim's Pickle Tools: 5 of the item "VRecyclingE_Trash" are spawned at (152, 150)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 3.3
    And I take a screenshot "things-core-filth-dust-02"
    Then no errors were logged

  Scenario: core-filth-dust-03
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
    And Nelim's Pickle Tools: 1 of the item "DirtBase" are spawned at (148, 151)
    And Nelim's Pickle Tools: 3 of the item "DirtBase" are spawned at (150, 151)
    And Nelim's Pickle Tools: 5 of the item "DirtBase" are spawned at (152, 151)
    And Nelim's Pickle Tools: 1 of the item "Gravel" are spawned at (148, 149)
    And Nelim's Pickle Tools: 3 of the item "Gravel" are spawned at (150, 149)
    And Nelim's Pickle Tools: 5 of the item "Gravel" are spawned at (152, 149)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size 3.3
    And I take a screenshot "things-core-filth-dust-03"
    Then no errors were logged

  Scenario: core-filth-dust-metadata
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the def metadata of the mod "VanillaExpanded.Recycling" is logged
    Then no errors were logged
