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

  Scenario: face-skin-closeup-1: the eight flagged skins, no lids, head framed at root size 1.6
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
    And Nelim's Pickle Tools: "Nelim" lids are "LidNone"
    And Nelim's Pickle Tools: "Nelim" face skin is "SkinNormal"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeNormal"
    And Nelim's Pickle Tools: "Nelim" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: the camera frames the head of "Nelim" at root size 1.6
    When Nelim's Pickle Tools: "Nelim" face skin is "AKN_SkinSnoot"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skinclose-AKN_SkinSnoot"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinLeftChin"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skinclose-SkinLeftChin"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinDecrepit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skinclose-SkinDecrepit"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFreckles2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skinclose-SkinFreckles2"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFreckles3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skinclose-SkinFreckles3"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFurrows"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skinclose-SkinFurrows"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinRightEye"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skinclose-SkinRightEye"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinTiredEyes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skinclose-SkinTiredEyes"

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

  Scenario: face-lid-gallery-1: BIGEYE to Biotech_Eyes_Beauty2 (all lids, from a normal face, lower priority)
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
    When Nelim's Pickle Tools: "Nelim" lids are "BIGEYE"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-BIGEYE"
    When Nelim's Pickle Tools: "Nelim" lids are "LidAlmond"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidAlmond"
    When Nelim's Pickle Tools: "Nelim" lids are "LidCheerful"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidCheerful"
    When Nelim's Pickle Tools: "Nelim" lids are "LidFlashy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidFlashy"
    When Nelim's Pickle Tools: "Nelim" lids are "LidFlirty"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidFlirty"
    When Nelim's Pickle Tools: "Nelim" lids are "LidHardened"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidHardened"
    When Nelim's Pickle Tools: "Nelim" lids are "LidNone"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidNone"
    When Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidNormal"
    When Nelim's Pickle Tools: "Nelim" lids are "LidPointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidPointy"
    When Nelim's Pickle Tools: "Nelim" lids are "LidQuite"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidQuite"
    When Nelim's Pickle Tools: "Nelim" lids are "LidShort"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidShort"
    When Nelim's Pickle Tools: "Nelim" lids are "LidSimple"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidSimple"
    When Nelim's Pickle Tools: "Nelim" lids are "LidSleepy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidSleepy"
    When Nelim's Pickle Tools: "Nelim" lids are "LidSquinting"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidSquinting"
    When Nelim's Pickle Tools: "Nelim" lids are "LidStuffed"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidStuffed"
    When Nelim's Pickle Tools: "Nelim" lids are "LidThick"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidThick"
    When Nelim's Pickle Tools: "Nelim" lids are "LidUnimpressed"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidUnimpressed"
    When Nelim's Pickle Tools: "Nelim" lids are "LidVK_ClosedEyes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidVK_ClosedEyes"
    When Nelim's Pickle Tools: "Nelim" lids are "LidVK_SmilingEyes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-LidVK_SmilingEyes"
    When Nelim's Pickle Tools: "Nelim" lids are "BionicBoth"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-BionicBoth"
    When Nelim's Pickle Tools: "Nelim" lids are "BionicLeft"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-BionicLeft"
    When Nelim's Pickle Tools: "Nelim" lids are "BionicRight"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-BionicRight"
    When Nelim's Pickle Tools: "Nelim" lids are "Biotech_Eyes_Beauty"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-Biotech_Eyes_Beauty"
    When Nelim's Pickle Tools: "Nelim" lids are "Biotech_Eyes_Beauty2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "lid-Biotech_Eyes_Beauty2"

  Scenario: face-tattoo-gallery-1: face tattoos 1 to 20 of 40 on a bald Nelim
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
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Tilak"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Tilak"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_Anima"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_Anima"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_Bisect"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_Bisect"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_BlackFangs"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_BlackFangs"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_BlueFangs"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_BlueFangs"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_BrowDots"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_BrowDots"

  Scenario: face-tattoo-gallery-2: face tattoos 21 to 40 of 40 on a bald Nelim
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
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_CheekDots"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_CheekDots"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_CheekStripes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_CheekStripes"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_MiddleDotsBlack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_MiddleDotsBlack"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_MiddleDotsBlue"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_MiddleDotsBlue"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_MiddleDotsRed"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_MiddleDotsRed"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_MiddleDotsWhite"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_MiddleDotsWhite"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripeBlack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripeBlack"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripeBlue"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripeBlue"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripePurple"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripePurple"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripeRed"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripeRed"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripeWhite"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripeWhite"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_RedFangs"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_RedFangs"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SacredAir"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SacredAir"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SacredFire"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SacredFire"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SacredGrass"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SacredGrass"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SacredWater"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SacredWater"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SunCrown"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SunCrown"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SunrisePlains"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SunrisePlains"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SunsetPlains"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SunsetPlains"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_WhiteFangs"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_WhiteFangs"

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
