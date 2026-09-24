# The RIMMSQOL restart chain of the aggregate bundle, launch 3 of 3: forget. A third process: hiding the button, the choice launch 2
# kept, must have survived a restart as well, and the last steps put RIMMSQOL back so the profile is left as it was found. The
# after-scenario hook would do it anyway; this scenario says it and checks the file.
#
# See aggregate-rimmsqol-restart-1-reveal.feature for the command and for what is left behind if the chain is cut.
@requires:nelim.pickletools
@requires:MalteSchulze.RIMMSqol
Feature: the bundle's RIMMSQOL choice is written for the next launch (3 of 3, forget)

  Scenario: hiding the button survived the restart, and RIMMSQOL is put back
    Given the main menu is open
    Then RIMMSQOL is ready to be driven
    And the choices RIMMSQOL kept in the previous launch are in place
    Then RIMMSQOL shows the main button "Inspect" as hidden
    And RIMMSQOL's settings file records the main button "Inspect" as hidden
    When RIMMSQOL forgets its choice for the main button "Inspect"
    Then RIMMSQOL holds no choice for the main button "Inspect"
    And RIMMSQOL's settings file records no choice for the main button "Inspect"
    And no errors were logged
