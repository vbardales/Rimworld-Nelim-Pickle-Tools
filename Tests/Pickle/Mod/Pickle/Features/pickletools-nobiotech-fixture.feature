# Builds the fixture `nobiotech-colony`: a new colony started with Biotech inactive, saved and copied to the run folder (Inbox/<run>/nobiotech-colony.rws).
# Asked by NightChange (scenario 13, 2026-11-02): test-colony was saved with Biotech and vanilla throws NullReferenceException on load without it.
# A new colony is costly and not reproducible: play it ONCE, in a ticket of its own, with -Extra "-pickle-scenario-timeout=400". The save is then the fixture, never rebuilt.
@requires:nelim.pickletools.newcolony
Feature: PickleTools fixture without Biotech

  @timeout:400
  Scenario: a colony started without Biotech is saved as a fixture
    Given the main menu is open
    And Nelim's Pickle Tools: the new colony's seed is "nobiotech-fixture"
    And Nelim's Pickle Tools: the new colony's map size is 250
    When Nelim's Pickle Tools: a new colony is started
    And Nelim's Pickle Tools: any open message dialog is accepted
    And Nelim's Pickle Tools: the new colony's colonists have landed
    And Nelim's Pickle Tools: the game is saved as "nobiotech-colony"
    And Nelim's Pickle Tools: the saved game "nobiotech-colony" is copied to the run folder
    Then no errors were logged
