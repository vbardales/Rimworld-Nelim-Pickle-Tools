@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: One photograph per face part of Seren (Experimentals set) and the whole Seren pawn, female and male (the Seren catalogues)

  Scenario: seren-face-gallery-1: face parts: 3 heads, 7 lids, 4 eyeballs, 2 brows, 2 mouths
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
    And Nelim's Pickle Tools: "Nelim" xenotype is "OL_SerenBase"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" mouth is "SerenMouthNormal"
    And Nelim's Pickle Tools: "Nelim" brows are "SerenBrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "SerenLidNormal"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "SerenEyesNormal"
    And Nelim's Pickle Tools: "Nelim" face head shape is "SerenHeadNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" face head shape is "SerenHeadNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-head-SerenHeadNormal"
    When Nelim's Pickle Tools: "Nelim" face head shape is "SerenHeadPointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-head-SerenHeadPointy"
    When Nelim's Pickle Tools: "Nelim" face head shape is "SerenHeadSquare"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-head-SerenHeadSquare"
    When Nelim's Pickle Tools: "Nelim" lids are "SerenLidNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-lid-SerenLidNormal"
    When Nelim's Pickle Tools: "Nelim" lids are "SerenLidGeek"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-lid-SerenLidGeek"
    When Nelim's Pickle Tools: "Nelim" lids are "SerenLidPointy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-lid-SerenLidPointy"
    When Nelim's Pickle Tools: "Nelim" lids are "SerenLidFlashy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-lid-SerenLidFlashy"
    When Nelim's Pickle Tools: "Nelim" lids are "SerenLidQuite"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-lid-SerenLidQuite"
    When Nelim's Pickle Tools: "Nelim" lids are "SerenLidSleepy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-lid-SerenLidSleepy"
    When Nelim's Pickle Tools: "Nelim" lids are "SerenLidSharp"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-lid-SerenLidSharp"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "SerenEyesNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-eyeball-SerenEyesNormal"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "SerenEyesDull"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-eyeball-SerenEyesDull"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "SerenEyesIntense"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-eyeball-SerenEyesIntense"
    When Nelim's Pickle Tools: "Nelim" eyeballs are "SerenEyesEmpty"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-eyeball-SerenEyesEmpty"
    When Nelim's Pickle Tools: "Nelim" brows are "SerenBrowNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-brow-SerenBrowNormal"
    When Nelim's Pickle Tools: "Nelim" brows are "SerenBrowThick"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-brow-SerenBrowThick"
    When Nelim's Pickle Tools: "Nelim" mouth is "SerenMouthNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-mouth-SerenMouthNormal"
    When Nelim's Pickle Tools: "Nelim" mouth is "SerenMouthHappy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-mouth-SerenMouthHappy"

  Scenario: seren-face-gallery-2: face skins: 7 marking skins
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
    And Nelim's Pickle Tools: "Nelim" xenotype is "OL_SerenBase"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" mouth is "SerenMouthNormal"
    And Nelim's Pickle Tools: "Nelim" brows are "SerenBrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "SerenLidNormal"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "SerenEyesNormal"
    And Nelim's Pickle Tools: "Nelim" face head shape is "SerenHeadNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" face skin is "SerenBrows"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-skin-SerenBrows"
    When Nelim's Pickle Tools: "Nelim" face skin is "SerenCenterLarge"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-skin-SerenCenterLarge"
    When Nelim's Pickle Tools: "Nelim" face skin is "SerenCenterSmall"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-skin-SerenCenterSmall"
    When Nelim's Pickle Tools: "Nelim" face skin is "SerenCheeks"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-skin-SerenCheeks"
    When Nelim's Pickle Tools: "Nelim" face skin is "SerenFreckles"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-skin-SerenFreckles"
    When Nelim's Pickle Tools: "Nelim" face skin is "SerenTarget"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-skin-SerenTarget"
    When Nelim's Pickle Tools: "Nelim" face skin is "SerenTriStar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-skin-SerenTriStar"

  Scenario: seren-face-gallery-3: VTE brow: OL_SerenBrowNone
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
    And Nelim's Pickle Tools: "Nelim" xenotype is "OL_SerenBase"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" brows are "OL_SerenBrowNone"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-brow-OL_SerenBrowNone"

  Scenario: seren-face-gallery-4: the whole Seren pawn: Nelim
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
    And Nelim's Pickle Tools: "Nelim" xenotype is "OL_SerenBase"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-xeno-Nelim-front"
    When Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-xeno-Nelim-side"
    When Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-xeno-Nelim-back"

  Scenario: seren-face-gallery-5: the whole Seren pawn: Soren
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And a colonist "Soren" exists
    And "Soren" is 30 years old
    And Nelim's Pickle Tools: "Soren" gender is male
    And Nelim's Pickle Tools: "Soren" body type is Male
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" xenotype is "OL_SerenBase"
    And Nelim's Pickle Tools: "Soren" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Soren" face tattoo is "none"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-xeno-man-front"
    When Nelim's Pickle Tools: "Soren" stands at (176, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-xeno-man-side"
    When Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "seren-xeno-man-back"
