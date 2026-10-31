@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Four race mods before the owner unsubscribes: Charmweavers, Molong and Frilleum, one photograph per visual item

  Scenario: races-gallery-1: Charmweavers genes and slave outfit on Nelim
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "RS_Skin_PaleGreen"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-RS_Skin_PaleGreen"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "RS_Headbone_RamHorns"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-RS_Headbone_RamHorns"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "RS_Headbone_MediumHorns"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-RS_Headbone_MediumHorns"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "RS_Headbone_LargeHorns"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-RS_Headbone_LargeHorns"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "RS_Wing_Batlike"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-RS_Wing_Batlike"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "RS_Tail_Spiked"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-RS_Tail_Spiked"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "RS_Eyes_Pink"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-RS_Eyes_Pink"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" wears "RS_Apparel_SlaveOutfit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-RS_Apparel_SlaveOutfit"

  Scenario: races-gallery-2: Molong genes on Nelim
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "GS_Headbone_Skinhorns"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-GS_Headbone_Skinhorns"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "GS_Ears_MFiend"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-GS_Ears_MFiend"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "GS_TigerEyeGene"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-GS_TigerEyeGene"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "GS_FiendHead"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-GS_FiendHead"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "GS_BigNose"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-GS_BigNose"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "GS_Skin_VRed"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-GS_Skin_VRed"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "GS_Skin_VBlue"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-GS_Skin_VBlue"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "GS_Skin_VYellow"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-GS_Skin_VYellow"

  Scenario: races-gallery-3: Frilleum garments 1 to 12 of 23 on a Frilleum colonist
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: a colonist "Fril" of kind "FrilleumColonistB" exists
    And Nelim's Pickle Tools: "Fril" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Fril" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Fril" face tattoo is "none"
    And Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillPantsA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillPantsA"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillPantsB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillPantsB"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillShirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillShirt"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillCoatG"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillCoatG"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillCoatP"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillCoatP"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillCoatR"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillCoatR"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillScapula"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillScapula"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillSmock"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillSmock"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillBrigandine"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillBrigandine"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillGambeson"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillGambeson"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillTricorn"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillTricorn"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillHelmet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillHelmet"

  Scenario: races-gallery-4: Frilleum garments 13 to 23 of 23 on a Frilleum colonist
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: a colonist "Fril" of kind "FrilleumColonistB" exists
    And Nelim's Pickle Tools: "Fril" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Fril" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Fril" face tattoo is "none"
    And Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillDoublet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillDoublet"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillCourtlyBreeches"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillCourtlyBreeches"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillGown"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillGown"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillCorset"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillCorset"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillFeatherCloak"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillFeatherCloak"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillRobe"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillRobe"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillRoyalArmor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillRoyalArmor"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillCirclet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillCirclet"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillCircletGem"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillCircletGem"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillDiadem"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillDiadem"
    When Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: "Fril" wears "Apparel_FrillCrown"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Apparel_FrillCrown"

  Scenario: races-gallery-5: Frilleum head types on a Frilleum colonist
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: a colonist "Fril" of kind "FrilleumColonistB" exists
    And Nelim's Pickle Tools: "Fril" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Fril" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Fril" face tattoo is "none"
    And Nelim's Pickle Tools: "Fril" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Fril" head type is "FrilleumSkull"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-FrilleumSkull"
    When Nelim's Pickle Tools: "Fril" head type is "FrilleumFaceA"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-FrilleumFaceA"
    When Nelim's Pickle Tools: "Fril" head type is "FrilleumFaceB"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-FrilleumFaceB"
    When Nelim's Pickle Tools: "Fril" head type is "FrilleumFaceC"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-FrilleumFaceC"

  Scenario: races-gallery-6: Frilleum drakes and the shellox
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: the other colonists are out of frame
    Given Nelim's Pickle Tools: an adult animal of kind "IceDrake" named "IceDrake1" is spawned at (170, 126)
    When Nelim's Pickle Tools: I frame the animal "IceDrake1" at zoom 2
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-IceDrake"
    Given Nelim's Pickle Tools: an adult animal of kind "ShieldDrake" named "ShieldDrake1" is spawned at (172, 126)
    When Nelim's Pickle Tools: I frame the animal "ShieldDrake1" at zoom 2
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-ShieldDrake"
    Given Nelim's Pickle Tools: an adult animal of kind "TundraDrake" named "TundraDrake1" is spawned at (174, 126)
    When Nelim's Pickle Tools: I frame the animal "TundraDrake1" at zoom 2
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-TundraDrake"
    Given Nelim's Pickle Tools: an adult animal of kind "Shellox" named "Shellox1" is spawned at (178, 126)
    When Nelim's Pickle Tools: I frame the animal "Shellox1" at zoom 2
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-Shellox"

  Scenario: races-gallery-7: Papou genes 1 to 10 of 19 on Nelim
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoBody1"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoBody1"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoBody2"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoBody2"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoTail"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoTail"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoWing0"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoWing0"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoWing1"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoWing1"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoWing2"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoWing2"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoWing3"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoWing3"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoWing4"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoWing4"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoSkinColor1"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoSkinColor1"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoSkinColor2"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoSkinColor2"

  Scenario: races-gallery-8: Papou genes 11 to 19 of 19 on Nelim
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoHairRed"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoHairRed"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoHairYellow"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoHairYellow"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoCheek0"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoCheek0"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoCheek1"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoCheek1"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoEar0"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoEar0"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoEar1"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoEar1"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoEar2"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoEar2"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoEar3"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoEar3"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "papagoEar4"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "race-papagoEar4"

