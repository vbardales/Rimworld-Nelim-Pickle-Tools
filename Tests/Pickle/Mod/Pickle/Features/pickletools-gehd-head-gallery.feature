@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: The ten head types of [LFS] Genes Expanded - Heads (the head catalogue)

  Scenario: gehd-heads-female: five female head types
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" head type is "GEHD_Amphibian_Female"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-GEHD_Amphibian_Female"
    And Nelim's Pickle Tools: "Nelim" head type is "GEHD_Insectoid_Female"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-GEHD_Insectoid_Female"
    And Nelim's Pickle Tools: "Nelim" head type is "GEHD_Rockey_Female"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-GEHD_Rockey_Female"
    And Nelim's Pickle Tools: "Nelim" head type is "GEHD_Scale_Female"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-GEHD_Scale_Female"
    And Nelim's Pickle Tools: "Nelim" head type is "GEHD_Slime_Female"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-GEHD_Slime_Female"

  Scenario: gehd-heads-male: five male head types
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: the other colonists are out of frame
    And a colonist "Mannequin" exists
    And Nelim's Pickle Tools: "Mannequin" gender is male
    And Nelim's Pickle Tools: "Mannequin" body type is Male
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Mannequin" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Mannequin" wears "Apparel_BasicShirt"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Mannequin" head type is "GEHD_Amphibian_Male"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-GEHD_Amphibian_Male"
    And Nelim's Pickle Tools: "Mannequin" head type is "GEHD_Insectoid_Male"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-GEHD_Insectoid_Male"
    And Nelim's Pickle Tools: "Mannequin" head type is "GEHD_Rockey_Male"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-GEHD_Rockey_Male"
    And Nelim's Pickle Tools: "Mannequin" head type is "GEHD_Scale_Male"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-GEHD_Scale_Male"
    And Nelim's Pickle Tools: "Mannequin" head type is "GEHD_Slime_Male"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-GEHD_Slime_Male"
