# Builds the fixture `sans-ideology-colony`: a new colony started with Ideology inactive, saved and copied to the run folder (Inbox/<run>/sans-ideology-colony.rws).
# Asked by MechanoidFactory (2026-11-10): test-colony was saved with Ideology and vanilla throws NullReferenceException (Pawn_AgeTracker.AgeTickInterval) on load without it. The other four DLC stay active.
# A new colony is costly and not reproducible: play it ONCE, in a ticket of its own, with -Extra "-pickle-scenario-timeout=400". The save is then the fixture, never rebuilt.
@requires:nelim.pickletools.newcolony
Feature: PickleTools fixture without Ideology

  @timeout:400
  Scenario: a colony started without Ideology is saved as a fixture
    Given the main menu is open
    And Nelim's Pickle Tools: the new colony's seed is "sans-ideology-fixture"
    And Nelim's Pickle Tools: the new colony's map size is 250
    When Nelim's Pickle Tools: a new colony is started
    And Nelim's Pickle Tools: any open message dialog is accepted
    And Nelim's Pickle Tools: the new colony's colonists have landed
    And Nelim's Pickle Tools: the game is saved as "sans-ideology-colony"
    And Nelim's Pickle Tools: the saved game "sans-ideology-colony" is copied to the run folder
    Then no errors were logged
