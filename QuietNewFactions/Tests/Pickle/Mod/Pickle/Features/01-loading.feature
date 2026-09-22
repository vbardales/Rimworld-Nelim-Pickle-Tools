# The mod is in place: it loads after VEF. No save needed, this runs at the main menu.
Feature: Quiet New Factions loads on top of VEF

  Scenario: the mod loads after the framework it patches
    Then mod "nelim.quietnewfactions" is loaded
    And mod "nelim.quietnewfactions" loads after "OskarPotocki.VanillaFactionsExpanded.Core"
