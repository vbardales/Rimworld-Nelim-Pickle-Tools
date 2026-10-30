@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: One photograph per Facial Animation head shape (the head shape catalogue)

  Scenario: fa-head-gallery-1: head shapes 1 to 10 of 21
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
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" face head shape is "FurCoveredGaunt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-FurCoveredGaunt"
    When Nelim's Pickle Tools: "Nelim" face head shape is "FurCoveredHeavyJaw1"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-FurCoveredHeavyJaw1"
    When Nelim's Pickle Tools: "Nelim" face head shape is "FurCoveredHeavyJaw2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-FurCoveredHeavyJaw2"
    When Nelim's Pickle Tools: "Nelim" face head shape is "FurCoveredHeavyJaw3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-FurCoveredHeavyJaw3"
    When Nelim's Pickle Tools: "Nelim" face head shape is "Gaunt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-Gaunt"
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeavyJaw"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-HeavyJaw"
    When Nelim's Pickle Tools: "Nelim" face head shape is "Nose_Pig"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-Nose_Pig"
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-HeadNormal"
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeadPointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-HeadPointy"
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeadSquare"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-HeadSquare"

  Scenario: fa-head-gallery-2: head shapes 11 to 20 of 21
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
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" face head shape is "NVFA_FurskinAverage1"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-NVFA_FurskinAverage1"
    When Nelim's Pickle Tools: "Nelim" face head shape is "NVFA_FurskinAverage2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-NVFA_FurskinAverage2"
    When Nelim's Pickle Tools: "Nelim" face head shape is "NVFA_FurskinAverage3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-NVFA_FurskinAverage3"
    When Nelim's Pickle Tools: "Nelim" face head shape is "NVFA_FurskinNarrow1"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-NVFA_FurskinNarrow1"
    When Nelim's Pickle Tools: "Nelim" face head shape is "NVFA_FurskinNarrow2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-NVFA_FurskinNarrow2"
    When Nelim's Pickle Tools: "Nelim" face head shape is "NVFA_FurskinNarrow3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-NVFA_FurskinNarrow3"
    When Nelim's Pickle Tools: "Nelim" face head shape is "NVFA_Gaunt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-NVFA_Gaunt"
    When Nelim's Pickle Tools: "Nelim" face head shape is "NVFA_HeavyJaw"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-NVFA_HeavyJaw"
    When Nelim's Pickle Tools: "Nelim" face head shape is "FurCoveredAverage1"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-FurCoveredAverage1"
    When Nelim's Pickle Tools: "Nelim" face head shape is "FurCoveredAverage2"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-FurCoveredAverage2"

  Scenario: fa-head-gallery-3: head shapes 21 to 21 of 21
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
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" face head shape is "FurCoveredAverage3"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-FurCoveredAverage3"
