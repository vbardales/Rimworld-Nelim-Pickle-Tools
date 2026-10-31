@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
# (copied from SerenBiotechExtended/Tests/Pickle/Mod/Pickle/Features/13-original-reference.feature, 2026-10-31, run under PickleTools because the SBE launcher always stages the fork) Reference photographs of the ORIGINAL Seren mod (HAR race, no Realistic Bodies, no Facial Animation): how its body mask 6 draws on a body, front, side and back, to compare with the ported mask of this mod. Map wsl-deps.seren-original.map. Scenario 1 is a probe: list the pawn's HAR addons, force body mask 6, one photograph.
Feature: Original Seren body mask 6

  Scenario: seren-reference-1: probe, the HAR addons of an original Seren, mask 6 forced, front
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: a colonist "Orig" of kind "SerenRefugee" exists
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: the alien addons of "Orig" are listed
    And Nelim's Pickle Tools: "Orig" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Orig" alien body mask variant is 6
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-mask-6-south"

  Scenario: seren-reference-2: original Seren body type Thin, masks 5 and 6, South East North
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: a colonist "Orig" of kind "SerenRefugee" exists
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Orig" body type is Thin
    And Nelim's Pickle Tools: the alien addons of "Orig" are listed
    And Nelim's Pickle Tools: "Orig" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Orig" alien body mask variant is 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-thin-mask-5-south"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-thin-mask-5-east"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-thin-mask-5-north"
    When Nelim's Pickle Tools: "Orig" alien body mask variant is 6
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-thin-mask-6-south"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-thin-mask-6-east"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-thin-mask-6-north"

  Scenario: seren-reference-3: original Seren body type Female, masks 5 and 6, South East North
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: a colonist "Orig" of kind "SerenRefugee" exists
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Orig" body type is Female
    And Nelim's Pickle Tools: the alien addons of "Orig" are listed
    And Nelim's Pickle Tools: "Orig" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Orig" alien body mask variant is 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-female-mask-5-south"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-female-mask-5-east"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-female-mask-5-north"
    When Nelim's Pickle Tools: "Orig" alien body mask variant is 6
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-female-mask-6-south"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-female-mask-6-east"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-female-mask-6-north"

  Scenario: seren-reference-4: original Seren body type Fat, masks 5 and 6, South East North
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: a colonist "Orig" of kind "SerenRefugee" exists
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Orig" body type is Fat
    And Nelim's Pickle Tools: the alien addons of "Orig" are listed
    And Nelim's Pickle Tools: "Orig" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Orig" alien body mask variant is 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-fat-mask-5-south"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-fat-mask-5-east"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-fat-mask-5-north"
    When Nelim's Pickle Tools: "Orig" alien body mask variant is 6
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-fat-mask-6-south"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-fat-mask-6-east"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-fat-mask-6-north"

  Scenario: seren-reference-5: original Seren body type Male, masks 5 and 6, South East North
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: a colonist "Orig" of kind "SerenRefugee" exists
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Orig" body type is Male
    And Nelim's Pickle Tools: the alien addons of "Orig" are listed
    And Nelim's Pickle Tools: "Orig" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Orig" alien body mask variant is 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-male-mask-5-south"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-male-mask-5-east"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-male-mask-5-north"
    When Nelim's Pickle Tools: "Orig" alien body mask variant is 6
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-male-mask-6-south"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-male-mask-6-east"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-male-mask-6-north"

  Scenario: seren-reference-6: original Seren body type Hulk, masks 5 and 6, South East North
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: a colonist "Orig" of kind "SerenRefugee" exists
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Orig" body type is Hulk
    And Nelim's Pickle Tools: the alien addons of "Orig" are listed
    And Nelim's Pickle Tools: "Orig" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Orig" alien body mask variant is 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-hulk-mask-5-south"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-hulk-mask-5-east"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-hulk-mask-5-north"
    When Nelim's Pickle Tools: "Orig" alien body mask variant is 6
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-hulk-mask-6-south"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-hulk-mask-6-east"
    And Nelim's Pickle Tools: "Orig" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "orig-hulk-mask-6-north"
