# The texture owner steps of PickleTools/TextureOwner: the claims that must NOT hold, played to read the words
# each failure gives. EVERY scenario here is expected to be RED, and @wip keeps a plain run away from them.
# This file exists only in this throwaway suite: a real suite never wants a red it expects.
#
# What is read from the report is the failure message of each scenario: it must name the winner, list every mod
# shipping the path in load order, and (for the owner claim) say why the named mod does not answer.
@wip
Feature: PickleTools texture owner steps, refused

  Scenario: R1 a mod that ships the path and loses
    Given the main menu is open
    Then Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Pair" is answered by the mod "nelim.pickletest.textureowner.first"

  Scenario: R2 a mod that is running and ships nothing at that path
    Given the main menu is open
    Then Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Alone" is answered by the mod "nelim.pickletest.textureowner"

  Scenario: R3 a mod that is not running at all
    Given the main menu is open
    Then Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Alone" is answered by the mod "nelim.pickletest.notstaged"

  Scenario: R4 a path nobody ships
    Given the main menu is open
    Then Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Nowhere" is answered by the mod "nelim.pickletest.textureowner.first"

  Scenario: R5 a contest with too few mods
    Given the main menu is open
    Then Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Alone" is shipped by at least 2 running mods

  Scenario: R6 a contest of four where three ship it
    Given the main menu is open
    Then Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Contested" is shipped by at least 4 running mods

  Scenario: R7 a contest that asks for nothing
    Given the main menu is open
    Then Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Contested" is shipped by at least 0 running mods

  Scenario: R8 a contest on a path nobody ships
    Given the main menu is open
    Then Nelim's Pickle Tools: the texture "PickleToolsCheck/TextureOwner/Nowhere" is shipped by at least 1 running mod