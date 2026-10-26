@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Every look value on Nelim, one photograph per value (gallery of the look catalogues)

  Scenario: look-gallery-1: hair 1 to 20 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "DoubleTuft"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-DoubleTuft"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ghoul_Furious"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ghoul_Furious"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ghoul_Hungry"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ghoul_Hungry"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ghoul_Ravenous"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ghoul_Ravenous"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ghoul_Twisted"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ghoul_Twisted"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ghoul_Vengeful"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ghoul_Vengeful"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ghoul_Warped"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ghoul_Warped"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ghoul_Wicked"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ghoul_Wicked"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "LargeTuft"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-LargeTuft"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "LongMess"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-LongMess"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "LongOily"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-LongOily"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Parted"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Parted"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "PatchyShave"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-PatchyShave"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RoughShave"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RoughShave"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "ShavedMohawk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-ShavedMohawk"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "ShortCut"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-ShortCut"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "SideCut"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-SideCut"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "SideSpikes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-SideSpikes"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Afro"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Afro"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Bald"

  Scenario: look-gallery-2: hair 21 to 40 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Bob"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Bob"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Bowlcut"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Bowlcut"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "BraidedKnot"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-BraidedKnot"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Bravo"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Bravo"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "BriefPonytail"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-BriefPonytail"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Burgundy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Burgundy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Cleopatra"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Cleopatra"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Curly"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Curly"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Cute"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Cute"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Decent"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Decent"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Elder"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Elder"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "FancyBun"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-FancyBun"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Firestarter"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Firestarter"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Flowy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Flowy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Fringe"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Fringe"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Frozen"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Frozen"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "GreasySwoop"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-GreasySwoop"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Junkie"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Junkie"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Keeper"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Keeper"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Lackland"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Lackland"

  Scenario: look-gallery-3: hair 41 to 60 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Locks"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Locks"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Long"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Messy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Messy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Mohawk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Mohawk"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Mop"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Mop"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Pigtails"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Pigtails"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytails"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ponytails"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Primal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Primal"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Princess"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Princess"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Randy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Randy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Recruit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Recruit"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Revolt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Revolt"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Rockstar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Rockstar"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Rookie"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Rookie"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Savage"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Savage"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Scatman"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Scatman"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "ScorpionTail"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-ScorpionTail"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Scrapper"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Scrapper"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Senorita"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Senorita"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Shaved"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Shaved"

  Scenario: look-gallery-4: hair 61 to 80 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "ShaveTopBraid"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-ShaveTopBraid"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Snazzy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Snazzy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Spikes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Spikes"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Sticky"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Sticky"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Topdog"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Topdog"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Troubadour"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Troubadour"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Tuft"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Tuft"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Warden"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Warden"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Wavy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Wavy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_BalaclavaL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_BalaclavaL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_BalaclavaS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_BalaclavaS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_Bandages"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_Bandages"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_BandanaL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_BandanaL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_BandanaLocsL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_BandanaLocsL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_BandanaLocsS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_BandanaLocsS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_BandanaM"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_BandanaM"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_BandanaS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_BandanaS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_BowL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_BowL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_BowS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_BowS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_BowT"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_BowT"

  Scenario: look-gallery-5: hair 81 to 100 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_EarringL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_EarringL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_EarringS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_EarringS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_EyePadL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_EyePadL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_EyePadS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_EyePadS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_EyepatchL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_EyepatchL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_EyepatchS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_EyepatchS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_EyepatchT"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_EyepatchT"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_FaceMaskL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_FaceMaskL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_FaceMaskS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_FaceMaskS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_FlowerCrown"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_FlowerCrown"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_GogglesS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_GogglesS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_GogglesT"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_GogglesT"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_Hachimaki"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_Hachimaki"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_HeadbandL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_HeadbandL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_HeadbandS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_HeadbandS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_HeadbandT"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_HeadbandT"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_HeadphonesL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_HeadphonesL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_HeadphonesS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_HeadphonesS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_HeadsetS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_HeadsetS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_HeadsetT"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_HeadsetT"

  Scenario: look-gallery-6: hair 101 to 120 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_Hijab"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_Hijab"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_Laurel"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_Laurel"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_NasogastricTube"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_NasogastricTube"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_Plasters"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_Plasters"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_Scarf"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_Scarf"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_SockHatL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_SockHatL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_SockHatS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_SockHatS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_SportsbandS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_SportsbandS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_SportsbandT"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_SportsbandT"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_TurbanL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_TurbanL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBAHD_TurbanS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBAHD_TurbanS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Alpha"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Alpha"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Amp"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Amp"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Astra"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Astra"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Bookworm"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Bookworm"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Buzzdreads"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Buzzdreads"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Camden"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Camden"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Clipsmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Clipsmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Crunch"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Crunch"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Dreadsmohawk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Dreadsmohawk"

  Scenario: look-gallery-7: hair 121 to 140 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Fairy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Fairy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Halfdyed"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Halfdyed"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Halfdyedmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Halfdyedmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Halfshavedreads"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Halfshavedreads"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Hangout"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Hangout"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Hangoutmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Hangoutmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Headbanddreads"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Headbanddreads"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Headbanddreadsmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Headbanddreadsmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Longdreads"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Longdreads"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Loosemale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Loosemale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Manbun"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Manbun"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Mane"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Mane"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Mediator"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Mediator"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Neat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Neat"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Paladin"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Paladin"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Ponytaildreads"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Ponytaildreads"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Poppy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Poppy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Puffs"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Puffs"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Relaxed"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Relaxed"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Shortdreads"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Shortdreads"

  Scenario: look-gallery-8: hair 141 to 160 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Sweptbackdreads"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Sweptbackdreads"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Sweptover"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Sweptover"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Turban"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Turban"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Twinbuns"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Twinbuns"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Twintails"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Twintails"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Widepart"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBDHD_Widepart"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Anaglyph"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Anaglyph"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_AviatorL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_AviatorL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_AviatorS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_AviatorS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Kitsuragi"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Kitsuragi"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Lennon"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Lennon"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Liquid"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Liquid"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Roundglassesbald"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Roundglassesbald"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Roundglassesdreads"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Roundglassesdreads"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Roundglassesdreadsmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Roundglassesdreadsmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Roundglasseslong"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Roundglasseslong"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Roundglasseslongmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Roundglasseslongmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Roundglassesmediummale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Roundglassesmediummale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Roundglassespony"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Roundglassespony"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Roundglassesshaved"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Roundglassesshaved"

  Scenario: look-gallery-9: hair 161 to 180 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Roundglassesshavedmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Roundglassesshavedmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Roundglassesshort"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Roundglassesshort"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Roundglassesshortmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Roundglassesshortmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Roundglassessmedium"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Roundglassessmedium"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Roundglassessupdo"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Roundglassessupdo"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Roundglassestied"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Roundglassestied"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_RoyalL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_RoyalL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_RoyalS"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_RoyalS"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Smallroundglassesbald"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Smallroundglassesbald"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Smallroundglassesdreads"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Smallroundglassesdreads"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Smallroundglassesdreadsmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Smallroundglassesdreadsmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Smallroundglasseslong"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Smallroundglasseslong"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Smallroundglasseslongmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Smallroundglasseslongmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Smallroundglassesmedium"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Smallroundglassesmedium"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Smallroundglassesmediummale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Smallroundglassesmediummale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Smallroundglassespony"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Smallroundglassespony"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Smallroundglassesshaved"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Smallroundglassesshaved"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Smallroundglassesshavedmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Smallroundglassesshavedmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Smallroundglassesshort"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Smallroundglassesshort"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Smallroundglassesshortmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Smallroundglassesshortmale"

  Scenario: look-gallery-10: hair 181 to 200 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Smallroundglassessupdo"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Smallroundglassessupdo"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Smallroundglassestied"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Smallroundglassestied"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_SpectaclesL"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_SpectaclesL"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Stanardglassessupdo"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Stanardglassessupdo"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Standardglassesbald"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Standardglassesbald"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Standardglassesdreads"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Standardglassesdreads"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Standardglassesdreadsmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Standardglassesdreadsmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Standardglasseslong"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Standardglasseslong"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Standardglasseslongmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Standardglasseslongmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Standardglassesmedium"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Standardglassesmedium"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Standardglassesmediummale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Standardglassesmediummale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Standardglassespony"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Standardglassespony"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Standardglassesshaved"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Standardglassesshaved"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Standardglassesshavedmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Standardglassesshavedmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Standardglassesshort"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Standardglassesshort"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Standardglassesshortmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Standardglassesshortmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBGHD_Standardglassestiedmale"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RBGHD_Standardglassestiedmale"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Almond"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Almond"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Angelwings"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Angelwings"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Barber"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Barber"

  Scenario: look-gallery-11: hair 201 to 220 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Block"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Block"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Brave"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Brave"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Breezy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Breezy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Bubblegum"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Bubblegum"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Chestnut"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Chestnut"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Chilli"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Chilli"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Choppy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Choppy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Cloud"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Cloud"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Cool"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Cool"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Dreadbuns"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Dreadbuns"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_FeatheredM"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_FeatheredM"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Flames"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Flames"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Halfshaveafro"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Halfshaveafro"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpigtails"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Highpigtails"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Hipster"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Hipster"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Idol"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Idol"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Lamb"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Lamb"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Lander"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Lander"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Lefteye"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Lefteye"

  Scenario: look-gallery-12: hair 221 to 240 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Mariya"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Mariya"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Natural"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Natural"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Octopus"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Octopus"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Onion"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Onion"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Overgrown"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Overgrown"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Palmtree"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Palmtree"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Pixie"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Pixie"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Puffy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Puffy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Pushback"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Pushback"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Quiet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Quiet"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Ranger"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Ranger"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Raven"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Raven"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_River"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_River"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Rough"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Rough"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Sedona"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Sedona"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Shell"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Shell"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Shy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Shy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Slack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Slack"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Slick"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Slick"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_SlickM"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_SlickM"

  Scenario: look-gallery-13: hair 241 to 260 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Spike"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Spike"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_SpikeM"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_SpikeM"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Stylish"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Stylish"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Supersonic"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Supersonic"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Swan"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Swan"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Sweep"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Sweep"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Tatsuro"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Tatsuro"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Tboz"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Tboz"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Technotails"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Technotails"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Thick"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Thick"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Tidy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Tidy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Topknot"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Topknot"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Twinbraids"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Twinbraids"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Undercut"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Undercut"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Vampire"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Vampire"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Walnut"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Walnut"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Waterfall"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Waterfall"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Waterfall2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Waterfall2"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Weevil"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Weevil"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Whippet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_HD_Hair_Whippet"

  Scenario: look-gallery-14: hair 261 to 280 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_AlmonerHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_AlmonerHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_AncientHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_AncientHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_BaroqueHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_BaroqueHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_BattleBunsHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_BattleBunsHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_BeadsHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_BeadsHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_Bob1HD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_Bob1HD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_Bob2HD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_Bob2HD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_Bob3HD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_Bob3HD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_BraidsHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_BraidsHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_BuncoversHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_BuncoversHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_BunsHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_BunsHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_CircletHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_CircletHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_CircletmaleHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_CircletmaleHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_CleancutHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_CleancutHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_CurlyHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_CurlyHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_DeietyfemaleeHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_DeietyfemaleeHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_DeietymaleHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_DeietymaleHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_DragonHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_DragonHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_DragonianmaleHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_DragonianmaleHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_DreadlocksHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_DreadlocksHD"

  Scenario: look-gallery-15: hair 281 to 300 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_ElvenHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_ElvenHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_ElvenmaleHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_ElvenmaleHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_EvilHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_EvilHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_EvilmaleHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_EvilmaleHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_GeikoHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_GeikoHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_GeorgianHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_GeorgianHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_GeorgianmaleHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_GeorgianmaleHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_HalftiedHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_HalftiedHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_KingHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_KingHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_KnightHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_KnightHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_LaurelHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_LaurelHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_LionHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_LionHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_LongcurlsHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_LongcurlsHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_LongHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_LongHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_LooseponytailHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_LooseponytailHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_MaidenbunHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_MaidenbunHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_Malebob2HD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_Malebob2HD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_MalebobHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_MalebobHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_ManggeonHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_ManggeonHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_NaturalcurlsHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_NaturalcurlsHD"

  Scenario: look-gallery-16: hair 301 to 320 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_NeatmaleHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_NeatmaleHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_OrderHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_OrderHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_OrnateHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_OrnateHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_PoetHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_PoetHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_PrinceHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_PrinceHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_PrincessHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_PrincessHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_RibbonHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_RibbonHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_SangtuHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_SangtuHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_ShogunHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_ShogunHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_SlickHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_SlickHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_SquireHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_SquireHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_TighttiedHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_TighttiedHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_TribalbigHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_TribalbigHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_TribalsmallHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_TribalsmallHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_TwinribbonHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_TwinribbonHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_TwintailsHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_TwintailsHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_ViscountessHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_ViscountessHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_WarriorHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_WarriorHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_WarriormaleHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_WarriormaleHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_WavyHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_WavyHD"

  Scenario: look-gallery-17: hair 321 to 340 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_WavymaleHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_WavymaleHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_ZeusHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Roo_Royal_ZeusHD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Anne"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Anne"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Artist"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Artist"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Elisabeth"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Elisabeth"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Henry"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Henry"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Jane"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Jane"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Lisa"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Lisa"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Mary"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Mary"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Richard"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Richard"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Stephen"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Stephen"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Victoria"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Victoria"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "William"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-William"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Abigail"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Abigail"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Annointed"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Annointed"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Aslaug"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Aslaug"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Barren"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Barren"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_BattleBraid"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_BattleBraid"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_BattleBraids"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_BattleBraids"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Beautiful"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Beautiful"

  Scenario: look-gallery-18: hair 341 to 360 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Bereaved"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Bereaved"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Beth"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Beth"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Bill"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Bill"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Bjorn"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Bjorn"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Blinder"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Blinder"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Braid"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Braid"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_BraidedHawk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_BraidedHawk"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Brave"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Brave"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Buzzcut"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Buzzcut"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Celebrity"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Celebrity"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Chosen"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Chosen"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Connor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Connor"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Corporal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Corporal"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Cyberpunk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Cyberpunk"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Dapp"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Dapp"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Dean"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Dean"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Distinguished"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Distinguished"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_DoubleHawk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_DoubleHawk"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Dreadlock"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Dreadlock"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Dusk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Dusk"

  Scenario: look-gallery-19: hair 361 to 380 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Dutch"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Dutch"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Egil"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Egil"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Erik"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Erik"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Faerie"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Faerie"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Farmboy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Farmboy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_FauxHawk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_FauxHawk"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Festive"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Festive"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_FireKeeper"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_FireKeeper"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Flak"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Flak"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_FlatAfro"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_FlatAfro"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Fox"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Fox"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Freydis"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Freydis"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Frida"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Frida"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Gangster"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Gangster"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_General"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_General"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Gentleman"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Gentleman"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Grimshaw"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Grimshaw"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Gunnar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Gunnar"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Halfdan"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Halfdan"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_HalfShaved"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_HalfShaved"

  Scenario: look-gallery-20: hair 381 to 400 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Harald"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Harald"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Hardened"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Hardened"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Helga"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Helga"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Hideout"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Hideout"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_HighTop"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_HighTop"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Hunter"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Hunter"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Jerry"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Jerry"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Karen"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Karen"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Lagertha"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Lagertha"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Librarian"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Librarian"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Long"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Long"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_LongAfro"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_LongAfro"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_LongPonytail"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_LongPonytail"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Major"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Major"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Maniac"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Maniac"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Marston"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Marston"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Messy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Messy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Micah"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Micah"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Midlife"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Midlife"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Mohawk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Mohawk"

  Scenario: look-gallery-21: hair 401 to 420 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Monk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Monk"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Mortimer"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Mortimer"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Mother"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Mother"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Mystic"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Mystic"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Oskar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Oskar"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Part"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Part"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Pearson"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Pearson"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_PinUp"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_PinUp"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Princess"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Princess"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Private"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Private"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Quaf"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Quaf"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Queen"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Queen"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Ragnar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Ragnar"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Raider"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Raider"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Regal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Regal"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Sad"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Sad"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Sam"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Sam"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Sanchez"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Sanchez"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Sarge"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Sarge"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_ScorpionKing"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_ScorpionKing"

  Scenario: look-gallery-22: hair 421 to 440 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Senator"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Senator"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Shelby"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Shelby"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_ShortAfro"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_ShortAfro"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_SideBraid"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_SideBraid"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Sigurd"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Sigurd"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Slick"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Slick"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Slicked"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Slicked"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_SlickedShort"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_SlickedShort"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Smith"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Smith"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Smuggler"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Smuggler"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Spikey"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Spikey"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Straight"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Straight"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Strongman"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Strongman"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Summer"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Summer"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Tower"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Tower"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Tribal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Tribal"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_TuftHawk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_TuftHawk"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Twisted"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Twisted"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_TwoTails"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_TwoTails"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Ulfrik"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Ulfrik"

  Scenario: look-gallery-23: hair 441 to 447 of 447
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Unkept"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Unkept"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Vile"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Vile"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Warrior"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Warrior"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Widow"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Widow"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Wilderness"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Wilderness"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Willow"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Willow"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hairstyle is "VHE_Wrap"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-VHE_Wrap"

  Scenario: look-gallery-24: haircolour 1 to 8 of 8
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Afro"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (237, 202, 156)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-Blonde"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (51, 51, 51)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-DarkBlack"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (90, 58, 32)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-DarkBrown"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (64, 51, 38)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-DarkReddish"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (76, 51, 26)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-DarkSaturatedReddish"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (79, 71, 66)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-MidBlack"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (26, 26, 26)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-PitchBlack"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (193, 146, 85)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-SandyBlonde"

  Scenario: look-gallery-25: beard 1 to 20 of 41
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinKnots"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinKnots"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinMegabraid"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinMegabraid"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinMonkey"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinMonkey"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinMoustache"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinMoustache"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinScruffy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinScruffy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinSenile"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinSenile"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinSideChops"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinSideChops"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinSideTufts"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinSideTufts"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinStrongChops"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinStrongChops"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "FurskinCurlyMoustache"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-FurskinCurlyMoustache"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Anchor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Anchor"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "BeardCurly"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardCurly"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Boxed"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Boxed"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Braided"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Braided"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Bushy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Bushy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "BushyStyled"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BushyStyled"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Circle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Circle"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Classy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Classy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Curtain"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Curtain"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Ducktail"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Ducktail"

  Scenario: look-gallery-26: beard 21 to 40 of 41
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" beard is "Fork"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Fork"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "French"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-French"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Full"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Full"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Goatee"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Goatee"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Lincoln"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Lincoln"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "LongDutch"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-LongDutch"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Machete"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Machete"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Moustache"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Moustache"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "MuttonChops"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-MuttonChops"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "NoBeard"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-NoBeard"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Norse"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Norse"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "OldDutch"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-OldDutch"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Seer"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Seer"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "SideWhiskers"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-SideWhiskers"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "SoulPatch"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-SoulPatch"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "StacheAndChops"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-StacheAndChops"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Stubble"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Stubble"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "TriBraid"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-TriBraid"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "Urist"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Urist"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" beard is "VanDyke"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-VanDyke"

  Scenario: look-gallery-27: beard 41 to 41 of 41
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" beard is "Wizard"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Wizard"

  Scenario: look-gallery-28: head 1 to 20 of 28
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" head type is "CultEscapee"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-CultEscapee"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "DarkScholar_Female"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-DarkScholar_Female"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Ghoul_Heavy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Ghoul_Heavy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Ghoul_Narrow"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Ghoul_Narrow"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Ghoul_Normal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Ghoul_Normal"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Ghoul_Wide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Ghoul_Wide"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Leathery_Female"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Leathery_Female"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "TimelessOne"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-TimelessOne"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Female_HeavyJawNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_HeavyJawNormal"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Average1"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Average1"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Average2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Average2"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Average3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Average3"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Gaunt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Gaunt"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Heavy1"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Heavy1"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Heavy2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Heavy2"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Heavy3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Heavy3"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Narrow1"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Narrow1"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Narrow2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Narrow2"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Narrow3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Narrow3"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Gaunt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Gaunt"

  Scenario: look-gallery-29: head 21 to 28 of 28
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" head type is "Female_AverageNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_AverageNormal"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Female_AveragePointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_AveragePointy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Female_AverageWide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_AverageWide"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Female_NarrowNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_NarrowNormal"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Female_NarrowPointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_NarrowPointy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Female_NarrowWide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_NarrowWide"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Skull"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Skull"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" head type is "Stump"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Stump"

  Scenario: look-gallery-30: facetattoo 1 to 20 of 40
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" face tattoo is "NoTattoo_Face"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-NoTattoo_Face"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Cobweb"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Cobweb"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Eclipse"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Eclipse"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Headshot"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Headshot"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Line"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Line"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Love"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Love"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Oracle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Oracle"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Pantheon"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Pantheon"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Spider"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Spider"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Stars"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Stars"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Tear"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Tear"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Tiger"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Tiger"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Warpaint"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Warpaint"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Worried"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Worried"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Tilak"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Tilak"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_Anima"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_Anima"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_Bisect"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_Bisect"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_BlackFangs"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_BlackFangs"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_BlueFangs"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_BlueFangs"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_BrowDots"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_BrowDots"

  Scenario: look-gallery-31: facetattoo 21 to 40 of 40
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_CheekDots"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_CheekDots"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_CheekStripes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_CheekStripes"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_MiddleDotsBlack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_MiddleDotsBlack"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_MiddleDotsBlue"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_MiddleDotsBlue"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_MiddleDotsRed"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_MiddleDotsRed"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_MiddleDotsWhite"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_MiddleDotsWhite"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripeBlack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripeBlack"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripeBlue"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripeBlue"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripePurple"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripePurple"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripeRed"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripeRed"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripeWhite"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripeWhite"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_RedFangs"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_RedFangs"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SacredAir"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SacredAir"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SacredFire"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SacredFire"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SacredGrass"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SacredGrass"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SacredWater"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SacredWater"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SunCrown"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SunCrown"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SunrisePlains"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SunrisePlains"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SunsetPlains"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SunsetPlains"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_WhiteFangs"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_WhiteFangs"

  Scenario: look-gallery-32: bodytattoo 1 to 20 of 73
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" body tattoo is "NoTattoo_Body"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-NoTattoo_Body"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Buttons"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Buttons"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Cross"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Cross"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Heart"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Heart"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Insect"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Insect"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Jester"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Jester"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Moon"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Moon"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Power"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Power"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Rings"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Rings"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Royal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Royal"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Scar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Scar"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Skeleton"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Skeleton"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Skull"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Skull"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Spike"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Spike"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Sun"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Sun"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Tiger"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tiger"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Wings"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Wings"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Bear"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Bear"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Birds"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Birds"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Bull"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Bull"

  Scenario: look-gallery-33: bodytattoo 21 to 40 of 73
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Butterfly"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Butterfly"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Cat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Cat"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_circles"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_circles"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Claws"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Claws"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Deer"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Deer"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Dragon"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Dragon"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Dragon_2c"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Dragon_2c"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Illuminati"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Illuminati"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_invertedcross"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_invertedcross"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Japan"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Japan"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_kanji_1c"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_1c"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_kanji_2c"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_2c"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_kanji_3c"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_3c"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_kanji_4c"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_4c"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_kanji_5c"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_5c"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Koi"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Koi"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Labyrinth"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Labyrinth"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_leviathan"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_leviathan"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Lion"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Lion"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Lizard"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Lizard"

  Scenario: look-gallery-34: bodytattoo 41 to 60 of 73
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_lucifer"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_lucifer"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_pentagram"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_pentagram"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_rose"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_rose"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_samurai"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_samurai"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_satanic_1c"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_satanic_1c"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_satanic_2c"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_satanic_2c"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_scythe"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_scythe"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Shark"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Shark"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Skull_2c"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Skull_2c"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Tiger_2c"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tiger_2c"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Triangle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Triangle"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Tribal_back"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Tribal_back_2c"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back_2c"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Tribal_back_3c"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back_3c"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Tribal_back_4c"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back_4c"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Tribal_back_5c"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back_5c"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_wings"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_wings"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Wolf"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Wolf"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_yinyang"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_yinyang"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "STribalTat_Body_Anima"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Anima"

  Scenario: look-gallery-35: bodytattoo 61 to 73 of 73
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" body tattoo is "STribalTat_Body_BlackClaw"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_BlackClaw"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "STribalTat_Body_BlueClaw"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_BlueClaw"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "STribalTat_Body_RedClaw"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_RedClaw"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "STribalTat_Body_SacredAir"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SacredAir"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "STribalTat_Body_SacredFire"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SacredFire"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "STribalTat_Body_SacredGrass"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SacredGrass"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "STribalTat_Body_SacredWater"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SacredWater"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "STribalTat_Body_Smoke"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Smoke"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "STribalTat_Body_Spiral"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Spiral"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "STribalTat_Body_Stripes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Stripes"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "STribalTat_Body_SunsBlessing"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SunsBlessing"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "STribalTat_Body_Vines"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Vines"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "STribalTat_Body_WhiteClaw"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_WhiteClaw"

  Scenario: look-gallery-36: garment 1 to 20 of 65
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BiomutationLance"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_BiomutationLance"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_DeadlifePack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_DeadlifePack"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_DisruptorFlarePack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_DisruptorFlarePack"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PackTurret"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PackTurret"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_ShardPsychicInsanityLance"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ShardPsychicInsanityLance"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_ShardPsychicShockLance"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ShardPsychicShockLance"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_LabCoat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_LabCoat"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PackBandwidth"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PackBandwidth"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PackControl"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PackControl"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PackTox"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PackTox"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_HeavyShield"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_HeavyShield"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Sash"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Sash"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_MechlordSuit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_MechlordSuit"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Bandolier"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Bandolier"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_FirefoampopPack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_FirefoampopPack"

  Scenario: look-gallery-37: garment 21 to 40 of 65
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PsychicInsanityLance"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PsychicInsanityLance"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PsychicShockLance"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PsychicShockLance"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_ShieldBelt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ShieldBelt"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_SmokepopBelt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_SmokepopBelt"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "OrbitalTargeterBombardment"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-OrbitalTargeterBombardment"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "OrbitalTargeterPowerBeam"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-OrbitalTargeterPowerBeam"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "TornadoGenerator"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-TornadoGenerator"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_FlakVest"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_FlakVest"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_FlakPants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_FlakPants"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorRecon"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorRecon"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PlateArmor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PlateArmor"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PowerArmor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PowerArmor"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_BasicShirt"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_CollarShirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_CollarShirt"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Pants"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_TribalA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_TribalA"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Cape"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Cape"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Duster"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Duster"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_FlakJacket"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_FlakJacket"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Jacket"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Jacket"

  Scenario: look-gallery-38: garment 41 to 60 of 65
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Parka"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Parka"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Robe"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Robe"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Collar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Collar"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BodyStrap"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_BodyStrap"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_CerebrexNode"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_CerebrexNode"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PackHunter"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PackHunter"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Vacsuit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Vacsuit"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PackBroadshield"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PackBroadshield"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PackJump"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PackJump"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "OrbitalTargeterMechCluster"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-OrbitalTargeterMechCluster"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Corset"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PsyfocusVest"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PsyfocusVest"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_VestRoyal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_VestRoyal"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorCataphract"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorCataphract"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorCataphractPhoenix"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorCataphractPhoenix"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorCataphractPrestige"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorCataphractPrestige"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorLocust"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorLocust"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorMarineGrenadier"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorMarineGrenadier"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorMarinePrestige"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorMarinePrestige"

  Scenario: look-gallery-39: garment 61 to 65 of 65
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorReconPrestige"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorReconPrestige"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PsyfocusShirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PsyfocusShirt"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_ShirtRuffle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ShirtRuffle"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PsyfocusRobe"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PsyfocusRobe"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_RobeRoyal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_RobeRoyal"

  Scenario: look-gallery-40: hat 1 to 20 of 47
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_CeremonialCultistMask"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_CeremonialCultistMask"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_CultistMask"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_CultistMask"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_AirwireHeadset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_AirwireHeadset"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorHelmetMechCommander"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_ArmorHelmetMechCommander"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorHelmetMechlordHelmet"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_ArmorHelmetMechlordHelmet"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArrayHeadset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_ArrayHeadset"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_GasMask"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_GasMask"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_IntegratorHeadset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_IntegratorHeadset"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_AdvancedHelmet"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_AdvancedHelmet"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorHelmetRecon"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_ArmorHelmetRecon"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BowlerHat"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_BowlerHat"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ClothMask"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_ClothMask"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_CowboyHat"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_CowboyHat"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_HatHood"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_HatHood"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PowerArmorHelmet"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PowerArmorHelmet"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PsychicFoilHelmet"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PsychicFoilHelmet"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_SimpleHelmet"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_SimpleHelmet"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_TribalHeaddress"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_TribalHeaddress"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Tuque"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_Tuque"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Victoria"

  Scenario: look-gallery-41: hat 21 to 40 of 47
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_WarMask"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_WarMask"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_WarVeil"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_WarVeil"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Blindfold"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_Blindfold"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_AuthorityCap"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_AuthorityCap"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Broadwrap"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_Broadwrap"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Flophat"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_Flophat"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Headwrap"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_Headwrap"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Shadecone"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_Shadecone"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Slicecap"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_Slicecap"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Tailcap"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_Tailcap"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_TortureCrown"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_TortureCrown"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_VisageMask"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_VisageMask"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Burka"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_Burka"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_VacsuitHelmet"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_VacsuitHelmet"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorHelmetCataphract"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_ArmorHelmetCataphract"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorHelmetCataphractPrestige"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_ArmorHelmetCataphractPrestige"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorHelmetReconPrestige"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_ArmorHelmetReconPrestige"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorMarineHelmetPrestige"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_ArmorMarineHelmetPrestige"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Beret"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_Beret"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Coronet"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_Coronet"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Victoria"

  Scenario: look-gallery-42: hat 41 to 47 of 47
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Crown"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_Crown"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_CrownStellic"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_CrownStellic"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_EltexSkullcap"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_EltexSkullcap"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Gunlink"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_Gunlink"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_HatLadies"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_HatLadies"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_HatTop"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_HatTop"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PsyfocusHelmet"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PsyfocusHelmet"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Victoria"

  Scenario: look-gallery-43: ideocolour 1 to 20 of 34
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (51, 51, 51)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Black"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (86, 191, 191)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Blue"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (67, 148, 148)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkBlue"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (83, 148, 67)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkGreen"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (128, 128, 128)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkGrey"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (83, 67, 148)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkMauve"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (132, 148, 67)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkOlive"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (148, 115, 67)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkOrange"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (148, 67, 115)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkPink"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (132, 67, 148)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkPurple"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (148, 67, 67)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkRed"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (67, 99, 148)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkSapphire"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (67, 148, 99)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkTeal"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (107, 191, 86)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Green"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (192, 192, 192)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Grey"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (115, 255, 255)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightBlue"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (143, 255, 115)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightGreen"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (245, 245, 245)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightGrey"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (143, 115, 255)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightMauve"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (227, 255, 115)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightOlive"

  Scenario: look-gallery-44: ideocolour 21 to 34 of 34
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (255, 199, 115)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightOrange"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (255, 115, 199)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightPink"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (227, 115, 255)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightPurple"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (255, 115, 115)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightRed"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (115, 171, 255)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightSapphire"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (115, 255, 171)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightTeal"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (107, 86, 191)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Mauve"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (170, 191, 86)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Olive"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (191, 149, 86)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Orange"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (191, 86, 149)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Pink"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (170, 86, 191)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Purple"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (191, 86, 86)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Red"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (86, 128, 191)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Sapphire"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (86, 191, 128)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Teal"

