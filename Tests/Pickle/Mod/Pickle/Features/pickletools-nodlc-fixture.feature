# Builds the fixture `nodlc-colony`: a new colony started with no DLC active, saved and copied to the run folder (Inbox/<run>/nodlc-colony.rws).
# Asked by HandMeDowns (pass 4, set sans-dlc, 2026-11-07, request of 2026-10-17): test-colony needs Ideology and Biotech.
# A new colony is costly and not reproducible: play it ONCE, in a ticket of its own, with -Extra "-pickle-scenario-timeout=400". The save is then the fixture, never rebuilt.
@requires:nelim.pickletools.newcolony
Feature: PickleTools fixture without any DLC

  @timeout:400
  Scenario: a colony started without any DLC is saved as a fixture
    Given the main menu is open
    And Nelim's Pickle Tools: the new colony's seed is "nodlc-fixture"
    And Nelim's Pickle Tools: the new colony's map size is 250
    When Nelim's Pickle Tools: a new colony is started
    And Nelim's Pickle Tools: any open message dialog is accepted
    And Nelim's Pickle Tools: the new colony's colonists have landed
    And Nelim's Pickle Tools: the game is saved as "nodlc-colony"
    And Nelim's Pickle Tools: the saved game "nodlc-colony" is copied to the run folder
    Then no errors were logged
