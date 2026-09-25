# The optional LoadAudit tool: the load of a mod is clean, read from the game log and from the data the game holds.
#
# PLAYED ONCE, 2026-09-25, English: 1 of 1 (314 log lines read, 0 types and 0 defs because this mod has none: the audit of a real mod is still to be seen). The unit tests (LoadAudit/Tests, 13 cases, no game) play the analysis on sample log lines, including the
# failing cases; what this scenario answers is whether the step can read the game log and the mod's types, defs and keys in a real game.
# It audits the tool's own mod, which logs nothing and has no defs: a positive control only. A run cannot prove the failing side without
# failing on purpose, so that side is proved by the unit tests, and by the first suite that finds a real error.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.loadaudit.map -Filter pickletools-loadaudit
@requires:nelim.pickletools.loadaudit
Feature: PickleTools load audit

  Scenario: the tool's own mod has a clean load, with and without a known message set aside
    Given the main menu is open
    Then Nelim's Pickle Tools: the load of the mod "nelim.pickletools.loadaudit" is clean
    And Nelim's Pickle Tools: the load of the mod "nelim.pickletools.loadaudit" is clean, apart from "a message nobody logs"
