# Batch 5m-3 (NSB order, owner verdict on 5m-2 right-bank 2026-11-09). Loads Nelims-tribe-decor-mods-z2 (installed in DecorBase, sha256 a02ee14c23bfa6b28e650f503d79b7d3579cc65beb4237a4341c41a3ac34be23), saves Nelims-tribe-decor-mods-z3. Terrain and things READ FROM z2 BEFORE writing (the .rws grids decoded offline, hashes checked: 11445 WaterShallow, 31116 WaterDeep, 12446 MossyTerrain, 34465 Soil, 56689 Yuran_flatstonefloorSandstone). Two fixes only: (1) plants standing on water cells of the right-bank frame go, (2) the west end of the path row z 127 (x 136 to 139: bare Soil on (136,127) and (137,127), flatstone over WaterShallow on (138,127) and (139,127)) goes back to WaterShallow, copied from (136,128..139,128). NOT PLAYED when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Sanctuary decor batch 5m-3

  Scenario: sanctuary-batch5m-3: right-bank plants off the water, the path row z 127 back to water at its west end, right-bank photographed, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-z2" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    Then Nelim's Pickle Tools: the animals named "Yuki" are counted
    And Nelim's Pickle Tools: the animals named "Shogun" are counted
    And Nelim's Pickle Tools: the animals named "Atticus" are counted
    And Nelim's Pickle Tools: the animals named "Rain" are counted
    And Nelim's Pickle Tools: the terrain of the cell (135, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (136, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (137, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (138, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (139, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (140, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (135, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (136, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (137, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (138, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (139, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (140, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (135, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (136, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (137, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (138, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (139, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (140, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (135, 135) is logged
    And Nelim's Pickle Tools: the terrain of the cell (141, 133) is logged
    And Nelim's Pickle Tools: the terrain of the cell (137, 131) is logged
    And Nelim's Pickle Tools: the terrain of the cell (143, 135) is logged
    And Nelim's Pickle Tools: the terrain of the cell (143, 134) is logged
    And Nelim's Pickle Tools: the terrain of the cell (144, 136) is logged
    And Nelim's Pickle Tools: the terrain of the cell (146, 138) is logged
    And Nelim's Pickle Tools: the terrain of the cell (140, 130) is logged
    And Nelim's Pickle Tools: the terrain of the cell (131, 137) is logged
    And Nelim's Pickle Tools: the terrain of the cell (130, 135) is logged
    And Nelim's Pickle Tools: the things within 16 cells of (144, 132) are listed

    # 1. plants on water cells (the three the owner saw: willow (135,135) WaterDeep, pine (141,133) and pink hydrangea (137,131) WaterShallow, plus every other plant of the frame standing on water in z2; the list above is the proof of what goes)
    When Nelim's Pickle Tools: the area from (135, 135) to (135, 135) is cleared
    And Nelim's Pickle Tools: the area from (141, 133) to (141, 133) is cleared
    And Nelim's Pickle Tools: the area from (137, 131) to (137, 131) is cleared
    And Nelim's Pickle Tools: the area from (143, 135) to (143, 135) is cleared
    And Nelim's Pickle Tools: the area from (143, 134) to (143, 134) is cleared
    And Nelim's Pickle Tools: the area from (144, 136) to (144, 136) is cleared
    And Nelim's Pickle Tools: the area from (146, 138) to (146, 138) is cleared
    And Nelim's Pickle Tools: the area from (140, 130) to (140, 130) is cleared
    And Nelim's Pickle Tools: the area from (131, 137) to (131, 137) is cleared
    And Nelim's Pickle Tools: the area from (130, 135) to (130, 135) is cleared

    # 2. path row z 127: the west end goes back to water, the path starts on land at x 140
    And Nelim's Pickle Tools: the floor of the cell (136, 127) is copied from the cell (136, 128)
    And Nelim's Pickle Tools: the floor of the cell (137, 127) is copied from the cell (137, 128)
    And Nelim's Pickle Tools: the floor of the cell (138, 127) is copied from the cell (138, 128)
    And Nelim's Pickle Tools: the floor of the cell (139, 127) is copied from the cell (139, 128)
    And Nelim's Pickle Tools: the terrain of the cell (135, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (136, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (137, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (138, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (139, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (140, 126) is logged
    And Nelim's Pickle Tools: the terrain of the cell (135, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (136, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (137, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (138, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (139, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (140, 127) is logged
    And Nelim's Pickle Tools: the terrain of the cell (135, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (136, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (137, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (138, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (139, 128) is logged
    And Nelim's Pickle Tools: the terrain of the cell (140, 128) is logged
    And Nelim's Pickle Tools: the things within 16 cells of (144, 132) are listed

    Then Nelim's Pickle Tools: the animals named "Yuki" are counted
    And Nelim's Pickle Tools: the animals named "Shogun" are counted
    And Nelim's Pickle Tools: the animals named "Atticus" are counted
    And Nelim's Pickle Tools: the animals named "Rain" are counted

    When Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "right-bank"
    And I take a screenshot "after-right-bank-z3"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-z3"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-z3" is copied to the run folder
