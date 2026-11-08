# Batch 5h (NSB, 2026-11-08, owner: she has not seen prestige-hall, hearth-hall and enclosure-north since 5f/5c): PHOTOS ONLY, no edit, no save. Loads Nelims-tribe-decor-mods-u (output of 5g). Places and zoom from SANCTUAIRE-LIEUX.md: hearth-hall (181,115) zoom 12 with the fire-pit, enclosure-north (166,235) zoom 13, prestige-hall framed 192,104-201,118 at 92 percent as in 5f. NSB judges the shots, then sends a decor batch 5i.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Sanctuary decor batch 5h

  Scenario: sanctuary-batch5h: prestige-hall, hearth-hall and enclosure-north photographed as they stand, nothing changed
    Given the save "Nelims-tribe-decor-mods-u" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "prestige-hall"
    And Nelim's Pickle Tools: I frame the cells (192, 104) to (201, 118) filling 92 percent of the screen
    And I take a screenshot "now-prestige-hall-u"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "hearth-hall"
    And I take a screenshot "now-hearth-hall-u"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-north"
    And I take a screenshot "now-enclosure-north-u"
