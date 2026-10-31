# RimWorld 1.7 variant of pickletools-look-catalogue: lists the hairstyles, beards, heads, tattoos and bodies of the loaded 1.7 game in the log ([look-*] lines of Player.log).
# No Nals step (the facial animation mods have no 1.7 build of their own: only the community compatibility patch), no garment, colour or weapon listing (not needed for the 1.7 mods under test), and the Pickle test-colony save instead of Nelims-tribe (which names mods of the 1.6 sets).
# Not a test: it never fails on a value, it makes the list. Play it through Submit-PickleRun.ps1 with -Game /home/nelim/rimworld17 and -DepMap wsl-deps.look-catalogue-17.map.
@requires:nelim.pickletools.colonistrace
Feature: PickleTools look catalogue on 1.7

  Scenario: the look options are listed on 1.7
    Given the save "test-colony" is loaded
    And Nelim's Pickle Tools: the hair, beard, head, tattoo and body options are listed
