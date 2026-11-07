# Batch 5c (NSB owner verdict on 5b, 2026-11-07): enclosures only. Chained: loads Nelims-tribe-decor-mods-p (output of 5b), saves Nelims-tribe-decor-mods-q. enclosure-south: dead and dying plants of the growing zone (the Nelim logo) removed and every missing cell filled with the zone's own flowers, cells logged ([zone-filled]). enclosure-north and enclosure: Yuran_WaterTrough (Yuran Shrine, a loaded mod: no new mod), vanilla Hay and Kibble stacks near the ED_PetBowl, RLE_AnimalBed under the canopies. Blind placement, not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 5c

  Scenario: sanctuary-batch5c: enclosure logo filled, feeders and animal beds added, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-p" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    # enclosure-south (149, 214), growing zone x 130-168, z 204-223: the logo
    And Nelim's Pickle Tools: the zones named "Zone agricole" are logged
    And Nelim's Pickle Tools: the growing zones in the area from (130, 204) to (168, 223) are cleaned and filled with "its own" fully grown
    # enclosure-north (166, 235) and enclosure (158, 224): troughs, hay, kibble, animal beds under the canopies
    And Nelim's Pickle Tools: I place the decor "Yuran_WaterTrough" near (164, 233)
    And Nelim's Pickle Tools: I place the decor "Yuran_WaterTrough" near (168, 237)
    And Nelim's Pickle Tools: I place the decor "Yuran_WaterTrough" near (160, 226)
    And Nelim's Pickle Tools: I place the decor "Hay" near (165, 233)
    And Nelim's Pickle Tools: I place the decor "Hay" near (169, 237)
    And Nelim's Pickle Tools: I place the decor "Kibble" near (163, 234)
    And Nelim's Pickle Tools: I place the decor "Kibble" near (167, 238)
    And Nelim's Pickle Tools: I place the decor "RLE_AnimalBed" near (167, 232)
    And Nelim's Pickle Tools: I place the decor "RLE_AnimalBed" near (169, 233)
    And Nelim's Pickle Tools: I place the decor "RLE_AnimalBed" near (162, 236)
    And Nelim's Pickle Tools: I place the decor "RLE_AnimalBed" near (161, 221)
    And Nelim's Pickle Tools: I place the decor "RLE_AnimalBed" near (163, 221)
    And Nelim's Pickle Tools: I place the decor "Hay" near (159, 227)
    And Nelim's Pickle Tools: I place the decor "Kibble" near (157, 223)
    And Nelim's Pickle Tools: the things within 10 cells of (166, 235) are listed
    And Nelim's Pickle Tools: the things within 8 cells of (158, 224) are listed
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure"
    And I take a screenshot "after-enclosure-q"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I take a screenshot "after-enclosure-south-q"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-north"
    And I take a screenshot "after-enclosure-north-q"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-q"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-q" is copied to the run folder
