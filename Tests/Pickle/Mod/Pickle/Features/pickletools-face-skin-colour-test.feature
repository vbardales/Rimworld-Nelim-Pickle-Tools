@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: The faint face skin marks on four skin colours

  Scenario: face-skin-colour-test-1-pale: 6 marks on the skin rgb (255, 244, 238)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeNormal"
    And Nelim's Pickle Tools: "Nelim" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" skin colour is rgb (255, 244, 238)
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinBruise"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-pale-SkinBruise"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinCheekbones"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-pale-SkinCheekbones"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFrownLines"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-pale-SkinFrownLines"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFurrows"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-pale-SkinFurrows"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinDecrepit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-pale-SkinDecrepit"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinCrowsFeet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-pale-SkinCrowsFeet"

  Scenario: face-skin-colour-test-2-tan: 6 marks on the skin rgb (222, 184, 150)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeNormal"
    And Nelim's Pickle Tools: "Nelim" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" skin colour is rgb (222, 184, 150)
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinBruise"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-tan-SkinBruise"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinCheekbones"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-tan-SkinCheekbones"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFrownLines"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-tan-SkinFrownLines"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFurrows"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-tan-SkinFurrows"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinDecrepit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-tan-SkinDecrepit"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinCrowsFeet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-tan-SkinCrowsFeet"

  Scenario: face-skin-colour-test-3-medium: 6 marks on the skin rgb (170, 120, 85)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeNormal"
    And Nelim's Pickle Tools: "Nelim" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" skin colour is rgb (170, 120, 85)
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinBruise"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-medium-SkinBruise"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinCheekbones"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-medium-SkinCheekbones"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFrownLines"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-medium-SkinFrownLines"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFurrows"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-medium-SkinFurrows"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinDecrepit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-medium-SkinDecrepit"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinCrowsFeet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-medium-SkinCrowsFeet"

  Scenario: face-skin-colour-test-4-dark: 6 marks on the skin rgb (100, 68, 50)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeNormal"
    And Nelim's Pickle Tools: "Nelim" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" skin colour is rgb (100, 68, 50)
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinBruise"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-dark-SkinBruise"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinCheekbones"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-dark-SkinCheekbones"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFrownLines"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-dark-SkinFrownLines"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinFurrows"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-dark-SkinFurrows"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinDecrepit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-dark-SkinDecrepit"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinCrowsFeet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "skintest-dark-SkinCrowsFeet"
