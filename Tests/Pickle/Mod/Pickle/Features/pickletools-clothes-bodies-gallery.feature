@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Lower-body garments of Lisa's Work and [LTS] Raiments on the Hulk and Fat bodies (NSB request 2026-11-04): no underwear base, it hides the LTS trousers

  Scenario: clothes-bodies-hulk-1: ten garments on Jiro (Hulk)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (180, 121) facing South
    And Nelim's Pickle Tools: a colonist "Jiro" of kind "Colonist" exists
    And Nelim's Pickle Tools: "Jiro" loses all genes
    And Nelim's Pickle Tools: "Jiro" gender is Male
    And "Jiro" is 40 years old
    And Nelim's Pickle Tools: "Jiro" body type is Hulk
    And Nelim's Pickle Tools: "Jiro" head type is "Male_AverageNormal"
    And Nelim's Pickle Tools: "Jiro" has the gene "Skin_Melanin3"
    And Nelim's Pickle Tools: "Jiro" has the gene "Hair_DarkBrown"
    And Nelim's Pickle Tools: "Jiro" hair colour is taken from its genes
    And Nelim's Pickle Tools: "Jiro" hairstyle is "Shaved"
    And Nelim's Pickle Tools: "Jiro" face tattoo is "none"
    And Nelim's Pickle Tools: "Jiro" body tattoo is "none"
    And Nelim's Pickle Tools: "Jiro" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Jiro" is undressed
    And Nelim's Pickle Tools: "Jiro" wears "LisaWork_ApparelPantsAndBelt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-hulk-LisaWork_ApparelPantsAndBelt"
    And Nelim's Pickle Tools: "Jiro" is undressed
    And Nelim's Pickle Tools: "Jiro" wears "LisaWork_ApparelCoveralls"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-hulk-LisaWork_ApparelCoveralls"
    And Nelim's Pickle Tools: "Jiro" is undressed
    And Nelim's Pickle Tools: "Jiro" wears "LisaWork_ApparelPoliceSkirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-hulk-LisaWork_ApparelPoliceSkirt"
    And Nelim's Pickle Tools: "Jiro" is undressed
    And Nelim's Pickle Tools: "Jiro" wears "LisaWork_ApparelBankerPants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-hulk-LisaWork_ApparelBankerPants"
    And Nelim's Pickle Tools: "Jiro" is undressed
    And Nelim's Pickle Tools: "Jiro" wears "LTS_Skirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-hulk-LTS_Skirt"
    And Nelim's Pickle Tools: "Jiro" is undressed
    And Nelim's Pickle Tools: "Jiro" wears "LTS_Dresspants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-hulk-LTS_Dresspants"
    And Nelim's Pickle Tools: "Jiro" is undressed
    And Nelim's Pickle Tools: "Jiro" wears "LTS_Shorts"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-hulk-LTS_Shorts"
    And Nelim's Pickle Tools: "Jiro" is undressed
    And Nelim's Pickle Tools: "Jiro" wears "LTS_StraightDress"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-hulk-LTS_StraightDress"
    And Nelim's Pickle Tools: "Jiro" is undressed
    And Nelim's Pickle Tools: "Jiro" wears "LTS_Tunika"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-hulk-LTS_Tunika"
    And Nelim's Pickle Tools: "Jiro" is undressed
    And Nelim's Pickle Tools: "Jiro" wears "LisaWork_ApparelPioneerDress"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-hulk-LisaWork_ApparelPioneerDress"

  Scenario: clothes-bodies-fat-1: ten garments on Vesper (Fat)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (180, 121) facing South
    And Nelim's Pickle Tools: a colonist "Vesper" of kind "Colonist" exists
    And Nelim's Pickle Tools: "Vesper" loses all genes
    And Nelim's Pickle Tools: "Vesper" gender is Female
    And "Vesper" is 40 years old
    And Nelim's Pickle Tools: "Vesper" body type is Fat
    And Nelim's Pickle Tools: "Vesper" head type is "Female_AverageNormal"
    And Nelim's Pickle Tools: "Vesper" has the gene "Skin_Melanin3"
    And Nelim's Pickle Tools: "Vesper" has the gene "Hair_DarkBrown"
    And Nelim's Pickle Tools: "Vesper" hair colour is taken from its genes
    And Nelim's Pickle Tools: "Vesper" hairstyle is "Bob"
    And Nelim's Pickle Tools: "Vesper" face tattoo is "none"
    And Nelim's Pickle Tools: "Vesper" body tattoo is "none"
    And Nelim's Pickle Tools: "Vesper" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Vesper" is undressed
    And Nelim's Pickle Tools: "Vesper" wears "LisaWork_ApparelPantsAndBelt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-fat-LisaWork_ApparelPantsAndBelt"
    And Nelim's Pickle Tools: "Vesper" is undressed
    And Nelim's Pickle Tools: "Vesper" wears "LisaWork_ApparelCoveralls"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-fat-LisaWork_ApparelCoveralls"
    And Nelim's Pickle Tools: "Vesper" is undressed
    And Nelim's Pickle Tools: "Vesper" wears "LisaWork_ApparelPoliceSkirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-fat-LisaWork_ApparelPoliceSkirt"
    And Nelim's Pickle Tools: "Vesper" is undressed
    And Nelim's Pickle Tools: "Vesper" wears "LisaWork_ApparelBankerPants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-fat-LisaWork_ApparelBankerPants"
    And Nelim's Pickle Tools: "Vesper" is undressed
    And Nelim's Pickle Tools: "Vesper" wears "LTS_Skirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-fat-LTS_Skirt"
    And Nelim's Pickle Tools: "Vesper" is undressed
    And Nelim's Pickle Tools: "Vesper" wears "LTS_Dresspants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-fat-LTS_Dresspants"
    And Nelim's Pickle Tools: "Vesper" is undressed
    And Nelim's Pickle Tools: "Vesper" wears "LTS_Shorts"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-fat-LTS_Shorts"
    And Nelim's Pickle Tools: "Vesper" is undressed
    And Nelim's Pickle Tools: "Vesper" wears "LTS_StraightDress"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-fat-LTS_StraightDress"
    And Nelim's Pickle Tools: "Vesper" is undressed
    And Nelim's Pickle Tools: "Vesper" wears "LTS_Tunika"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-fat-LTS_Tunika"
    And Nelim's Pickle Tools: "Vesper" is undressed
    And Nelim's Pickle Tools: "Vesper" wears "LisaWork_ApparelPioneerDress"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodygarment-fat-LisaWork_ApparelPioneerDress"
