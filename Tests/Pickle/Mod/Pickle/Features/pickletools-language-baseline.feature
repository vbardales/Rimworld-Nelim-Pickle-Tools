# The baseline of the load errors of the active language, with no mod under test (see wsl-deps.language-baseline.map and
# wsl-deps.language-baseline-no-odyssey.map). Requested by Animal Ark (2026-10-11) to tell the errors a mod adds from the ones the
# base game and its DLC already report in a language (French: Biotech, Odyssey, Vacstone, Mechanoid defs). A FAILURE is the result:
# its message lists every error by language and package; read the list, do not "fix" the scenario. Not played yet.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.language-baseline.map -Filter pickletools-language-baseline -Language French
@requires:nelim.pickletools.loadaudit
Feature: Load errors of the active language, without any mod under test

  Scenario: the active language recorded no load error
    Then Nelim's Pickle Tools: the active language recorded no load error
