# Batch 5f (NSB, 2026-11-07, owner verdict on 5d/5e). FILED 2026-11-07. Chained: loads Nelims-tribe-decor-mods-s, saves Nelims-tribe-decor-mods-t. Fixes: (1) prestige-hall north wall (Wall WoodLog x 193-195 and 197-200, Door WoodLog x 196, all z 117) taken by the 5d clear, restored exactly, the 2 KCB_Potting_A + SCLavender moved inside at (195,116) and (198,116); (2) MarriageSpot (196,115) restored; (3) enclosure-south: nothing but plants on the Nelim logo flowers (growing zones touching x 130-168, z 204-223): guard step, every non-plant taken off, cells replanted with the zone plant; (4) sleeping-nook: the candle that stood under the plush (179,122) moved to the free cell (180,122), the plush put back alone. (5) the 2 Yuran_Statue_lion at (194,116) and (199,116) taken out, cells left empty (owner: 'Oui, les lions', 2026-11-07); NSB confirmed, filed.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 5f

  Scenario: sanctuary-batch5f: prestige-hall wall restored, logo kept free of decor, sleeping-nook candle moved, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-s" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: a decor that finds no cell is skipped and logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    # guard first: from here nothing but a plant may be placed on the logo flowers of enclosure-south (zones 3 to 15, x 130-168, z 204-223)
    And Nelim's Pickle Tools: the cells of the growing zones in the area from (130, 204) to (168, 223) are kept free of decor
    # 5. the 2 wooden lions of the hall out FIRST, nothing in their place: each is 2 cells (the 5d run put them near (194,116) facing east and (199,116) facing west, 5f ticket bb94 failed on (195,116)), so both pairs of cells are cleared; the candle stands (193,116) (200,116) stay
    And Nelim's Pickle Tools: the area from (194, 116) to (195, 116) is cleared
    And Nelim's Pickle Tools: the area from (198, 116) to (199, 116) is cleared
    # 1. prestige-hall north wall z 117: the two pots of 5d stand on it, out; wall pieces then the door (a door needs its two neighbours), same stuff as in -q
    And Nelim's Pickle Tools: the area from (193, 117) to (200, 117) is cleared
    And Nelim's Pickle Tools: I place the decor "Wall" made of "WoodLog" exactly at (193, 117)
    And Nelim's Pickle Tools: I place the decor "Wall" made of "WoodLog" exactly at (194, 117)
    And Nelim's Pickle Tools: I place the decor "Wall" made of "WoodLog" exactly at (195, 117)
    And Nelim's Pickle Tools: I place the decor "Wall" made of "WoodLog" exactly at (197, 117)
    And Nelim's Pickle Tools: I place the decor "Wall" made of "WoodLog" exactly at (198, 117)
    And Nelim's Pickle Tools: I place the decor "Wall" made of "WoodLog" exactly at (199, 117)
    And Nelim's Pickle Tools: I place the decor "Wall" made of "WoodLog" exactly at (200, 117)
    And Nelim's Pickle Tools: I place the decor "Door" made of "WoodLog" exactly at (196, 117)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" holding "SCLavender" fully grown at (195, 116)
    And Nelim's Pickle Tools: I place the decor "KCB_Potting_A" holding "SCLavender" fully grown at (198, 116)
    # 2. the marriage spot the 5d clears took
    And Nelim's Pickle Tools: I place the decor "MarriageSpot" exactly at (196, 115)
    And Nelim's Pickle Tools: the things within 8 cells of (196, 114) are listed
    # 4. sleeping-nook: the candle stood on the plush cell; clear the cell, plush back alone, candle on a free cell
    And Nelim's Pickle Tools: the area from (179, 122) to (179, 122) is cleared
    And Nelim's Pickle Tools: I place the decor "ED_Plushie" exactly at (179, 122)
    And Nelim's Pickle Tools: I place the decor "ED_Candles" exactly at (180, 122)
    And Nelim's Pickle Tools: the things within 5 cells of (177, 121) are listed
    # 3. enclosure-south: every non-plant off the logo cells (fences and gates stay), then wild plants out and the cells replanted with the zone's own plant
    And Nelim's Pickle Tools: the things that are not plants are removed from the growing zones in the area from (130, 204) to (168, 223)
    And Nelim's Pickle Tools: the growing zones in the area from (130, 204) to (168, 223) are cleared of wild plants and filled with "its own" fully grown
    And Nelim's Pickle Tools: the things within 12 cells of (158, 214) are listed
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "prestige-hall"
    # framed to show the north wall z 117 and its door (196,117) and the dais
    And Nelim's Pickle Tools: I frame the cells (192, 104) to (201, 118) filling 92 percent of the screen
    And I take a screenshot "after-prestige-hall-s"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And I take a screenshot "after-sleeping-nook-s"
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I take a screenshot "after-enclosure-south-t"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-t"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-t" is copied to the run folder
