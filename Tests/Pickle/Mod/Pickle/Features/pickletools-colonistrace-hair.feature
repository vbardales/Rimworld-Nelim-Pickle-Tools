# The step that lets a hairstyle show its own colours: 'Nelim's Pickle Tools: I let the hairstyle of "Name" show its own colours'.
# It sets the hair colour to white and redraws the pawn; the Then reads the colour the game reports back. The colonist's colour
# before the step is random, so the scenario cannot prove the colour changed; it proves the step leaves white and that the game reports it.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.colonistrace.map -Filter pickletools-colonistrace-hair
@requires:nelim.pickletools.colonistrace
Feature: PickleTools hairstyle in its own colours

  Background:
    Given the save "test-colony" is loaded

  Scenario: a hairstyle is drawn untinted
    Given a colonist "Ash" exists
    And "Ash" is 30 years old
    When Nelim's Pickle Tools: I let the hairstyle of "Ash" show its own colours
    Then Nelim's Pickle Tools: the hairstyle of "Ash" is drawn in its own colours

  @requires:Ludeon.RimWorld.Ideology
  Scenario: a colonist is dressed with a hairstyle, a colour, a tattoo and a dyed garment
    Given a colonist "Ivy" exists
    And "Ivy" is 30 years old
    And Nelim's Pickle Tools: "Ivy" hairstyle is "Shaved"
    And Nelim's Pickle Tools: "Ivy" hair colour is rgb (200, 40, 40)
    And Nelim's Pickle Tools: "Ivy" face tattoo is "none"
    And I dress "Ivy" in "Apparel_BasicShirt"
    When Nelim's Pickle Tools: the "Apparel_BasicShirt" worn by "Ivy" is dyed rgb (30, 90, 160)
    Then "Ivy" is wearing "Apparel_BasicShirt"
