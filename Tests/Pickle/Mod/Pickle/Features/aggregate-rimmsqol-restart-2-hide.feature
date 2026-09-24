# The RIMMSQOL restart chain of the aggregate bundle, launch 2 of 3: hide. A NEW process, which read RIMMSQOL's settings file at
# startup: the button revealed by launch 1 must read visible without anything having revealed it in THIS process. The hand-off
# step refuses to pass when launch 1 ran in this same process. Then it is hidden again, and that choice is kept for launch 3.
#
# See aggregate-rimmsqol-restart-1-reveal.feature for the command and for what is left behind if the chain is cut.
@requires:nelim.pickletools
@requires:MalteSchulze.RIMMSqol
Feature: the bundle's RIMMSQOL choice is written for the next launch (2 of 3, hide)

  Scenario: the revealed button survived the restart, then RIMMSQOL hides it again
    Given the main menu is open
    Then RIMMSQOL is ready to be driven
    And the choices RIMMSQOL kept in the previous launch are in place
    Then RIMMSQOL shows the main button "Inspect" as visible
    And RIMMSQOL's settings file records the main button "Inspect" as visible
    When RIMMSQOL hides the main button "Inspect"
    Then RIMMSQOL shows the main button "Inspect" as hidden
    And RIMMSQOL's settings file records the main button "Inspect" as hidden
    And no errors were logged
    And RIMMSQOL's choices are kept for the next launch
