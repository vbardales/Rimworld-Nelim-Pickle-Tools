# The texture owner steps of PickleTools/TextureOwner, played against stock Pickle: the claims that HOLD.
#
# Three mods are staged that ship known paths (see wsl-deps.textureowner.map): the load order is First, Second,
# the tests companion, and the last one to ship a path answers for it. No save is loaded: the content holders
# are filled when the mods load.
Feature: PickleTools texture owner steps

  Scenario: the last mod that ships a path answers for it
    Given the main menu is open
    Then Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Contested" is answered by the mod "nelim.pickletest.textureowner.tests"
    And Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Pair" is answered by the mod "nelim.pickletest.textureowner.second"
    And Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Alone" is answered by the mod "nelim.pickletest.textureowner.first"

  Scenario: the packageId is read without regard to case
    Given the main menu is open
    Then Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Pair" is answered by the mod "Nelim.PickleTest.TextureOwner.Second"

  Scenario: a path is shipped by as many running mods as ship it
    Given the main menu is open
    Then Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Contested" is shipped by at least 3 running mods
    And Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Pair" is shipped by at least 2 running mods
    And Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Alone" is shipped by at least 1 running mod