# Ritual hall rework (NSB request 2026-11-05, Virginie approved): recon on the modded fixture k. Before shot, what stands in and around the hall (202..209, 114..123), free cells, the defs to place.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
Feature: Sanctuary ritual hall: recon

  Scenario: sanctuary-hall-recon: before shot, things, free cells, defs
    Given the save "Nelims-tribe-decor-mods" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the things within 10 cells of (206, 118) are listed
    And Nelim's Pickle Tools: the free standable cells of the area from (198, 112) to (220, 125) are listed
    And Nelim's Pickle Tools: the decor def "Yuran_flowerwoodfloor" is described
    And Nelim's Pickle Tools: the decor def "Yuran_woodfloor" is described
    And Nelim's Pickle Tools: the decor def "Yuran_chair_one" is described
    And Nelim's Pickle Tools: the decor def "Yuran_chair_two" is described
    And Nelim's Pickle Tools: the decor def "milple_CStoolS" is described
    And Nelim's Pickle Tools: the decor def "milple_CStoolR" is described
    And Nelim's Pickle Tools: the decor def "WMFF_WallDrape" is described
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "ritual-hall"
    And I take a screenshot "before-ritual-hall"
