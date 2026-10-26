@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Profile of every face tattoo on a bald Nelim (side view of the face tattoo gallery)

  Scenario: face-tattoo-side-gallery-1: profile of face tattoos 1 to 20 of 40 on a bald Nelim
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing East
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
    And I take a screenshot "facetattoo-NoTattoo_Face-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Cobweb"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Cobweb-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Eclipse"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Eclipse-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Headshot"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Headshot-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Line"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Line-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Love"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Love-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Oracle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Oracle-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Pantheon"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Pantheon-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Spider"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Spider-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Stars"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Stars-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Tear"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Tear-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Tiger"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Tiger-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Warpaint"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Warpaint-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Worried"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Worried-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Tilak"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Tilak-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_Anima"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_Anima-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_Bisect"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_Bisect-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_BlackFangs"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_BlackFangs-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_BlueFangs"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_BlueFangs-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_BrowDots"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_BrowDots-side"

  Scenario: face-tattoo-side-gallery-2: profile of face tattoos 21 to 40 of 40 on a bald Nelim
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing East
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
    And I take a screenshot "facetattoo-STribalTat_Face_CheekDots-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_CheekStripes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_CheekStripes-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_MiddleDotsBlack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_MiddleDotsBlack-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_MiddleDotsBlue"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_MiddleDotsBlue-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_MiddleDotsRed"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_MiddleDotsRed-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_MiddleDotsWhite"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_MiddleDotsWhite-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripeBlack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripeBlack-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripeBlue"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripeBlue-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripePurple"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripePurple-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripeRed"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripeRed-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_NoseStripeWhite"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_NoseStripeWhite-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_RedFangs"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_RedFangs-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SacredAir"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SacredAir-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SacredFire"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SacredFire-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SacredGrass"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SacredGrass-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SacredWater"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SacredWater-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SunCrown"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SunCrown-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SunrisePlains"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SunrisePlains-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_SunsetPlains"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_SunsetPlains-side"
    When Nelim's Pickle Tools: "Nelim" face tattoo is "STribalTat_Face_WhiteFangs"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-STribalTat_Face_WhiteFangs-side"

