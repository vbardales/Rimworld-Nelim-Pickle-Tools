# The research window steps of PickleTools/ResearchSteps: a vanilla tab opened by its def name, then read back.
#
# NOT PLAYED (written 2026-10-12 for the RimWorld 1.7 pass, AUDIT.md "Passe 1.7", prerequisite 2: one scenario per assembly).
# Played only after aggregate-minimal, pickletools-keyedclick and inspect-tabs. Uses vanilla only: the tab "Main" and the project
# "Stonecutting" (the same pair as the vanilla scenario of AdaptiveStorageNeolithicRenew's 08 feature, played there on 1.6).
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.researchsteps.map -Filter pickletools-researchsteps
@requires:nelim.pickletools.research
Feature: PickleTools research steps
  Background:
    Given the save "test-colony" is loaded
  Scenario: a vanilla research tab is opened by its def name and read back
    When Nelim's Pickle Tools: I open the research tab "Main"
    Then Nelim's Pickle Tools: the research window is on the tab "Main"
    And Nelim's Pickle Tools: the research window lists the project "Stonecutting"
    When I close all dialogs
