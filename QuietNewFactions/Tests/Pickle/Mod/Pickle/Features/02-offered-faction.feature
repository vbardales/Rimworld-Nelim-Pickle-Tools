# The case the mod exists for. A faction the world lacks, not yet ignored: VEF would open its
# window for it at every load, and "skip" would record nothing. With the mod no window opens, the
# faction lands on VEF's ignored list, and the list survives the save.
#
# The fixture was not made with this mod list, so loading it already runs VEF's check once.
# "a faction the world lacks is chosen" takes one faction back off the ignored list to replay it.
@requires:nelim.pickletools.veffactions
@requires:OskarPotocki.VanillaFactionsExpanded.Core
Feature: a faction the world lacks is ignored without a window

  Background:
    Given the save "test-colony" is loaded
    When Nelim's Pickle Tools: the load has settled

  Scenario: loading the fixture leaves no window open
    Then Nelim's Pickle Tools: no new faction window is open
    And no errors were logged

  Scenario: VEF's check ignores the faction instead of asking
    Given Nelim's Pickle Tools: a faction the world lacks is chosen
    And Nelim's Pickle Tools: the chosen faction is not ignored
    When Nelim's Pickle Tools: VEF runs its new faction check
    Then Nelim's Pickle Tools: no new faction window is open
    And Nelim's Pickle Tools: the chosen faction is ignored in this save
    And Nelim's Pickle Tools: the game log says the chosen faction was ignored
    And no errors were logged

  Scenario: the choice is kept in the save, and the next load asks nothing
    Given Nelim's Pickle Tools: a faction the world lacks is chosen
    When Nelim's Pickle Tools: VEF runs its new faction check
    And I save and reload
    And Nelim's Pickle Tools: the load has settled
    Then Nelim's Pickle Tools: the chosen faction is ignored in this save
    And Nelim's Pickle Tools: no new faction window is open
    And no errors were logged
