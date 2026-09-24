# The ColonistRace scenarios that need RimWorks/Rimworld-Pickle#32: "body is drawn from", "apparel is drawn from" and
# "body type is Fat". They are not in the stock Pickle, so they are not part of Tests/Pickle/.../tools.feature; play them on a build
# that carries the PR (scripts/Run-PickleWsl.ps1 ... -PickleSrc <that build>, with ColonistRace staged) and copy this file into a suite
# for the run. Not played since they were split out of tools.feature.
#
# Genie (Body_Thin) and Yttakin (Body_Hulk) are the xenotypes with ONE body-type gene, so their body type is not a die roll.
# Hussar lists Body_Standard and Body_Hulk and comes out Male or Hulk at random: it cannot be asserted.
Feature: ColonistRace steps that read the drawn body (Pickle PR 32)

  Background:
    Given the save "test-colony" is loaded

  Scenario: the genie xenotype is drawn with the thin body
    Given a colonist "Slim" exists
    And "Slim" is 30 years old
    And Nelim's Pickle Tools: "Slim" xenotype is "Genie"
    Then Nelim's Pickle Tools: "Slim" has body type Thin
    And "Slim" body is drawn from "Things/Pawn/Humanlike/Bodies/Naked_Thin"

  Scenario: the yttakin xenotype is drawn with the hulk body
    Given a colonist "Brute" exists
    And "Brute" is 30 years old
    And Nelim's Pickle Tools: "Brute" xenotype is "Yttakin"
    Then Nelim's Pickle Tools: "Brute" has body type Hulk
    And "Brute" body is drawn from "Things/Pawn/Humanlike/Bodies/Naked_Hulk"

  Scenario: a body type set after the xenotype wins
    Given a colonist "Mixed" exists
    And "Mixed" is 30 years old
    And Nelim's Pickle Tools: "Mixed" xenotype is "Genie"
    And "Mixed" body type is Fat
    Then Nelim's Pickle Tools: "Mixed" has xenotype "Genie"
    And Nelim's Pickle Tools: "Mixed" has body type Fat
    And "Mixed" body is drawn from "Things/Pawn/Humanlike/Bodies/Naked_Fat"

  Scenario: a colonist generated from a humanlike kind is drawn with the fat body when set
    Given Nelim's Pickle Tools: a colonist "Farmer" of kind "Villager" exists
    And "Farmer" is 30 years old
    And "Farmer" body type is Fat
    When I dress "Farmer" in "Apparel_BasicShirt"
    Then "Farmer" is wearing "Apparel_BasicShirt"
    And "Farmer" body is drawn from "Things/Pawn/Humanlike/Bodies/Naked_Fat"
    And "Farmer" apparel "Apparel_BasicShirt" is drawn from "Things/Pawn/Humanlike/Apparel/ShirtBasic/ShirtBasic_Fat"
