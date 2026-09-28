# The optional DefFields tool: a public field of a def read by the def's TYPE and name, for a name two def types share.
#
# NOT PLAYED YET (written 2026-09-28). It reads the vanilla Muffalo, which is both a ThingDef and a PawnKindDef: the case Pickle's own
# `def {string} field {string} is {string}` refuses. Expected values are the vanilla ones (Data/Core, Races_Animal_CowGroup.xml: baseBodySize 2.4,
# lifeExpectancy 15); this pass stages no other mod, so nothing patches them. It needs no save, only the loaded defs.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.deffields.map -Filter pickletools-deffields
@requires:nelim.pickletools.deffields
Feature: PickleTools def fields

  Scenario: a name shared by a ThingDef and a PawnKindDef is read by its type
    Given the main menu is open
    Then Nelim's Pickle Tools: def "Muffalo" of type "ThingDef" field "race.baseBodySize" is "2.4"
    And Nelim's Pickle Tools: def "Muffalo" of type "ThingDef" field "race.lifeExpectancy" is "15"
    And Nelim's Pickle Tools: def "Muffalo" of type "PawnKindDef" field "race.defName" is "Muffalo"
