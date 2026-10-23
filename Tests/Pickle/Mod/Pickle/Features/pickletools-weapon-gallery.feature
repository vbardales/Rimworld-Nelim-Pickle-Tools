@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Every weapon on Nelim, one photograph per value (gallery of the weapon catalogue)

  Scenario: weapon-gallery-1: hand weapons 1 to 20 of 82
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" wields "Gun_HellcatRifle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_HellcatRifle"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_Incinerator"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_Incinerator"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "NerveSpiker"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-NerveSpiker"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Flamebow"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Flamebow"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_BeamGraser"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_BeamGraser"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_HellsphereCannon"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_HellsphereCannon"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_MiniFlameblaster"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_MiniFlameblaster"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_MiniShotgun"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_MiniShotgun"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_NeedleLauncher"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_NeedleLauncher"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_Slugthrower"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_Slugthrower"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_Spiner"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_Spiner"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_ToxbombLauncher"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_ToxbombLauncher"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_ToxicNeedle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_ToxicNeedle"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Weapon_GrenadeTox"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Weapon_GrenadeTox"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Beer"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Beer"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "ElephantTusk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-ElephantTusk"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_BreachAxe"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_BreachAxe"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_Club"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_Club"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_Gladius"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_Gladius"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_Ikwa"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_Ikwa"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away

  Scenario: weapon-gallery-2: hand weapons 21 to 40 of 82
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_Knife"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_Knife"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_LongSword"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_LongSword"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_Mace"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_Mace"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_Spear"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_Spear"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "ThrumboHorn"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-ThrumboHorn"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "WoodLog"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-WoodLog"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Bow_Great"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Bow_Great"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Bow_Recurve"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Bow_Recurve"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Bow_Short"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Bow_Short"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_AssaultRifle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_AssaultRifle"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_Autopistol"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_Autopistol"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_BoltActionRifle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_BoltActionRifle"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_ChainShotgun"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_ChainShotgun"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_ChargeBlasterHeavy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_ChargeBlasterHeavy"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_ChargeLance"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_ChargeLance"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_ChargeRifle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_ChargeRifle"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_DoomsdayRocket"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_DoomsdayRocket"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_EmpLauncher"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_EmpLauncher"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_HeavySMG"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_HeavySMG"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_IncendiaryLauncher"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_IncendiaryLauncher"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away

  Scenario: weapon-gallery-3: hand weapons 41 to 60 of 82
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" wields "Gun_InfernoCannon"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_InfernoCannon"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_LMG"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_LMG"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_MachinePistol"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_MachinePistol"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_Minigun"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_Minigun"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_Needle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_Needle"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_PumpShotgun"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_PumpShotgun"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_Revolver"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_Revolver"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_RocketswarmLauncher"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_RocketswarmLauncher"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_SmokeLauncher"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_SmokeLauncher"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_SniperRifle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_SniperRifle"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_ThumpCannon"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_ThumpCannon"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_TripleRocket"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_TripleRocket"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Pila"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Pila"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Weapon_GrenadeEMP"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Weapon_GrenadeEMP"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Weapon_GrenadeFrag"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Weapon_GrenadeFrag"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Weapon_GrenadeMolotov"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Weapon_GrenadeMolotov"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "AlphaThrumboHorn"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-AlphaThrumboHorn"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MastodonTusk"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MastodonTusk"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Bow_Great_Unique"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Bow_Great_Unique"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_AssaultRifle_Unique"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_AssaultRifle_Unique"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away

  Scenario: weapon-gallery-4: hand weapons 61 to 80 of 82
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" wields "Gun_BeamRepeater"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_BeamRepeater"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_BeamRepeater_Unique"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_BeamRepeater_Unique"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_BoltActionRifle_Unique"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_BoltActionRifle_Unique"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_ChainShotgun_Unique"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_ChainShotgun_Unique"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_ChargeLance_Unique"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_ChargeLance_Unique"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_ChargeRifle_Unique"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_ChargeRifle_Unique"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_HeavySMG_Unique"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_HeavySMG_Unique"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_HellcatRifle_Unique"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_HellcatRifle_Unique"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_LMG_Unique"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_LMG_Unique"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_Minigun_Unique"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_Minigun_Unique"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_Revolver_Unique"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_Revolver_Unique"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_Scattergun"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_Scattergun"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_SniperRifle_Unique"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_SniperRifle_Unique"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_Axe"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_Axe"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_MonoSword"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_MonoSword"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_MonoSwordBladelink"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_MonoSwordBladelink"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_PlasmaSword"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_PlasmaSword"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_PlasmaSwordBladelink"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_PlasmaSwordBladelink"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_PsyfocusStaff"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_PsyfocusStaff"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_Warhammer"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_Warhammer"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away

  Scenario: weapon-gallery-5: hand weapons 81 to 82 of 82
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_Zeushammer"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_Zeushammer"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "MeleeWeapon_ZeusHammerBladelink"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-MeleeWeapon_ZeusHammerBladelink"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away

  Scenario: weapon-gallery-6: turret, artillery and mech guns 1 to 12 of 12
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" wields "Gun_TacticalTurret"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_TacticalTurret"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_ChargeBlasterTurret"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_ChargeBlasterTurret"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Artillery_AutoMortar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Artillery_AutoMortar"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Artillery_Mortar"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Artillery_Mortar"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_AutocannonTurret"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_AutocannonTurret"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_ChargeBlasterHeavyTurret"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_ChargeBlasterHeavyTurret"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_InfernoCannonTurret"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_InfernoCannonTurret"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_MiniTurret"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_MiniTurret"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_MiniTurretMech"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_MiniTurretMech"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_TurretFoam"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_TurretFoam"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_TurretSniper"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_TurretSniper"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
    When Nelim's Pickle Tools: "Nelim" wields "Gun_AncientArmoredTurret"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "weapon-Gun_AncientArmoredTurret"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away

