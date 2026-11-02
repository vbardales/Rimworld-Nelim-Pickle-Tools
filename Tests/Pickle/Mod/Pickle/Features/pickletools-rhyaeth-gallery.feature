@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: One photograph pair per body part gene of Erin's Rhy'aeth (south and north, every other gene removed first)

  Scenario: rhyaeth-gallery-1: body part genes ERN_RhyaethEars to ERN_RhyaethTail_Frilled (10)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
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
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethEars"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethEars-south"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethEars-north"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethFaceFrills"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethFaceFrills-south"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethFaceFrills-north"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethFaceHorns"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethFaceHorns-south"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethFaceHorns-north"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethFaceWhiskers"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethFaceWhiskers-south"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethFaceWhiskers-north"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethHead"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethHead-south"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethHead-north"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethBrokenHorns"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethBrokenHorns-south"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethBrokenHorns-north"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethCurvedHorns"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethCurvedHorns-south"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethCurvedHorns-north"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethRamHorns"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethRamHorns-south"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethRamHorns-north"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethTallHorns"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethTallHorns-south"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethTallHorns-north"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethTail_Frilled"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethTail_Frilled-south"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethTail_Frilled-north"

  Scenario: rhyaeth-gallery-2: body part genes ERN_RhyaethTail_Simple to ERN_RhyaethWings (4)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
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
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethTail_Simple"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethTail_Simple-south"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethTail_Simple-north"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethTail_Spade"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethTail_Spade-south"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethTail_Spade-north"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethTail_Spiked"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethTail_Spiked-south"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethTail_Spiked-north"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethWings"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethWings-south"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethWings-north"

  Scenario: rhyaeth-gallery-scales: scale colour genes (10)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
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
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethBlackScales"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethBlackScales-south"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethBlueScales"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethBlueScales-south"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethBronzeScales"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethBronzeScales-south"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethCopperScales"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethCopperScales-south"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethGoldScales"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethGoldScales-south"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethGreenScales"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethGreenScales-south"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethPurpleScales"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethPurpleScales-south"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethRedScales"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethRedScales-south"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethSilverScales"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethSilverScales-south"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "ERN_RhyaethWhiteScales"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "rhygene-ERN_RhyaethWhiteScales-south"
