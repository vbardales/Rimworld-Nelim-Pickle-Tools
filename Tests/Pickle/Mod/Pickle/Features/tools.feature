Feature: PickleTools steps

  Background:
    Given the save "test-colony" is loaded

  Scenario: the genie xenotype gives a thin body
    Given a colonist "Slim" exists
    And "Slim" is 30 years old
    And Nelim's Pickle Tools: "Slim" xenotype is "Genie"
    Then Nelim's Pickle Tools: "Slim" has xenotype "Genie"
    And Nelim's Pickle Tools: "Slim" has body type Thin
    And "Slim" body is drawn from "Things/Pawn/Humanlike/Bodies/Naked_Thin"

  Scenario: the hussar xenotype gives a hulk body
    Given a colonist "Brute" exists
    And "Brute" is 30 years old
    And Nelim's Pickle Tools: "Brute" xenotype is "Hussar"
    Then Nelim's Pickle Tools: "Brute" has xenotype "Hussar"
    And Nelim's Pickle Tools: "Brute" has body type Hulk
    And "Brute" body is drawn from "Things/Pawn/Humanlike/Bodies/Naked_Hulk"

  Scenario: a body type set after the xenotype wins
    Given a colonist "Mixed" exists
    And "Mixed" is 30 years old
    And Nelim's Pickle Tools: "Mixed" xenotype is "Genie"
    And "Mixed" body type is Fat
    Then Nelim's Pickle Tools: "Mixed" has xenotype "Genie"
    And Nelim's Pickle Tools: "Mixed" has body type Fat
    And "Mixed" body is drawn from "Things/Pawn/Humanlike/Bodies/Naked_Fat"

  Scenario: a colonist can be generated from a humanlike kind
    Given Nelim's Pickle Tools: a colonist "Farmer" of kind "Villager" exists
    And "Farmer" is 30 years old
    And "Farmer" body type is Fat
    When I dress "Farmer" in "Apparel_BasicShirt"
    Then "Farmer" is wearing "Apparel_BasicShirt"
    And Nelim's Pickle Tools: "Farmer" is of race "Human"
    And Nelim's Pickle Tools: "Farmer" is at the Adult stage of life
    And "Farmer" body is drawn from "Things/Pawn/Humanlike/Bodies/Naked_Fat"
    And "Farmer" apparel "Apparel_BasicShirt" is drawn from "Things/Pawn/Humanlike/Apparel/ShirtBasic/ShirtBasic_Fat"

  Scenario: the readers see the gender and the stage of life that were set
    Given a colonist "Kid" exists
    And "Kid" is 8 years old
    And "Kid" gender is female
    Then Nelim's Pickle Tools: "Kid" has gender female
    And Nelim's Pickle Tools: "Kid" is at the Child stage of life
    And Nelim's Pickle Tools: "Kid" is of race "Human"
