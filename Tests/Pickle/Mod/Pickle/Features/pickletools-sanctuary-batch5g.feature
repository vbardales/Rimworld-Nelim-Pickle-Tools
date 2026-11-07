# Batch 5g (NSB, 2026-11-08, after 5f). WRITTEN, NOT FILED: NSB holds it for the owner's answer on the throne facing (if she wants it turned NSB adds the step, loads -t, saves -u). Enclosure-south: everything that is not a plant, a fence, a gate or a natural rock wall standing on a cell of growing zones 3 to 15 OR within 1 cell of one (the holes and the edge of the Nelim logo: 2 hay/feed baskets, rocks, the top right brazier, the bottom right edge brazier, the canopy over the right edge about x 163-168 z 213-218) is taken off, the freed cells of a zone replanted with the zone plant. The widened set is the zone cells dilated by 1 (not the bounding rectangle: that would strip the pen braziers (133,207) (147,205) (152,209) (160,213)... and the fence line z 223).
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 5g

  Scenario: sanctuary-batch5g: enclosure-south logo holes and edge cleared of decor and replanted, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-t" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the cells of the growing zones in the area from (130, 204) to (168, 223) are kept free of decor
    And Nelim's Pickle Tools: the things that are not plants are removed from the growing zones in the area from (130, 204) to (168, 223) widened by 1 cells
    And Nelim's Pickle Tools: the growing zones in the area from (130, 204) to (168, 223) are cleared of wild plants and filled with "its own" fully grown
    And Nelim's Pickle Tools: the things within 12 cells of (158, 214) are listed
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I take a screenshot "after-enclosure-south-u"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-u"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-u" is copied to the run folder
