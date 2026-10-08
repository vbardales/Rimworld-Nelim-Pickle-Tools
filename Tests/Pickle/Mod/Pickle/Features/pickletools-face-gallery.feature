@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
Feature: Every facial animation of the loaded mods on Nelim (gallery)

  Scenario: face-gallery-1: facial animations, part 1 of 4
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And Nelim's Pickle Tools: I let 120 ticks pass
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+AttackMelee"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-AttackMelee"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+AttackMelee2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-AttackMelee2"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+AttackStatic"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-AttackStatic"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+AttackStatic2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-AttackStatic2"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+blink"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-blink"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+DoBill"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-DoBill"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+DoBill2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-DoBill2"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+eyeFlicker"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-eyeFlicker"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+eyeMoving"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-eyeMoving"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+eyeMoving2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-eyeMoving2"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+FleeAndCower"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-FleeAndCower"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Goto"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Goto"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Haul"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Haul"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Haul2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Haul2"

  Scenario: face-gallery-2: facial animations, part 2 of 4
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And Nelim's Pickle Tools: I let 120 ticks pass
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+HaulSub"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-HaulSub"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+HaulSub2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-HaulSub2"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Lovin"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Lovin"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Lovin2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Lovin2"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+LovinRepeat"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-LovinRepeat"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+moodCheerful"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-moodCheerful"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+moodCheerful2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-moodCheerful2"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+moodGloomy"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-moodGloomy"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+moodHopeless"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-moodHopeless"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+moodHopeless3"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-moodHopeless3"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+NLR-Blink"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-NLR-Blink"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+NLR-Blush"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-NLR-Blush"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+NLR-Cold"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-NLR-Cold"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+NLR-Hot"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-NLR-Hot"

  Scenario: face-gallery-3: facial animations, part 3 of 4
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And Nelim's Pickle Tools: I let 120 ticks pass
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+NLR-Open"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-NLR-Open"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+NLR-Sad"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-NLR-Sad"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+NLR-Smile"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-NLR-Smile"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+painHigh"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-painHigh"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Reading"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Reading"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Reading2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Reading2"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+ReceivedAnAttack01"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-ReceivedAnAttack01"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Thought_Cold"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Thought_Cold"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Thought_Hot"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Thought_Hot"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Thought_Naked"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Thought_Naked"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Wait_Combat_Rare"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Wait_Combat_Rare"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Wait_Downed"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Wait_Downed"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Wait_Downed2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Wait_Downed2"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+WaitCombat"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-WaitCombat"

  Scenario: face-gallery-4: facial animations, part 4 of 4
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And Nelim's Pickle Tools: I let 120 ticks pass
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Ingest"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Ingest"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+laydown"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-laydown"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+laydown2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-laydown2"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+laydown3"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-laydown3"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Mine"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Mine"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Research"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Research"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Research2"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Research2"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+SocialRelax"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-SocialRelax"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+StandAndBeSociallyActive"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-StandAndBeSociallyActive"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Lovin3"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Lovin3"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+MVE_UnconsciousDowned"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-MVE_UnconsciousDowned"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal+Thought_Tired"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 4
    And I take a screenshot "g-Thought_Tired"
