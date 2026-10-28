@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Profile of every face tattoo and birthmark of Roo's two mods on a bald Nelim

  Scenario: roo-face-side-gallery-1: profile of facetattoo 1 to 20 of 40
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
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBAcneA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBAcneA-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBAcneB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBAcneB-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBAcneScars"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBAcneScars-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBBirthmarkA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBBirthmarkA-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBBirthmarkB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBBirthmarkB-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBBirthmarkC"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBBirthmarkC-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBBirthmarkD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBBirthmarkD-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBBirthmarkE"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBBirthmarkE-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBBlushA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBBlushA-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBBlushB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBBlushB-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBChinDimple"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBChinDimple-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBDimples"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBDimples-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBDoubleChin"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBDoubleChin-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBEyeBags"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBEyeBags-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBEyelashes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBEyelashes-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBFrecklesA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBFrecklesA-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBFrecklesB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBFrecklesB-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBKisses"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBKisses-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBMakeup"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBMakeup-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBMolesA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBMolesA-side"

  Scenario: roo-face-side-gallery-2: profile of facetattoo 21 to 40 of 40
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
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBMolesB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBMolesB-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBPsoriasis"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBPsoriasis-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBStitches"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBStitches-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBVitiligoA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBVitiligoA-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBVitiligoB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBVitiligoB-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBWrinkleA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBWrinkleA-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBWrinkleB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBWrinkleB-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Backface"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Backface-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Elemental"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Elemental-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Eyebrows"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Eyebrows-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Hairfade"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Hairfade-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Joker"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Joker-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Kabuki"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Kabuki-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Lipstick"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Lipstick-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Necromancer"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Necromancer-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Oni"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Oni-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Piercings"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Piercings-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Sixeyes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Sixeyes-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Sniper"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Sniper-side"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Thirdeye"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Thirdeye-side"

