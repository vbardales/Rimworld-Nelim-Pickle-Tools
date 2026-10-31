@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Probe of the Anomaly part pack for Facial Animation (DEV Genetic Heads Framework): does a part set by name show without a creepjoiner?

  Scenario: anomaly-probe-1: the 5 Anomaly heads
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
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeadLeatheryStranger"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-HeadLeatheryStranger"
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeadCultEscapee"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-HeadCultEscapee"
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeadGhoulNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-HeadGhoulNormal"
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeadGhoulHeavy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-HeadGhoulHeavy"
    When Nelim's Pickle Tools: "Nelim" face head shape is "HeadGhoulWide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "fahead-HeadGhoulWide"

  Scenario: anomaly-probe-2: one eyeball, lid, brow, mouth and skin
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
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" eyeballs are "EyeGhoulNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "anomalypart-EyeGhoulNormal"
    When Nelim's Pickle Tools: "Nelim" lids are "LidGhoulNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "anomalypart-LidGhoulNormal"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowDarkScholar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "anomalypart-BrowDarkScholar"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthGhoulFrown"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "anomalypart-MouthGhoulFrown"
    When Nelim's Pickle Tools: "Nelim" face skin is "SkinDarkScholar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "anomalypart-SkinDarkScholar"

  Scenario: anomaly-probe-3: the head the framework picks by itself when Nelim is a ghoul
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
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" has the hediff "Ghoul"
    And Nelim's Pickle Tools: I let 30 frames pass
    And I take a screenshot "anomalypart-ghoul-auto"

