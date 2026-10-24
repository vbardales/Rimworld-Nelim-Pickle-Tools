@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Skins, brows, head shapes and the EyeGenes3 eyeballs on a bald Nelim, neutral and without blush (the redone part of the face gallery)

  Scenario: face-skin-gallery-1: SkinLeftChin to SkinTiredEyes (all skins)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: "Nelim" face skin is "SkinNormal"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeNormal"
    And Nelim's Pickle Tools: "Nelim" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinLeftChin"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinLeftChin"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinNormal"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinRightEye"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinRightEye"
    When Nelim's Pickle Tools: "Nelim" face skin is "AKN_SkinSnoot"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-AKN_SkinSnoot"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinBandaid"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinBandaid"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinBruise"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinBruise"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinCheekbones"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinCheekbones"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinCheekScar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinCheekScar"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinChinCleft"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinChinCleft"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinCrowsFeet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinCrowsFeet"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinDecrepit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinDecrepit"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinEyeshadow"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinEyeshadow"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinForeheadScar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinForeheadScar"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinForheadWrinkles"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinForheadWrinkles"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFreckles"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinFreckles"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFreckles2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinFreckles2"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFreckles3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinFreckles3"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFrownLines"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinFrownLines"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFurrows"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinFurrows"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinRosyCheeks"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinRosyCheeks"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinSmileLines"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinSmileLines"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinTiredEyes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skin-SkinTiredEyes"

  Scenario: face-brow-gallery-1: BrowNormal to MonoScarredBrows (all brows)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: "Nelim" face skin is "SkinNormal"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeNormal"
    And Nelim's Pickle Tools: "Nelim" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-BrowNormal"
    When Nelim's Pickle Tools: "Nelim" brows are "AKN_BrowCourageous"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-AKN_BrowCourageous"
    When Nelim's Pickle Tools: "Nelim" brows are "AKN_BrowEmpathetic"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-AKN_BrowEmpathetic"
    When Nelim's Pickle Tools: "Nelim" brows are "AKN_BrowSwift"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-AKN_BrowSwift"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowEven"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-BrowEven"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowFurryMonobrow"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-BrowFurryMonobrow"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowFuzzy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-BrowFuzzy"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowNone"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-BrowNone"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowRaised"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-BrowRaised"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowSquare"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-BrowSquare"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowStreamer"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-BrowStreamer"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowThin"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-BrowThin"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowTriangle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-BrowTriangle"
    When Nelim's Pickle Tools: "Nelim" brows are "MonoBrow"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-MonoBrow"
    When Nelim's Pickle Tools: "Nelim" brows are "MonoScarredBrows"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "brow-MonoScarredBrows"

  Scenario: face-head-gallery-1: HeadNormal, HeadPointy, HeadSquare, Beauty, Beauty2 (all head shapes)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: "Nelim" face skin is "SkinNormal"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeNormal"
    And Nelim's Pickle Tools: "Nelim" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-HeadNormal"
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeadPointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-HeadPointy"
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeadSquare"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-HeadSquare"
    When Nelim's Pickle Tools: "Nelim" face head shape is "Beauty"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Beauty"
    When Nelim's Pickle Tools: "Nelim" face head shape is "Beauty2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Beauty2"

  Scenario: face-eyeball-swift: the EyeGenes3 eyeballs, Swift redone
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: "Nelim" face skin is "SkinNormal"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeNormal"
    And Nelim's Pickle Tools: "Nelim" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" eyeballs are "Courageous"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyeball-Courageous"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "Empathetic"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyeball-Empathetic"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "Swift"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyeball-Swift"
