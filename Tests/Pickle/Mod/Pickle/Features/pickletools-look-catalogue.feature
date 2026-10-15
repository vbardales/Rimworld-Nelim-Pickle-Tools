# Lists the look options of the loaded game (hairstyles, beards, heads, tattoos, bodies, garments, face parts, expressions) in the log, for the
# catalogue docs/CATALOGUE-LOOKS.md. Not a test: it never fails on a value, it makes the list.
#
# NOT PLAYED (written 2026-10-15). Play it on a pass whose map stages every mod whose options the sessions may choose, then read the
# lines [look-*], [face-parts] and [face-animations] of Player.log.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.look-catalogue.map -Filter pickletools-look-catalogue   (through Submit-PickleRun.ps1)
@requires:nelim.pickletools.colonistrace
Feature: PickleTools look catalogue
  Scenario: the look options are listed
    Given the save "Nelims-tribe" is loaded
    And Nelim's Pickle Tools: the hair, beard, head, tattoo and body options are listed
    And Nelim's Pickle Tools: the garment options are listed
    And Nelim's Pickle Tools: the facial animations are listed
