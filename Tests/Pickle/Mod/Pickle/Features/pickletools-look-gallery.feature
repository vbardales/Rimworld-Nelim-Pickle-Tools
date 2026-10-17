@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Every look value on Nelim, one photograph per value (gallery of the look catalogues)

  Scenario: look-gallery-1: hair 1 to 20 of 80
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" hairstyle is "DoubleTuft"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-DoubleTuft"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ghoul_Furious"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ghoul_Furious"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ghoul_Hungry"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ghoul_Hungry"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ghoul_Ravenous"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ghoul_Ravenous"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ghoul_Twisted"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ghoul_Twisted"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ghoul_Vengeful"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ghoul_Vengeful"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ghoul_Warped"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ghoul_Warped"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ghoul_Wicked"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ghoul_Wicked"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "LargeTuft"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-LargeTuft"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "LongMess"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-LongMess"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "LongOily"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-LongOily"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Parted"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Parted"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "PatchyShave"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-PatchyShave"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RoughShave"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-RoughShave"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "ShavedMohawk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-ShavedMohawk"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "ShortCut"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-ShortCut"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "SideCut"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-SideCut"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "SideSpikes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-SideSpikes"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Afro"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Afro"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Bald"

  Scenario: look-gallery-2: hair 21 to 40 of 80
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Bob"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Bob"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Bowlcut"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Bowlcut"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "BraidedKnot"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-BraidedKnot"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Bravo"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Bravo"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "BriefPonytail"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-BriefPonytail"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Burgundy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Burgundy"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Cleopatra"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Cleopatra"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Curly"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Curly"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Cute"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Cute"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Decent"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Decent"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Elder"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Elder"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "FancyBun"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-FancyBun"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Firestarter"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Firestarter"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Flowy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Flowy"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Fringe"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Fringe"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Frozen"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Frozen"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "GreasySwoop"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-GreasySwoop"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Junkie"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Junkie"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Keeper"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Keeper"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Lackland"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Lackland"

  Scenario: look-gallery-3: hair 41 to 60 of 80
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Locks"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Locks"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Long"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Messy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Messy"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Mohawk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Mohawk"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Mop"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Mop"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Pigtails"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Pigtails"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytails"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Ponytails"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Primal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Primal"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Princess"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Princess"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Randy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Randy"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Recruit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Recruit"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Revolt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Revolt"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Rockstar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Rockstar"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Rookie"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Rookie"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Savage"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Savage"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Scatman"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Scatman"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "ScorpionTail"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-ScorpionTail"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Scrapper"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Scrapper"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Senorita"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Senorita"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Shaved"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Shaved"

  Scenario: look-gallery-4: hair 61 to 80 of 80
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" hairstyle is "ShaveTopBraid"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-ShaveTopBraid"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Snazzy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Snazzy"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Spikes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Spikes"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Sticky"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Sticky"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Topdog"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Topdog"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Troubadour"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Troubadour"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Tuft"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Tuft"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Warden"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Warden"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Wavy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Wavy"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Anne"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Anne"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Artist"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Artist"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Elisabeth"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Elisabeth"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Henry"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Henry"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Jane"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Jane"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Lisa"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Lisa"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Mary"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Mary"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Richard"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Richard"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Stephen"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Stephen"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Victoria"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-Victoria"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "William"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hair-William"

  Scenario: look-gallery-5: haircolour 1 to 8 of 8
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Afro"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (237, 202, 156)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-Blonde"
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (51, 51, 51)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-DarkBlack"
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (90, 58, 32)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-DarkBrown"
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (64, 51, 38)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-DarkReddish"
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (76, 51, 26)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-DarkSaturatedReddish"
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (79, 71, 66)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-MidBlack"
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (26, 26, 26)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-PitchBlack"
    When Nelim's Pickle Tools: "Nelim" hair colour is rgb (193, 146, 85)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "haircolour-SandyBlonde"

  Scenario: look-gallery-6: beard 1 to 20 of 41
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinKnots"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinKnots"
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinMegabraid"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinMegabraid"
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinMonkey"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinMonkey"
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinMoustache"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinMoustache"
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinScruffy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinScruffy"
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinSenile"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinSenile"
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinSideChops"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinSideChops"
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinSideTufts"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinSideTufts"
    When Nelim's Pickle Tools: "Nelim" beard is "BeardFurskinStrongChops"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinStrongChops"
    When Nelim's Pickle Tools: "Nelim" beard is "FurskinCurlyMoustache"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-FurskinCurlyMoustache"
    When Nelim's Pickle Tools: "Nelim" beard is "Anchor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Anchor"
    When Nelim's Pickle Tools: "Nelim" beard is "BeardCurly"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardCurly"
    When Nelim's Pickle Tools: "Nelim" beard is "Boxed"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Boxed"
    When Nelim's Pickle Tools: "Nelim" beard is "Braided"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Braided"
    When Nelim's Pickle Tools: "Nelim" beard is "Bushy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Bushy"
    When Nelim's Pickle Tools: "Nelim" beard is "BushyStyled"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BushyStyled"
    When Nelim's Pickle Tools: "Nelim" beard is "Circle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Circle"
    When Nelim's Pickle Tools: "Nelim" beard is "Classy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Classy"
    When Nelim's Pickle Tools: "Nelim" beard is "Curtain"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Curtain"
    When Nelim's Pickle Tools: "Nelim" beard is "Ducktail"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Ducktail"

  Scenario: look-gallery-7: beard 21 to 40 of 41
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" beard is "Fork"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Fork"
    When Nelim's Pickle Tools: "Nelim" beard is "French"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-French"
    When Nelim's Pickle Tools: "Nelim" beard is "Full"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Full"
    When Nelim's Pickle Tools: "Nelim" beard is "Goatee"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Goatee"
    When Nelim's Pickle Tools: "Nelim" beard is "Lincoln"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Lincoln"
    When Nelim's Pickle Tools: "Nelim" beard is "LongDutch"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-LongDutch"
    When Nelim's Pickle Tools: "Nelim" beard is "Machete"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Machete"
    When Nelim's Pickle Tools: "Nelim" beard is "Moustache"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Moustache"
    When Nelim's Pickle Tools: "Nelim" beard is "MuttonChops"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-MuttonChops"
    When Nelim's Pickle Tools: "Nelim" beard is "NoBeard"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-NoBeard"
    When Nelim's Pickle Tools: "Nelim" beard is "Norse"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Norse"
    When Nelim's Pickle Tools: "Nelim" beard is "OldDutch"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-OldDutch"
    When Nelim's Pickle Tools: "Nelim" beard is "Seer"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Seer"
    When Nelim's Pickle Tools: "Nelim" beard is "SideWhiskers"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-SideWhiskers"
    When Nelim's Pickle Tools: "Nelim" beard is "SoulPatch"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-SoulPatch"
    When Nelim's Pickle Tools: "Nelim" beard is "StacheAndChops"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-StacheAndChops"
    When Nelim's Pickle Tools: "Nelim" beard is "Stubble"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Stubble"
    When Nelim's Pickle Tools: "Nelim" beard is "TriBraid"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-TriBraid"
    When Nelim's Pickle Tools: "Nelim" beard is "Urist"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Urist"
    When Nelim's Pickle Tools: "Nelim" beard is "VanDyke"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-VanDyke"

  Scenario: look-gallery-8: beard 41 to 41 of 41
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" beard is "Wizard"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Wizard"

  Scenario: look-gallery-9: head 1 to 20 of 37
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" head type is "CultEscapee"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-CultEscapee"
    When Nelim's Pickle Tools: "Nelim" head type is "DarkScholar_Female"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-DarkScholar_Female"
    When Nelim's Pickle Tools: "Nelim" head type is "DarkScholar_Male"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-DarkScholar_Male"
    When Nelim's Pickle Tools: "Nelim" head type is "Ghoul_Heavy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Ghoul_Heavy"
    When Nelim's Pickle Tools: "Nelim" head type is "Ghoul_Narrow"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Ghoul_Narrow"
    When Nelim's Pickle Tools: "Nelim" head type is "Ghoul_Normal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Ghoul_Normal"
    When Nelim's Pickle Tools: "Nelim" head type is "Ghoul_Wide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Ghoul_Wide"
    When Nelim's Pickle Tools: "Nelim" head type is "Leathery_Female"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Leathery_Female"
    When Nelim's Pickle Tools: "Nelim" head type is "Leathery_Male"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Leathery_Male"
    When Nelim's Pickle Tools: "Nelim" head type is "TimelessOne"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-TimelessOne"
    When Nelim's Pickle Tools: "Nelim" head type is "Female_HeavyJawNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_HeavyJawNormal"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Average1"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Average1"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Average2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Average2"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Average3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Average3"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Gaunt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Gaunt"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Heavy1"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Heavy1"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Heavy2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Heavy2"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Heavy3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Heavy3"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Narrow1"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Narrow1"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Narrow2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Narrow2"

  Scenario: look-gallery-10: head 21 to 37 of 37
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Narrow3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Narrow3"
    When Nelim's Pickle Tools: "Nelim" head type is "Gaunt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Gaunt"
    When Nelim's Pickle Tools: "Nelim" head type is "Male_HeavyJawNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_HeavyJawNormal"
    When Nelim's Pickle Tools: "Nelim" head type is "Female_AverageNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_AverageNormal"
    When Nelim's Pickle Tools: "Nelim" head type is "Female_AveragePointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_AveragePointy"
    When Nelim's Pickle Tools: "Nelim" head type is "Female_AverageWide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_AverageWide"
    When Nelim's Pickle Tools: "Nelim" head type is "Female_NarrowNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_NarrowNormal"
    When Nelim's Pickle Tools: "Nelim" head type is "Female_NarrowPointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_NarrowPointy"
    When Nelim's Pickle Tools: "Nelim" head type is "Female_NarrowWide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_NarrowWide"
    When Nelim's Pickle Tools: "Nelim" head type is "Male_AverageNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_AverageNormal"
    When Nelim's Pickle Tools: "Nelim" head type is "Male_AveragePointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_AveragePointy"
    When Nelim's Pickle Tools: "Nelim" head type is "Male_AverageWide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_AverageWide"
    When Nelim's Pickle Tools: "Nelim" head type is "Male_NarrowNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_NarrowNormal"
    When Nelim's Pickle Tools: "Nelim" head type is "Male_NarrowPointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_NarrowPointy"
    When Nelim's Pickle Tools: "Nelim" head type is "Male_NarrowWide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_NarrowWide"
    When Nelim's Pickle Tools: "Nelim" head type is "Skull"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Skull"
    When Nelim's Pickle Tools: "Nelim" head type is "Stump"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Stump"

  Scenario: look-gallery-11: facetattoo 1 to 14 of 14
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" face tattoo is "NoTattoo_Face"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-NoTattoo_Face"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Cobweb"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Cobweb"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Eclipse"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Eclipse"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Headshot"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Headshot"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Line"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Line"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Love"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Love"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Oracle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Oracle"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Pantheon"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Pantheon"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Spider"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Spider"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Stars"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Stars"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Tear"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Tear"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Tiger"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Tiger"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Warpaint"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Warpaint"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Worried"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Worried"

  Scenario: look-gallery-12: bodytattoo 1 to 17 of 17
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" body tattoo is "NoTattoo_Body"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-NoTattoo_Body"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Buttons"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Buttons"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Cross"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Cross"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Heart"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Heart"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Insect"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Insect"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Jester"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Jester"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Moon"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Moon"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Power"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Power"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Rings"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Rings"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Royal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Royal"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Scar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Scar"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Skeleton"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Skeleton"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Skull"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Skull"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Spike"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Spike"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Sun"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Sun"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Tiger"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tiger"
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Wings"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Wings"

  Scenario: look-gallery-13: garment 1 to 20 of 112
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BiomutationLance"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_BiomutationLance"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_DeadlifePack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_DeadlifePack"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_DisruptorFlarePack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_DisruptorFlarePack"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PackTurret"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PackTurret"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ShardPsychicInsanityLance"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ShardPsychicInsanityLance"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ShardPsychicShockLance"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ShardPsychicShockLance"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_CeremonialCultistMask"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_CeremonialCultistMask"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_CultistMask"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_CultistMask"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_LabCoat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_LabCoat"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PackBandwidth"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PackBandwidth"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PackControl"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PackControl"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PackTox"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PackTox"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_HeavyShield"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_HeavyShield"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Sash"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Sash"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_MechlordSuit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_MechlordSuit"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_KidPants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_KidPants"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_KidRomper"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_KidRomper"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_KidShirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_KidShirt"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_KidTribal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_KidTribal"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_AirwireHeadset"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_AirwireHeadset"

  Scenario: look-gallery-14: garment 21 to 40 of 112
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorHelmetMechCommander"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorHelmetMechCommander"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorHelmetMechlordHelmet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorHelmetMechlordHelmet"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArrayHeadset"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArrayHeadset"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_GasMask"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_GasMask"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_IntegratorHeadset"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_IntegratorHeadset"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_KidHelmet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_KidHelmet"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Bandolier"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Bandolier"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_KidParka"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_KidParka"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_FirefoampopPack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_FirefoampopPack"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PsychicInsanityLance"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PsychicInsanityLance"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PsychicShockLance"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PsychicShockLance"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ShieldBelt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ShieldBelt"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_SmokepopBelt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_SmokepopBelt"
    When Nelim's Pickle Tools: "Nelim" wears "OrbitalTargeterBombardment"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-OrbitalTargeterBombardment"
    When Nelim's Pickle Tools: "Nelim" wears "OrbitalTargeterPowerBeam"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-OrbitalTargeterPowerBeam"
    When Nelim's Pickle Tools: "Nelim" wears "TornadoGenerator"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-TornadoGenerator"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_FlakVest"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_FlakVest"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_FlakPants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_FlakPants"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorRecon"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorRecon"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PlateArmor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PlateArmor"

  Scenario: look-gallery-15: garment 41 to 60 of 112
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PowerArmor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PowerArmor"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_BasicShirt"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_CollarShirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_CollarShirt"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Pants"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_TribalA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_TribalA"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_AdvancedHelmet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_AdvancedHelmet"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorHelmetRecon"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorHelmetRecon"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BowlerHat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_BowlerHat"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ClothMask"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ClothMask"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_CowboyHat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_CowboyHat"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_HatHood"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_HatHood"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PowerArmorHelmet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PowerArmorHelmet"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PsychicFoilHelmet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PsychicFoilHelmet"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_SimpleHelmet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_SimpleHelmet"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_TribalHeaddress"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_TribalHeaddress"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Tuque"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Tuque"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_WarMask"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_WarMask"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_WarVeil"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_WarVeil"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Cape"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Cape"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Duster"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Duster"

  Scenario: look-gallery-16: garment 61 to 80 of 112
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_FlakJacket"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_FlakJacket"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Jacket"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Jacket"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Parka"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Parka"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Robe"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Robe"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Blindfold"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Blindfold"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_AuthorityCap"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_AuthorityCap"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Broadwrap"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Broadwrap"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Collar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Collar"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Flophat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Flophat"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Headwrap"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Headwrap"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Shadecone"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Shadecone"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Slicecap"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Slicecap"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Tailcap"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Tailcap"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_TortureCrown"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_TortureCrown"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_VisageMask"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_VisageMask"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BodyStrap"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_BodyStrap"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Burka"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Burka"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_CerebrexNode"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_CerebrexNode"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PackHunter"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PackHunter"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Vacsuit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Vacsuit"

  Scenario: look-gallery-17: garment 81 to 100 of 112
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_VacsuitChildren"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_VacsuitChildren"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_VacsuitHelmet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_VacsuitHelmet"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PackBroadshield"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PackBroadshield"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PackJump"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PackJump"
    When Nelim's Pickle Tools: "Nelim" wears "OrbitalTargeterMechCluster"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-OrbitalTargeterMechCluster"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Corset"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PsyfocusVest"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PsyfocusVest"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_VestRoyal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_VestRoyal"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorCataphract"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorCataphract"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorCataphractPhoenix"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorCataphractPhoenix"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorCataphractPrestige"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorCataphractPrestige"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorLocust"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorLocust"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorMarineGrenadier"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorMarineGrenadier"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorMarinePrestige"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorMarinePrestige"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorReconPrestige"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorReconPrestige"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PsyfocusShirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PsyfocusShirt"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ShirtRuffle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ShirtRuffle"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorHelmetCataphract"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorHelmetCataphract"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorHelmetCataphractPrestige"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorHelmetCataphractPrestige"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorHelmetReconPrestige"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorHelmetReconPrestige"

  Scenario: look-gallery-18: garment 101 to 112 of 112
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorMarineHelmetPrestige"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_ArmorMarineHelmetPrestige"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Beret"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Beret"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Coronet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Coronet"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Crown"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Crown"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_CrownStellic"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_CrownStellic"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_EltexSkullcap"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_EltexSkullcap"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Gunlink"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_Gunlink"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_HatLadies"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_HatLadies"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_HatTop"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_HatTop"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PsyfocusHelmet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PsyfocusHelmet"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PsyfocusRobe"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PsyfocusRobe"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_RobeRoyal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_RobeRoyal"

  Scenario: look-gallery-19: ideocolour 1 to 20 of 34
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (51, 51, 51)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Black"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (86, 191, 191)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Blue"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (67, 148, 148)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkBlue"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (83, 148, 67)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkGreen"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (128, 128, 128)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkGrey"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (83, 67, 148)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkMauve"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (132, 148, 67)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkOlive"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (148, 115, 67)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkOrange"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (148, 67, 115)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkPink"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (132, 67, 148)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkPurple"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (148, 67, 67)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkRed"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (67, 99, 148)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkSapphire"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (67, 148, 99)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-DarkTeal"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (107, 191, 86)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Green"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (192, 192, 192)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Grey"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (115, 255, 255)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightBlue"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (143, 255, 115)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightGreen"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (245, 245, 245)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightGrey"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (143, 115, 255)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightMauve"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (227, 255, 115)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightOlive"

  Scenario: look-gallery-20: ideocolour 21 to 34 of 34
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (255, 199, 115)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightOrange"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (255, 115, 199)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightPink"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (227, 115, 255)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightPurple"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (255, 115, 115)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightRed"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (115, 171, 255)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightSapphire"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (115, 255, 171)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-LightTeal"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (107, 86, 191)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Mauve"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (170, 191, 86)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Olive"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (191, 149, 86)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Orange"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (191, 86, 149)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Pink"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (170, 86, 191)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Purple"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (191, 86, 86)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Red"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (86, 128, 191)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Sapphire"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (86, 191, 128)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ideocolour-Teal"

