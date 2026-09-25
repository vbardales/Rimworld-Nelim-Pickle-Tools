# The step that gives a pawn a body type the game cannot draw at random: 'Nelim's Pickle Tools: "Name" body type is <word>'.
# It removes every body-type gene of the pawn, adds the one of the type asked for (Body_Standard for Male and Female: with none left the game picks Thin one time in two) and reads the type back.
# Hussar lists two body-type genes (Body_Standard, Body_Hulk) and is Male or Hulk by chance (see ColonistRace/README.md), so it is the
# pawn that proves the step: Thin and Fat are types Hussar cannot draw, and Male after Hulk proves the second gene is gone.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.colonistrace.map -Filter pickletools-colonistrace-bodytype
@requires:nelim.pickletools.colonistrace
Feature: PickleTools colonist body type

  Background:
    Given the save "test-colony" is loaded

  Scenario: a pawn with two body-type genes gets each body type asked for, in turn
    Given a colonist "Slim" exists
    And "Slim" is 30 years old
    And "Slim" gender is male
    And Nelim's Pickle Tools: "Slim" xenotype is "Hussar"
    When Nelim's Pickle Tools: "Slim" body type is Thin
    Then Nelim's Pickle Tools: "Slim" has body type Thin
    When Nelim's Pickle Tools: "Slim" body type is Fat
    Then Nelim's Pickle Tools: "Slim" has body type Fat
    When Nelim's Pickle Tools: "Slim" body type is Hulk
    Then Nelim's Pickle Tools: "Slim" has body type Hulk
    When Nelim's Pickle Tools: "Slim" body type is Male
    Then Nelim's Pickle Tools: "Slim" has body type Male
    And Nelim's Pickle Tools: "Slim" has xenotype "Hussar"

  Scenario: a female pawn gets the Female body when no gene is left
    Given a colonist "Fern" exists
    And "Fern" is 30 years old
    And "Fern" gender is female
    And Nelim's Pickle Tools: "Fern" xenotype is "Hussar"
    When Nelim's Pickle Tools: "Fern" body type is Hulk
    Then Nelim's Pickle Tools: "Fern" has body type Hulk
    When Nelim's Pickle Tools: "Fern" body type is Female
    Then Nelim's Pickle Tools: "Fern" has body type Female

  Scenario: a child gets the body of a child, which setting the age alone does not give
    Given a colonist "Kid" exists
    And "Kid" is 8 years old
    And "Kid" gender is male
    When Nelim's Pickle Tools: "Kid" body type is Child
    Then Nelim's Pickle Tools: "Kid" has body type Child
    And Nelim's Pickle Tools: "Kid" is at the Child stage of life
