# The ColonistRace steps, on the stock Pickle. Body types come from genes, and the game chooses among them AT RANDOM
# (PawnGenerator.GetBodyTypeFor keeps every body-type gene the pawn has and picks one, each time the genes change, and
# Pawn_GeneTracker.Notify_GenesChanged calls it). A xenotype that lists several body-type genes is therefore not a body type:
# Hussar lists Body_Standard and Body_Hulk and comes out Male or Hulk by chance, so it cannot be asserted. Only a xenotype with a
# single such gene is deterministic: Genie (Body_Thin) and Yttakin (Body_Hulk), used below.
# The steps that read a pawn's DRAWN body ("body is drawn from", "body type is Fat") are RimWorks/Rimworld-Pickle#32 and are not in
# the stock Pickle: their scenarios are in Upstream/tests/colonist-race-bodytype-probe.feature, for a build that has that PR.
Feature: PickleTools steps

  Background:
    Given the save "test-colony" is loaded

  Scenario: the genie xenotype gives a thin body
    Given a colonist "Slim" exists
    And "Slim" is 30 years old
    And Nelim's Pickle Tools: "Slim" xenotype is "Genie"
    Then Nelim's Pickle Tools: "Slim" has xenotype "Genie"
    And Nelim's Pickle Tools: "Slim" has body type Thin

  Scenario: the yttakin xenotype gives a hulk body
    Given a colonist "Brute" exists
    And "Brute" is 30 years old
    And Nelim's Pickle Tools: "Brute" xenotype is "Yttakin"
    Then Nelim's Pickle Tools: "Brute" has xenotype "Yttakin"
    And Nelim's Pickle Tools: "Brute" has body type Hulk

  Scenario: a colonist can be generated from a humanlike kind
    Given Nelim's Pickle Tools: a colonist "Farmer" of kind "Villager" exists
    And "Farmer" is 30 years old
    When I dress "Farmer" in "Apparel_BasicShirt"
    Then "Farmer" is wearing "Apparel_BasicShirt"
    And Nelim's Pickle Tools: "Farmer" is of race "Human"
    And Nelim's Pickle Tools: "Farmer" is at the Adult stage of life

  Scenario: the readers see the gender and the stage of life that were set
    Given a colonist "Kid" exists
    And "Kid" is 8 years old
    And "Kid" gender is female
    Then Nelim's Pickle Tools: "Kid" has gender female
    And Nelim's Pickle Tools: "Kid" is at the Child stage of life
    And Nelim's Pickle Tools: "Kid" is of race "Human"
