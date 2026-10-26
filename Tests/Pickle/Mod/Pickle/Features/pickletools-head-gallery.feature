@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: The male head types on a male pawn (the head catalogue)

  Scenario: head-gallery-1: male head types 1 to 9 of 9
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
    And Nelim's Pickle Tools: "Mannequin" face kit is "neutral"
    And Nelim's Pickle Tools: "Mannequin" facial expression is "normal"
    And Nelim's Pickle Tools: "Mannequin" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    And Nelim's Pickle Tools: the look of "Mannequin" is saved
    When Nelim's Pickle Tools: "Mannequin" head type is "DarkScholar_Male"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-DarkScholar_Male"
    And Nelim's Pickle Tools: the look of "Mannequin" is restored
    When Nelim's Pickle Tools: "Mannequin" head type is "Leathery_Male"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Leathery_Male"
    And Nelim's Pickle Tools: the look of "Mannequin" is restored
    When Nelim's Pickle Tools: "Mannequin" head type is "Male_HeavyJawNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_HeavyJawNormal"
    And Nelim's Pickle Tools: the look of "Mannequin" is restored
    When Nelim's Pickle Tools: "Mannequin" head type is "Male_AverageNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_AverageNormal"
    And Nelim's Pickle Tools: the look of "Mannequin" is restored
    When Nelim's Pickle Tools: "Mannequin" head type is "Male_AveragePointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_AveragePointy"
    And Nelim's Pickle Tools: the look of "Mannequin" is restored
    When Nelim's Pickle Tools: "Mannequin" head type is "Male_AverageWide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_AverageWide"
    And Nelim's Pickle Tools: the look of "Mannequin" is restored
    When Nelim's Pickle Tools: "Mannequin" head type is "Male_NarrowNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_NarrowNormal"
    And Nelim's Pickle Tools: the look of "Mannequin" is restored
    When Nelim's Pickle Tools: "Mannequin" head type is "Male_NarrowPointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_NarrowPointy"
    And Nelim's Pickle Tools: the look of "Mannequin" is restored
    When Nelim's Pickle Tools: "Mannequin" head type is "Male_NarrowWide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_NarrowWide"
