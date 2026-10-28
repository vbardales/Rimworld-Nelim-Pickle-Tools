@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Ponpeco Accessories and Kids' Clothes, one photograph per garment (gallery of the look catalogues)

  Scenario: ponpeco-gallery-1: accessory hats 1 to 20 of 29
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
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAGEyepatchL"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAGEyepatchL"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAGEyepatchLU"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAGEyepatchLU"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAGEyepatchR"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAGEyepatchR"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAGEyepatchRU"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAGEyepatchRU"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAGGlasses"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAGGlasses"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAGSunglassesA"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAGSunglassesA"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAGSunglassesB"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAGSunglassesB"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHAngolaBeret"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHAngolaBeret"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHCatEarNewsboy"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHCatEarNewsboy"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHCyberHelm"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHCyberHelm"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHCyberSunVisor"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHCyberSunVisor"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHDeepHood"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHDeepHood"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHDekaRibbon"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHDekaRibbon"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHFedora"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHFedora"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHFlatCap"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHFlatCap"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHHalfKitsuneMask"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHHalfKitsuneMask"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHHeadband"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHHeadband"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHHeaddress"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHHeaddress"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHHeadphones"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHHeadphones"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHHeadScarf"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHHeadScarf"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"

  Scenario: ponpeco-gallery-2: accessory hats 21 to 29 of 29
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
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHHeadScarfB"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHHeadScarfB"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHKnitHeadband"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHKnitHeadband"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHMechaBunnyEars"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHMechaBunnyEars"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHMokoRibbon"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHMokoRibbon"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHPillboxHat"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHPillboxHat"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHPilotGoggles"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHPilotGoggles"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHRibbonHeadband"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHRibbonHeadband"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHSailorBeret"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHSailorBeret"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_PAHVeil"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PAHVeil"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"

  Scenario: ponpeco-gallery-3: accessory neck pieces 1 to 13 of 13
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
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAERodEarrings"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PAERodEarrings"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAESmallEarrings"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PAESmallEarrings"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAETeardropEarrings"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PAETeardropEarrings"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAMCloverCrown"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PAMCloverCrown"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAMFloralPin"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PAMFloralPin"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAMHairExtensions"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PAMHairExtensions"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAMPartyHat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PAMPartyHat"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAMRibbonPin"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PAMRibbonPin"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAMRoseCrown"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PAMRoseCrown"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PAMStarHairPin"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PAMStarHairPin"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PANFluffyMuffler"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PANFluffyMuffler"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PANMuffler"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PANMuffler"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_PANNeckScarf"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PANNeckScarf"

  Scenario: ponpeco-gallery-4: kids clothes 1 to 20 of 32
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And a colonist "Soren" exists
    And "Soren" is 8 years old
    And Nelim's Pickle Tools: "Soren" gender is male
    And Nelim's Pickle Tools: "Soren" body type is Child
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCBackpack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCBackpack"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKBranch"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKBranch"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKPlushie"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKPlushie"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCVacsuitChildrenA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCVacsuitChildrenA"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCVacsuitChildrenB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCVacsuitChildrenB"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCHalloweenWerewolf"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCHalloweenWerewolf"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCHalloweenWitch"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCHalloweenWitch"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCRoyalBoy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCRoyalBoy"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCRoyalGirl"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCRoyalGirl"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCSailorSuit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCSailorSuit"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCSummerDress"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCSummerDress"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKBorderShirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKBorderShirt"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKCamisoleDress"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKCamisoleDress"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKCatPajama"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKCatPajama"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKDinoPajama"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKDinoPajama"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKFormalOnePiece"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKFormalOnePiece"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKKidsSuit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKKidsSuit"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKKnitVest"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKKnitVest"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKMedievalBoy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKMedievalBoy"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKMedievalGirl"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKMedievalGirl"

  Scenario: ponpeco-gallery-5: kids clothes 21 to 32 of 32
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And a colonist "Soren" exists
    And "Soren" is 8 years old
    And Nelim's Pickle Tools: "Soren" gender is male
    And Nelim's Pickle Tools: "Soren" body type is Child
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKSFBoy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKSFBoy"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKSFGirl"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKSFGirl"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKSkirtLeggings"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKSkirtLeggings"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCCheckedCoat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCCheckedCoat"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCHeroCape"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCHeroCape"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCRaincoat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCRaincoat"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCSailorShirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCSailorShirt"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCScallopCardigan"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCScallopCardigan"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCShortCape"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PKCShortCape"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKFurCoat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKFurCoat"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKKidsHoodie"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKKidsHoodie"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKSummerHoodie"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_PPKSummerHoodie"

  Scenario: ponpeco-gallery-6: kids hats 1 to 8 of 8
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And a colonist "Soren" exists
    And "Soren" is 8 years old
    And Nelim's Pickle Tools: "Soren" gender is male
    And Nelim's Pickle Tools: "Soren" body type is Child
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCCheckedHood"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PKCCheckedHood"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCHeroHelmet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PKCHeroHelmet"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCHWerewolfHood"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PKCHWerewolfHood"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCHWitchHat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PKCHWitchHat"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCVacsuitHelmetA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PKCVacsuitHelmetA"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PKCVacsuitHelmetB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PKCVacsuitHelmetB"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKCatEarHood"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PPKCatEarHood"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_PPKDinoHood"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Apparel_PPKDinoHood"

