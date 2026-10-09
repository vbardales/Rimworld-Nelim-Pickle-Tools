@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
Feature: Every face part and kit on Nelim, one photograph per value (gallery of the step parameters)

  Scenario: face-parts-gallery-1: Mouths, Brows (part 1 of 3)
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
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthEdnaLipsMale"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthEdnaLipsMale"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsBigMale"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLipsBigMale"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSimpleMale"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLipsSimpleMale"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSimpleSmileMale"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLipsSimpleSmileMale"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmallSmileMale"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLipsSmallSmileMale"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmirkMale"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLipsSmirkMale"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsTinySmileMale"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLipsTinySmileMale"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsWorriedMale"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLipsWorriedMale"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLittle"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLittle"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthNone"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthNone"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthSubtle"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthSubtle"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthNormal"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthNormal"
    When Nelim's Pickle Tools: "Nelim" mouth is "AKN_MouthCourageous"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-AKN_MouthCourageous"
    When Nelim's Pickle Tools: "Nelim" mouth is "AKN_MouthEmpathetic"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-AKN_MouthEmpathetic"
    When Nelim's Pickle Tools: "Nelim" mouth is "AKN_MouthSwift"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-AKN_MouthSwift"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthCaveman"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthCaveman"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthCheekFrown"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthCheekFrown"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthClassicSmile"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthClassicSmile"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthEdnaLips"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthEdnaLips"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthFatCheeks"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthFatCheeks"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthHawk"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthHawk"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsBig"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLipsBig"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSimple"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLipsSimple"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSimpleSmile"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLipsSimpleSmile"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmallSmile"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLipsSmallSmile"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmirk"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLipsSmirk"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsTinySmile"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLipsTinySmile"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsWorried"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLipsWorried"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLittleFrown"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLittleFrown"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLittleGrin"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLittleGrin"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLittleSuperSmirk"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthLittleSuperSmirk"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthMrStreamer"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthMrStreamer"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthSad"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthSad"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthScowl"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthScowl"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthSimpleMouth"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthSimpleMouth"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthSmile"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthSmile"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthSmirkSmile"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthSmirkSmile"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthSmug"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "mouth-MouthSmug"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-BrowNormal"
    When Nelim's Pickle Tools: "Nelim" brows are "AKN_BrowCourageous"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-AKN_BrowCourageous"
    When Nelim's Pickle Tools: "Nelim" brows are "AKN_BrowEmpathetic"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-AKN_BrowEmpathetic"
    When Nelim's Pickle Tools: "Nelim" brows are "AKN_BrowSwift"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-AKN_BrowSwift"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowEven"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-BrowEven"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowFurryMonobrow"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-BrowFurryMonobrow"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowFuzzy"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-BrowFuzzy"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowNone"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-BrowNone"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowRaised"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-BrowRaised"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowSquare"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-BrowSquare"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowStreamer"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-BrowStreamer"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowThin"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-BrowThin"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowTriangle"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-BrowTriangle"
    When Nelim's Pickle Tools: "Nelim" brows are "MonoBrow"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-MonoBrow"
    When Nelim's Pickle Tools: "Nelim" brows are "MonoScarredBrows"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "brow-MonoScarredBrows"

  Scenario: face-parts-gallery-2: Lids, Skins (part 2 of 3)
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
    When Nelim's Pickle Tools: "Nelim" lids are "BIGEYE"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-BIGEYE"
    When Nelim's Pickle Tools: "Nelim" lids are "LidAlmond"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidAlmond"
    When Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidCheerful"
    When Nelim's Pickle Tools: "Nelim" lids are "LidFlashy"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidFlashy"
    When Nelim's Pickle Tools: "Nelim" lids are "LidFlirty"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidFlirty"
    When Nelim's Pickle Tools: "Nelim" lids are "LidHardened"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidHardened"
    When Nelim's Pickle Tools: "Nelim" lids are "LidNone"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidNone"
    When Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidNormal"
    When Nelim's Pickle Tools: "Nelim" lids are "LidPointy"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidPointy"
    When Nelim's Pickle Tools: "Nelim" lids are "LidQuite"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidQuite"
    When Nelim's Pickle Tools: "Nelim" lids are "LidShort"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidShort"
    When Nelim's Pickle Tools: "Nelim" lids are "LidSimple"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidSimple"
    When Nelim's Pickle Tools: "Nelim" lids are "LidSleepy"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidSleepy"
    When Nelim's Pickle Tools: "Nelim" lids are "LidSquinting"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidSquinting"
    When Nelim's Pickle Tools: "Nelim" lids are "LidStuffed"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidStuffed"
    When Nelim's Pickle Tools: "Nelim" lids are "LidThick"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidThick"
    When Nelim's Pickle Tools: "Nelim" lids are "LidUnimpressed"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidUnimpressed"
    When Nelim's Pickle Tools: "Nelim" lids are "LidVK_ClosedEyes"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidVK_ClosedEyes"
    When Nelim's Pickle Tools: "Nelim" lids are "LidVK_SmilingEyes"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-LidVK_SmilingEyes"
    When Nelim's Pickle Tools: "Nelim" lids are "BionicBoth"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-BionicBoth"
    When Nelim's Pickle Tools: "Nelim" lids are "BionicLeft"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-BionicLeft"
    When Nelim's Pickle Tools: "Nelim" lids are "BionicRight"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-BionicRight"
    When Nelim's Pickle Tools: "Nelim" lids are "Biotech_Eyes_Beauty"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-Biotech_Eyes_Beauty"
    When Nelim's Pickle Tools: "Nelim" lids are "Biotech_Eyes_Beauty2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lid-Biotech_Eyes_Beauty2"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinLeftChin"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinLeftChin"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinNormal"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinNormal"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinRightEye"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinRightEye"
    When Nelim's Pickle Tools: "Nelim" face skin is "AKN_SkinSnoot"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-AKN_SkinSnoot"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinBandaid"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinBandaid"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinBruise"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinBruise"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinCheekbones"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinCheekbones"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinCheekScar"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinCheekScar"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinChinCleft"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinChinCleft"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinCrowsFeet"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinCrowsFeet"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinDecrepit"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinDecrepit"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinEyeshadow"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinEyeshadow"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinForeheadScar"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinForeheadScar"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinForheadWrinkles"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinForheadWrinkles"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFreckles"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinFreckles"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFreckles2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinFreckles2"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFreckles3"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinFreckles3"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFrownLines"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinFrownLines"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFurrows"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinFurrows"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinRosyCheeks"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinRosyCheeks"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinSmileLines"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinSmileLines"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinTiredEyes"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "skin-SkinTiredEyes"

  Scenario: face-parts-gallery-3: Eyeballs, Head shapes, Lid options, Emotion marks, kits (part 3 of 3)
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
    When Nelim's Pickle Tools: "Nelim" eyeballs are "BIGEYE"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "eyeball-BIGEYE"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "EyeBig"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "eyeball-EyeBig"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "EyeNone"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "eyeball-EyeNone"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "EyeNormal"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "eyeball-EyeNormal"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "EyeSmall"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "eyeball-EyeSmall"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "EyeThin"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "eyeball-EyeThin"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "EyeWide"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "eyeball-EyeWide"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "Courageous"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "eyeball-Courageous"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "Empathetic"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "eyeball-Empathetic"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "Swift"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "eyeball-Swift"
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "head-HeadNormal"
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeadPointy"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "head-HeadPointy"
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeadSquare"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "head-HeadSquare"
    When Nelim's Pickle Tools: "Nelim" face head shape is "Beauty"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "head-Beauty"
    When Nelim's Pickle Tools: "Nelim" face head shape is "Beauty2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "head-Beauty2"
    When Nelim's Pickle Tools: "Nelim" lid option is "LidOptionNormal"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "lidoption-LidOptionNormal"
    When Nelim's Pickle Tools: "Nelim" emotion mark is "EmotionNormal"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "emotion-EmotionNormal"
    When Nelim's Pickle Tools: "Nelim" face kit is "smile"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "kit-smile"
    When Nelim's Pickle Tools: "Nelim" face kit is "calm"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "kit-calm"
    When Nelim's Pickle Tools: "Nelim" face kit is "sad"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "kit-sad"
    When Nelim's Pickle Tools: "Nelim" face kit is "angry"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "kit-angry"
    When Nelim's Pickle Tools: "Nelim" face kit is "smug"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "kit-smug"
    When Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "kit-neutral"
