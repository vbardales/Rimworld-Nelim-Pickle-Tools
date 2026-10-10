# The steps that build an ideoligion and a prison scene: 'Nelim's Pickle Tools: the colony adopts an ideoligion ...',
# '... follows an ideoligion ...', '... a prison cell is built at (x, z) ...', '... a prisoner "Name" exists in the cell ...'.
# Each scenario builds the scene and reads the state back, so an API drift in the game shows here before a mod suite meets it.
# Coordinates: a 9 by 9 square from (30, 30) is thing-free in test-colony (docs/FIXTURES.md); the cell built at (32, 32) covers (31..35, 31..35), inside it. (29, 29) holds rock. Terrain was not decoded, and the cell step fails 2026-10-10 (ticket 037b): (31, 31) holds a Slate (natural rock the save does not list), so the cell moved to (113, 190), beside the colonists, a spot with no saved thing; played again to confirm.
# naming the first blocked cell if the spot is unusable.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.ideologysteps.map -Filter pickletools-ideologysteps
@requires:nelim.pickletools.ideologysteps
@requires:Ludeon.RimWorld.Ideology
Feature: PickleTools ideology steps

  Background:
    Given the save "test-colony" is loaded

  Scenario: the colony adopts an ideoligion with chosen memes and precepts
    When Nelim's Pickle Tools: the colony adopts an ideoligion with the memes "Collectivist,Rancher" and the precepts "Slavery_Abhorrent,Execution_Abhorrent"
    Then Nelim's Pickle Tools: the colony ideoligion has the precept "Slavery_Abhorrent"
    And Nelim's Pickle Tools: the colony ideoligion has the precept "Execution_Abhorrent"
    And Nelim's Pickle Tools: the colony ideoligion does not have the precept "Slavery_Acceptable"
    And Nelim's Pickle Tools: the colonist "Jet" has the precept "Slavery_Abhorrent"

  Scenario: one colonist follows another ideoligion than the colony's
    Given Nelim's Pickle Tools: the colony adopts an ideoligion with the memes "Collectivist,Rancher" and the precepts "Slavery_Abhorrent"
    When Nelim's Pickle Tools: the colonist "Larson" follows an ideoligion with the precepts "Slavery_Honorable"
    Then Nelim's Pickle Tools: the colonist "Larson" has the precept "Slavery_Honorable"
    And Nelim's Pickle Tools: the colonist "Jet" has the precept "Slavery_Abhorrent"
    And Nelim's Pickle Tools: the colony ideoligion has the precept "Slavery_Abhorrent"

  Scenario: a prison cell holds a prisoner in restraints, and the prisoner tab offers the mode just set
    Given Nelim's Pickle Tools: a prison cell is built at (113, 190) with a bed and a door
    And Nelim's Pickle Tools: a prisoner "Rook" exists in the cell at (113, 190), in restraints
    When Nelim's Pickle Tools: the prisoner "Rook" interaction mode is "ReduceWill"
    Then Nelim's Pickle Tools: the prisoner "Rook" is offered the interaction mode "ReduceWill"

  Scenario: the negative control, a prisoner who is not in restraints
    Given Nelim's Pickle Tools: a prison cell is built at (113, 190) with a bed and a door
    And Nelim's Pickle Tools: a prisoner "Fox" exists in the cell at (113, 190), not in restraints

  Scenario: a work type is switched without touching the others
    Given Nelim's Pickle Tools: the colonist "Jet" has the work type "Crafting" disabled
    When Nelim's Pickle Tools: the colonist "Jet" has the work type "Crafting" enabled

  Scenario: a colonist follows a faith whose memes differ from the colony's
    Given Nelim's Pickle Tools: the colony adopts an ideoligion with the memes "Collectivist,Rancher" and the precepts "Slavery_Abhorrent"
    When Nelim's Pickle Tools: the colonist "Morrison" follows an ideoligion with the memes "Individualist,Nudism" and the precepts "Slavery_Acceptable"
    Then Nelim's Pickle Tools: the colonist "Morrison" has the precept "Slavery_Acceptable"
    And Nelim's Pickle Tools: the colony ideoligion has the precept "Slavery_Abhorrent"

  @requires:Ludeon.RimWorld.Biotech
  Scenario: the prisoner tab hides the bloodfeed mode when the colony has no bloodfeeder
    Given Nelim's Pickle Tools: a prison cell is built at (113, 190) with a bed and a door
    And Nelim's Pickle Tools: a prisoner "Rook" exists in the cell at (113, 190), in restraints
    Then Nelim's Pickle Tools: the prisoner "Rook" is not offered the interaction mode "Bloodfeed"
