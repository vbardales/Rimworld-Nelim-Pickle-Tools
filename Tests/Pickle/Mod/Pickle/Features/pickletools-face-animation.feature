@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Short photo sequences of the face parts, for animated sheets (a blink, a smile, brows)

  Scenario: face-animation-blink: 5 frames of a blink
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
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" lids are "LidSimple"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-blink-1-LidSimple"
    When Nelim's Pickle Tools: "Nelim" lids are "LidSleepy"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-blink-2-LidSleepy"
    When Nelim's Pickle Tools: "Nelim" lids are "LidVK_ClosedEyes"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-blink-3-LidVK_ClosedEyes"
    When Nelim's Pickle Tools: "Nelim" lids are "LidSleepy"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-blink-4-LidSleepy"
    When Nelim's Pickle Tools: "Nelim" lids are "LidSimple"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-blink-5-LidSimple"

  Scenario: face-animation-smile: 5 frames of a smile
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
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthSimpleMouth"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-smile-1-MouthSimpleMouth"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsTinySmile"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-smile-2-MouthLipsTinySmile"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmallSmile"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-smile-3-MouthLipsSmallSmile"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsTinySmile"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-smile-4-MouthLipsTinySmile"
    When Nelim's Pickle Tools: "Nelim" mouth is "MouthSimpleMouth"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-smile-5-MouthSimpleMouth"

  Scenario: face-animation-brows: 5 frames of a brows
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
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-brows-1-BrowNormal"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowRaised"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-brows-2-BrowRaised"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowTriangle"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-brows-3-BrowTriangle"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowRaised"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-brows-4-BrowRaised"
    When Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: I let 4 frames pass
    And I take a screenshot "anim-brows-5-BrowNormal"
