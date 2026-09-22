# A faction its mod marks as required (forcePlayerToAddFactionIfMissing) is left to VEF: its window
# refuses both skip and ignore, so ignoring it here would defeat that mod. No such faction is
# guaranteed in the mod list, so the scenario marks one for its own duration and removes the marker
# afterwards.
@requires:nelim.pickletools.veffactions
@requires:OskarPotocki.VanillaFactionsExpanded.Core
Feature: a required faction still gets VEF's window

  Background:
    Given the save "test-colony" is loaded
    When Nelim's Pickle Tools: the load has settled
    And Nelim's Pickle Tools: a faction the world lacks is chosen
    And Nelim's Pickle Tools: the chosen faction is marked required by its mod

  Scenario: the window opens and nothing is ignored
    When Nelim's Pickle Tools: VEF runs its new faction check
    Then Nelim's Pickle Tools: a new faction window is open for the chosen faction
    And Nelim's Pickle Tools: the chosen faction is not ignored
    When I close all dialogs
    Then no errors were logged
