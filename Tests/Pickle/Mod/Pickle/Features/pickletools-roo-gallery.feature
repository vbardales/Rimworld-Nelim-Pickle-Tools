@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: One photograph per tattoo and birthmark of Roo's two mods on Nelim (look catalogue, Roo)

  Scenario: roo-gallery-1: facetattoo 1 to 20 of 40
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
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBAcneA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBAcneA"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBAcneB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBAcneB"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBAcneScars"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBAcneScars"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBBirthmarkA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBBirthmarkA"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBBirthmarkB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBBirthmarkB"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBBirthmarkC"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBBirthmarkC"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBBirthmarkD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBBirthmarkD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBBirthmarkE"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBBirthmarkE"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBBlushA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBBlushA"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBBlushB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBBlushB"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBChinDimple"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBChinDimple"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBDimples"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBDimples"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBDoubleChin"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBDoubleChin"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBEyeBags"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBEyeBags"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBEyelashes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBEyelashes"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBFrecklesA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBFrecklesA"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBFrecklesB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBFrecklesB"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBKisses"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBKisses"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBMakeup"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBMakeup"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBMolesA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBMolesA"

  Scenario: roo-gallery-2: facetattoo 21 to 40 of 40
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
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBMolesB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBMolesB"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBPsoriasis"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBPsoriasis"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBStitches"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBStitches"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBVitiligoA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBVitiligoA"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBVitiligoB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBVitiligoB"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBWrinkleA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBWrinkleA"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "RBWrinkleB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-RBWrinkleB"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Backface"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Backface"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Elemental"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Elemental"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Eyebrows"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Eyebrows"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Hairfade"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Hairfade"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Joker"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Joker"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Kabuki"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Kabuki"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Lipstick"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Lipstick"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Necromancer"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Necromancer"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Oni"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Oni"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Piercings"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Piercings"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Sixeyes"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Sixeyes"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Sniper"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Sniper"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" face tattoo is "Face_Thirdeye"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "facetattoo-Face_Thirdeye"

  Scenario: roo-gallery-3: bodytattoo 1 to 16 of 31
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" body tattoo is "RBBirthmarkBodyA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBBirthmarkBodyA"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "RBBirthmarkBodyB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBBirthmarkBodyB"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "RBBirthmarkBodyC"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBBirthmarkBodyC"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "RBLightningScars"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBLightningScars"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "RBMolesBodyA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyA"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "RBMolesBodyB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyB"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "RBMolesBodyC"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyC"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "RBMolesBodyD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyD"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "RBMolesBodyE"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyE"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "RBPsoriasisBody"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBPsoriasisBody"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "RBStitchesBodyA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBStitchesBodyA"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "RBStitchesBodyB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBStitchesBodyB"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "RBStretchMarksBody"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBStretchMarksBody"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "RBVitiligoBody"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBVitiligoBody"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Barcode"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Barcode"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Cassandra"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Cassandra"

  Scenario: roo-gallery-4: bodytattoo 17 to 31 of 31
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Chesttext"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Chesttext"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_DarkPsycaster"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_DarkPsycaster"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Fullbody"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Fullbody"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Kitsune"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Kitsune"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Lancaster"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Lancaster"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Nonipples"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Nonipples"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Oni"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Oni"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Phoebe"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Phoebe"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Randy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Randy"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Rave"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Rave"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Ribcage"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Ribcage"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Soulmateleft"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Soulmateleft"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Soulmateright"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Soulmateright"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Yakuza"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Yakuza"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Yorkshire"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Yorkshire"
