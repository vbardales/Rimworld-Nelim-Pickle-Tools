@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: The vanilla head types on a bald pawn, on a map without Facial Animation (the head catalogue)

  Scenario: vanilla-head-gallery-male-1: male head types 1 to 9 of 9
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
    And Nelim's Pickle Tools: "Mannequin" face tattoo is "none"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Mannequin" head type is "DarkScholar_Male"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-DarkScholar_Male"
    When Nelim's Pickle Tools: "Mannequin" head type is "Leathery_Male"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Leathery_Male"
    When Nelim's Pickle Tools: "Mannequin" head type is "Male_HeavyJawNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_HeavyJawNormal"
    When Nelim's Pickle Tools: "Mannequin" head type is "Male_AverageNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_AverageNormal"
    When Nelim's Pickle Tools: "Mannequin" head type is "Male_AveragePointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_AveragePointy"
    When Nelim's Pickle Tools: "Mannequin" head type is "Male_AverageWide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_AverageWide"
    When Nelim's Pickle Tools: "Mannequin" head type is "Male_NarrowNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_NarrowNormal"
    When Nelim's Pickle Tools: "Mannequin" head type is "Male_NarrowPointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_NarrowPointy"
    When Nelim's Pickle Tools: "Mannequin" head type is "Male_NarrowWide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Male_NarrowWide"

  Scenario: vanilla-head-gallery-other-1: other head types 1 to 10 of 29
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
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" head type is "---"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head----"
    When Nelim's Pickle Tools: "Nelim" head type is "CultEscapee"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-CultEscapee"
    When Nelim's Pickle Tools: "Nelim" head type is "DarkScholar_Female"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-DarkScholar_Female"
    When Nelim's Pickle Tools: "Nelim" head type is "Ghoul_Heavy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Ghoul_Heavy"
    When Nelim's Pickle Tools: "Nelim" head type is "Ghoul_Narrow"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Ghoul_Narrow"
    When Nelim's Pickle Tools: "Nelim" head type is "Ghoul_Normal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Ghoul_Normal"
    When Nelim's Pickle Tools: "Nelim" head type is "Ghoul_Wide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Ghoul_Wide"
    When Nelim's Pickle Tools: "Nelim" head type is "Leathery_Female"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Leathery_Female"
    When Nelim's Pickle Tools: "Nelim" head type is "TimelessOne"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-TimelessOne"
    When Nelim's Pickle Tools: "Nelim" head type is "Female_HeavyJawNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_HeavyJawNormal"

  Scenario: vanilla-head-gallery-other-2: other head types 11 to 20 of 29
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
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Average1"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Average1"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Average2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Average2"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Average3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Average3"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Gaunt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Gaunt"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Heavy1"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Heavy1"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Heavy2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Heavy2"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Heavy3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Heavy3"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Narrow1"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Narrow1"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Narrow2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Narrow2"
    When Nelim's Pickle Tools: "Nelim" head type is "Furskin_Narrow3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Furskin_Narrow3"

  Scenario: vanilla-head-gallery-other-3: other head types 21 to 29 of 29
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
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" head type is "Gaunt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Gaunt"
    When Nelim's Pickle Tools: "Nelim" head type is "Female_AverageNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_AverageNormal"
    When Nelim's Pickle Tools: "Nelim" head type is "Female_AveragePointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_AveragePointy"
    When Nelim's Pickle Tools: "Nelim" head type is "Female_AverageWide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_AverageWide"
    When Nelim's Pickle Tools: "Nelim" head type is "Female_NarrowNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_NarrowNormal"
    When Nelim's Pickle Tools: "Nelim" head type is "Female_NarrowPointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_NarrowPointy"
    When Nelim's Pickle Tools: "Nelim" head type is "Female_NarrowWide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Female_NarrowWide"
    When Nelim's Pickle Tools: "Nelim" head type is "Skull"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Skull"
    When Nelim's Pickle Tools: "Nelim" head type is "Stump"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "head-Stump"
