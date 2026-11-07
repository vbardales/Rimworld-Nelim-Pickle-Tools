# Ritual hall rework (NSB request 2026-11-05, Virginie's go): from the modded fixture k. Hall interior x 202..209, z 114..123.
# Warm wood floor, the Reliquary kept as the altar of the west side (Virginie), six floor cushions in an arc east of it (x205-206, z116..122), all facing west (second pass, NSB 2026-11-06), the brazier and thurible no longer in front of a loudspeaker.
# Drapes (203,123) and (208,123) already stand: kept. Originals untouched: blue fire bowls, loudspeakers, light ball, centre markers, ideology items, power.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
Feature: Sanctuary ritual hall: rework

  Scenario: sanctuary-hall-rework: wood floor, cushion ring, then the fixture saved
    Given the save "Nelims-tribe-decor-mods" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And Nelim's Pickle Tools: the decor def "Reliquary" is described
    And Nelim's Pickle Tools: the decor def "YR_Bigthurible" is described
    And Nelim's Pickle Tools: the decor def "Loudspeaker" is described
    And Nelim's Pickle Tools: I lay the floor "Yuran_woodfloor" from (202, 114) to (209, 123)
    And Nelim's Pickle Tools: the things "Yuran_Brazier_two" within 0 cells of (208, 121) are hidden
    And Nelim's Pickle Tools: the things "YR_Bigthurible" within 0 cells of (208, 120) are hidden
    And Nelim's Pickle Tools: I place the decor "YR_Bigthurible" near (208, 121)
    And Nelim's Pickle Tools: I place the decor "Yuran_Brazier_two" near (204, 118)
    And Nelim's Pickle Tools: I place the decor "Yuran_chair_one" near (206, 122) facing west
    And Nelim's Pickle Tools: I place the decor "Yuran_chair_two" near (206, 121) facing west
    And Nelim's Pickle Tools: I place the decor "Yuran_chair_one" near (205, 120) facing west
    And Nelim's Pickle Tools: I place the decor "Yuran_chair_two" near (205, 118) facing west
    And Nelim's Pickle Tools: I place the decor "Yuran_chair_one" near (205, 116) facing west
    And Nelim's Pickle Tools: I place the decor "Yuran_chair_two" near (206, 116) facing west
    And Nelim's Pickle Tools: the building "LightBall" at (205, 119) is on a power net with a power source
    And Nelim's Pickle Tools: the building "LightBall" at (205, 119) is connected with no visible wire
    And Nelim's Pickle Tools: the building "Loudspeaker" at (209, 120) is connected with no visible wire
    And Nelim's Pickle Tools: the building "Loudspeaker" at (204, 123) is connected with no visible wire
    And Nelim's Pickle Tools: the building "Loudspeaker" at (206, 114) is connected with no visible wire
    And Nelim's Pickle Tools: the things within 4 cells of (206, 118) are listed
    And Nelim's Sanctuary: the buildings of the sanctuary "ritual-hall" are repaired
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "ritual-hall"
    And I take a screenshot "after-ritual-hall"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods" is copied to the run folder
