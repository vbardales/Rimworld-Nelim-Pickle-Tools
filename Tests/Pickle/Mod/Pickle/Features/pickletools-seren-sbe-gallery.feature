@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
@requires:nelim.serenbiotechextended
Feature: The 12 body masks of Seren Biotech Extended, front and back, on Nelim and on a man

  Scenario: seren-sbe-gallery-1: SBE body masks on nelim, front (12 genes)
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
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    And Nelim's Pickle Tools: "Nelim" skin colour is rgb (70, 50, 80)
    And Nelim's Pickle Tools: "Nelim" is undressed
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_0"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_0-nelim-front"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_1"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_1-nelim-front"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_2"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_2-nelim-front"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_3"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_3-nelim-front"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_4"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_4-nelim-front"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_5"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_5-nelim-front"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_6"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_6-nelim-front"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_7"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_7-nelim-front"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_8"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_8-nelim-front"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_9"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_9-nelim-front"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_10"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_10-nelim-front"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_11"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_11-nelim-front"

  Scenario: seren-sbe-gallery-2: SBE body masks on nelim, back (12 genes)
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
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    And Nelim's Pickle Tools: "Nelim" skin colour is rgb (70, 50, 80)
    And Nelim's Pickle Tools: "Nelim" is undressed
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_0"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_0-nelim-back"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_1"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_1-nelim-back"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_2"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_2-nelim-back"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_3"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_3-nelim-back"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_4"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_4-nelim-back"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_5"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_5-nelim-back"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_6"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_6-nelim-back"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_7"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_7-nelim-back"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_8"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_8-nelim-back"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_9"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_9-nelim-back"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_10"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_10-nelim-back"
    When Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "SerenOriginalMask_11"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_11-nelim-back"

  Scenario: seren-sbe-gallery-3: SBE body masks on man, front (12 genes)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And a colonist "Mannequin" exists
    And Nelim's Pickle Tools: "Mannequin" gender is male
    And Nelim's Pickle Tools: "Mannequin" body type is Male
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Mannequin" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Mannequin" face tattoo is "none"
    And Nelim's Pickle Tools: "Mannequin" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Mannequin" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Mannequin" lids are "LidNormal"
    And Nelim's Pickle Tools: "Mannequin" face skin is "SkinNormal"
    And Nelim's Pickle Tools: "Mannequin" eyeballs are "EyeNormal"
    And Nelim's Pickle Tools: "Mannequin" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: "Mannequin" facial expression is "normal"
    And Nelim's Pickle Tools: "Mannequin" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    And Nelim's Pickle Tools: "Mannequin" skin colour is rgb (70, 50, 80)
    And Nelim's Pickle Tools: "Mannequin" is undressed
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_0"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_0-man-front"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_1"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_1-man-front"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_2"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_2-man-front"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_3"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_3-man-front"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_4"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_4-man-front"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_5"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_5-man-front"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_6"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_6-man-front"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_7"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_7-man-front"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_8"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_8-man-front"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_9"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_9-man-front"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_10"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_10-man-front"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_11"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_11-man-front"

  Scenario: seren-sbe-gallery-4: SBE body masks on man, back (12 genes)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And a colonist "Mannequin" exists
    And Nelim's Pickle Tools: "Mannequin" gender is male
    And Nelim's Pickle Tools: "Mannequin" body type is Male
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Mannequin" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Mannequin" face tattoo is "none"
    And Nelim's Pickle Tools: "Mannequin" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Mannequin" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Mannequin" lids are "LidNormal"
    And Nelim's Pickle Tools: "Mannequin" face skin is "SkinNormal"
    And Nelim's Pickle Tools: "Mannequin" eyeballs are "EyeNormal"
    And Nelim's Pickle Tools: "Mannequin" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: "Mannequin" facial expression is "normal"
    And Nelim's Pickle Tools: "Mannequin" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    And Nelim's Pickle Tools: "Mannequin" skin colour is rgb (70, 50, 80)
    And Nelim's Pickle Tools: "Mannequin" is undressed
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_0"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_0-man-back"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_1"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_1-man-back"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_2"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_2-man-back"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_3"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_3-man-back"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_4"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_4-man-back"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_5"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_5-man-back"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_6"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_6-man-back"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_7"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_7-man-back"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_8"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_8-man-back"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_9"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_9-man-back"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_10"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_10-man-back"
    When Nelim's Pickle Tools: "Mannequin" loses all genes
    And Nelim's Pickle Tools: "Mannequin" has the gene "SerenOriginalMask_11"
    And Nelim's Pickle Tools: "Mannequin" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodymask-SerenOriginalMask_11-man-back"

