# Mods that add buildings, props, animals and plants

Read on 2026-10-18 with `scripts/Search-Workshop.sh` (default mode, ripgrep, `-i '*.xml'`), pattern `<(wildness|plant|designationCategory)>`: 9547 of 9548 folders read (the other one holds no XML). A `<designationCategory>` line marks a building the player can place from an Architect tab (its value is the tab: Furniture, Structure, Production, Misc, ...; furniture and props are told apart by it), a `<wildness>` line an animal, an empty `<plant>` block a plant. Commented lines are left out. Only mods with at least 3 hits per list are shown.

**Counts are text hits, not loaded defs**: a def kept in several version folders counts once per folder, and one that `LoadFolders` never activates counts too (SEARCHING.md). A building that is only reachable through a research or a mod setting counts as well. The exact buildings of the mods that are staged, with size and research, come from the catalogue run (`pickletools-building-catalogue`, CATALOGUE-BUILDINGS.md).

## Buildings and props (1208 mods with 3 or more hits, 2099 with at least one)

| Mod | Workshop id | packageId | Hits | Architect tabs |
|---|---|---|---|---|
| Better Architect Menu | 3563882422 | ferny.BetterArchitect | 5079 | Ferny_Weapons 372, Ferny_Lighting 265, Ferny_PowerGeneration 220, Ferny_Production 211 |
| Vault-Tec - Handy things for your vault! | 1888778429 | Twink.Vaultfurniture | 460 | VaultItems 447, Structure 8, Temperature 4, Production 1 |
| Save Our Ship 2 | 1909914131 | kentington.saveourship2 | 432 | Ship 392, Joy 19, Structure 10, Floors 6 |
| Daily furniture 塔林家具 | 3024562670 | ZeroWhite.Dailyfurniture | 424 | ADH_A_DESIGNATIONCATEGORY 309, Floors 82, Structure 30, Power 3 |
| Medieval Overhaul | 3219596926 | DankPyon.Medieval.Overhaul | 343 | Production 119, DankPyon_RusticFurniture 83, Misc 44, Structure 24 |
| [1.6] Very Ordinary Security Buildings | 3523395212 | FlareShooter.VOSBVer16P | 319 | VOSB_Categories 195, VOSB_CategoriesSup 123, Security 1 |
| 联合轻工家具拓展-UF Light Industries Furniture | 3651799915 | KindSeal.UFLI | 310 | UFLI_designation_group_II 186, UFLI_designation_group 124 |
| 【ZP】Rice cultivating civilization | 3046830338 | Udon.Ricecultivatingcivilization.for14 | 303 | Zipangu 144, Zipangu_KA 78, Zipangu_FU 54, Zipangu_ST 27 |
| [SZ] [综合内容+持续更新版] 含商咀徵——神州文化扩展 Chinese Traditional Cultural Things Expanded | 2877536640 | Dajian.ChiTeaditional.Expanded | 291 | DaJian_Ui_Menu 202, SZ_Ui_Menu_ShengChan 67, Joy 12, Structure 8 |
| Buildable Terrain v1 | 1420979918 | Buildable.Terrain | 245 | terraforming 186, alienworlds 59 |
| Resource Pipes | 3548897173 | HMD.ResourcePipes | 240 | VCHE_PipeNetworks 234, Power 4, Ferny_PowerGeneration 2 |
| Gloomy Furniture Fix | 2987876242 | Gloomy.Furniture.Fix | 232 | OldStyleFurniture 202, OldStyleDeco 30 |
| Lantern Hunters | 2866414675 | kdm.lanternhunters | 227 | Production 68, Misc 42, Joy 26, Structure 18 |
| GloomyFurniture (Continued) Unofficial Fix | 3532426842 | Gloomy.Furniture.Continued.Fix | 222 | OldStyleFurniture 192, OldStyleDeco 30 |
| Vanilla Factions Expanded - Mechanoids | 2329011599 | OskarPotocki.VFE.Mechanoid | 220 | VFE_Factory 183, Security 16, Misc 15, Structure 3 |
| More Furniture (Continued) | 2565302299 | Mlie.MoreFurniture | 214 | ANON2MF 201, Floors 8, Furniture 5 |
| GloomyFurniture (Continued) | 3240958004 | Gloomy.Furniture.Continued | 204 | OldStyleFurniture 174, OldStyleDeco 30 |
| [MUS]哥特式吸血鬼家具 Gothicstyle Vampire Furniture | 3102678787 | mingtuwuxiang.GothicDecorative | 203 | Museum_Decoration 144, Structure 48, Security 8, Furniture 3 |
| Dubs Bad Hygiene | 836308268 | Dubwise.DubsBadHygiene | 196 | Hygiene 122, Temperature 35, Joy 31, HygieneMisc 8 |
| RimLife Expansion Terrain and Floor | 2289110791 | daylight.RimLifeExSTFMod | 192 | Floors 188, Structure 4 |
| [MUS]捕鱼装饰 FishingDecorative | 2981211719 | mingtuwuxiang.FishingDecorative | 185 | Museum_Decoration 156, Structure 24, Furniture 5 |
| RimPlas (Continued) | 2194993727 | Mlie.RimPlas | 172 | Power 72, RimPlas_FurnDesig 40, Temperature 24, Misc 18 |
| More Archotech Garbage (Continued) | 3241944893 | zal.morearchotechgarbage | 164 | MoreArchotechGarbage 93, Floors 21, Power 18, Structure 18 |
| RimLife Expansion Furniture | 2309537905 | daylight.RimLifeExFurMod | 158 | Furniture 98, Temperature 24, Joy 18, Misc 12 |
| Yuran Shrine Japanese Architecture | 3671664434 | Caoyuanfei.YuranShrineJapaneseArchitecture | 149 | Yuranbuilding 89, Production 24, Misc 6, Security 5 |
| TurtleShroom Productions Proudly Presents: Ancient Rim (Continued) | 3507862392 | Mlie.AncientRimCore | 141 | Jerry 81, Temperature 20, Hygiene 13, Security 9 |
| Glitter Tech | 2558099206 | Xavior.GlitterTech | 134 | Security 45, Production 30, Power 28, Furniture 19 |
| Decor into Props | 3771248988 | ferny.decorintoprops | 132 | Misc 128, Ferny_Lighting 3, Joy 1 |
| GloomyFurniture | 1558635181 | Solaris.FurnitureBase | 132 | OldStyleFurniture 112, OldStyleDeco 20 |
| [RH2] Uncle Boris' - Used Furniture | 2563508405 | CP.Uncle.Boris.Used.Furniture | 131 | Structure 36, Misc 24, Joy 24, Furniture 23 |
| Ambition of the Cosmic [Continued] | 3379479793 | Para0234.SNSAmbitionCosmic | 128 | Security 32, Joy 26, Production 24, Misc 22 |
| Raven Race - Embers in Shadow | 3781005562 | ZuoYao.RavenRace | 128 | Raven_Category 85, RavenCum_Category 30, Security 13 |
| [MUS]太空基地家具Space Base Furniture | 3523916780 | mingtuwuxiang.SpaceBaseDecorative | 126 | Museum_Decoration 85, Structure 36, Power 4, Furniture 1 |
| [SZ] [旧版本适用+全版本纯净版] 含商咀徵——神州文化扩展 Chinese Traditional Cultural Things Expanded | 2371079000 | Dajian.ChiTeaditional.Expanded.OldMode | 126 | DaJian_Ui_Menu 84, SZ_Ui_Menu_ShengChan 32, Joy 6, Structure 4 |
| Glitter Tech (No Surgery) | 2559817428 | Xavior.GliterTech.NS | 119 | Security 41, Production 24, Power 24, Furniture 18 |
| UN-Furniture (Continued) | 2019774854 | Mlie.UNFurniture | 119 | SadjuukUN-Furniture 119 |
| DisplayStand | 2024956515 | Spencer.DisplayStand | 117 | Misc 102, Furniture 14, Power 1 |
| Erin's Decorations | 2463358089 | erin.decorations | 116 | Furniture 80, PropsandDecor 36 |
| Rimsenal - Security Pack | 736139206 | rimsenal.security | 111 | Security 105, Power 6 |
| Rimstro | 1714572710 | Lat.Rimstro | 111 | RS_Category 107, Floors 4 |
| VGP Garden Tools | 2007063961 | dismarzero.VGP.VGPGardenTools | 111 | GardenTools 111 |
| Vanilla Expanded Pipe Network Categories | 2971289568 | broms.pipenetworkcategories | 110 | VCHE_PipeNetworks 110 |
| RimTycoon - Core | 3817697186 | nela.rimtycoon.core | 108 | RT_Tycoon 108 |
| Christmas Stuff - Advent calendar (Continued) | 2441048499 | Mlie.ChristmasStuffAdventCalendar | 105 | Furniture 63, Production 14, Structure 14, Misc 7 |
| 华夏扩展 Chinese Comprehensive Expansion | 3221850511 | ninedaylongbow.ChineseComprehensiveExpansion | 105 | HX_Ui_Menu_Furniture 93, Structure 8, Joy 4 |
| Joe's Tweaks | 3458506170 | Joe.MO.Tweaks | 104 | Joe_FloorTanks 16, Ferny_Bedroom 13, Ferny_Lighting 7, Ferny_Seating 6 |
| Rim-Effect Renegade: Core | 3473370247 | RimEffectRenegade.Core | 104 | RE_ArchitectPrefab 104 |
| RimApps (Continued) | 2581240648 | Mlie.RimApps | 104 | Production 104 |
| Apothecary (Continued) | 2195469123 | Mlie.Apothecary | 102 | Production 78, Temperature 12, Power 6, Furniture 6 |
| Fertile Fields 1.6 | 3225843229 | jamaicancastle.RF.fertilefields | 102 | RFF_Farm 79, ? 6, Security 6, Production 5 |
| Rimstation 13 a e s t h e t i c mod | 1545845883 |  | 99 | Misc 45, Furniture 35, Joy 17, Production 1 |
| Star Wars KotOR Resources and Materials | 3254370945 | guy762.MM.KotORCore | 97 | KOTOR_BuildTab 91, Power 3, MM_StarWarsShipBuildTab 3 |
| [CM] Spots Tab | 2603638022 | CM.SpotsTabMod | 96 | CM_SpotsTab 96 |
| Road to the Ultimate Material | 2145007265 | daylight.LRUltimateMatt | 92 | Misc 19, Power 16, Production 15, Security 10 |
| GravTech | 3545374124 | als.gravtech | 90 | Odyssey 26, VGE_Workbenches_GT 18, VGE_Power_GT 12, Security 6 |
| Perspective Walls | 2163949230 | edwardsh.perswalls | 88 | PersWallsTriangular 58, PersWallsSpecial 21, PersWallsPassable 5, PersWallsImpassable 1 |
| Vee's decorating Abyss (Continued) | 2400813464 | Mlie.VeesDecoratingAbyss | 88 | Misc 80, Production 8 |
| Mincho, The Mint Choco Slime ~ HAR ver. | 2477501851 | SutSutMan.MinchoTheMintChocoSlimeHARver | 86 | Mincho_Furniture 86 |
| Rim-Effect: Core | 2479560240 | RimEffect.Core | 84 | Misc 21, Power 18, Security 15, Temperature 9 |
| Appliances Expanded | 2869098359 | scpchemfuel.appliances | 83 | Production 44, Power 23, Furniture 8, Temperature 8 |
| Fortifications - Industrial | 2561619583 | Aoba.Fortress.Industrial | 82 | Security 46, Misc 15, Power 13, Production 4 |
| VGP Garden Gourmet | 2007062982 | dismarzero.VGP.VGPGardenGourmet | 82 | Production 68, Misc 14 |
| OCanonnsMod | 2585577254 | OCM.Cannons | 81 | OCM 80, Security 1 |
| Vanilla Factions Expanded - Insectoids 2 | 3309003431 | OskarPotocki.VFE.Insectoid2 | 81 | VFEI2_Insectoids 81 |
| RimFantasy - Medieval Overhaul Edition | 2836791007 | Sierra.RF.MedievalOverhaul | 80 | Furniture 40, Temperature 20, Security 15, Production 5 |
| Edo Themed Expansion | 2878807817 | Heis.Edo.Themed.Expansion | 79 | HSEdoBuildingsTab 73, Structure 3, Security 3 |
| [1.7]边缘仙路-神机天纵 RimImmortal-Forge | 3308873789 | RI.RimImmortal.Forge | 78 | RI_RimImmortals_Furniture 33, RI_RimImmortals_Group 29, Security 9, Power 7 |
| GlitterStone | 3448660461 | Harmonea.GlitterStone | 77 | AdvBF_Category 45, Structure 32 |
| Early Times (Continued) | 3289912856 | zal.earlytimes | 76 | Production 16, Furniture 12, Security 12, Structure 10 |
| RimCuisine 2: Bottling and Booze Expansion (Continued) | 2069596932 | Mlie.RC2.BaBE | 76 | RC2_RimCuisine 73, Production 3 |
| Floor Lights 2 | 2882927601 | temeez.floorlights2 | 75 | Lamps 72, Floors 3 |
| Glitter Tech Classic | 725576127 | GT.Sam.GlitterTech | 75 | Security 25, Power 18, Production 14, Furniture 9 |
| Vanilla Furniture Expanded | 1718190143 | VanillaExpanded.VFECore | 75 | Furniture 49, Joy 16, Misc 8, Temperature 2 |
| Vanilla Vehicles Expanded | 3014906877 | OskarPotocki.VanillaVehiclesExpanded | 75 | VF_Vehicles 72, Security 3 |
| Palim - P.S. Series | 3797374488 | Valensia.Palim | 72 | Palim 38, PalimIndustry 33, Joy 1 |
| Taki's Random Stuff (Continued) | 2483488820 | Mlie.TakisRandomStuff | 72 | Production 72 |
| Ultimate Survival (Continued) | 2306285708 | Mlie.UltimateSurvival | 72 | Security 42, Production 18, Power 12 |
| CeleTech Arsenal MKIII | 3446237098 | TOT.CeleTech.MKIII | 71 | CMC_DefensenProduction 71 |
| Vee's decorating | 1585057683 | Lat.VeeDeco | 70 | VeeDecoCategory 70 |
| ZARS Core | 1502619368 | dracoix.zars.core | 70 | Desperation 56, Structure 8, Power 6 |
| Misstall's Furniture | 3688166182 | Misstall.Furniture | 69 | MF_Building 69 |
| Whaleys Props | 3523190580 | Whaley.WhaleysProps | 69 | WhaleysProps 67, Furniture 2 |
| A RimWorld of Magic | 1201382956 | Torann.ARimworldOfMagic | 68 | Production 34, Misc 21, ? 13 |
| Paintable Gloomy Furniture | 2881715849 | Paintable.Gloomy.Furniture | 68 | OldStyleFurniture 58, OldStyleDeco 10 |
| RimTycoon - Hospital | 3817712487 | nela.rimtycoon.hospital | 68 | RT_Tycoon 68 |
| 雅居·四象 / Elegant Interiors · Four Realms | 3809685888 | baolei.elegantinteriors2 | 68 | EI2_FourRealms 68 |
| Genetic Rim | 1113137502 | sarg.geneticrim | 67 | GR_GeneticsTab 61, Security 3, Power 3 |
| Glass+Lights | 826153738 | NanoCE.GlassLights | 67 | Furniture 26, Production 18, Structure 12, Joy 6 |
| Pawnmorpher | 1786466855 | tachyonite.pawnmorpherpublic | 67 | GR_GeneticsTab 56, Security 6, Production 5 |
| Soil Growverhaul | 2836539042 | Joeyjoejoeshabidoo.Growverhaul | 66 | Floors 62, Production 3, Power 1 |
| Vanilla Furniture Expanded - Architect | 2608762624 | VanillaExpanded.VFEArchitect | 66 | Structure 50, Floors 16 |
| [RWY]Dragon's Descent: Void Dwellers | 3349058179 | ravvy.DD.Void.Addon | 65 | DD_Void_Dragon_Stuff 65 |
| Carpets++ 1.6 | 2487332833 | Daniledman.Carpets | 65 | FurnitureCarpetsPP 65 |
| Clockwork And Steam (Continued) | 3316197028 | zal.clockworkandsteam | 62 | Steampunk 52, Security 8, Power 2 |
| RimLife Expansion Production Plus | 2523034535 | daylight.RLEsExpansionProductPS | 61 | Production 37, Misc 18, RLE_Decoration 6 |
| Survivalist's Additions (Continued) | 3052462368 | Mlie.SurvivalistsAdditions | 61 | Production 31, Structure 12, Misc 6, Temperature 6 |
| Medical Supplements (Continued) | 2195037369 | Mlie.MedicalSupplements | 60 | Misc 54, Production 6 |
| RimLife Expansion Electric Power | 2291047258 | daylight.RimLifeExSPWMod | 60 | Power 60 |
| Westerado (Continued) | 2236973780 | Mlie.Westerado | 60 | Security 15, Production 15, Temperature 10, Joy 10 |
| Homesteader | 3759238501 | AzraelGodKing.Homesteader | 59 | Production 22, Homesteader_Storage 12, Furniture 12, Power 6 |
| Miho, the celestial fox | 2816826107 | miho.fortifiedoutremer | 59 | MihoBuilding 59 |
| UNAGI Decorative Furniture | 3379047800 | UNAGI.Funiture.Build.window | 58 | UNAGI_Furniture 58 |
| Fortification Industrial - Citadel | 2887532326 | Aoba.Fortress.Industrial.Citadel | 57 | Security 19, Misc 16, FTC_PermanentStructure 6, Power 4 |
| Oni of the Rim | 2891432261 | tarojun.morishep.onioftherim | 57 | Production 19, Security 16, Misc 12, Furniture 4 |
| Vanilla Helixien Gas Expanded | 2877699803 | VanillaExpanded.HelixienGas | 57 | VCHE_PipeNetworks 43, Production 5, Furniture 4, Temperature 2 |
| Hospitals Extended | 2121326566 | zymex.HospitalsExtended | 56 | HE_Hospital 54, Structure 2 |
| Sparkling Worlds - Full Mod | 1123043922 | Albion.SparklingWorlds.Full | 56 | Misc 28, Production 14, Power 7, Furniture 7 |
| Warhammer-ish:Dryad (Continued++) | 3563451515 | Mortimer.WarhammerishDryad | 56 | Production 28, Security 14, Furniture 14 |
| Clutter Furniture | 2056740389 | neronix17.clutterfurniture | 55 | Production 25, Furniture 20, Temperature 5, Misc 5 |
| Korean Style Furniture | 3733695302 | milple.KoreanStyleFurniture | 55 | Milple_furniture 49, Production 6 |
| Muke's Medieval balance | 3740446179 | medievalbalance.Mukezh | 55 | DankPyon_RusticFurniture 8, Ferny_Production 5, Ferny_Decorations 4, Ferny_Auxiliaries 4 |
| [1.7]边缘仙路-羽化登仙 RimImmortal-Core | 3296476341 | RI.RimImmortal.Core | 54 | RI_RimImmortals_Group 54 |
| [HYE] Nanotech Overpower | 3533473917 | Hye.NTO | 54 | Floors 24, Production 8, Security 6, Biotech 4 |
| Gloomy Deco | 1865654125 | Dalrae.GloomyDeco | 54 | OldStyleDeco 54 |
| Sunset Technology 3 | 3601719516 | SunsetModerTeam.SunsetTechnology3 | 54 | Buildings_cy 54 |
| GC虚空台/虚空造物 | 3580038288 | gc.XKT | 53 | GC_XKT_DesignationCategoryDef 53 |
| TurtleShroom Productions Proudly Presents: Make Honey EVEN MORE Compatible | 2959585309 | TSP.zal.patchhoney2 | 53 | TSP_DoctorBees_Buildings 53 |
| Gas Traps And Shells | 2012627964 | com.distman.gastrap | 52 | Security 52 |
| Ludus — Gladiateurs | 3813622260 | boogiesman.ludus.gladiateurs | 52 | Ludus 52 |
| Sunset Weapon Technology 2 | 2890976130 | SunsetModerTeam.SunsetWeaponTechnology2 | 52 | Buildings_cy 52 |
| [GP]Flowery Furniture | 3649367637 | Flower.Furniture.GP | 51 | FLFurniture 51 |
| RimCuisine 2 Core (Continued) | 2562519366 | Mlie.RC2.Core | 51 | RC2_RimCuisine 42, Production 9 |
| Vanilla Furniture Expanded - Security | 1845154007 | VanillaExpanded.VFESecurity | 51 | Security 51 |
| Vanilla Temperature Expanded | 3202046258 | VanillaExpanded.Temperature | 51 | Temperature 51 |
| <![CDATA[Advanced Bridges & Corners]]> | 3006527110 | kongkim.AdvancedBridges | 50 | KKBridges 48, Joy 2 |
| Ceramics (Continued) | 3537698767 | zal.ceramics | 50 | Production 47, Misc 3 |
| Hakuro Xenohuman | 2911715839 | Hakuro.Xenohuman.septentrionrace | 50 | Production 14, Misc 13, Security 9, Biotech 9 |
| RimVali: Far From Avalon | 2936412543 | Nesi.RimValiFFARW | 50 | RVFFA_Furniture 33, RVFFA_Security 12, RVFFA_Production 5 |
| Chemistry Tech (Continued) | 2373492195 | Mlie.ChemistryTech | 49 | Furniture 28, Production 14, Power 7 |
| Power++ | 1771402217 | aRandomKiwi.PowerPP | 49 | Power 49 |
| Utility Columns | 2013476665 | nephlite.orbitaltradecolumn | 49 | Security 21, Furniture 11, Misc 8, Temperature 7 |
| [Syulipia]OrientalDragonMOD (Continued) | 3564312643 | ProjectSyulipia.OrientalDragonMOD.continued | 48 | Syulipia_Tools 48 |
| 【1.6】Hello, Lansy Forked | 3180951208 | mg.ferianstory.lansy.fork | 48 | AF_CITE 33, AF_Thankyou 12, Security 3 |
| Rimefeller | 1321849735 | Dubwise.Rimefeller | 48 | Rimefeller 40, ? 8 |
| Small Furniture | 3696700829 | Xercaine.Furniture.Small | 48 | Production 41, VF_Vehicles 3, Misc 2, Ideology 2 |
| Vanilla Factions Expanded - Classical | 2787850474 | OskarPotocki.VFE.Classical | 48 | Production 20, Temperature 8, Misc 8, Joy 8 |
| Hellsing ARMS Ultimate | 2834801420 | Baskerville.HellsingARMSUltimate | 47 | Production 24, Misc 15, Security 4, ? 4 |
| Alpha Biomes | 1841354677 | sarg.alphabiomes | 46 | Furniture 20, AB_AlphaBiomesBuildings 15, Production 4, Structure 3 |
| Decorative Terrain Elevation  | 3338573086 | quality.decorativeterrain | 46 | Floors 46 |
| Gravship Conquest- RimSkyBlockDLC | 3702563414 | YeXiaoYang978.RimSkyBlockHUHOdysseyDLC | 45 | Odyssey 40, Power 5 |
| Big and Small Furniture | 3024478368 | RedMattis.BSFurniture | 44 | BS_Furniture 44 |
| Jurassic Rimworld (Continued) | 3541468886 | Mlie.JurassicRimworld | 44 | JurassicRimworld 35, AviaryJurassicRimworld 8, Structure 1 |
| Outer Rim - Furniture &amp; Decor | 2919553599 | Neronix17.OuterRim.FurnitureAndDecor | 44 | OuterRim_ArchitectHypertech 44 |
| [1.7]边缘仙路-俗世仙工 RimImmortal-Living | 3326145525 | RI.RimImmortal.Living | 43 | RI_RimImmortals_Group 33, Joy 8, Production 2 |
| [CP] Military Furniture | 2019227986 | CP.Military.Furniture | 43 | Misc 22, Structure 7, Furniture 5, Joy 4 |
| Blue Archive Furniture | 3491176484 | mlmlmlm.bluearchivefurniture | 43 | BA_Decoration 43 |
| Tribal Essentials Reborn | 2597790751 | zal.tribalessentials | 43 | Production 13, Security 8, Joy 8, Furniture 4 |
| [1.7]边缘仙路-炊耕百味 RimImmortal-Farmcraft | 3655458570 | RI.RimImmortal.Farmcraft | 42 | RI_RimImmortals_Group 42 |
| [WYD] Thermoregulation | 3011190988 | Wyr3d.Thermoregulation | 42 | Production 24, Temperature 12, Furniture 6 |
| Basic Dropdowns - Extended | 3562304092 | KobeRiddle.CategoriesDropdownsExtended | 42 | Production 9, Ferny_Lighting 4, Furniture 4, Ferny_Kitchen 4 |
| Blue Archive Furniture 4 | 3685138265 | mlmlmlm.bluearchivefurniture4 | 42 | BA_Decoration 38, Structure 2, Temperature 2 |
| Endgame Buildings (Continued) | 2899213464 | Mlie.EndgameBuildings | 42 | Misc 30, Production 6, Power 6 |
| Extended Woodworking | 836912371 | teflonjim.extendedwoodworking | 42 | Structure 25, Floors 10, Production 7 |
| Land Fill (Terrains+) (Continued) | 2162781055 | Mlie.LandFill | 42 | DesignationLandFill 42 |
| Medieval Times (Continued) | 2880558608 | zal.medievaltimes | 42 | MedTimes_Medieval 15, Structure 12, Security 12, Power 3 |
| NPDTiers - The Nutrient Paste Expansion Mod (Continued) | 2043895447 | Mlie.NPDTiers | 42 | Production 42 |
| Real World Food 2-Fish Addon (Continued) | 2256557380 | Mlie.RealWorldFood2FishAddon | 42 | RealFoodmaker 28, Production 14 |
| RimWriter - Books, Scrolls, Tablets, and Libraries (Continued) | 2251045831 | Mlie.RimWriter | 42 | Joy 35, Production 7 |
| Simple Mining Extension (Continued) | 2819002574 | Mlie.SimpleMiningExtension | 42 | Production 29, Misc 7, Power 6 |
| Ultima Britannia Construction Co. | 2610773618 | Bowen.Ultima.Construction | 42 | Structure 30, Misc 7, Furniture 3, Ideology 2 |
| Vanilla Factions Expanded - Medieval 2 | 3444347874 | OskarPotocki.VFE.Medieval2 | 42 | Structure 12, Production 10, Misc 6, Temperature 4 |
| Vanilla-like wheat (Continued) | 2717707382 | Mlie.VanillalikeWheat | 42 | Production 42 |
| [sd] Bridges (Continued) | 2036488024 | Mlie.SDBridges | 41 | sd_bridges_category_terraform 21, Structure 20 |
| Alpha Memes | 2661356814 | Sarg.AlphaMemes | 41 | Misc 27, Security 6, Furniture 4, Ideology 2 |
| Ancient_Structures(continued) | 2177808043 | AncientStructures.Velcroboy333 | 41 | Structure 11, Floors 10, Security 10, Temperature 6 |
| Cake! Furniture-蛋糕家具 | 3629632481 | elsa.CakeFurniture.FDF | 41 | FDF_CakeFurniture 41 |
| Eccentric Tech - Spacer Furniture | 3118185542 | Aelanna.EccentricTech.Furniture | 41 | Eccentric_Tech 41 |
| Stratum | 3740754795 | SolarWeb.Stratum | 41 | SolarWeb-Stratum-Roofs 15, Misc 5, Ferny_Farming 3, Temperature 3 |
| Comigo's Nutrition (Continued) | 3290758760 | Mlie.ComigosNutrition | 40 | Production 40 |
| Dead Can Serve (Continued) | 2548091455 | Mlie.DeadCanServe | 40 | Production 24, Misc 8, Floors 8 |
| EM Ancient Technology (Continued) | 2568842105 | Mlie.EMAncientTechnology | 40 | Security 28, Production 12 |
| Expert Stairs | 3688237449 | milple.ExpertStairs | 40 | Milple_Stairs 40 |
| RimLife Expansion Structure | 2305035365 | daylight.RimLifeExSRCMod | 40 | Structure 40 |
| Malay Themed Expansion | 2884249920 | NSTR.Malay.Themed.Expansion | 39 | NSTRMalayBuildingsTab 39 |
| RIMkea (Continued) | 3324786856 | zal.rimkea | 39 | RIMkea 39 |
| Alpha Props - Parks and Gardens | 3146268928 | sarg.alphapropsparks | 38 | Furniture 20, Structure 14, Floors 4 |
| Dark Ages : Crypts and Tombs | 2963826335 | Van.DACrypts | 38 | Furniture 16, Misc 14, Ideology 5, Structure 3 |
| WA v1.0 | 1548358607 |  | 38 | WA_Builder 34, WA_FutonCategory 3, ? 1 |
| 雅居 · Elegant Interiors | 3802178852 | baolei.elegantinteriors | 38 | EI_ElegantInteriors 38 |
| Dragons Descent | 2026992161 | onyxae.dragonsdescent | 37 | Misc 17, Furniture 12, Ideology 6, Temperature 2 |
| 菜篮子工程扩展-五谷丰登(Shopping Basket Program-Bumper harvest Expansion) | 3725184247 | shenpc.ShoppingBasketProgramBumperharvest | 37 | SBP_ShoppingBasketProgram 37 |
| Censored Armory | 2356277786 | ALIEN.CensoredArmory | 36 | Reich_Armory_Tab 36 |
| Crystalloid | 1571323744 | atomicravioli.Crystalloid | 36 | Misc 10, Security 8, Power 8, Production 5 |
| JapaneseHomestead | (local) JapaneseHomestead |  | 36 | WA_Builder 33, WA_FutonCategory 3 |
| Kai's Vending Machine | 3161655279 | kai.vendingmachine | 36 | Vending 36 |
| Nelim's Japanese Homestead (unofficial) | 3806764776 | nelim.wa | 36 | WA_Builder 33, WA_FutonCategory 3 |
| Outlander Solutions - Vehicles | 3058386745 | Mjeiouws.Outlander.Vehicles | 36 | VF_Vehicles 34, Misc 2 |
| Pharma (Continued) | 2856432368 | zal.Pharma | 36 | Production 28, Misc 8 |
| RimSkyBlock - Vassal Outposts, Establish Empire | 3564083626 | Yexiaoyang.RimSkyBlock | 36 | RSB_SkyBlock 36 |
| [sd] Advanced Powergeneration (Continued) | 2079579039 | Mlie.SdAdvancedPowergeneration | 35 | Power 35 |
| Epona Dynastic Rise | 3514746737 | Epona.EponaDynasticRise | 35 | Production 19, Security 6, Misc 5, Power 5 |
| Izzyssentials (Continued) | 2510322065 | Mlie.Izzyssentials | 35 | Power 21, Structure 7, Production 7 |
| Red Army (Continued) | 2471982147 | Mlie.RedArmy | 35 | Security 28, Joy 7 |
| Rim of Madness - Bones Unofficial Fix | 3252977437 | sihv.rombonesPort | 35 | Floors 28, Structure 7 |
| Velcroboy's Japanese Revival | 2160109949 | JapanStyle.velcroboy333 | 35 | Furniture 20, Misc 5, Temperature 5, Structure 5 |
| Zen Garden (Continued) | 2777931683 | Mlie.ZenGarden | 35 | ZEN_Decoration 21, Joy 7, Misc 7 |
| [LSK]月兔扩展——基础家具和设施 | 3155273482 | LSK.RabbieFurnitureAndFacilities.Basic | 34 | Enterprise_architecture 34 |
| [OA]Ratkin : Knight Order(Furniture) | 3492088220 | OARK.RatkinKnightOrderFurniture | 34 | Misc 9, Joy 8, Furniture 6, Production 4 |
| Hotels and Recreation | 3814336747 | ROBTRG.HotelsAndRecreation | 34 | Misc 20, Joy 12, Furniture 2 |
| Ratkin Lifestyle+ | 3263391066 | fxz.ratkinlifestyle.update | 34 | OldStyleDeco 34 |
| Rimsential - Homebound: Continued | 3119559485 | Orpheusly.PawnStorages | 34 | Production 24, Furniture 6, Misc 4 |
| VGP Vegetable Garden | 2007061826 | dismarzero.VGP.VGPVegetableGarden | 34 | Temperature 10, Production 9, Floors 8, Furniture 7 |
| Weird Defences | 1753026389 | Luke.WeirdDefences | 34 | Security 34 |
| [VSER] Industry | 2997037628 | VSER.Industry | 33 | Power 12, Production 9, Misc 8, Temperature 4 |
| ActiveResponseTraining (Continued) | 2570370139 | Mlie.ActiveResponseTraining | 32 | Security 32 |
| Alpha Bees | 1558161673 | sarg.rimbees | 32 | RB_Bees 32 |
| Mechanoid Factory 1.6 (prohibited) | 3806762382 | nelim.mechanoidfactory | 32 | VFE_Factory 29, Misc 2, Security 1 |
| MechanoidFactory | (local) MechanoidFactory |  | 32 | VFE_Factory 29, Misc 2, Security 1 |
| Organic Based Industry | 3749691458 | hoffy57.OrganicBasedIndustry | 32 | hoffy57_OBI 23, Power 4, Production 3, Misc 1 |
| Ponpeco Furnitures : Sci-Fi | 3610234567 | ponpeco.PFSF | 32 | PonpecoFurniture 32 |
| Rimsenal: Murder diversified | 725947920 | rimsenal.core | 32 | Production 32 |
| Corruption: Worship | 2555397551 | CptVHOhu970.CorruptionWorship | 31 | Worship 27, Structure 4 |
| Aliaile Race Furniture | 3706046839 | Misstall.AR.IdeologyStyle | 30 | AR_Building 29, MF_Building 1 |
| Ancient urban ruins | 3316062206 | XMB.AncientUrbanrUins.MO | 30 | AM_FLOOR 12, Misc 10, Production 4, Power 4 |
| Biomes! Fossils | 3100958580 | BiomesTeam.BiomesFossils | 30 | BMT_Paleontology 30 |
| Boats (Continued) | 3017479589 | zal.boats | 30 | VF_Vehicles 30 |
| Caravan Equipment (Continued) | 2607286876 | Mlie.CaravanEquipment | 30 | Temperature 12, Security 6, Production 6, Power 6 |
| LateGameQuests (LoGiQ) | 3740630604 | Dimman.LateGameQuests | 30 | Security 23, Misc 7 |
| Rim of Madness - Bones | 1180573408 | sihv.rombones | 30 | Floors 24, Structure 6 |
| RimLife Expansion Security | 2297837011 | daylight.RimLifeExSCYMod | 30 | Security 30 |
| SimpleStairs (Fork) | 3526906079 | rw.mod.simplestairs | 30 | OldStyleFurniture 18, Structure 12 |
| The Profaned | 3202008037 | BotchJob.Profaned | 30 | Furniture 12, Production 6, Structure 3, Security 3 |
| Vanilla Furniture Expanded - Production | 1880253632 | VanillaExpanded.VFEProduction | 30 | Production 18, Misc 12 |
| Weapons of the Gods (Continued) | 2689357399 | Mlie.WeaponsOfTheGods | 30 | Production 16, Security 14 |
| Oracle's Miscellania | 3279582979 | oracle.miscellania | 29 | Structure 18, Ship 10, Odyssey 1 |
| RimForge | 2505778174 | co.uk.epicguru.rimforge | 29 | Power 11, Security 9, Misc 6, Production 3 |
| Tabletop Decorations | 2535771403 | ucp.TabletopDecorations | 29 | Furniture 29 |
| Colony Leadership (Continued) | 2859856468 | Mlie.ColonyLeadership | 28 | LeadershipModTab 28 |
| Eternal Science | 3537565209 | LostS1ght.EternalScience.250601 | 28 | EternalScience_LostS1ght 28 |
| Expanded Brickwork | 3587748570 | qq.expanded.brickwork | 28 | Production 28 |
| Honey Unification for BIOMES! BEES | 3746323752 | lucius.beeuni | 28 | Production 12, Ferny_Farming 8, Misc 4, Ferny_Kitchen 4 |
| Medieval Overhaul: Immersive Storage Patch | 3580586626 | Fodo.MedievalOverhaulImmersiveStorage | 28 | DankPyon_RusticDecoration 26, ASFstorage 2 |
| OuterrealmTech 超维科技 | 3712146789 | Jeremie.Fully.Automatic.OmniCrafter | 28 | OmniCrafter_Category 28 |
| RazzleDazzle! (Continued) | 2024612321 | Mlie.RazzleDazzle | 28 | Joy 28 |
| RimCuisine 2 Meals and Munchies Expansion (Continued) | 2069589941 | Mlie.RC2.MaME | 28 | RC2_RimCuisine 21, Production 7 |
| The Poop Mod | 1728184416 | WindowsXP.ThePoopMod | 28 | Temperature 9, Furniture 6, Power 5, Production 5 |
| Vanilla Chemfuel Expanded | 2792917473 | VanillaExpanded.VChemfuelE | 28 | VCHE_PipeNetworks 28 |
| Vanilla Furniture Expanded - Power | 2062943477 | VanillaExpanded.VFEPower | 28 | Power 28 |
| Vanilla Furniture Expanded - Spacer Module | 2028381079 | VanillaExpanded.VFESpacer | 28 | Furniture 16, Joy 8, Misc 4 |
| Popstar Mod  | 3550566071 | Axotl.PopstarMod | 27 | VF_Vehicles 25, Security 1, Power 1 |
| RimOverhaul | 1760022158 | FunkyShit.RimOverhaul.Main | 27 | GasProduction 11, Power 7, Production 6, Misc 1 |
| Ushankas Glittertech Expansion | 3522676478 | Ushanka.GlittertechExpansion | 27 | Misc 9, Production 6, Security 5, Joy 3 |
| [Syulipia]SlimeMOD | 1651394964 | ProjectSyulipia.SlimeMOD | 26 | Syulipia_Tools 26 |
| Bleach Mod | 3635653759 | RS.BleachMod | 26 | Floors 12, Misc 11, Structure 2, Production 1 |
| Crystal Tech 透晶科技 | 3735005608 | Maiya.CrystalTech | 26 | Structure 17, Furniture 6, Floors 1, Security 1 |
| Get Rimped - Gym Equipment - Pumped Up | 3534002285 | kones.getrimped | 26 | Joy 26 |
| Gloomy Vanilla Overhaul | 1883678698 | zymex.GloomyVanillaOverhaul | 26 | Furniture 14, OldStyleDeco 4, Structure 2, Temperature 2 |
| GloomyFurniture Darklight Expanded | 2972239868 | GFDE.DarklightExpanded | 26 | OldStyleFurniture 26 |
| Potato Overlord's Alcohol Expansion Mod | 1372954702 |  | 26 | Production 26 |
| Vanilla Factions Expanded - Vikings | 2231295285 | OskarPotocki.VFE.Vikings | 26 | Misc 11, Joy 6, Temperature 3, Structure 3 |
| [CP] Military Furniture (B18) | 1401289932 |  | 25 | TacticoolDes 23, Furniture 2 |
| [HMC]Wall Furniture | 3533512691 | HMC.Wall.Furniture | 25 | Security 18, Misc 5, Joy 1, Production 1 |
| Amnabi's Flags (Continued) | 2592638428 | Mlie.AmnabisFlags | 25 | Furniture 25 |
| Biomes! Caverns | 2969748433 | BiomesTeam.BiomesCaverns | 25 | Production 12, Structure 6, Power 4, Misc 3 |
| Fantasy Biotech | 3632363090 | vr.fantasy.biotech | 25 | VR_Artifice 16, Biotech 4, Temperature 2, Misc 2 |
| Put Linkables With Linked! | 3571782995 | KobeRiddle.PutLinkablesWithLinked | 25 | Production 8, Ferny_Production 3, Ferny_ResearchProduction 3, Ferny_Medical 3 |
| RimHighSchool! | 3312818432 | barsil.RimHighSchool | 25 | Rhsbuilding 24, Structure 1 |
| Wall Decorations | 2546782400 | ucp.WallDecorations | 25 | Furniture 20, Hygiene 3, Power 2 |
| Witching Hour (Continued) | 2596779692 | zal.WitchingHour | 25 | Misc 10, Furniture 10, Production 5 |
| 边缘仙路-四象之争 RimImmortals-SeasonsOfRule | 3308877707 | RI.RimImmortals.SeasonsOfRule | 25 | RI_RimImmortals_Group 14, Power 5, Joy 3, RI_RimImmortals_Furniture 3 |
| [RF] Concrete (Continued) | 2012397587 | Mlie.Concrete | 24 | Structure 10, Production 7, Security 7 |
| [RF] Fishing-ReWork (Continued) | 2920098766 | Mlie.RFFishingReWork | 24 | Production 24 |
| [TW1.6]烧烤之星2.0 Barbecue~Star2.0 | 3226645152 | TW.BBQS.Barbecue.Star | 24 | Misc 14, Production 10 |
| Alpha Animals | 1541721856 | sarg.alphaanimals | 24 | VFEI2_Insectoids 18, Power 6 |
| Alpha Vehicles - Neolithic | 3028675048 | sarg.alphavehiclesneolithic | 24 | VF_Vehicles 24 |
| Construction Expanded | 2794480005 | CS.CE | 24 | Production 7, Temperature 6, Structure 3, Furniture 3 |
| Dragon's Torch | 3544458513 | tc3wikieditor.compat.DragonsTorch | 24 | Furniture 24 |
| Mona The Moon Bear (1.6 fork) | 3248186952 | kku.MonaTMB | 24 | Production 24 |
| Rimsenal Faction Pack - Federation | 736172213 | rimsenal.federation | 24 | Security 16, Production 8 |
| 巴尔：赛马与伙伴 / Baal: Racing and Companions | 3800832686 | baal.racingandcompanions | 24 | Joy 16, BRC_Campus 8 |
| Blue Archive Furniture 5 | 3802627735 | mlmlmlm.bluearchivefurniture5 | 23 | BA_Decoration 23 |
| Jujutsu Kaisen | 3658634704 | RSG.JJKMod | 23 | Floors 14, JJK_Jujutsu 8, Furniture 1 |
| [LTS]Furnishing | 2567438519 | LimeTreeSnake.Furnishing | 22 | LTSFurniture 12, Temperature 4, Joy 1, Misc 1 |
| Blue Archive Furniture 2 | 3541617529 | mlmlmlm.bluearchivefurniture2 | 22 | BA_Decoration 22 |
| Ceramics VEF (1.6 Fork) | 3525659711 | n7huntsman.ceramics.1.6.fork | 22 | Production 13, Insulation_Desig 4, VFE_Factory 3, Structure 2 |
| Children, school and learning | 1541438230 | Dylan.CSL | 22 | Production 22 |
| Expanded Prosthetics and Organ Engineering - Forked | 1949064302 | vat.epoeforked | 22 | Production 22 |
| I Am Hungry(continued) | 2094216512 | IAmHungry.velcroboy333 | 22 | Production 14, Temperature 7, OldStyleFurniture 1 |
| Malfunction (Continued) | 2970476077 | zal.malfunction | 22 | Power 12, Security 6, Production 4 |
| Rimbody | 3354086860 | Maux36.Rimbody | 22 | Joy 18, Furniture 2, ASFstorage 2 |
| Transcendent Mechanoid（超凡机械体） | 3543445173 | Matthew.mei.Transcendent.Mechanitors | 22 | Security 8, Biotech 6, Misc 4, Power 4 |
| Vanilla Genetics Expanded | 2801160906 | VanillaExpanded.VGeneticsE | 22 | GR_GeneticsTab 22 |
| A Monkey Expansion (Continued) | 3166737970 | zal.monketime | 21 | Power 15, Security 6 |
| EM Insects And Plants (Continued) | 2025643074 | Mlie.EMInsectsAndPlants | 21 | Production 21 |
| Imperial Functionality | 3112706932 | YabbyShabby.ImperialFunctionality | 21 | IF_ImperialTech 21 |
| Mechanite Plague | 2503246357 | Chairheir.MechanitePlague | 21 | Security 17, Misc 4 |
| NaturalFloors (Continued) | 2618631108 | Mlie.NaturalFloors | 21 | Production 14, Floors 7 |
| No Water, No Life (Continued) | 2387857358 | Mlie.NoWaterNoLife | 21 | Mizu 21 |
| Organized Food Mods | 2254893913 | Cozarkian.Organized.Food | 21 | DZ_Culinary 20, GardenTools 1 |
| Outland - Furniture &amp; Decor | 2897435739 | Neronix17.Outland.FurnitureAndDecor | 21 | Outland_Outland 21 |
| Roots of Rimworld | 2977818583 | GHOST.RootsofRimworld | 21 | Furniture 21 |
| Temperature Gauge (Continued) | 2017464494 | Mlie.TemperatureGauge | 21 | Temperature 14, Power 7 |
| Ultima: Artisan's Guild | 2615809268 | Bowen.Ultima.Artisans | 21 | Furniture 15, Production 6 |
| Vanilla Races Expanded - Sanguophage | 2963116383 | vanillaracesexpanded.sanguophage | 21 | Biotech 21 |
| Vanilla Recycling Expanded | 3155781848 | VanillaExpanded.Recycling | 21 | Biotech 21 |
| (NWN) Real Fog of War (Continued) | 3391128917 | Mlie.NWNRealFogOfWar | 20 | Security 20 |
| Doors Expanded | 3532342422 | jecrell.doorsexpanded | 20 | Structure 20 |
| Glowpods | 2312396995 | Forsaken.Growpods | 20 | Misc 20 |
| Nanomachine Foundry | 3277088090 | ThatHitmann.NanomachineFoundry | 20 | THNMF_PipeNetworks 20 |
| PLA-Armory | 2439966011 | IssacZhuang.PLA.Armory | 20 | Security 15, Production 5 |
| Reel's Expanded Storage | 3237638097 | reel.expanded.storage | 20 | Furniture 9, Security 5, VF_Vehicles 3, Misc 3 |
| Stellaris DEMO | 3769459524 | Feng.StellarisDEMO | 20 | Ship 15, Misc 3, Power 1, Structure 1 |
| Stone Age v2019.01 | 1710940628 |  | 20 | Production 8, Temperature 4, Misc 3, Structure 2 |
| Toxicity Evolved | 3262128970 | basilthebatlord.toxicityevolved | 20 | Rimefeller 10, Furniture 4, Power 2, Production 2 |
| Undergrounders: Complete | 2817357535 | BattIeBear.Undergrounders.Complete | 20 | Temperature 12, Furniture 4, Ideology 2, Misc 2 |
| World Expanded - EasternLamps (Continued) | 3468431559 | jsin0.Worldexpanded.eastern.lights | 20 | Lamps 18, Furniture 2 |
| AncientSalvage | (local) AncientSalvage |  | 19 | Misc 10, Production 4, Temperature 2, Structure 2 |
| Dropdown Production Buildings | 3223442477 | kongkim.DropdownProductionBuildings | 19 | Production 7, Power 6, Furniture 3, Temperature 3 |
| Grimdark Recycling2 | 3363054797 | CJTLW.HereTech | 19 | Misc 10, Production 3, Temperature 3, Security 3 |
| Kraltech Industries | 3250496402 | BlackMarket420.KraltechIndustries | 19 | Security 9, Biotech 5, Structure 3, Production 1 |
| More Fix For Game | 3634969773 | makkei.mffg | 19 | Misc 5, Power 4, Odyssey 3, Security 3 |
| Musical Instruments (Continued) | 2274558815 | Mlie.MusicalInstruments | 19 | Misc 7, Joy 7, Production 5 |
| Nelim's Ancient Salvage (prohibited) | 3806763048 | nelim.ancientsalvage | 19 | Misc 10, Production 4, Temperature 2, Structure 2 |
| RimVali: Far From Avalon | 2180380125 | NeziTheAvali.RimVali | 19 | RimVali_AvaliFurniture 9, RimVali_AvaliSecurity 5, RimVali_AvaliFloors 5 |
| Soil improvement and Glass[1.0] | 1550258962 |  | 19 | SIandGlass 17, Structure 1, Production 1 |
| Tobe's Realistic Farming [TRF] | 1136426568 |  | 19 | FarmingTool 10, ReclaimTool 5, CookingTool 2, SaltingTool 1 |
| [TW1.4]中世纪装饰 Medieval~Decoration | 2032442285 | TangW.MedievalDecoration | 18 | Medieval_Decoration 18 |
| ↁ House Sanguin [Continued] | 3292190756 | Finch.Blood | 18 | Furniture 9, DankPyon_RusticFurniture 6, Misc 3 |
| Artificial Water Place | 2382789361 | SC.waterplace | 18 | Floors 15, Production 3 |
| ASF Furniture | 3711942873 | CreeeesP.ASFFurniture | 18 | Furniture 8, ANON2MF 6, MF_Building 3, Misc 1 |
| Blue Archive Furniture 3 | 3610152668 | mlmlmlm.bluearchivefurniture3 | 18 | BA_Decoration 18 |
| Covenant Of Hir (Continued) | 3646443012 | Zaltys.CovenantofHirUpdated | 18 | Power 6, Production 4, Temperature 4, Security 2 |
| Decorative Railway Prop (Continued) | 3147720105 | zal.decorail | 18 | DecoRailProp 18 |
| Diagonal Walls 2 | 2859965620 | chv.DiagonalWalls2 | 18 | Floors 12, chv_Diagonal 4, Security 2 |
| Erin's Cottage Collection | 2977561141 | Erin.CottageCollection | 18 | Production 9, Temperature 9 |
| Expanded Materials - Plastics | 2465263608 | Argon.VMEuP | 18 | Production 9, Structure 6, Power 3 |
| Fake Flowers | 2220276434 | FF.Goat.FakeFlowers | 18 | Misc 18 |
| Fire Extinguisher (Continued) | 2195996970 | Mlie.FireExtinguisher | 18 | Misc 12, Security 6 |
| For Colour and Justice Kz | 2217395767 | Moo.FCJ.Kz | 18 | Structure 8, Production 7, Misc 2, Floors 1 |
| Medieval Overlap Remover | 3455187565 | joeownage.overlap.remover | 18 | ? 16, Production 2 |
| Neon Rim: The Rimworld Signs Pack (Continued) | 3157206396 | zal.neon | 18 | Furniture 18 |
| Nopower Comms Simplified | 2019297016 | Meltup.NopowerCommsSimplified | 18 | Misc 18 |
| Onimods - Colored Fire | 3178738990 | Onimods.ColoredFire | 18 | Temperature 11, Furniture 6, VCHE_PipeNetworks 1 |
| PalRim | 3770344985 | Elvlin.PalRim | 18 | Misc 8, Production 5, Temperature 2, Security 2 |
| Recon And Discovery (Continued) | 2035131107 | Mlie.ReconAndDiscovery | 18 | Misc 12, Power 6 |
| ResourcePackCore | 1543671683 | RimWorldsoudanzyo.ResourcePackCore | 18 | ? 15, は空欄に。 2, を置換することでメニューに登場する。 1 |
| RimNauts 2 | 2880599514 | sindre0830.rimnauts2 | 18 | Misc 12, ? 4, Structure 2 |
| RimTycoon - Funeral | 3817727551 | nela.rimtycoon.funeral | 18 | RT_Tycoon 18 |
| Synthetik - Vehicle | 3036978814 | amaoto.ThisThingSynthetik | 18 | VF_Vehicles 18 |
| T's Samurai Faction | 2559958496 | Trickity.Samurai.Faction | 18 | Production 8, Security 4, Joy 4, Misc 2 |
| TurtleShroom Productions Proudly Presents: Pan-Halloweenie Integration Mod II | 3593434506 | TSP.Halloweenie.IntegrationMore | 18 | Furniture 14, Production 2, Misc 2 |
| Utility Supplements (Continued) | 2195065488 | Mlie.UtilitySupplements | 18 | Misc 18 |
| Vanilla Factions Expanded - Settlers | 2052918119 | OskarPotocki.VanillaFactionsExpanded.SettlersModule | 18 | Joy 4, Furniture 4, Power 2, Security 2 |
| Wall Torches N Grill Tech | 1913512696 | Hauvega.RetroMod.WallTorchesNGrillTech | 18 | Furniture 14, Production 4 |
| ZARS Tribal Reborn | 1503813330 |  | 18 | Production 8, Floors 2, Furniture 2, Security 2 |
| ZeroTech-Core (Continued) | 2608812829 | Mlie.ZeroTechCore | 18 | Production 12, Floors 6 |
| 圣蜣螂种族 | 3740297753 | super.scarabpeople | 18 | Scarab 18 |
| BoneReapers ReMarrowed | 3516603515 | JTCsBonereapers.FormerlyPPHHYY | 17 | Furniture 8, Production 7, Ideology 1, Biotech 1 |
| Dark Ages : Medieval Tools | 3028566550 | Van.DATools | 17 | Misc 17 |
| Eccentric Tech - Fusion Power | 2742125879 | Aelanna.EccentricTech.FusionPower | 17 | Power 16, Odyssey 1 |
| Gloomy Deco - Reupload | 3811339191 | zzz.dalrae.gloomydeco | 17 | OldStyleDeco 17 |
| Kijin Race 3.0 | 2884551646 | ssulunge.KijinRace3 | 17 | Production 9, Misc 5, Joy 3 |
| Nelim's Rabbie Gear | 3811382082 | nelim.rabbiegear | 17 | Enterprise_architecture 12, Lunararchitecture 5 |
| RabbieGearRenew | (local) RabbieGearRenew |  | 17 | Enterprise_architecture 12, Lunararchitecture 5 |
| Smokeleaf Industry (Continued) | 3795903934 | zal.smokeleafindustry | 17 | MSI 14, Furniture 2, Floors 1 |
| Stormproof | 3760021127 | AzraelGodKing.Stormproof | 17 | Power 16, Furniture 1 |
| Terran's Security Buildings (Continued) | 3120276865 | Mlie.TerransSecurityBuildings | 17 | Security 15, Production 2 |
| UN-Furniture Vanilla Resources | 2086216872 | OutboundLegend.UNFurniture | 17 | SadjuukUN-Furniture 17 |
| Victorian decorations | 2937276828 | MOs.Victoriandecorations | 17 | Victoria_Decorations 17 |
| 吊顶家具 | 3614993770 | JL.CeilingFurniture | 17 | Misc 5, Security 4, Temperature 2, Biotech 2 |
| Big and Small Furniture - More Medieval Overhaul Beds | 3808891681 | DanZinagri.BSFurnitureMOGiantBeds | 16 | BS_Furniture 16 |
| Call of Cthulhu - Cults (Continued) | 3588548484 | zal.cocc | 16 | Misc 10, Structure 4, Furniture 2 |
| Cane Aternitigno, The war dogs of battlefield Xenotypes and Faction | 3165847953 | Resurrectionem.CaneBellum | 16 | VF_Vehicles 9, Production 7 |
| Dubs Skylights | 833899765 | Dubwise.DubsSkylights | 16 | skylights 16 |
| Dummy! (Continued) | 2069465324 | Mlie.Dummy | 16 | Security 16 |
| Holiday Special Edition | 813190996 | spoonshortage.holidayse | 16 | RIMkea 16 |
| Hunterphage - Equipment Only | 3430020141 | JoeOwnage.HunterphageEquip | 16 | HuntersWorkshop 15, Production 1 |
| Landless Voyage | 3762391752 | sven.shipmod | 16 | ShipMod_Ships 16 |
| Lanterns (Continued) | 3266721359 | zal.lanterns | 16 | Furniture 16 |
| New Joy Source: Play Music (Continued) | 2032918797 | Mlie.NewJoySourcePlayMusic | 16 | Joy 16 |
| Poo Patch | 3712874460 | CountVlad.PooPatch | 16 | VFEFactory_Factories 16 |
| Pumps Plus (1.0-1.7) | 1265858918 | magicalliopleurodon.pumpsplus | 16 | Misc 16 |
| Silts Radio (Continued) | 2404731911 | Mlie.SiltsRadio | 16 | Joy 16 |
| Steamworld Defenses | 3033669826 | Koni.Misc.SteamworldDefenses | 16 | Security 16 |
| The Heaven Forged Celestial | 3122537632 | Create.AncientCelestial | 16 | SZ_Furniture 16 |
| Tribal Genetics (Continued) | 3029891263 | Mlie.TribalGenetics | 16 | GR_GeneticsTab 8, Furniture 4, Structure 4 |
| Undergrounders: Darkfire | 2808569417 | BattIeBear.Undergrounders.Darkfire | 16 | Temperature 12, Furniture 4 |
| Vanilla Nutrient Paste Expanded | 2920385763 | VanillaExpanded.VNutrientE | 16 | VCHE_PipeNetworks 16 |
| [1.6] UN-Colony (Continued) | 3501284735 | Mlie.UNColony | 15 | SadjuukUN-Industry 8, SadjuukUN-Building 7 |
| [krs] Buildable Terrain V1 - Odyssey | 3754661122 | krs.More.Buildable.Terrain | 15 | terraforming 15 |
| Asimov | 3096481956 | Neronix17.Asimov | 15 | Power 12, Misc 3 |
| BamStructure | 3584936871 | Bammalting.bamstructure | 15 | Structure 4, Misc 2, Joy 2, Ideology 1 |
| Caveworld Flora Unleashed | 3409043551 | Fluffysminion.ItW.CaveworldFloraUnleashed | 15 | Production 10, RFF_Farm 5 |
| ChargedEnergyMunitions (Continued) | 2826312539 | zal.CEM | 15 | Security 12, Power 3 |
| El's Rebel Alliance | 2780886227 | ellit.Rebels | 15 | Furniture 9, Joy 6 |
| Erin's Auraeyl | 3653150966 | Erin.Auraeyl | 15 | ERN_CozyFurniture 15 |
| Fortifications - Neolithic | 2385960678 | Aoba.Fortress.Neolithic | 15 | Security 10, Structure 5 |
| Gerrymon's Hotspring Expanded | 3717051546 | GM.Hotspring | 15 | Ferny_GMHotSpring 6, Misc 3, Structure 2, Joy 2 |
| Gloomy Deco [temp] | 2881455044 | Dalrae.GloomyDecoTemp | 15 | OldStyleDeco 15 |
| Glowstone | 1545160307 | Mantrasong.Glowstone.1 | 15 | GLO_Glowstone 12, Furniture 3 |
| LK Resources Mod | 3531934234 | LeutianKane.Resources | 15 | Power 8, Temperature 3, Odyssey 3, Production 1 |
| MF Vanilla | 3725961309 | oracle.mfvanilla | 15 | Production 9, Temperature 2, Structure 2, Misc 2 |
| Ofuton 1.0 | 1612962122 |  | 15 | JPstyle 13, Furniture 1, Floors 1 |
| Outdoor Lighting (continued) | 2888755935 | velcroboy333.outdoorlighting | 15 | Furniture 15 |
| The Division Gadgets | 2850132083 | Alkolyte.DivisionGadgets | 15 | Security 15 |
| Vanilla Factions Expanded - Pirates | 2723801948 | OskarPotocki.VFE.Pirates | 15 | Security 10, Production 5 |
| Vanilla Factions Expanded - Tribals | 3079786283 | OskarPotocki.VFE.Tribals | 15 | Temperature 3, Security 3, Misc 3, Furniture 3 |
| [FSF] Pose For Me | 1932628728 | FrozenSnowFox.PoseForMe | 14 | Misc 14 |
| [KCB] Plant Pot Deco | 3575201181 | kcb.pottingdeco | 14 | KCB_Deco 14 |
| [KV] Change Dresser | 2880268357 | changedresser.kv.rw | 14 | Furniture 9, Misc 5 |
| [Mech]Pavia-RogueServitor/帕维亚-失控机仆 | 3009608965 | RogueServitor.Mechanoids | 14 | Biotech 7, Security 3, VF_Vehicles 2, Odyssey 1 |
| Bamp Xenotype | 3297545550 | Bamp.Gorani | 14 | Anomaly 6, Production 4, Power 2, Security 2 |
| Expanded Woodworking 2 | 3576156542 | qq.expanded.woodwork | 14 | Production 13, Structure 1 |
| ExtraSecurity (Continued) | 2590690665 | Mlie.ExtraSecurity | 14 | Security 14 |
| Guards For Me | 1855885448 | aRandomKiwi.GuardsForMe | 14 | Security 14 |
| Instruments for Extinction | 3789316911 | ATMnou.exomech | 14 | Misc 4, Production 4, Security 2, Temperature 1 |
| LWOP Package | 2012717312 | LWOP.Package | 14 | Security 3, Power 3, Misc 2, Biotech 2 |
| Mashed's Ashlands | 3109835541 | SirMashedPotato.Ashlands | 14 | Misc 3, Furniture 3, Production 3, Floors 3 |
| Mediterranean Furniture/地中海风格家具 | 3293528946 | Wwskyon.Mediterranean.Furniture | 14 | Mediterranean_Series_Furniture 13, Joy 1 |
| Nelim's Repossessed Furniture | 3811382245 | nelim.repossessedfurniture | 14 | Nelim_Repossessed 14 |
| Outland - Eastborn Empire | 2755502128 | Neronix17.Outland.EastbornEmpire | 14 | Outland_Outland 11, Outland_OutlandDeco 3 |
| PLA Steel Torrent | 2743947189 | IssacZhuang.PLA.Vehicle | 14 | PLA_DesignationCategory_Vehicle 14 |
| Polyamory Beds (Vanilla Edition) | 3276496684 | Meltup.PolyamoryBeds.Vanilla | 14 | Furniture 9, Ogre_NanoRepairTech_DesignationCategory 5 |
| Potions (Continued) | 2595809112 | Mlie.Potions | 14 | Production 14 |
| Quarry | 2007576583 | Ogliss.TheWhiteCrayon.Quarry | 14 | Production 7, Misc 7 |
| Questionable Ethics Enhanced (Continued) | 2850854272 | Mlie.QuestionableEthicsEnhanced | 14 | Production 14 |
| Real Fog of War (Continued) | 2559045153 | Mlie.YYRealFogofWar | 14 | Security 14 |
| RepossessedFurniture | (local) RepossessedFurniture |  | 14 | Nelim_Repossessed 14 |
| Rimsential - Spaceports (Continued) | 3225120958 | zal.spaceports | 14 | Misc 14 |
| Secret Passage Doors (Continued) | 2412682633 | Mlie.SecretPassageDoors | 14 | Structure 14 |
| Smoked meat | 1542364782 | dismarzero.VGP.Smokedmeat | 14 | Production 14 |
| Soft wall | 1500958814 | karukus.Softwall | 14 | Structure 14 |
| Soybean Products | 3586634388 | paseri.SoybeanProducts | 14 | Production 14 |
| Underground Food | 1761270139 | RelaxedOtter.UndergroundFood | 14 | Temperature 8, Misc 4, Furniture 2 |
| Vanilla Brewing Expanded | 2186560858 | VanillaExpanded.VBrewE | 14 | Production 14 |
| Vanilla Christmas Expanded (Continued) | 2310043014 | Mlie.VanillaChristmasExpanded | 14 | Temperature 7, Misc 7 |
| VGP Garden Canning | 2007062033 | dismarzero.VGP.VGPGardenCanning | 14 | Production 14 |
| VGP Garden Fabrics | 2007062162 | dismarzero.VGP.VGPGardenFabrics | 14 | Production 14 |
| VGP Garden Fabrics Simplified | 2007062335 | dismarzero.VGP.VGPGardenFabricsSimplified | 14 | Production 14 |
| What the Hack?! (Continued) | 3372841828 | zal.whatthehack | 14 | WTH_Hacking 14 |
| [ATW] House Decor | 3535047810 | mgatwood.housedecor | 13 | Decor 10, Joy 2, Furniture 1 |
| Alpha Crafts | 3382446150 | sarg.alphacrafts | 13 | Production 13 |
| Ceramics Crafting | 2689231029 | n7huntsman.ceramics.craft | 13 | Production 7, Insulation_Desig 4, Structure 2 |
| DeCore 1.6 | 951016023 | Daniledman.DeCore | 13 | Production 7, Power 6 |
| Gerrymon's Hotspring Expanded XML Only | 3765052370 | brucethemoose.Hotspring | 13 | Ferny_GMHotSpring 5, Misc 3, Structure 2, Joy 2 |
| Industrial Age - Objects and Furniture (Continued) | 3539738188 | Mlie.CallofCthulhuIndustrialAge | 13 | Furniture 6, Joy 3, Temperature 2, Structure 1 |
| Lacer Race | 3807780767 | Cavetiger.PureLacerRace | 13 | Production 4, Power 4, Security 3, Misc 1 |
| Project RimFactory - Materials | 3581627851 | PRF.Materials | 13 | Furniture 11, Structure 1, Production 1 |
| ReBuild: Doors and Corners | 3262718980 | ReBuild.COTR.DoorsAndCorners | 13 | Structure 4, Odyssey 3, Temperature 2, Floors 2 |
| Rimframe: Vatgrown Hate | 3431220821 | JTC.Grineer | 13 | Production 6, Power 4, Biotech 2, Odyssey 1 |
| Storage Solutions | 895944018 | cucumpear.storage | 13 | CCP_StorageSolutions 13 |
| Storytime Official Mod | 2411541093 | Jonah.Storytime | 13 | Production 11, Structure 1, Power 1 |
| The Borg Collective | 3704848468 | TheBorg.Collective.Main | 13 | Borg 13 |
| Training Rack - Continued | 2545876810 | Lemonaise.TrainingRackContinued | 13 | Training_Racks 12, Production 1 |
| Vanilla Factions Expanded - Medieval | 2023513450 | OskarPotocki.VanillaFactionsExpanded.MedievalModule | 13 | Production 5, Structure 3, Joy 2, Furniture 2 |
| [D] Thermodynamics - Hot Meals (Continued) | 2909103255 | Mlie.DThermodynamicsHotMeals | 12 | Temperature 12 |
| [V1]Tempta Formation | 1544986569 | CamoAdventure.TemptaFormation | 12 | Security 12 |
| [旋风绘卷]Andery-Tech | 2085370932 | andery233xj.mod.AnderyTech | 12 | Security 6, Production 4, Furniture 2 |
| Advanced Cultivation - Continued | 3623069749 | Memegoddess.AdvancedCultivation | 12 | Production 6, Floors 6 |
| Architect Expanded - Fences (Continued) | 2576081324 | Mlie.ArchitectExpandedFences | 12 | Structure 12 |
| Cargo Holds | 3536708812 | jdgg.adaptive.cargoholds | 12 | cargoholds 12 |
| CaveBiome (Continued) | 2259124387 | Mlie.CaveBiome | 12 | Security 6, Furniture 6 |
| CCP's Plant Stuff | 1264725945 | cucumpear.plantstuff | 12 | Floors 5, Misc 3, Furniture 3, Power 1 |
| Curious Curios | 2877810737 | drenzyme.curiouscurios | 12 | Misc 12 |
| CVN Mechanoid Naval Warfare | 3030303999 | ShunTheWitch.CVNmechanoidnavalwarfare | 12 | Biotech 12 |
| Decorations and dishes at Gorgeous banquet | 3027639868 | MO.DecorationsLuxury | 12 | Banquet_Decorations 12 |
| El's Tribal Water | 2818036590 | ellit.TribalWater | 12 | Temperature 6, Misc 3, Furniture 3 |
| Epochs - Pottery | 3092351095 | det.epochspottery | 12 | Structure 6, Production 6 |
| Equal Milking | 3266052474 | akaster.equalmilking | 12 | VCHE_PipeNetworks 12 |
| Equiums Wall N Floor Art | 2016401914 | Hauvega.EquiumsSeries.EquiumsWallNFloorArt | 12 | Equium_Things 12 |
| FishIndustry (Continued) | 3456386887 | Mlie.FishIndustry | 12 | Production 12 |
| Floor-Mounted Fuel Tanks | 3625783623 | quartz.floorstoragetanks | 12 | Odyssey 8, VGE_Fuel 2, VGE_Vacuum 2 |
| FoodCourt | (local) FoodCourt |  | 12 | Production 12 |
| Gomi-Craft Tactics | 3542111698 | wareware.GomiCraft.Tactics | 12 | Security 6, Structure 6 |
| HE-Ford Explorer '19 | 3276086519 | HE.FE | 12 | HE_Vehicles 12 |
| Hospitality: Vending machines | 3014885065 | Adamas.VendingMachines | 12 | Misc 12 |
| JoyPreservation | (local) JoyPreservation |  | 12 | Joy 12 |
| Kimchianz Xenotype (Beta) | 3752498193 | Kimchibok.KimchianzBeta | 12 | KCA_KimchianzTab 11, Misc 1 |
| Materials+ (Continued) | 3498029046 | zal.materialsplus | 12 | Production 6, Misc 4, Structure 2 |
| Medical bay (Continued) | 3320205277 | Mlie.MedicalBay | 12 | Misc 12 |
| Misc. Training (no Task) | 2779572925 | Haplo.Miscellaneous.TrainingNoTask | 12 | Joy 12 |
| More Vanilla Fences - Fence Tab | 2554238801 | Jiopaba.FenceTab | 12 | Fences 12 |
| Nelim's Food Court (prohibited) | 3806764040 | nelim.foodcourt | 12 | Production 12 |
| Nelim's Joy Preservation (prohibited) | 3806768984 | nelim.joypreservation | 12 | Joy 12 |
| Nomads' Land | 2905854321 | NiobProta.Nomadism | 12 | Structure 8, Misc 4 |
| Outland - Redburn Pact | 2839780900 | Neronix17.Outland.RedburnPact | 12 | Outland_Outland 10, Outland_OutlandDeco 2 |
| Reese's Anomaly Accessibility | 3511996838 | StockSounds.AnomalyAccessibility | 12 | Production 6, Misc 4, Temperature 2 |
| Religions of Rimworld | 1645324706 | Basarab.ReligionsOfRimworld | 12 | ReligionBuildings 12 |
| RimThunder Functional Furniture Expanded (Continued) | 3769624561 | zal.rimthunderfurniture | 12 | Misc 11, VF_Vehicles 1 |
| Simple Learning (Continued) | 3580464748 | Fox.SimpleLearning | 12 | Misc 9, Joy 2, Furniture 1 |
| Sundial:Desrt Storm | 3529001629 | Park.DesrtStorm | 12 | VF_Vehicles 12 |
| Supply Box | 3595129621 | trigger.supplybox | 12 | Odyssey 8, Misc 4 |
| TIMG - Production Completion | 3794925875 | timg.productioncompletion | 12 | Odyssey 6, Power 2, Production 2, Misc 2 |
| Vanilla Christmas Expanded | 3380695249 | VE.VanillaChristmasExpanded | 12 | Security 4, Ideology 2, Floors 2, Misc 2 |
| Vanilla Cooking Expanded | 2134308519 | VanillaExpanded.VCookE | 12 | Production 12 |
| Vanilla Factions Expanded - Deserters | 3025493377 | OskarPotocki.VFE.Deserters | 12 | Security 9, Misc 3 |
| Vanilla Furniture Expanded - Medical Module | 1718191613 | VanillaExpanded.VFEMedical | 12 | Misc 10, Structure 2 |
| Vertibird Transport Add-On | 1876532724 | KurtusMob.Vertibird | 12 | Misc 6, Furniture 6 |
| VGP Garden Drinks | 2167582651 | dismarzero.VGP.VGPGardenDrinks | 12 | Production 12 |
| Wolfhaul Core Metals | 2760316066 | Wolf478.Wolfhaulcore.Metals | 12 | Power 9, Production 3 |
| 装饰挂画-Decorative painting | 3587440566 | KindSeal.DecorativePainting | 12 | Furniture 12 |
| 边缘仙路-镇邪诛鬼 RimImmortal-Exorcism[1.6] | 3663824172 | RI.RimImmortal.Exorcism | 12 | Biotech 7, Production 3, Furniture 1, Misc 1 |
| [CP] Rimmu-Nation - Security | 2011774401 | CP.RimmuNation.Security | 11 | Security 11 |
| [DHM]Simple Pipe Mod | 3434589821 | drilledhead.simplepipe | 11 | PipeSystem_Designation 11 |
| [GMT] Mausoleums, Tombs and Graves (Continued) | 3792508376 | zal.mausoleum | 11 | Mourning 11 |
| Dimensions RePocketed | 3554632020 | KB.PocketDimension | 11 | Misc 11 |
| Ecotech | 3740443679 | RA.Ecotech | 11 | EcotechDesignation 8, Furniture 2, Production 1 |
| Fantastic Decor (continued) | 2504655776 | RedrusFijorn.VBY333.FantasticDecor | 11 | FantasticDecor 11 |
| Glowstone 2 | 3775171637 | Murph.Glowstone2 | 11 | GS2_Glowstone 6, Glowstone 5 |
| Hallowen Monster Mash | 2257175849 | KD.HalloweenMonsterMash | 11 | Misc 11 |
| MedievalHomestead | (local) MedievalHomestead |  | 11 | Structure 5, Temperature 2, Production 2, Misc 2 |
| MorrowRim - Telvanni Technology | 2443090232 | SirMashedPotato.MorrowRim.TelvanniTechnology | 11 | Misc 6, Production 5 |
| MUGB Goblin | 3768425355 | mustard1557.mugb.goblin | 11 | MUGB_Goblin 6, Security 2, Ideology 1, Structure 1 |
| Nelim's Medieval Homestead (prohibited) | 3806765035 | nelim.medievalhomestead | 11 | Structure 5, Temperature 2, Production 2, Misc 2 |
| RimKimetsu - Demon Slayer Rimworld Mod | 3641720143 | WILL.DemonSlayerRimworldMod | 11 | Misc 9, Security 1, Joy 1 |
| Run and Hide (Continued) | 2022480344 | Mlie.RunAndHide | 11 | Misc 11 |
| Tate's Tiny Furniture Mod | 2247819099 | alleZSoyez.TTFM.TatesTinyFurnitureMod | 11 | Furniture 10, ? 1 |
| Toxic Wastepack Generator Plus | 2917419173 | Bazel.ToxGenPlus.2 | 11 | Power 10, Biotech 1 |
| Trading Control | 2007107588 | TradingControl.Tad.Rimworld.Core | 11 | Misc 11 |
| Transitional Materials | 3781469394 | Foppyx.materials | 11 | Production 8, Structure 2, Power 1 |
| Vanilla Furniture Expanded - Farming | 1957158779 | VanillaExpanded.VFEFarming | 11 | Production 6, Misc 4, RFF_Farm 1 |
| Voodoo Magic | 3676797081 | Douez.VoodooMagic | 11 | Furniture 4, Production 3, Power 2, Odyssey 1 |
| Weapon Enhancement Pack 1.1 | 1602211450 | Armifer18.WeaponEnhancementPack | 11 | Security 11 |
| [CP] Get to the Chopper! - Aircraft mod [1.0] | 1845399472 |  | 10 | CP_Aircraft 10 |
| [OA]Ratkin Gene Expand | 3300291918 | OARK.RatkinFaction.GeneExpand | 10 | Biotech 8, Ideology 2 |
| [PyRim] HBot | 3777542629 | Hades3623.PyRim.HBot | 10 | Security 8, Production 2 |
| [SYR] Metallic Batteries (Continued) | 3345223519 | Mlie.SYRMetallicBatteries | 10 | Power 10 |
| [SZ]分居异爨——杂项内容和黑科技 Chinese Traditional Cultural Things Expanded Other Styles Pack | 2477792890 | ChiTeaditional.ExtraPack | 10 | SZ_Ui_Menu_ShengChan 7, Temperature 2, Power 1 |
| [WYD] More Tables | 3013617961 | Wyr3d.ExtraTables | 10 | Furniture 10 |
| 【1.5】Fox Lamp Forked | 3248294052 | mg.ferianstory.foxlamp | 10 | AF_CITE 6, AF_Thankyou 2, Furniture 2 |
| Animal Sarcophagus | 2876565401 | overpl.AnimalSarcophagus | 10 | Misc 10 |
| Chemfuel Pipe Network | 3446464627 | CPN.pipenetwork | 10 | VCHE_PipeNetworks 5, CPN_ChemNetworks 5 |
| CompBoards | 3515314420 | Mdtk.Compboards | 10 | Misc 10 |
| Expanded Materials - Masonry | 3662913084 | Argon.ExpandedMaterials.Masonry | 10 | Production 7, Structure 3 |
| Expanded Materials Add-On - Minimalist Production | 2564410016 | Argon.VMEuMP | 10 | Production 10 |
| Fortifications - Medieval | 2501486827 | Aoba.Fortress.Medieval | 10 | Security 7, Structure 3 |
| Kwiver | 2120889697 | GarbageDayIsHereToStay.Kwiver.GDIHTSKWVR | 10 | KWVR_DESIGNATION_DEF 10 |
| Large Animal Beds | 1111387020 | cucumpear.animalbeds | 10 | CCP_PetBeds 10 |
| Life Lessons | 2920678419 | GhostData.lifelessons | 10 | Production 8, Misc 2 |
| Misc. Incidents | 719702781 | Haplo.Miscellaneous.Incidents | 10 | Misc 10 |
| MoreGloomyWalls 1.6 | 2569611644 | sunny.GLSterileWalls | 10 | Structure 10 |
| Operable Roof (Continued) | 2896531741 | Mlie.OperableRoof | 10 | Structure 10 |
| Paintable RIMkea Furniture | 2882654523 | Paintable.RIMkea.Furniture | 10 | RIMkea 10 |
| Power Poles | 2507086460 | co.uk.epicguru.rimforgepoles | 10 | Power 10 |
| Pyrinth Stove &amp; Smithy | 3740618688 | zwei2stein.PyrinthStove | 10 | Production 8, Joy 2 |
| RBSE | 850429707 | Rah.RBSE | 10 | Production 10 |
| Rim Lane | 3681117139 | WYH.RL.RimLaneAll | 10 | RL_RimLane 10 |
| RimTube | 3797938050 | luca.rimtube | 10 | RT_Studio 9, Production 1 |
| Salted Meat | 2606419180 | Argon.SaltedMeatRemake | 10 | Production 10 |
| Tabletop Trove - Additional Joy Objects and Decor (Unofficial 1.6) | 3262297105 | SoulfulPumpkin.TabletopTroveUnofficial | 10 | Joy 10 |
| The Wonderland of Mr Cringe | 2781994359 | aratocat.Wonderland | 10 | Cringe 10 |
| Underground Vault | 3021706489 | MrHydralisk.UndergroundVault | 10 | Misc 9, LWM_DS_Storage 1 |
| Vanilla Books Expanded | 2193152410 | VanillaExpanded.VBooksE | 10 | Misc 6, Production 4 |
| Vanilla Ideology Expanded - Memes and Structures | 2636329500 | VanillaExpanded.VMemesE | 10 | Production 6, Misc 4 |
| VGP Garden Dyes | 2007062688 | dismarzero.VGP.VGPGardenDyes | 10 | Production 7, Floors 3 |
| Wall-Mounted Function Furniture | 3807382130 | WallMounted.FunctionFurniture | 10 | Furniture 3, Misc 3, Ideology 2, Joy 1 |
| Westerado | 1389086625 |  | 10 | Furniture 4, Joy 2, Temperature 1, Structure 1 |
| 琼琚 · 新中式家具 / Qiongju Neo-Chinese Furniture | 3811425067 | iris.qiongju | 10 | QJ_Furniture 10 |
| [kik]Adjustmentformyself | 3503877930 | Miran.Adjustmentformyself | 9 | Security 6, Furniture 3 |
| [RF] Fishing | 2034028432 | firefoxpdm.RainbeausFishing | 9 | Production 9 |
| [RH2] Rimmu-Nation² - Weapons | 2563507593 | CP.RimmuNation.2.Weapons | 9 | Production 9 |
| Bill Doors' Props | 3118374245 | 3HSTltd.Props.3HST | 9 | Furniture 6, BDsProps 2, Structure 1 |
| Blue Archive Joy Objects | 3668590151 | mlmlmlm.bluearchivejoybojects | 9 | BA_Decoration 9 |
| Cranial Specimens | 3773570278 | anthony.cranialspecimens | 9 | Security 3, Misc 3, Production 3 |
| Cultured Meat | 1420944836 | leion247153.CulturedHMeat | 9 | Production 9 |
| CuproPanda's Drinks | 1543172057 | dismarzero.VGP.CuproPandasDrinks | 9 | Production 9 |
| Defenses Expanded | 1550972678 | n7huntsman.defensesexpanded | 9 | DefensesExpanded_CustomCategory 9 |
| Drunken Rim | 3820399879 | valeriy.wallbeershelves | 9 | Furniture 7, Power 1, Joy 1 |
| El's Archeology | 3132100846 | ellit.Archeology | 9 | Furniture 3, Production 3, Misc 3 |
| Extrematorium Etc. | 2297080232 | Hol.Extrematorium | 9 | Production 9 |
| Fishing Boats (Continued) | 2932093144 | zal.FishingBoats | 9 | VF_Vehicles 6, Misc 3 |
| Fortifications - Medieval - Material | 2501487160 | Aoba.Fortress.Medieval.Material | 9 | Production 6, Security 3 |
| Friendly Armchair | 3338585047 | Woolyung.FriendlyArmchair | 9 | Furniture 9 |
| Gloomy Extra - Kitchen (Continued) | 3147698168 | zal.gloomyextrakitchen | 9 | OldStyleFurniture 6, Production 3 |
| Glowbug Jars | 3556290113 | Pineapple.GlowbugJars | 9 | Furniture 9 |
| hydroponic fruit tree's for veggie garden | 855650291 |  | 9 | GardenTools 9 |
| LWM DS for Gloomy Furniture and Deco | 2037264293 | AhnDemi.LWMDSforGFD | 9 | LWM_DS_Storage 9 |
| Magical Decor Compilation | 3726648335 | Seti.Random.Decor | 9 | DankPyon_RusticDecoration 7, DankPyon_Candle 2 |
| Medieval Extras (Continued) | 3582426486 | Satpyn.MedievalExtras | 9 | Structure 9 |
| One with Death | 3448902635 | 6224Y.OneWithDeath | 9 | OWD_Necromancy 8, Misc 1 |
| Primitive Workbenches (Continued) | 3751287735 | zal.primitiveproduction | 9 | Production 3, Misc 2, Structure 2, Joy 1 |
| Reinforced Mechanoid 2 (Continued) | 3541404610 | Mlie.ReinforcedMechanoid2 | 9 | Security 4, VFE_Factory 2, Temperature 1, Power 1 |
| Rimhammer - The End Times - Magic | 2020384442 | SickBoyWi.TheEndTimes.Magic | 9 | Misc 5, Temperature 4 |
| RimSeasoning | 2212032458 | tikubonn.RimSeasoning | 9 | Misc 3, Furniture 3, ? 3 |
| Roo's Painting Expansion | 3534441698 | Rooboid.Paintings.Ex | 9 | Misc 6, Structure 2, Production 1 |
| SimplyMoreFloors (Continued) | 2889856826 | zal.simplymorefloors | 9 | Floors 9 |
| Stone Bollards | 3529241418 | acutus.StoneBollards | 9 | Security 8, Joy 1 |
| Time-of-Day Switches | 776114412 | Merthsoft.TimeOfDaySwitch | 9 | Power 9 |
| Tinimar the Harfling | 3211734754 | nsns.Tinimar | 9 | Production 6, Misc 3 |
| Vanilla Factions Expanded - Empire | 2938820380 | OskarPotocki.VFE.Empire | 9 | Floors 3, Misc 3, Furniture 3 |
| Vanilla Nutrient Paste Expanded: NPDTiers | 3021706834 | MrHydralisk.VNPENPDTiers | 9 | VCHE_PipeNetworks 9 |
| たたら製鉄 | 1833556876 |  | 9 | ? 4, Zipangu 2, Production 1, Storage 1 |
| 抵扣券系统2 (Colony Coupons 2) | 3657676020 | AAA.ColonyCoupons2 | 9 | Misc 8, Joy 1 |
| [1.2, 1.3] Tank Beds (Fast Sleep) | 2020858426 | tremeloe.tankbeds_copy | 8 | Furniture 8 |
| [1.6]淬炼国魂——传统派系和文化扩展 [continued] Chinese culture and faction and equipment expansion [continued] | 3472595911 | SZ.TW.XXK.GuoHun | 8 | Production 6, Security 2 |
| [Core] MDK Terrain Patch | 1510932875 | dracoix.mdk.terrain | 8 | Structure 8 |
| [O21] Barbed Wire (Continued) | 2209097136 | Mlie.O21BarbedWire | 8 | Security 8 |
| [OA]Stepped Flower Cake | 3379736801 | WW.OberoniaAurea.SteppedFlowerCake | 8 | Ideology 6, Production 2 |
| [sd] floorpaint (Continued) | 2361392101 | Mlie.SdFloorpaint | 8 | sd_floorpaint_designationcategory_shapes 8 |
| [sd] medicaddons (Continued) | 3325079510 | Mlie.sdMedicaddons | 8 | Misc 8 |
| [sd] Spaceship (Continued) | 2036342825 | Mlie.SDSpaceship | 8 | Ship 8 |
| [SimplySublime] - ABS Polymer (Continued) | 2296579110 | Mlie.SimplySublimeABSPolymer | 8 | Production 8 |
| [TFB] Animal Kigurumi Party | 846418230 | caigan.kiguparty | 8 | Production 8 |
| [TY]天鹰核心 Aquila Core | 3249108695 | Spread.TY.Core | 8 | AtlasTab 4, Security 2, Power 2 |
| [ZAV] Glowstone | 3231900626 | zav.glowstoneForked | 8 | Floors 3, Structure 3, Furniture 2 |
| Aquariums! | 3478462020 | Nightmare.Aquariums | 8 | Furniture 8 |
| Ascension - Immortal Cultivation | 2652340519 | anobis.epicmods.ascension | 8 | Production 6, Misc 2 |
| AuroranKingslayer's RimWorld of the Dragon | 2954791310 | aurorankingslayer.asoiafdd | 8 | Misc 3, Ideology 3, Furniture 2 |
| Basic Mirrors (Continued) | 2597543500 | Mlie.BasicMirrors | 8 | Joy 8 |
| Bees | 3090186019 | Adamas.Bees | 8 | Misc 4, Production 4 |
| Biomes! Bees | 3745522952 | BiomesTeam.BiomesBees | 8 | Production 4, Furniture 4 |
| Bridgello | 932124891 | Shinzy.Bridgello | 8 | Structure 6, Floors 2 |
| Ceiling and Floor Lamps[continued] | 2025127001 | miodec.CeilingAndFloorLamps | 8 | Furniture 8 |
| Comigo's Nutrition | 2886008670 | KB.Miniaturization.Kitchen | 8 | Production 8 |
| Crowju Race | 3406168267 | 3HSTltd.Factions.Crows | 8 | Production 6, Security 2 |
| Cultured Animal Products | 3048939856 | Iman.CulturedAnimalProducts | 8 | CP_CulturedProducts 8 |
| Cupro's Alloys (Continued) | 2019702358 | Mlie.CuprosAlloys | 8 | Floors 8 |
| CV90 - A Combat Vehicle Mod | 3017155329 | Samael.Vehicles | 8 | VF_Vehicles 8 |
| Dark Glowpods / Growpods | 2879238242 | Forsaken.DarkGrowpods | 8 | Misc 8 |
| Dauntless' RimPhysique: Training Integration | 3790078220 | orion.dauntless.rimphysique.trainingintegration | 8 | Joy 8 |
| Decorative Clutter | 2872459865 | Rin.ClutterDecos | 8 | ClutterDeco 8 |
| Exosuit Framework | 3352894993 | Aoba.Exosuit.Framework | 8 | Misc 8 |
| Expanded Materials - Metals | 2259837114 | Argon.VMEu | 8 | Production 6, Power 2 |
| Expanded Materials - Metals | 3333419387 | Argon.ExpandedMaterials.Metals | 8 | Production 8 |
| Expanded Materials - Stones and Mortars | 2859334065 | Argon.ExpandedMaterials.Stones | 8 | Production 6, Structure 2 |
| Far Easterner, Ama the Three Raijus of the Far East Xenotypes and Factions | 2974761367 | Resurrectionem.Ama | 8 | VF_Vehicles 8 |
| Fish Traps | 2594468074 | warlocksforge.fishtraps | 8 | Production 8 |
| From Ashes to Ashes, Dust to Dust | 2753920635 | Garethp.AshAndDust | 8 | Misc 8 |
| Garden Box (Continued) | 2777123045 | zal.gardenbox | 8 | Furniture 8 |
| Geothermal Coolers | 2554535077 | neronix17.geothermalcooler | 8 | Temperature 8 |
| Geyser Cooker (Continued) | 2586473053 | Mlie.GeyserCooker | 8 | Production 8 |
| Geyser Cooking Revived (Continued) | 2803663308 | zal.geysercookingrevived | 8 | Production 8 |
| GhillieModPack (Continued) | 2862485631 | zal.GMP | 8 | Production 8 |
| GrillTech (Continued) | 2775594290 | zal.GrillTech | 8 | Production 8 |
| HRG164hjo's PGI Overpower | 3720439672 | HRG164hjo.PerfectlyGenericItem.Overpower | 8 | PGI_MainCategory 8 |
| Hunterphage Xenotype (Continued) | 3542200033 | Mlie.HunterphageXenotype | 8 | HuntersWorkshop 8 |
| Log Walls 1.0-1.6 | 1628354420 | HarryRobinson.LogWallsAll | 8 | Structure 8 |
| Lord of the Rims - Dwarves (Continued) | 3548257505 | zal.lotrdwarves | 8 | Furniture 5, Structure 1, Production 1, Joy 1 |
| Mashed's Lynians | 2871704782 | SirMashedPotato.Lynians | 8 | Production 6, Misc 2 |
| Max's Abakinars | 2850528153 | maximilian.maxsabakinars | 8 | Furniture 8 |
| Medieval Things: Geysers | 3464984971 | Salvador143.MThings.Geysers | 8 | Production 4, Misc 4 |
| More shooting walls | 3625955924 | onese.Moreshootingwalls | 8 | Security 8 |
| More Traps | 2035646473 | PalverZ.MoreTraps | 8 | Security 8 |
| More Useful Materials | 3734307960 | CN.MoreUsefulMaterials | 8 | Floors 6, Production 2 |
| MSS Tweaks and Fun | 3379574408 | MSS.FlavourPack | 8 | Production 3, Structure 2, Floors 2, Security 1 |
| Museums | 3204176859 | Nightmare.Museums | 8 | Furniture 4, Structure 3, Misc 1 |
| Noble and Psycaster Furniture | 3800595973 | morton.NobleandPsycasterFurniture | 8 | Furniture 7, Misc 1 |
| Printing Press | 3431938877 | zal.printingpress | 8 | Production 8 |
| Rails and Roads of the Rim (Continued) | 3271115410 | Mlie.RailsAndRoadsOfTheRim | 8 | Floors 4, Structure 4 |
| Raise The Roof (Continued) | 3592101493 | Mlie.RaiseTheRoof | 8 | Zone 4, Power 4 |
| Resource Generator | 2747511650 | Mlie.ResourceGenerator | 8 | Production 8 |
| RimLife Expansion Trading items | 2951594887 | daylight.RimLifeExTRGMod | 8 | Production 8 |
| RimMagic (1.0-1.7) -- now with Ascendant Vampires, Resurrection and Healing! | 775650249 | magicalliopleurodon.rimmagic | 8 | Production 8 |
| Rimsec Security (Continued) | 3520375010 | zal.rimsecsecurity | 8 | RSSRSBuildings 8 |
| Rimsenal Faction Pack - Feral | 736207111 | rimsenal.feral | 8 | Production 8 |
| RimSide Recycling | 1825360426 | pgamesfood.RimSideRecycling | 8 | Power 4, Floors 4 |
| RimWest | 3453765588 | ymaxeuss.rimwest | 8 | Production 4, Temperature 2, Furniture 2 |
| Royal Apparel (Continued) | 2022544087 | Mlie.RoyalApparel | 8 | Furniture 8 |
| Simple Chains: Lumber (Continued) | 3424121395 | Mlie.SimpleChainsLumber | 8 | Production 8 |
| Stargates! | 2831698056 | ccyt.stargatesmod | 8 | Misc 8 |
| Statues | 2063389055 | TheGoofyOne.Statues | 8 | Misc 8 |
| Steve's Walls | 2616538981 | Scurvyez.StevesWalls | 8 | Structure 4, Production 4 |
| Stuffed Power | 2346232265 | Hol.StuffedPower | 8 | M13Power 8 |
| Survival Expanded - Arctic Paradise | 3186926042 | arcticparadise.survivalexpanded.dracoix | 8 | Survival 6, Power 2 |
| The Luckymoon Archite tech | 3742734590 | canamanyak.LuckymoonArchite | 8 | Production 3, Security 2, Power 2, Temperature 1 |
| Traps Plus (Continued) | 2042706367 | Mlie.TrapsPlus | 8 | Security 8 |
| Tribal Furniture | 3671245310 | Xercaine.Tribal.Furniture | 8 | Production 7, Ideology 1 |
| UNAGI Japanese Assortment 鰻の和風箱 | 3297676809 | UNAGI.Wahuu.hako | 8 | Furniture 8 |
| URMC | 3373838883 | pphhyy.URMC | 8 | Furniture 4, Power 2, Biotech 2 |
| Vanilla Books Expanded Expanded (Continued) | 2894816192 | Mlie.VanillaBooksExpandedExpanded | 8 | Production 8 |
| Vanilla Factions Expanded - Ancients | 2654846754 | VanillaExpanded.VFEA | 8 | Production 6, Furniture 2 |
| Vanilla Iron and Steel (Continued) | 2644227855 | Mlie.VanillaIronandSteel | 8 | Production 8 |
| VFEArchitect Addon and Patches | 2610051049 | sol.vfearchaddon | 8 | Floors 4, ? 4 |
| Wanna Get High (Continued) | 2613804831 | zal.wannagethigh | 8 | Production 8 |
| Witch's Garden (Continued) | 2644141682 | zal.witchsgarden | 8 | Production 8 |
| Witch's Garden (With Healroot) | 2835149383 | zal.witchsgardenhealroot | 8 | Production 8 |
| Zal's Smoked Meat | 2594528677 | zal.smokedmeat | 8 | Production 8 |
| Zal's Smoked Meat PF Edition | 2671357344 | zal.smokedmeatpf | 8 | Production 8 |
| [1.0] TR brewing and alcohol expanded | 1688530219 |  | 7 | Production 7 |
| [1.6] Rimworld Westernization Project (Continued) | 3498164561 | Mlie.RimworldWesternizationProject | 7 | Security 7 |
| [1.7]边缘仙路-雕梁画栋 RimImmortal-Furniture | 3478098371 | RI.RimImmortal.Furniture | 7 | Floors 4, RI_RimImmortals_Furniture 3 |
| [LF] Red Dawn | 2313318568 | LeFaux.RedDawnSovietMultiKit | 7 | Security 7 |
| [SYR] Prosthetic Table (Continued) | 3320042433 | Mlie.SYRProstheticTable | 7 | Production 7 |
| 【AF】SydailyFox (Continued) | 3540588386 | Mlie.AFSydailyFox | 7 | AF_Thankyou 3, AF_CITE 3, Furniture 1 |
| AnimalHarvestingSpot (Continued) | 1542765654 | Mlie.AnimalHarvestingSpot | 7 | Misc 7 |
| CIWS_Core (Continued) | 2606506346 | Mlie.CIWSCore | 7 | Production 7 |
| Combat Training (Continued) | 2778569619 | Mlie.CombatTraining | 7 | Misc 7 |
| Cyber Fauna 1.6 | 1548649032 | Daniledman.CyberFauna | 7 | Production 7 |
| Decorative Cliffs (Continued) | 2453099145 | Mlie.DecorativeCliffs | 7 | DecorativeCliff 7 |
| Decorative trees (Continued) | 2670019924 | Mlie.DecorativeTrees | 7 | Furniture 7 |
| Decorative Vending Machines | 3049464611 | lunartika.VendingM | 7 | Misc 6, Temperature 1 |
| Dune (Continued) | 2154017463 | Mlie.Dune | 7 | Production 7 |
| Dye Vat (Continued) | 2622089950 | Mlie.DyeVat | 7 | Production 7 |
| Expanded Roofing (Continued) | 2026595894 | Mlie.ExpandedRoofing | 7 | Power 7 |
| Fishing Nets (Continued) | 2569802700 | Mlie.FishingNets | 7 | Production 7 |
| GlitterNet | 1725544583 | K.GlitterNet | 7 | GlitterNet 7 |
| Gods of Elona | 1505332648 | karukus.GodsofElona | 7 | Production 7 |
| Jelly Farm 1.6 | 1363721847 | Daniledman.JellyFarm | 7 | Production 7 |
| Kenshi Cuisine | 2600344770 | Super.Kenshicuisine | 7 | Production 7 |
| LunaRose：BonBunny | 3657986169 | rw.LunaRose.Bonbunny | 7 | Production 5, Misc 1, Furniture 1 |
| Mechanical Defense 2 - Walls (Continued) | 2016313260 | Mlie.MechanicalDefense2Walls | 7 | Structure 7 |
| Medieval - Less Wood Please | 2836499897 | Hol.LessWoodPlease | 7 | Production 5, Furniture 2 |
| Misc. Bees'n'Honey | 766264659 | Haplo.Miscellaneous.BeesNHoney | 7 | Production 7 |
| More Linkables | 1103809207 | 4loris4.MoreLinkables | 7 | Misc 7 |
| My Home | 3766854289 | chance.myhome | 7 | Furniture 7 |
| Nanotrasen's Armory (Continued) | 2171553025 | Mlie.NanotrasenArmory | 7 | Security 7 |
| Napoleonic Age (Continued) | 2052310880 | Mlie.NapoleonicAge | 7 | Security 7 |
| Pawns Paint! Restored (Continued) | 2449797994 | Mlie.PawnsPaintRestored | 7 | Production 7 |
| Playable Flood | 3769250791 | rdash99.PlayableFlood | 7 | Misc 5, Production 1, Security 1 |
| Prisoner Arena (Continued) | 2022581505 | Mlie.PrisonerArena | 7 | Misc 7 |
| Project Moon - Sweepers | 3761992483 | Althar.ProjectMoonSweepers | 7 | Production 7 |
| Punji Sticks (Continued) | 2018989792 | Mlie.PunjiSticks | 7 | Security 7 |
| Radiology (Continued) | 3263857887 | Mlie.Radiology | 7 | Radiology 7 |
| Real World Food 2 (Continued) | 2256552171 | Mlie.RealWorldFood2 | 7 | RealFoodmaker 7 |
| Reclaim, Reuse, Recycle (Continued) | 2567364887 | Mlie.ReclaimReuseRecycle | 7 | Production 7 |
| Resident Rim | 3732795691 | ProstoMax.ResidentRim | 7 | Misc 6, Production 1 |
| Rim-Robots_ | 2743171832 | VexedTrees980.RimRobots | 7 | Production 7 |
| RimCuisine 2: Smokes and Shrooms Expansion (Continued) | 2069579592 | Mlie.RC2.SaSE | 7 | Joy 7 |
| RimGacha (Continued) | 2135371381 | Mlie.RimGacha | 7 | Misc 7 |
| RimJoust | 3743710674 | forti.rimjoust | 7 | Misc 6, Ferny_Jousting 1 |
| Rimspite Gitz: Loonclans | 3735204214 | JTC.AOSgitz | 7 | Production 7 |
| Rimstro Farming Expansion | 3580027782 | Roo.rfe | 7 | RS_Category 7 |
| Rimzone: Sons and Daughters of Helghan | 3492260324 | JTC.Helghast | 7 | Security 5, Odyssey 1, Production 1 |
| rjw-whorebeds | (local) rjw-whorebeds |  | 7 | Furniture 7 |
| Signs and Memorials (Continued) | 2071681396 | Mlie.SignsAndMemorials | 7 | Misc 7 |
| SS Lightning Rod (Continued) | 2358261479 | Mlie.SSLightningRod | 7 | Misc 7 |
| Tilled Soil | 725747149 | GT.Sam.TilledSoil | 7 | Floors 7 |
| VGP Soylent Production | 2007063605 | dismarzero.VGP.VGPSoylentProduction | 7 | Production 7 |
| World of Naruto | 3025338958 | LifeisGame.WorldOfNaruto | 7 | Production 6, Misc 1 |
| 出于沙漠之花 | 3494511060 | Owen.FlowerFromTheDesert | 7 | Production 3, Security 2, Temperature 1, Power 1 |
| 占星师 Astrologer | 3574358036 | LOF.Astrologer | 7 | Production 5, Misc 1, Power 1 |
| [1.6] CAI 5000 - Advanced AI + Fog Of War (continued) | 3673768803 | Krkr.rule56 | 6 | Intelligences 6 |
| [Abandoned] Extended Storage (Continued) | 2566120724 | Mlie.ExtendedStorage | 6 | FurnitureStorage 6 |
| [CP] Retro Joy | 1842663639 | CP.Retro.Joy | 6 | Furniture 3, Joy 3 |
| [FM] Furniture Expanded Pack | 3537360590 | Farxmai2.VFEstandalone | 6 | Furniture 3, Production 2, Temperature 1 |
| [HAS] MedievalDiet | 3750840931 | BiscuitMiner.HAS.MedievalDiet | 6 | Production 6 |
| [JF] More Floor Icons | 2873911573 | JF.MoreFloorIcons | 6 | Floors 6 |
| [JPT] Human Resources | 2119687603 | JPT.HumanResources | 6 | Production 2, Security 2, Furniture 1, Misc 1 |
| [JPT] Human Resources (1.4 Unofficial) | 3004242895 | JPT.HumanResources.1.4 | 6 | Production 2, Security 2, Furniture 1, Misc 1 |
| [LTS]Biosphere | 3217394931 | LimeTreeSnake.Biosphere | 6 | Floors 4, Production 1, LTSFurniture 1 |
| [RF] Fishing-ReWork Seafood and Sushi Addon (Continued) | 2920099647 | Mlie.RFFishingReWorkSeafoodAndSushiAddon | 6 | Production 6 |
| [SYR] Naga Continued | 3307453651 | Sans.naga | 6 | Production 6 |
| [TP]Blood (Continued) | 2974969628 | Mlie.TPBlood | 6 | Production 6 |
| [TW][SZ]（非正式版本）戢斨国魂——传统派系和文化扩展 Chinese culture and faction and equipment expansion | 2330850570 | TangW.SZ.GuoHun | 6 | TW_Guohun 6 |
| [XND] Carpenter Tables (Continued) | 2375479881 | Mlie.XNDCarpenterTables | 6 | Production 6 |
| 【颜正】异界神术（Foreign Magic）1.6 continued | 3726631657 | Moo.FCJKz.ForeignMagic1.6continued | 6 | Production 6 |
| Anomalies Expected | 3240752689 | MrHydralisk.AnomaliesExpected | 6 | Anomaly 6 |
| Big Graves and Sarcophaguses | 3304095842 | Wanzi.BigGraves | 6 | Misc 6 |
| Caravan Hauler | 3798638836 | asus.caravantruck | 6 | CT_Garages 4, Structure 2 |
| Carnarodian, the two Mustelids Xenotypes and Factions | 3104049393 | Resurrectionem.LyunicaandSobolelyud | 6 | Production 6 |
| CaveworldFlora (Continued) | 2259058735 | Mlie.CaveworldFlora | 6 | Production 6 |
| Clone Bay | 1304432145 | goudaquiche.clonebay | 6 | Misc 6 |
| Comigo's Adequate Cooking Continued | 3331622419 | ComigoGames.Patches.VCESugarGrain | 6 | Production 6 |
| Concrete for Fertile Fields | 2035462091 | malkav73.concrete | 6 | Structure 6 |
| Craftable Urns | 2492836452 | RedBaronFlyer.RedsTweaks.CraftableUrns | 6 | Misc 6 |
| Crimson - Greenbud | 3457763586 | CC.Drug.Dealer | 6 | Production 6 |
| CrystalBall (Continued) | 2483367722 | Mlie.CrystalBall | 6 | Production 6 |
| Cutting out Head (1.6) | 3700765558 | ab.beheading | 6 | Misc 5, Security 1 |
| Dark Ages : Beasts and Monsters | 3472275628 | Van.Beasts | 6 | Floors 6 |
| Dragon's Ores Utilities | 3553761214 | dragonking.dragonsoresutilities | 6 | Temperature 2, Misc 2, Power 1, Furniture 1 |
| Early Vehicle Parts | 3022062151 | CaptainTesss.EVP | 6 | Early_Early_Vehicles 6 |
| ED-Laser-Drill | 722086956 | Jaxxa.EnhancedDevelopment.LaserDrill | 6 | Power 6 |
| Egg Incubator | 2505566813 | Mlie.EggIncubator | 6 | Production 6 |
| El's Ilk of the Old Gods | 3005403475 | ellit.IlkoftheOldOnes | 6 | Furniture 6 |
| EM Tattoos and Piercings (Continued) | 2030227116 | Mlie.EMTattoosAndPiercings | 6 | Production 6 |
| End times: Renn Organisms | 2811289481 | DanielRenner.RennOrganisms | 6 | Misc 6 |
| ENOS’s buildings | 2641227649 | Binkl.enos.buildings | 6 | Production 3, Power 2, Misc 1 |
| Epochs - Incense | 3072579620 | det.epochsincense | 6 | Furniture 6 |
| Epochs - Pyrinth | 3336544632 | det.epochspyrinth | 6 | Furniture 4, Temperature 2 |
| Erin's Japanese Furniture | 2354938860 | Erin.JapaneseFurniture | 6 | PropsandDecor 6 |
| Fire Warden (Continued) | 2197425463 | Mlie.FireWarden | 6 | Misc 6 |
| Fishing Village Decor and Props (Continued) | 2902499006 | zal.fishprops | 6 | Misc 6 |
| Food Drying | 3664822476 | paseri.FoodDrying | 6 | Production 6 |
| Gardening - 1.0 | 1738749527 |  | 6 | Gardening 6 |
| GlitterWorld Supplies | 3393822429 | wuhu1234.GlitterWorldSupplies | 6 | Production 6 |
| Gloomy Furniture Upscale | 3231428653 | cw.gloomy.textureupscale | 6 | OldStyleFurniture 6 |
| Gokusotsu the Hell Guard | 2892925626 | muri.gokusotsu | 6 | Joy 4, Production 2 |
| Golden Books 书中自有黄金屋 | 3648400909 | maiya.GoldenBooks | 6 | Furniture 4, Production 2 |
| HE-Ford B700 Bus '87 | 3281446276 | HE.FBBUS | 6 | HE_Vehicles 6 |
| Head Pike (Continued) | 2893169195 | zal.headpike | 6 | Furniture 6 |
| Heruan, Keepers of Memories | 2810613161 | Aelanna.Heruan | 6 | Security 4, Furniture 2 |
| Heyra the Horned (Revived) | 3679943662 | Foxed.HeyraTheHorned | 6 | Production 6 |
| JetPack (Continued) | 2196487991 | Mlie.JetPack | 6 | Power 6 |
| Kapitalist's Pay Them All | 3592525342 | kapitalist.paythemall | 6 | Misc 3, Production 2, Joy 1 |
| Kemetic Decorations - the legacy of Jerry | 2841187250 | Sovereign.Samsucksfrozenchicken | 6 | Jerry 6 |
| Kit's Gunpowder Weapons (Continued) | 3413714419 | zal.kitgunpowder | 6 | Security 6 |
| Lantern's Light | 3621184307 | DrAke.LanternsLight | 6 | Misc 6 |
| Lava Must Flow | 3796886440 | Rayz.LavaMustFlow | 6 | Misc 5, Floors 1 |
| Lost Joy Objects - Arcades | 1506336556 | dracoix.ljo.arcades | 6 | Joy 6 |
| Marro | 2057712425 | zot.marro | 6 | Structure 2, Furniture 2, Production 2 |
| Mechanoid Master Blaster (Continued) | 3503503505 | Mlie.MechanoidMasterBlaster | 6 | Security 6 |
| Medieval Gene Assembler | 3171518917 | DDJY.MedievalGeneAssembler | 6 | Biotech 6 |
| Medieval Overhaul Misc. Patches | 2775878596 | Jsin.MedievalOverhaulMisc | 6 | Production 6 |
| Medieval Overhaul: Air Vehicles | 3302419308 | GAYUKI.MedievalOverhaulAirVehicles | 6 | VF_Vehicles 6 |
| Medieval Transport Airships | 3695137672 | joeownage.transport.airships | 6 | Odyssey 6 |
| MiningCo. Alert speaker (Continued) | 3276121703 | Mlie.MiningCoAlertSpeaker | 6 | Security 6 |
| MoeLotl: Rigor Mortis | 3454053400 | fxz.moelotlzombie.update | 6 | Misc 6 |
| mustards-sexy-statues | (local) mustards-sexy-statues |  | 6 | Ideology 6 |
| Neolithic Desk and Blackboard | 2949033630 | Hol.NeolStuff | 6 | Furniture 6 |
| Planetary Cataclysms | 3794266591 | xenomorphchyma.planetarycataclysms | 6 | Temperature 4, Power 2 |
| RE : 飲み物は？ - RE : Where is drinks? | 3732726174 | lardry.whereisdrinks | 6 | Production 5, Furniture 1 |
| Retro Joy Renew (unofficial) | 3811391689 | nelim.retrojoy | 6 | Furniture 3, Joy 3 |
| RetroJoyRenew | (local) RetroJoyRenew |  | 6 | Furniture 3, Joy 3 |
| Rim Colosseum | 3725002406 | legendaryminuteman.rimcolosseum | 6 | RC_ArenaDesignations 6 |
| Rim Expedition 33 | 3534663071 | warult.expedition33mod | 6 | Security 3, Production 2, Misc 1 |
| RimBees patch | 1904872824 | sztorno.rimbees | 6 | RB_Bees 5, ReligionBuildings 1 |
| Rimcense: Neolithic Soothe | 2532255863 | Incense.velcroboy333 | 6 | Misc 4, Production 2 |
| Rimputers (No Dubs Bad Hygiene) | 2798666741 | Hol.Rimputersforked | 6 | Misc 6 |
| rimvore-2-reformers | (local) rimvore-2-reformers |  | 6 | Misc 6 |
| RimWorld - The Dark Descent (Continued) | 3312022150 | zal.darkdescent | 6 | Production 2, Power 2, Misc 2 |
| RimWorld Logistics Company v0.27.1 | 3794853585 | Xite.RimLogistics | 6 | Production 3, Furniture 3 |
| rimworld-stripper-pole | (local) rimworld-stripper-pole |  | 6 | Joy 6 |
| rjw-ex | (local) rjw-ex |  | 6 | Misc 6 |
| Sahari, The Natives Of Desert | 3531751946 | Sahari.Minjunbulsang | 6 | Sahari_building 6 |
| Simple Soil V3(continued) | 2187570377 | SimpleSoil.velcroboy333 | 6 | SimpleSoilV3 6 |
| Slippers ＆ Mats | 2871977123 | RMC.SlippersMats | 6 | Furniture 6 |
| Small Graves and Sarcophaguses | 2845934077 | Wanzi.SmallGraves | 6 | Misc 6 |
| Standalone Hot Spring | 2205980094 | balistafreak.StandaloneHotSpring | 6 | Joy 6 |
| Steam Light | 2372416175 | TheGoofyOne.SteamLight | 6 | Furniture 6 |
| Stoneborn - Cuisine | 3725224779 | det.sbcuisine | 6 | Production 6 |
| Swarmpocalypse | 3447056193 | Luosheng.Swarmpocalypse | 6 | Production 3, Misc 2, Biotech 1 |
| SyrenitesMod | 3326074711 | IceLordSyren.SyrenitesMod | 6 | Security 3, Power 2, Production 1 |
| The Devil's Bong | 2568674348 | adwarf.devilbong | 6 | Misc 6 |
| Too Many Props (Continued) | 3132069492 | zal.toomanyprops | 6 | Props 6 |
| Torches and Braziers (Continued) | 3658303543 | Mlie.TorchesAndBraziers | 6 | Furniture 6 |
| Toxlamps | 3166048152 | Koni.Misc.Toxlamps | 6 | Furniture 4, Floors 2 |
| TurtleShroom Productions Proudly Presents: Mongolian Factions (Continued) | 3812891039 | SZ.MengGu.Expanded | 6 | DaJian_Ui_Menu 6 |
| Useful Parasites | 3175473107 | Romyashi.UsefulParasites | 6 | Production 6 |
| Vanilla Cooking Expanded - Sushi | 2158539170 | VanillaExpanded.VCookESushi | 6 | Production 6 |
| Vanillafied Vivi | 3739051552 | kahirDragoon.vanillafiedVivi | 6 | Furniture 1, Misc 1, Production 1, Security 1 |
| VCE - Electric/Chemfuel Stew Pot | 3436690949 | JXW.VCEElectricStewPot | 6 | Production 6 |
| Villages:Homes | 2941977041 | Ottersholdhands.VillagesHomes | 6 | Structure 6 |
| Walkable Solar Panels | 2511096015 | Mlie.WalkableSolarPanels | 6 | Power 6 |
| Wallmounted Battery | 2514057480 | Mlie.WallmountedBattery | 6 | Power 6 |
| ZARS Simple Fish (Continued) | 2941173785 | zal.simplefish | 6 | Production 6 |
| 原木存储网络 | 3582428739 | NBNW.WoodLogPipeNetwork | 6 | VCHE_PipeNetworks 6 |
| 钢铁存储网络 | 3580359910 | NBNW.SteelPipeNetwork | 6 | VCHE_PipeNetworks 6 |
| [1.1] Resource Generators | 2018432396 | atitaner.ResourceGen | 5 | Production 5 |
| [1.6] BeautyFloors (Continued) | 3498407243 | Mlie.BeautyFloors | 5 | Floors 4, Production 1 |
| [Cosplay equipment] Blue archive | 2674876907 | mlmlmlm.cosplayequipmentbluearchive | 5 | Production 3, Security 2 |
| [FSF] Meditation Freedom | 3241427647 | FrozenSnowFox.MeditationFreedom | 5 | Misc 5 |
| [PLA] Addon - Lost Vehicles | 2843481344 | TMC.Vehicle.Lost | 5 | Ship 2, PLA_DesignationCategory_Vehicle 2, Security 1 |
| [SS]Maid Project | 1498756997 | BBIS.MaidProject | 5 | Production 5 |
| A Regular Ol' Plumbus | 2210738958 | Xercaine.Plumbus | 5 | Production 5 |
| alven-lewd-style | (local) alven-lewd-style |  | 5 | Floors 5 |
| Ancient Buildings Renew (unofficial) | 3806708945 | nelim.ancientbuildings | 5 | Structure 2, Temperature 1, Production 1, Security 1 |
| AncientBuildingsRenew | (local) AncientBuildingsRenew |  | 5 | Structure 2, Temperature 1, Production 1, Security 1 |
| bakalogistics | 3567954857 | jokebakaQAQ.bakalogistics | 5 | Production 5 |
| Barbs And Moats | 3601561731 | SgtBruce.BarbsAndMoats | 5 | Floors 3, Security 2 |
| Baumilha Wood expanded | 3259877442 | yld.Woodpipeline | 5 | Burn_PipeNetworks 5 |
| BeautyFloors (Continued) | 3820970849 | Mlie.BeautyFloors | 5 | Floors 4, Production 1 |
| Beer＆PsychiteTea Retexture 啤酒与精神茶贴图AI重置 | 3737335488 | ICEorANGE.Beer | 5 | BEERtea 5 |
| Biomes! Islands | 2038001322 | BiomesTeam.BiomesIslands | 5 | Structure 3, Furniture 2 |
| Cloth Production Expanded Continued | 3516299224 | cyanobot.cloth.production.expanded | 5 | Production 5 |
| Colony Manager Redux | 3310027356 | ilyvion.colonymanagerredux | 5 | Production 4, Odyssey 1 |
| Crossworld Artifacts 异世珍宝 | 3626804613 | Mily.HighValueItems | 5 | Misc 5 |
| CSL Blackboard Retexture | 2559456394 | CSL.Blackboadretxture | 5 | Production 5 |
| Decorative Grass and Plants | 2679687967 | Euphoric.DecorativeGrassAndPlants | 5 | Decorations 5 |
| Dolls frontline少女前線——IOP戦術人形テクノロジー(日本語化) | 2778917744 | TenMoe.GFIOP.JP | 5 | Production 5 |
| Evaporation Pond | 2949776907 | joeyjoejoeshabidoo.EvaporationPond | 5 | Misc 5 |
| Fences | 672717999 |  | 5 | ItchyFences 5 |
| Garbage Craft--垃圾工艺 | 2931173580 | Yuan.GarbageCraft.Misc | 5 | Production 4, Misc 1 |
| Halloween Graves(from Halloween Parade) | 2569165844 | HalloweenGraves.velcroboy333 | 5 | Misc 5 |
| Meal Printer (Continued) | 2896093930 | Mlie.MealPrinter | 5 | Production 5 |
| Medieval Festival | 2042616573 | MedievalFestival.velcroboy333 | 5 | Joy 3, Furniture 1, Temperature 1 |
| Medieval Overhaul: House Van Illa | 3327601396 | Addie.HouseVanIlla | 5 | Misc 3, Furniture 2 |
| Miniature Props and Decor | 3579351912 | Leo.PropsDecor | 5 | Ferny_Decorations 2, Floors 1, MiniatureProps_Decoration 1, Misc 1 |
| More than Ashes V2 | 2846247713 | Layken.morethanashesV2 | 5 | Production 5 |
| MorrowRim | 2443089362 | SirMashedPotato.MorrowRim | 5 | Furniture 5 |
| MorrowRim - Alcohol | 2091165362 | SirMashedPotato.MorrowRim.Alcohol | 5 | Production 5 |
| Movable Hitech Research | 2547321761 | grampybones.movableresearch | 5 | Production 5 |
| OverPowered Gaming | 2161009836 | CB745.OverPoweredGaming | 5 | CB745_DesignationMenu 5 |
| PowerSwitch | 717632155 | Haplo.PowerSwitch | 5 | Power 5 |
| RecreationalBallpit | 2453428418 | mitch.asdf.RecreationalBallpit | 5 | Joy 5 |
| RecreationalSlotMachine | 2469522690 | mitch.asdf.RecreationalSlotMachine | 5 | Joy 5 |
| Repair hubs | 3025361802 | lts.RH | 5 | Security 3, Anomaly 2 |
| Resource Pipes - Addons | 3569926089 | HMD.ResourcePipesAddons | 5 | VCHE_PipeNetworks 5 |
| Rim of Madness - Bones (Continued) | 3820831704 | zal.rombones | 5 | Floors 4, Structure 1 |
| Rimworld-Tentacle-Lord | (local) Rimworld-Tentacle-Lord |  | 5 | Floors 4, Structure 1 |
| Rolled Up Sleeves (prohibited) | 3811403177 | nelim.rolledupsleeves | 5 | RUS_Builder 4, ? 1 |
| RolledUpSleeves | (local) RolledUpSleeves |  | 5 | RUS_Builder 4, ? 1 |
| Signs and Comments | 3281950776 | Dark.Signs | 5 | Dark_Signs 5 |
| Simple Utilities: Wall Adjusted | 3446248877 | Owlchemist.WallUtilities | 5 | Furniture 5 |
| Standalone Hot Spring Retexture | 2759464668 | Xeva.HSRetexture.11 | 5 | Joy 5 |
| Star Wars Dub's Hygiene Stuff | 3371695380 | ucp.starwarsdubshygienestuff | 5 | Hygiene 4, Temperature 1 |
| Tavern | 3775694305 | ODs.Tavern | 5 | TavernFurniture 5 |
| TAXIDERIM | 3809332435 | local.taxidermybusts | 5 | Misc 5 |
| Tiny Recreation Pack | 3816944171 | lizalka.tinyrecreationpack | 5 | Joy 5 |
| Tribal Instruments | 1122870388 | Hansenbansen243.TribalInstruments | 5 | Joy 5 |
| Vanilla Nutrient Paste Expanded: Reimagined Progression | 3530651481 | MrHydralisk.VNPEReimaginedProgression | 5 | Production 3, VCHE_PipeNetworks 2 |
| Velcroboy's Miscellaneous Debris | 2094567363 | RandomThings.velcroboy333 | 5 | Misc 3, Production 1, Power 1 |
| WA-ElectricalLight [1.0] | 1557591491 |  | 5 | WA_Builder 4, WA_FutonCategory 1 |
| Warm and Cool FloorPaint | 1502333873 | karukus.WarmandCoolFloorPaint | 5 | Temperature 5 |
| Witcher Bestiary v2.0 | 3814238007 | voskres.witcherbestiary | 5 | Furniture 3, Joy 1, Production 1 |
| 菜篮子工程-营养膏扩展（Shopping Basket Program - Nutrient Paste Expansion） | 3697701184 | shenpc.ShoppingBasketProgramNutrientPasteExpansion | 5 | Misc 3, Production 2 |
| [CAP] Rimworld Interactive Chat Service | 3603078790 | Captolamia.RICS | 4 | Misc 4 |
| [CP] Rimmu-Nation - Gloves N' Boots - 1.6 temp port | 3759005701 | CP.RimmuNation.GlovesNBoots | 4 | Production 4 |
| [DBL]Awnings And Roofs | 2836493333 | DBL.AwningsAndRoofs | 4 | Roofs 4 |
| [DHM]Preservation_Sarcophagus | 3477409793 | drilledhead.preservationSarcophagus | 4 | Misc 4 |
| [EL]Hairdressing Salon | 3807822626 | Elanilda.HairDressingSalon | 4 | EL_ElanFurniture 4 |
| [GP]Small Pond | 3750876226 | Smallpond.GP | 4 | Joy 4 |
| [HMC] Multifunctional Workbench | 3698326957 | HMC.MultifunctionalWorkbench.mod | 4 | Production 4 |
| [JAIL] Prison Walls and Beds (Continued) | 3235623894 | DerekBickley.PrisonWalls | 4 | Structure 4 |
| [MQM] Prosperity | 3806440075 | friver.mqm.prosperity | 4 | Production 2, Misc 1, Joy 1 |
| [SYR] Processor Framework | 3210544395 | syrchalis.processor.framework | 4 | Production 4 |
| [TW1.4]春节装饰 ChineseNewYear_Decoration | 3159818432 | TW.ChineseNewYearDecoration | 4 | Misc 4 |
| akt-lewd-clothes | (local) akt-lewd-clothes |  | 4 | Production 4 |
| Apothecary Expansion | 3572529533 | untamo.apothecary.expansion | 4 | Production 4 |
| Archotech Expanded | 1442734859 | Teok25.ArchotechExpanded | 4 | Production 4 |
| Argentine Mate | 3302277737 | Argon.Mate | 4 | Production 4 |
| Arsenal - America Founding Weapon Pack | 3818357505 | ziom.arsenalamericafounding | 4 | ARS_ArsenalBuildings 4 |
| Automatic Hydroponics Expanded | 3536424131 | AutomaticHydroponics.Expanded | 4 | Production 4 |
| Bill Doors' modular wolf girl weapon module | 2899078092 | 3HSTltd.wolf.geneweapon | 4 | Security 4 |
| Biotech Expansion - Mythic | 2883216840 | biotexpans.mythic | 4 | BTEMy_Mythic 4 |
| Caravan Gear | 2018290315 | jelly.caravangear | 4 | Production 2, Furniture 1, Power 1 |
| Cargo container | 2725808118 | Aoba.CargoContainer | 4 | Misc 4 |
| Castle Branne (Continued) | 3263010218 | zal.castlebranne | 4 | Structure 2, Joy 2 |
| COF's Execute -R18G | 2869133661 | cof.moretorture | 4 | Power 2, Furniture 2 |
| ColdCrystal Continued | 3781359791 | lebendigeskissen.ColdCrystalContinued | 4 | Furniture 4 |
| Columbarium | 3816362428 | mint.columbarium | 4 | Misc 4 |
| CPS: Compact Pawn Storage | 2974541112 | zed.0xff.CPS | 4 | VCHE_PipeNetworks 2, Misc 1, Structure 1 |
| Crafting Table | 3208284159 | AOBA.CraftingTable | 4 | Production 4 |
| Cyber Fauna [1.3] | 2554182392 | Scherub.CyberFauna | 4 | Production 4 |
| Cybermen | 3418128007 | darthdakka.cybermen | 4 | Power 2, Structure 1, Production 1 |
| Cybranian - Anima Obelisk | 2614248835 | DimonSever000.AnimaObelisk.Specific | 4 | Misc 4 |
| Daily furniture Fix 塔林家具补丁 | 3431681279 | JXW.DailyfurnitureFix | 4 | ADH_Fix_Category_Structure 3, ADH_Fix_Category_Decoration 1 |
| Dispensary Mod | 3045681495 | firestarme.dispensarymod | 4 | Misc 2, Structure 2 |
| Door Mat | 1505423207 | dracoix.doormat.r12a | 4 | Misc 4 |
| DucKs Things | 3225105695 | theduck.ducksthings | 4 | Power 4 |
| Enter Here | 2824117092 | Mlie.EnterHere | 4 | Misc 4 |
| Entomophagy | 2996527741 | HIGGS.Cozarkian.Entomophagy | 4 | Production 4 |
| Epochs - Tallow | 3502180016 | det.epochstallow | 4 | Furniture 4 |
| EvolvedOrgansRedux | 3648390934 | StatistNo1.EvolvedOrgansRedux | 4 | Production 4 |
| Expanded Glasswork | 3592997089 | qq.expanded.glasswork | 4 | Production 4 |
| Expanded Materials - Christmas | 2687653217 | Argon.ExpandedMaterials.Xmas | 4 | Structure 4 |
| Fermenter (Continued) | 2194522312 | Mlie.Fermenter | 4 | Production 4 |
| FIP - RobCo | 3563825876 | FIP.RobCo | 4 | Biotech 3, Misc 1 |
| Fireplace | 3236347705 | Xercaine.Fireplace | 4 | Temperature 4 |
| Flintlocks Extended | 2984576168 | CETeam.CombatExtendedFlintlocks | 4 | Security 4 |
| Gatagata Stoneworks | 3724064672 | Becke.ChunkWoFzoroiKakeraNi | 4 | Furniture 3, Security 1 |
| Gladiator Arena | 3805398399 | local.bloodcourt.arena2 | 4 | Misc 4 |
| Gothic Dress | 2756420520 | SafetyMets.GothicDress | 4 | Production 4 |
| Grains and Brewing (1.4+) | 2897396824 | tidal.grainsandbrewing | 4 | Production 4 |
| Gravlite Furniture | 3725894389 | Koni.Misc.GravliteFurniture | 4 | Odyssey 2, Ideology 2 |
| Gravship Garden | 3761101347 | GG.GravshipGarden | 4 | Odyssey 4 |
| HALO - UNSC Faction (1.6) | 3527658978 | Harkon.HALO.UNSCFaction | 4 | Security 2, Misc 1, Production 1 |
| Heat Pumps | 2975382296 | Pineapple.HeatPump | 4 | Temperature 4 |
| Hobo Tough Life | 2468025074 | bbbbilly.hobotoughlife | 4 | Furniture 2, Temperature 1, Production 1 |
| Hospital | 2992224079 | Adamas.Hospital | 4 | Misc 4 |
| Hospitality: Casino | 2939292644 | Adamas.HospitalityCasino | 4 | Joy 4 |
| Immersive Chefs | 3782589902 | fumblesneeze.immersivechefs | 4 | Production 4 |
| Immortals | 1984905966 | fridgeBaron.Immortals | 4 | Production 4 |
| InwallShelf (Continued) | 2603986959 | Mlie.InwallShelf | 4 | Furniture 4 |
| It's the ultimate Diamond+ | 877482162 |  | 4 | Security 4 |
| Kemetic Decorations | 2836144432 | Sovereign.Kemet | 4 | Misc 3, Structure 1 |
| Kitchen Counter and Shelves | 1885953540 | dismarzero.VGP.KitchenCounterandShelves | 4 | Furniture 4 |
| LED Technology(continued) | 2613973519 | Velcroboy333.RimworldLEDTechnology | 4 | LEDTechnology 4 |
| Logic Switch | 3723818517 | Borsh.LogicSwitches | 4 | Power 4 |
| Lord of the Rims - Elves (Continued) | 3548255064 | zal.lotrelves | 4 | Structure 3, Furniture 1 |
| luxandra-lust | (local) luxandra-lust |  | 4 | Ideology 2, Misc 2 |
| Mahjong Table | 3535837584 | Yayoflake.Mahjong | 4 | Joy 4 |
| Manure | 3252954927 | Manure.Public.Velcroboy333 | 4 | Hygiene 4 |
| Mashed's Spiribirds | 2839002794 | SirMashedPotato.Spiribirds | 4 | Production 4 |
| Matter | 3820086040 | pigeaca.matter | 4 | Production 4 |
| Medical IVs Fork | 3480177412 | cantaloupetheclown.MedicalIVsFork | 4 | Misc 4 |
| Medieval Chemfuel | 3669123776 | atrumchalybs.medievalchemfuel | 4 | Production 2, Temperature 1, Furniture 1 |
| Medieval Overhaul Industrialized | 3681673290 | MedievalOverhaul.Industrialized | 4 | Production 4 |
| Medieval Things: Medical | 3470308998 | Salvador143.MThings.Medical | 4 | Misc 2, Joy 2 |
| MediStation | 3791910009 | Asiimoves.MediStation | 4 | Misc 4 |
| Metaflora | 2782577156 | SA.Metaflora | 4 | Furniture 4 |
| MGS Item Pack (Continued) | 2779413411 | zal.mgsitems | 4 | Furniture 4 |
| Milkwater's Warframe Mod: The Sequel | 3431282756 | Milkwater.WarframeModSequel | 4 | Production 4 |
| Mimic Slime - Deliria | 3636189401 | lf.mod.MimicSlime | 4 | Production 2, Misc 2 |
| Modern Bed | 2430249387 | SC.modernbed | 4 | Furniture 4 |
| Modern Bed (1.4+) | 2888914698 | Hol.modernbed | 4 | Furniture 4 |
| Moonjelly Xenotype | 3030254580 | SG.moonjelly | 4 | Production 4 |
| More Batteries | 747397788 | Stolij.MoreBatteries | 4 | Power 4 |
| More Bee Candles | 3434323830 | lumiona.MoreBeeCandles | 4 | RB_Bees 4 |
| More Guerrilla Tactics Traps | 3538725785 | MPCatcher.TrapsExpanded | 4 | Security 4 |
| Muffalo-in-a-Box | 3393699499 | tiredguy.muffaloinabox | 4 | Furniture 2, Production 2 |
| Mythic Ages: Megafauna Bestiary | 3537788184 | veterano.mythicages.megafaunabestiary | 4 | MA_MythicProduction_Tribal 4 |
| Neolithic Scavenging (Continued) | 2893843175 | Mlie.NeolithicScavenging | 4 | Production 4 |
| No Water, No Life. Forked | 3447655477 | redbrick.MizuModForked | 4 | Mizu 4 |
| Nukes | 1777069843 | PrivateGER.Nukes.Shells | 4 | Security 4 |
| Old World Coalition | 3638946530 | mihailsmorodin.OWC | 4 | Production 4 |
| Oni Xenotype | 3311134271 | Eclair155.OniXeno | 4 | Production 4 |
| Orostonian, the Frontiers Xenotypes and Factions | 3147447844 | Resurrectionem.Orostonian | 4 | Production 4 |
| Outdoor Stuff | 3569403743 | ESP.Outdoorstuff | 4 | Furniture 2, Misc 1, Hygiene 1 |
| Paramount Combat Armaments | 3220205937 | Samael.PCA | 4 | Security 4 |
| Pirates! Gold | 2599107582 | zal.piratesgold | 4 | Security 4 |
| Ponpeco Furnitures : Kids' Room | 3367310887 | ponpeco.PFKidsRoom | 4 | PonpecoFurniture 4 |
| PVZRimWorld | 3676353877 | acct.PVZRimWorld | 4 | Security 3, Misc 1 |
| RadWorld | 2644582906 | Declinedkilr.RadWorld | 4 | Misc 4 |
| Religions of Rimworld 2.0 | 1974112020 | basarab.ror | 4 | ReligionBuildings 4 |
| Requeen Build | 3659843359 | build.requeen | 4 | Security 4 |
| Resource Generation Spots | 3773685286 | Evran.ResourceGenerationSpots | 4 | Misc 4 |
| RIM Enchantment Craft | 3666549755 | SunsetModerTeam.RIMEnchantmentExpansion | 4 | REE_EnchantmentBuilding 4 |
| rim!tale | 3714568121 | stardustus.rimtale.souldarklv | 4 | Production 2, Misc 1, Power 1 |
| RimFortress: Dwarven Plants | 2042926702 | dismarzero.VGP.RimFortressDwarvenPlants | 4 | Temperature 4 |
| RimOffice (Continued) | 3673901910 | zal.rimoffice | 4 | Furniture 2, Production 2 |
| RimPest: Infestation Ecology | 3738134262 | alec.rimpest | 4 | Misc 4 |
| RimPhysique | 3771856492 | Lenatuo.hormones | 4 | Misc 3, Production 1 |
| RimThedas: Metals (Continued) | 3716852779 | zal.dragonagemetals | 4 | Misc 2, Furniture 2 |
| Rimworld of the Rising Sun | 3792240821 | NorthSpirit.RimworldOfTheRisingSun | 4 | Security 2, Production 1, Power 1 |
| rjw-sexperience-ideology | (local) rjw-sexperience-ideology |  | 4 | Misc 4 |
| RPG Adventure Flavour Pack | 2916348220 | MrSamuelStreamer.RPGAdventureFlavour | 4 | Joy 2, Production 2 |
| RR's EZ Ceramics | 3785639810 | Resurrectionem.RRBrickCeramic | 4 | Production 3, Structure 1 |
| RR's Furniture pack-Collection Rapture | 3310690878 | Resurrectionem.Furniture | 4 | RRFurniture 3, Hygiene 1 |
| Sake Brewery (1.3-1.6) | 3574420212 | Lambdapatch.Sake | 4 | Production 4 |
| School and learning | 3573095529 | Dylan.SchoolAndLearning | 4 | Production 4 |
| Seafood Farm | 2820752251 | Mlie.SeafoodFarm | 4 | Production 4 |
| Simple Chains: Leather (Continued) | 3424122756 | Mlie.SimpleChainsLeather | 4 | Production 4 |
| Simple Loom | 1489517427 | Techmago.SimpleLoom | 4 | Production 4 |
| Simple Ships | 2905305622 | Rudinov.CommissionPLA | 4 | PLA_DesignationCategory_Vehicle 4 |
| SloppyMods Mending Solutions | 3808805962 | sloppymod.dynamicmending | 4 | Production 4 |
| Small Stoves | 3371558245 | Xercaine.SmallStoves | 4 | Production 4 |
| Smaller Geothermal Generator (更小的地熱發電機) | 3456671049 | emoryoakley.buildings.smallergeothermalgenerator | 4 | Power 4 |
| Stoneborn - Delights | 3106413957 | det.sbdelights | 4 | Production 4 |
| Stony campfire | 1367897185 | goudaquiche.stonycampfire | 4 | Temperature 3, Production 1 |
| Subnautica Machines | 3671343337 | Xeneo.SubnauticaMachines | 4 | Production 2, Misc 1, Power 1 |
| Survival Expanded - Desert Dreams | 3191123007 | desertdreams.survivalexpanded.dracoix | 4 | Survival 4 |
| The Dead Man's Switch - Shroud Zone Special Force | 3656498257 | Berserk.DeadManSwitch.ExperimentalWeapons | 4 | DMS_Category 4 |
| The Jukebox | 2775601991 | zal.jukebox | 4 | Joy 4 |
| Thin Walls | 3808584418 | Xercaine.ThinWalls | 4 | Temperature 2, Structure 1, Odyssey 1 |
| TiberiumRim | 1346865620 | telefonmast.tiberiumrim | 4 | Floors 2, Misc 2 |
| Tiny Table ReUpload | 3186290184 | Proxyer.TinyTableReUpload | 4 | Furniture 4 |
| Trains of the Rim | 3530446424 | princeofpluto.vehicles.trains | 4 | RailroadCategory 4 |
| Transport Shuttle Standalone (Continued) | 3640979439 | zal.transportshuttlestandalone | 4 | Transport 3, Ship 1 |
| UNAGI CAFE | 3325530853 | UNAGI.Cafe.gohan | 4 | Furniture 4 |
| Vanilla Taxidermy (Continued) | 2800012411 | zal.vanillataxidermy | 4 | Production 4 |
| Vanilla Trading Expanded | 2785616901 | VanillaExpanded.VanillaTradingExpanded | 4 | Misc 4 |
| VFE Insectoids 2 - Hellpods Expanded | 3318988740 | CaptainCrunch.VFEInsectoidsHellpodsExpanded | 4 | Ship 4 |
| Wall Light Reworked | 3801032065 | Leesduk.WallLightReworked | 4 | MURWallLightCategory 4 |
| Wall mounted solar panels | 3545934731 | Xale86.WallSolarPanels | 4 | Power 4 |
| Watergazing Spot | 2935998359 | Mlie.WatergazingSpot | 4 | Joy 4 |
| Web Color Carpets (Including Fine Royalty Versions) | 2078596882 | Krinberry.WebColoCarpets | 4 | Floors 4 |
| Whaleys Computers | 3526347119 | Whaley.WHComputers | 4 | Joy 3, Furniture 1 |
| WM420_Mother | 3248912334 | ShunTheWitch.Termimother | 4 | Security 4 |
| 中华老先人：Mingshu Faction | 3012932396 | WeiShanMaoWei.gudairen | 4 | Production 4 |
| 菜篮子工程扩展-刀耕火种- Shopping Basket Program-Slash-and-burn Farming | 3689683396 | shenpc.VegetableBasketProject.slashandburnfarming | 4 | SBP_ShoppingBasketProgram 4 |
| 边缘外包 / Edge Outsourcing | 3804825440 | edge.outsourcing.rebuilt | 4 | Misc 4 |
| [1.5]肥鸟工艺-核心 FatPenguinCraft-Core | 3266169490 | TW.FPC.FatPenguinCraft.Core | 3 | Production 3 |
| [AP] All Tomorrows | 2834031303 | AP.alltomorrows | 3 | Production 3 |
| [COG] Corvus Production Logistics | 3715921140 | PlatoArete.corvusproductionlogistics | 3 | Corvus_Logistics 3 |
| [Curvaceous Mechanoid]The Teddy bear [1.5] | 3463695410 | Fluff.FCMBear | 3 | Biotech 3 |
| [FSF] Carpets of the Rainbow | 893156099 | FrozenSnowFox.CarpetsoftheRainbow | 3 | Floors 3 |
| [FSF] Meditation Freedom (No Backstory Change) | 2578656876 | FrozenSnowFox.MeditationFreedomNoStory | 3 | Misc 3 |
| [HMC]Wall Furniture Odyssey | 3530419984 | HMC.Wall.Furniture.Odyssey | 3 | Odyssey 2, Misc 1 |
| [JF] Geometric Floors | 2863525144 | JF.GeometricFloors | 3 | Floors 3 |
| [KCB] Kimchi and Kimchi Fried Rice | 3004802051 | Kimchibok.kimchi | 3 | Production 3 |
| [KD] Pickled Vegetables (Continued) | 3044218649 | zal.pickledvegetables | 3 | Production 3 |
| [LITE]Expanded Materials - Metals | 2434786884 | Argon.LVMEu | 3 | Production 3 |
| [RH2] Faction: V.O.I.D. | 2883208829 | RH2.Faction.VOID | 3 | Floors 3 |
| [SL] Cooking Stations | 2951522016 | SkillerDankOP.CookingStations | 3 | Production 3 |
| [SZ]凤引九雏——文化dlc扩展 Chinese Ideology Expanded | 2803569577 | SZ.Ideology.Expanded | 3 | DaJian_Ui_Menu 1, Misc 1, Furniture 1 |
| [T] ExpandedCrops (Continued) | 3009264708 | zal.expandedcrops | 3 | Misc 3 |
| [WYD] Reinforced Walls Reworked | 3219861022 | Wyr3d.ReinforcedWallsResumed | 3 | Structure 3 |
| [WYD] Sashimi | 3218788370 | Wyr3d.Sashimi | 3 | Production 3 |
| 【OFB】护城河 | 2826843021 | OFB.huchenghe | 3 | Floors 3 |
| AES Interesting Items | 3808929128 | AbandonedDuck.AESInterestingItems | 3 | Misc 3 |
| amor-tentaculum | (local) amor-tentaculum |  | 3 | Temperature 2, Security 1 |
| Ancient Junk Loot | 3023180229 | Romyashi.AncientJunkLoot | 3 | Power 3 |
| Angled Hull Expansion | 3542377046 | NuanKi.AngledHullExpansion | 3 | VGE_Platform 1, Floors 1, Odyssey 1 |
| Apparello 2 | 728381322 | Shinzy.Apparello | 3 | Production 3 |
| BallGames | 2845856763 | kaitorisenkou.BallGames | 3 | Joy 3 |
| Batteries Expanded | 3033920368 | mopolita.bame.batteriesexpanded | 3 | Power 3 |
| Big and Small - Genes &amp; More | 2920751126 | RedMattis.BigSmall.Core | 3 | Security 3 |
| BK's Nutrient Bars! | 2884508615 | BK.NutrientBars | 3 | VCHE_PipeNetworks 3 |
| Bon's Gynoids | 3562923697 | BonSombrero.Gynoids | 3 | Biotech 3 |
| Canuck Bucks | 3629741980 | Cinchknight.CanuckBucks | 3 | Production 3 |
| Cargo Containers Expanded | 3714050938 | KyleMHB.CargoContainerExpanded | 3 | Misc 3 |
| Cargo waste container | 2888532939 | Aoba.CargoContainer.Waste | 3 | Misc 3 |
| Cash Register (Continued) | 3509487668 | Orion.CashRegister | 3 | Production 3 |
| Char's Fences - 1.0.4 | 742084241 |  | 3 | ItchyFences 3 |
| Chemfuel Is Life | 3725620520 | lilycdev.chemfuelislife | 3 | Production 2, Structure 1 |
| chickens Multiproducer | 966175947 | chicken305.Multiprod | 3 | Production 3 |
| Chroma Screen Floors | 3797650810 | TheOtterKing.ChromaScreenFloors | 3 | Floors 3 |
| Clash Of Rim | 3751938556 | AIRsLight.ClashOfRim | 3 | Security 2, Misc 1 |
| Clonebay | 1836767750 | SomewhereOutInSpace.Clonebay | 3 | Production 3 |
| Clown Mod (Continued) | 3709355703 | zal.clownmod | 3 | Security 3 |
| Codename: Project R.I.M. (Continued) | 3208906859 | zal.codenameprojectrim | 3 | Misc 3 |
| Comically Large Block of Cheese | 3195445675 | moistestWhale.massiveCheeseBlock | 3 | Misc 3 |
| Comments and No Signs | 2580713054 | Dark.CommentsAndNoSigns | 3 | Orders 3 |
| CommunalBed | 3406117215 | yaveton.communalbed | 3 | Temperature 2, Furniture 1 |
| Corpse Starch | 3567574370 | Portesel.CorpseStarch | 3 | Production 3 |
| Crude Machine 简陋机械体 | 3648853500 | happyzz.Crude.Machine | 3 | Security 1, Power 1, Production 1 |
| Cryptorestore Caskets | 2270494853 | cat2002.cryptorestore | 3 | Misc 3 |
| Dandelions | 2250969277 | GeoppettoHosseltoff.Dandelions | 3 | Production 3 |
| DBH for Medieval | 2926675339 | ElderSign.DBHforMedieval | 3 | Hygiene 3 |
| DCSS statues and altars | 2194950097 | Flyingstar.DCDeco | 3 | Joy 3 |
| DECO: Doors Expanded Continued Overhaul | 3743335462 | CheaterEater.DECO | 3 | Structure 3 |
| Dry Leaves (Continued) | 3059242478 | Mlie.DryLeaves | 3 | Production 3 |
| Eccentric Extras - Beach Stuff | 3066838193 | Aelanna.EccentricTech.BeachStuff | 3 | Joy 3 |
| Efficient batteries | 865497369 | efficient.batteries | 3 | Power 3 |
| Empire Refactored | 3701480464 | Matathias.Empire | 3 | Empire 2, Power 1 |
| Entosomnia - Medieval Cryptosleep | 2112267985 | NunahurAlShamikh.Entosomnia | 3 | Misc 3 |
| Epochs - Golems | 3609646528 | det.epochsgolems | 3 | Production 2, Misc 1 |
| Evelyn's Corporate additions! Weapons, Tools, and more! [In Development] | 2831690534 | Evelyn.EveCoMod | 3 | Production 3 |
| ExGT UrbanCombat (Continued) | 3638597751 | Mlie.ExGTUrbanCombat | 3 | Security 3 |
| ExNeph's Unrealistic Fun Factory (Continued) | 2841119761 | zal.EUFF | 3 | Security 3 |
| Fantastic Collectables | 1678192680 | SpessCarp.FantasticCollectables | 3 | Misc 3 |
| Farmland [adopted] | 2879990720 | Mahrimba.Farmland.adopted | 3 | Floors 3 |
| FFRocketstove | 1542650154 | forestfey.rocketstove | 3 | Temperature 3 |
| Floor-Mounted Aquarium | 3538928291 | Floor.Mounted.Aquarium | 3 | Production 3 |
| Fortifications - Medieval - Miscellaneous | 2501487519 | Aoba.Fortress.Medieval.Misc | 3 | Production 2, Misc 1 |
| Frankenstein's Menagerie | 3060165030 | GarryFlowers.Frankenstein | 3 | Production 3 |
| Functional Vanilla Expanded Props (Continued) | 2574097280 | Mlie.FunctionalVanillaExpandedProps | 3 | LWM_DS_Storage 3 |
| Gene Fabrication | 3352773112 | AmCh.Eragon.HCGeneFabrication | 3 | Biotech 3 |
| Gerrymon's Misc Props: Dungeon | 3772571876 | GMMP.Dungeon | 3 | Furniture 3 |
| Gerrymon's Misc Props: Fences | 3797400517 | GMMP.Fences | 3 | Structure 3 |
| Gerrymon's Misc Props: Graveyard | 3780458386 | GMMP.Graveyard | 3 | Misc 2, Ferny_Memorial 1 |
| Gloomy Vanilla Overhaul Fixes | 2953321248 | Gorlath.GloomyVanillaOverhaulPatch | 3 | Joy 1, Production 1, Temperature 1 |
| GloomyFurniture Drag Fix | 3743400206 | FIX.Solaris.FurnitureBase | 3 | OldStyleDeco 2, OldStyleFurniture 1 |
| Gulden Biome (Continued) | 3607066070 | pphhyy.GuldenNew | 3 | Production 3 |
| Head And Tail Decorations_头部与尾部装饰 | 2383857400 | SR.ModRimWorld.HeadAndTailDecorations | 3 | Production 3 |
| HEL3 | 3566846244 | BunX.Hel3addon | 3 | Power 3 |
| Helixien Gas Boiler | 2765741088 | CiXwOw.HelixienBoiler | 3 | VCHE_PipeNetworks 3 |
| Helluva Rimworld | 3259187548 | Ragtatter.HelluvaRim.Core | 3 | Structure 2, Production 1 |
| Holo Doors (Continued) | 3157384174 | zal.holodoors | 3 | Structure 3 |
| ImperialFurnishings | (local) ImperialFurnishings |  | 3 | Floors 1, Misc 1, Furniture 1 |
| Industrial concrete | 2888037450 | Aoba.Fortress.Industrial.Concrete | 3 | Production 3 |
| Industrial Hardleather, Concrete and Cheese | 3535926848 | talias.VFEHardleatherConcrete | 3 | Production 3 |
| Kenshi Armory (1.4+) | 2886236013 | biowreck.kenshiarmory | 3 | Production 3 |
| Kenshi Fauna | 3535797656 | EL.KenshiFauna | 3 | Structure 3 |
| Living Weave | 3797892818 | ribbonfairy.core | 3 | Security 2, Misc 1 |
| Lost Joy Objects - Books (Continued) | 2657878164 | zal.books | 3 | Joy 2, Production 1 |
| Manure | 3784198780 | Burok.Manure | 3 | Orders 3 |
| ManyCats Toolbox Continued | 3778567759 | gimmecat.manycats.toolbox.continued | 3 | Misc 3 |
| Meal Bars | 3247548652 | moxie.mealbars | 3 | Production 3 |
| MECP - Dunedain Armory | 2704651665 | Rick.FotRDunedainArmory | 3 | Production 3 |
| Medieval Medicines Medieval Overhaul Edition | 2883228057 | JoeDaly.MedMeds.MO | 3 | Misc 3 |
| Medieval Overhaul: Royalty | 2646321064 | Accurex.MedievalEmpireOverhaul | 3 | DankPyon_RusticFurniture 3 |
| Monster Hunter RimWorld - Continued | 3656798567 | BigBone87.MHRW | 3 | Security 1, Production 1, Furniture 1 |
| Monster Mash (Continued) | 3175345611 | zal.monstermash | 3 | Temperature 3 |
| More Animal Products | 2963341912 | Romyashi.MoreAnimalProducts | 3 | Furniture 3 |
| More Corpse Display | 2560778769 | Verniy709.More.Corpse.Display | 3 | CD_Gibbet_Structures 3 |
| More Hydroponics 1.0+ | 2042872320 | Red.MoreHydroponics.1 | 3 | Production 3 |
| More Survival Items（更多求生物品） | 2454970017 | LoveCat.MoreSurvivalItems | 3 | Production 1, Furniture 1, Security 1 |
| N00by95's Misc Ores | 2800498040 | NMOres-By-N00by95 | 3 | Temperature 2, Power 1 |
| Namekians (Continued) | 3132062302 | zal.DBZNamekians | 3 | Production 3 |
| Nelim's Imperial Furnishings (prohibited) | 3806764528 | nelim.imperialfurnishings | 3 | Floors 1, Misc 1, Furniture 1 |
| Nelim's Slippers &amp; Mats | 3811334432 | nelim.slippersmats | 3 | Furniture 3 |
| Neolithic Prosthetics | 3338191290 | Uga.Booga | 3 | Production 3 |
| Neon Rim: The Rimworld Signs Pack | 1359728827 |  | 3 | Furniture 3 |
| One and Done Gun | 2638107852 | howgoesit7315.OneandDoneGun | 3 | Security 3 |
| Ores and metallurgy | 3250835539 | TP.OresAndMetallurgy | 3 | Production 3 |
| Oriental Instruments Expanded | 3648789910 | Febvre.TheOrientalInstruments.Rework | 3 | DesignationCategory_Oriental 2, Ideology 1 |
| Outland - More Floors | 2873199953 | Neronix17.Outland.MoreFloors | 3 | Floors 3 |
| Picnic Spot | 1528586050 |  | 3 | Furniture 3 |
| Pink Material Sheep | 1543522877 | akairo.PinkMaterialSheep | 3 | Floors 3 |
| Plant genetics(Continued) | 3537990347 | Adamas.PlantGenetics.Continued | 3 | Production 3 |
| PocketMapTent | 3505123702 | flammpfeil.PocketMapTent | 3 | Odyssey 2, Misc 1 |
| Potions! (Continued) | 3806731197 | zal.potions | 3 | Production 3 |
| Project Armory 1.4.0.1 [1.4] | 1245964483 | Plymouth.ProjectArmoury.Mod | 3 | Production 3 |
| Prostheses+ | 2211789855 | DimonSever000.ProsthesesPlus.Specific | 3 | Production 3 |
| PsiTech | 2078892294 | K.PsiTech | 3 | Misc 2, Production 1 |
| Reading Bill (Continued) | 3559185722 | USE.ReadingBill | 3 | Misc 3 |
| Refined Minerals | 3816455269 | raki.refinedminerals | 3 | Production 3 |
| Research Data | 3001121619 | kongkim.ResearchData | 3 | OldStyleFurniture 1, Production 1, Misc 1 |
| Research Spot (Continued) | 2961577800 | zal.researchspot | 3 | Production 3 |
| RGBmods Deep Concrete | 3549649507 | RGBmods.misc.DeepConcrete | 3 | Floors 3 |
| Rim of Madness - Vampires (Continued) | 3599360002 | zal.romvampires | 3 | Misc 3 |
| Rim-Gnoblins | 3018569666 | VexedTrees980.RimGnoblinsBiotech | 3 | Production 3 |
| Rimazon | 3523821501 | pc1001.PunkyRoo.Rimazon | 3 | Production 3 |
| Rimframe: Vatgrown Home! | 3490855953 | JTC.Grineerfurniture | 3 | Structure 2, Misc 1 |
| RimFridge: Now with Shelves! | 2898411376 | rimfridge.kv.rw | 3 | Temperature 3 |
| RimGamble | 3547255934 | Takumunt.RimGamble | 3 | Joy 2, Misc 1 |
| RimThunder - Flying Chariot | 3163422402 | RimThunderTeams.RimThunder.FlyingChariot | 3 | VF_Vehicles 3 |
| RimWorld - Witcher Monster Hunt | 2008529522 | sargoskar.witcherhunt | 3 | Production 3 |
| RimWorld Survival Frontier | 3548195656 | lele.rimworldsurvivalfrontier | 3 | Production 2, Misc 1 |
| RimWorld Together | 3005289691 | nova.rimworldtogether | 3 | Misc 3 |
| RimZon: World Marketplace | 3817183111 | SlomannayaPsihika.WorldMarketplace | 3 | Misc 3 |
| Rooms | 3783136605 | arsiy.rooms | 3 | Misc 2, Production 1 |
| Rot &amp; Compost | 3808608132 | rotandcompost.mod | 3 | Production 3 |
| RX97 Medieval Airships: Hermes | 3026601066 | RX97.Medieval.Airships.Hermes | 3 | VF_Vehicles 3 |
| Ryuu's Electric Art Bench | 3161850346 | Ryuu.RimWorld.ElectricArtBench | 3 | Production 3 |
| Scavenging | 3108829323 | Romyashi.Scavenging | 3 | Production 3 |
| Scrap Metal Walls | 3009889840 | zal.scrapmetalwalls | 3 | Structure 3 |
| Scrolls | 3075712319 | Romyashi.Scrolls | 3 | Production 3 |
| Shuttlecraft | 1189302747 |  | 3 | Misc 3 |
| Simple Cooking and Brewing | 3533623625 | talias.veSimpleCooking | 3 | Production 2, Ferny_Kitchen 1 |
| Simple Doors | 3767304373 | ODs.SimpleDoors | 3 | Structure 3 |
| Simple Propaganda | 3510231980 | Kilo.SProp | 3 | Ideology 3 |
| Simple Salted Meal | 2817764056 | SaltedFood.Mod | 3 | Production 2, Temperature 1 |
| Simple Utilities: Fridge | 3219883811 | Owlchemist.FridgeUtilities | 3 | Temperature 2, LWM_DS_Storage 1 |
| Simpleitem | 3236623394 | Asname.simpleitem | 3 | Temperature 2, Production 1 |
| SlippersMatsRenew | (local) SlippersMatsRenew |  | 3 | Furniture 3 |
| Small Hot Spring (Continued) | 3171013935 | zal.smallhotspring | 3 | Joy 3 |
| Smart Agriculture, Climate &amp; Colony Logistics | 3797110254 | sacl.smartagriculture | 3 | Temperature 2, Furniture 1 |
| Smarter Visitors | 3012491521 | Mlie.SmarterVisitors | 3 | Misc 3 |
| Some Things Float | 2940072380 | Mlie.SomeThingsFloat | 3 | Structure 3 |
| Something misc. items | 3789182769 | chamomilere.somethingmiscitems | 3 | Misc 2, Power 1 |
| Split Air Conditioner (分体空调) | 3743438197 | user10446.splitairconditioner | 3 | Temperature 3 |
| Steve's Doors | 3141057381 | Scurvyez.StevesDoors | 3 | Structure 3 |
| TaosBasics | 2600237269 | TaosChagic.Basics | 3 | BasicMod 3 |
| The Dead Man's Switch - AssemblyMaster | 3611546460 | Maple.DeadManSwitch.SuperAssemblyMaster | 3 | DMS_Category 2, Misc 1 |
| The Gilded Spiral - Spiralborn Xenotype | 3684159046 | addie.spiralbornxenotype | 3 | Misc 2, Production 1 |
| Titanfall | 3784062728 | Anmon.Titanfall | 3 | Misc 3 |
| To My Side! | 1644517104 | FLASHPOINT55.ToMySide | 3 | Production 3 |
| To My Side! - Medieval | 1663881478 | FLASHPOINT55.ToMySideMedieval | 3 | Production 3 |
| TouhouRimworld.test | 3789231443 | yesterdayx2.touhourimworld.test | 3 | TH_Gensokyo 3 |
| Transport Shuttle 1.4 and 1.5 | 2879336912 | Azazellz.TransportShuttle14 | 3 | SRTS_Expanded 3 |
| TribalInstruments (Royalty) | 2596778006 | zal.tribalinstruments | 3 | Joy 3 |
| Ultra Moisture Pump | 1529498499 | ChrisBradel.UltraMoisturePump | 3 | Misc 3 |
| Vanilla Cooking Expanded - Stews | 2134312965 | VanillaExpanded.VCookEStews | 3 | Production 3 |
| Vehicle Framework | 3014915404 | SmashPhil.VehicleFramework | 3 | VF_Vehicles 3 |
| VOICEROIDグッズMOD | 909316877 |  | 3 | Production 2, Misc 1 |
| Vomit Rain | 3797683474 | kingmoo92.VomitRain | 3 | Ideology 1, Production 1, Floors 1 |
| VV - New Harvest: Compatibility Patches | 3570411438 | octodecoy.vvnewharvest.compatpatches | 3 | Floors 2, Structure 1 |
| WA-Amusement | 1383834577 |  | 3 | WA-Builder 3 |
| Weapon Tech | 2005456121 | Janson.WeaponTech | 3 | Security 3 |
| Windows (Continued) | 3779371861 | Owlchemist.Windows | 3 | Structure 3 |
| You're not Alone on the Tile | 3691806696 | qpehrit.undergeconomy | 3 | Production 3 |
| 哥特式吸血鬼家具--死眠棺材床 Gothicstyle Vampire Furniture--CoffinBedCanBeDeathRest | 3261636943 | XXK.CoffinBedCanBeDeathRest | 3 | Museum_Decoration 2, Furniture 1 |
| 基地车拓展Mobile Construction Vehicle | 3741990694 | SpacyCuttingWings.MobileConstructionVehicle | 3 | VF_Vehicles 1, Floors 1, ? 1 |
| 巴尔：楼上楼下 | 3820071953 | Baal.SecondFloor | 3 | Structure 3 |
| 杳无音讯 / 失去联系 (Lost Contact) | 3820744626 | monika.rimworld.noword | 3 | Misc 3 |
| 精卫填海 (JingWeiFillsSea) | 3793254679 | pooiwoop.jingweifillssea | 3 | Structure 3 |

## Animals (237 mods with 3 or more hits, 392 with at least one)

| Mod | Workshop id | packageId | Hits |
|---|---|---|---|
| Genetic Rim | 1113137502 | sarg.geneticrim | 270 |
| Legacy Ark (Continued) | 2070686241 | Mlie.LegacyArk | 243 |
| Megafauna | 1055485938 | Spino.Megafauna | 228 |
| Animal Collab Project Vanilla-Style | 2208467668 | ACPteam.ACPVanillaStyle | 216 |
| Dinosauria | 1136958577 | spincrus.dinosauria | 192 |
| Biomes! Islands | 2038001322 | BiomesTeam.BiomesIslands | 175 |
| Biomes! Caverns | 2969748433 | BiomesTeam.BiomesCaverns | 172 |
| Vanilla Genetics Expanded | 2801160906 | VanillaExpanded.VGeneticsE | 167 |
| Lantern Hunters | 2866414675 | kdm.lanternhunters | 133 |
| Vanilla Animals Expanded | 2871933948 | VanillaExpanded.VanillaAnimalsExpanded | 122 |
| MorrowRim | 2443089362 | SirMashedPotato.MorrowRim | 119 |
| Beasts of the Rim (Continued) | 2194018641 | Mlie.BeastsoftheRim | 114 |
| RimWorld - Witcher Monster Hunt | 2008529522 | sargoskar.witcherhunt | 101 |
| Vanilla Animals Expanded — Cats and Dogs | 1823540489 | VanillaExpanded.VAECD | 84 |
| Steves Animals | 2479431577 | Scurvyez.Bastyon | 80 |
| Zoo-动物（Animal） | 783946617 |  | 70 |
| [SZ] [综合内容+持续更新版] 含商咀徵——神州文化扩展 Chinese Traditional Cultural Things Expanded | 2877536640 | Dajian.ChiTeaditional.Expanded | 68 |
| Pawnmorpher | 1786466855 | tachyonite.pawnmorpherpublic | 62 |
| TurtleShroom Productions Proudly Presents: CKAPP Tropical Rainforest Mod (Continued) | 3544154279 | Mlie.TropickappRainforestMod | 60 |
| Dragons Descent | 2026992161 | onyxae.dragonsdescent | 58 |
| Save Our Ship 2 | 1909914131 | kentington.saveourship2 | 58 |
| A RimWorld of Magic | 1201382956 | Torann.ARimworldOfMagic | 57 |
| WhaleysDogs (Continued) | 2274606936 | Mlie.WhaleysDogs | 54 |
| DuelMonsterRimWorld | 3050289249 | DuelMonster.RimWorld | 48 |
| Mashed's Ashlands | 3109835541 | SirMashedPotato.Ashlands | 48 |
| Milkable Vanilla Animals (Mammals) | 2573060595 | Milkable.Mammals | 46 |
| Storytime Official Mod | 2411541093 | Jonah.Storytime | 46 |
| Synthetic Animals (Continued) | 3171141566 | zal.syntheticanimals | 44 |
| Monstrous Compendium (Continued) | 2381100965 | Mlie.MonstrousCompendium | 40 |
| Medieval Overhaul | 3219596926 | DankPyon.Medieval.Overhaul | 38 |
| AuroranKingslayer's RimWorld of the Dragon | 2954791310 | aurorankingslayer.asoiafdd | 36 |
| Biomes! Bunnies | 2874907777 | BiomesTeam.Bunnies | 36 |
| Biomes! Oasis | 2538518381 | BiomesTeam.Oasis | 36 |
| Max's Abakinars | 2850528153 | maximilian.maxsabakinars | 36 |
| More Thrumbos (Continued) | 2786832432 | Mlie.MoreThrumbos | 36 |
| Westerado (Continued) | 2236973780 | Mlie.Westerado | 36 |
| Warhammer-ish:Dryad (Continued++) | 3563451515 | Mortimer.WarhammerishDryad | 35 |
| L-Slimes (Continued) | 3285062246 | Vector.Leonapp.LSlimes | 34 |
| Rimhammer - The End Times - Magic | 2020384442 | SickBoyWi.TheEndTimes.Magic | 33 |
| The Poop Mod | 1728184416 | WindowsXP.ThePoopMod | 33 |
| [RWY]Dragon's Descent: Void Dwellers | 3349058179 | ravvy.DD.Void.Addon | 32 |
| [Syulipia]SlimeMOD | 1651394964 | ProjectSyulipia.SlimeMOD | 32 |
| [SZ] [旧版本适用+全版本纯净版] 含商咀徵——神州文化扩展 Chinese Traditional Cultural Things Expanded | 2371079000 | Dajian.ChiTeaditional.Expanded.OldMode | 32 |
| CheetahCaptain's Horse Breeds | 3033602543 | CheetahCaptain.HorseBreeds | 32 |
| SCP - 111/Dragon Snails Continued | 2897617847 | DrTinyFace.DragonSnails | 30 |
| PWG Bioweapons | 2099290631 | PWG.Bioweapons | 28 |
| Dragon Genetics | 2846348757 | Hol.DragonGenetics | 27 |
| Ebbbs | 2817264755 | Coolie.Ebbbs | 27 |
| pphhyy's Demigryphs Continued | 3540496928 | pphhyy.DemigryphsMod | 27 |
| Scaled World | 2799361186 | Scaled.World | 27 |
| Slimes | 2639634490 | zylle.Slimes | 27 |
| Vanilla Animals Expanded — Royal Animals | 2858079457 | VanillaExpanded.VAERoy | 27 |
| FishIndustry (Continued) | 3456386887 | Mlie.FishIndustry | 25 |
| Let's Have a Cat! Continued | 3682940618 | akairo.LetsHaveaCat | 24 |
| Meme-Superpack | 2957903828 | MrSamuelStreamer.MemeSuperpack | 24 |
| TiberiumRim | 1346865620 | telefonmast.tiberiumrim | 24 |
| Vanilla Animals Expanded — Arid Shrubland | 1836900626 | VanillaExpanded.VAEAS | 24 |
| Vanilla Factions Expanded - Insectoids 2 | 3309003431 | OskarPotocki.VFE.Insectoid2 | 24 |
| CIWS_Animal (Continued) | 2610389492 | Mlie.CIWSAnimal | 23 |
| Panjandrum | 1946414842 | tikubonn.panjangdrum | 23 |
| HC Animal Continued | 3238206164 | HC.Animal.continued | 22 |
| Vanilla Animals Expanded — Waste Animals | 2962126499 | VanillaExpanded.VAEWaste | 22 |
| MorrowRim - Ashlands Swamp | 2230936898 | SirMashedPotato.MorrowRim.AshSwamp | 20 |
| Parrots | 2537399407 | zylle.Parrots | 20 |
| Vanilla Animals Expanded — Tropical Rainforest | 1907283872 | VanillaExpanded.VAETR | 20 |
| Fungi lite | 2129406860 | Druid.Fungilite | 19 |
| World of Naruto | 3025338958 | LifeisGame.WorldOfNaruto | 19 |
| Ducks | 2377069366 | zylle.Ducks | 18 |
| Flommel | 1541255350 | Tigerblut.Flommel | 18 |
| [Syulipia]OrientalDragonMOD (Continued) | 3564312643 | ProjectSyulipia.OrientalDragonMOD.continued | 17 |
| Dragon Mod | 1163162658 |  | 17 |
| 华夏扩展 Chinese Comprehensive Expansion | 3221850511 | ninedaylongbow.ChineseComprehensiveExpansion | 17 |
| Vanilla Animals Expanded — Australia | 1963681588 | VanillaExpanded.VAEAU | 16 |
| Vanilla Animals Expanded — Tundra | 1895364585 | VanillaExpanded.VAET | 16 |
| Elephants | 2389095025 | zylle.Elephants | 15 |
| FCP - The Wasteland Compendium (Continued) | 2886511401 | zal.WastelandCompendium | 15 |
| FCP - The Wasteland Compendium Retexture !!!  | 3702242543 | Whyamihere.TheWastelandCompendiumRetexture | 15 |
| PWG Grim Magic | 2138862354 | PWG.GrimMagic | 15 |
| Vanilla Factions Expanded - Vikings | 2231295285 | OskarPotocki.VFE.Vikings | 15 |
| Alpha Biomes | 1841354677 | sarg.alphabiomes | 14 |
| Floran Root | 2967105902 | TitaniusRex.FloranRoot | 14 |
| Dark Ages : Beasts and Monsters | 3472275628 | Van.Beasts | 13 |
| Kenshi Fauna | 3535797656 | EL.KenshiFauna | 13 |
| Mojave Wasteland Creatures | 2449930064 | Arisher.MWC | 13 |
| Oni of the Rim | 2891432261 | tarojun.morishep.onioftherim | 13 |
| [1.0] RimSlave V5.1: Daenerys' Army - A Game of Thrones Mod  | 1746084920 |  | 12 |
| Japanese Dogs | 2192937058 | Poetik.JapaneseDogs | 12 |
| Mincho, The Mint Choco Slime ~ HAR ver. | 2477501851 | SutSutMan.MinchoTheMintChocoSlimeHARver | 12 |
| Monster Mash (Continued) | 3175345611 | zal.monstermash | 12 |
| Vanilla Animals Expanded — Boreal Forest | 1895364938 | VanillaExpanded.VAEBF | 12 |
| Vanilla Animals Expanded — Extreme Desert | 1849184079 | VanillaExpanded.VAEED | 12 |
| Vanilla Animals Expanded — Ice Sheet | 1895364782 | VanillaExpanded.VAEIS | 12 |
| Witching Hour (Continued) | 2596779692 | zal.WitchingHour | 12 |
| Bite 'Em Where It Hurts! | 1109523024 |  | 11 |
| Frost and Fire (Continued) | 3243969146 | zal.frostandfire | 11 |
| Miho, the celestial fox | 2816826107 | miho.fortifiedoutremer | 11 |
| Vanilla Animals Expanded — Endangered | 2366589898 | VanillaExpanded.VAEEndAndExt | 11 |
| Erin's Valheim Creatures | 2914177066 | Erin.Valheim.Creatures | 10 |
| Recon And Discovery (Continued) | 2035131107 | Mlie.ReconAndDiscovery | 10 |
| The Profaned | 3202008037 | BotchJob.Profaned | 10 |
| Unique Canids Remake (Continued) | 2941177706 | zal.canidsremake | 10 |
| Vanilla Animals Expanded — Temperate Forest | 2260502331 | VanillaExpanded.VAETF | 10 |
| Wildlife | 1778625372 | klausgunniharold.wildlife | 10 |
| [AP] All Tomorrows | 2834031303 | AP.alltomorrows | 9 |
| Improved Insectoids (Continued) | 3285519742 | zal.improvedinsectoids | 9 |
| Martens - Nature's Most Adorable Assassins | 1966193572 | RaZim.ZGFMartens | 9 |
| Rim-Effect: Core | 2479560240 | RimEffect.Core | 9 |
| Shiba Wanko | 1566921497 | akairo.ShibaWanko | 9 |
| Vanilla Animals Expanded — Livestock | 1700683323 |  | 9 |
| [WYD] Mamuffalo Reworked | 3209607611 | Wyr3d.MamuffaloReworked | 8 |
| CIWSpk Animal | 2414365715 | UNKNOWN.CIWS.Animal | 8 |
| Helpful Pals | 3451569996 | hamtastic.palworld | 8 |
| More than Ashes V2 | 2846247713 | Layken.morethanashesV2 | 8 |
| MorrowRim - Bloodmoon | 2243604074 | SirMashedPotato.MorrowRim.Bloodmoon | 8 |
| Outland - Toxic Forest | 2985460903 | Neronix17.Outland.ToxicForest | 8 |
| RadWorld | 2644582906 | Declinedkilr.RadWorld | 8 |
| SparrowsMOD | 1542481590 | akairo.SparrowsMOD | 8 |
| Turtles | 2832804475 | zylle.Turtles | 8 |
| Useful Parasites | 3175473107 | Romyashi.UsefulParasites | 8 |
| Zoo-国家-罪恶帝国（Country-Evil Empire） | 783946712 |  | 8 |
| [L] House Maid Nukos 1.7 | 3327359869 | HouseMaidNukos1.5bysaltbabe | 7 |
| AA Rodent Pack | 2120851909 | ArmoredAmpharos.RodentPack | 7 |
| BIRD UP! Continued | 3529627105 | Dizzy.BIRDUP.AllInOne | 7 |
| Erin's Fox Squirrel | 2092951979 | Erin.Foxsquirrel | 7 |
| [1.0] Trading Economy Mod 3.1 | 1130945311 |  | 6 |
| Add Elona Shoujo | 1500213859 | karukus.AddElonaShoujo | 6 |
| BIRD UP! All-in-one | 2088146194 | Alex.BIRDUP.AllInOne | 6 |
| Birds of the World! | 3245417989 | tyrannidae.birdsoftheworld | 6 |
| Christmas Stuff - Advent calendar (Continued) | 2441048499 | Mlie.ChristmasStuffAdventCalendar | 6 |
| Cutie's Cat Pack | 1399560567 |  | 6 |
| Dapper Muffalo | 1541725465 | temeez.dappermuffalo | 6 |
| ExNeph's Unrealistic Fun Factory (Continued) | 2841119761 | zal.EUFF | 6 |
| Frilleus | 1612298388 | Bichang.Frilleus | 6 |
| Gods of Elona | 1505332648 | karukus.GodsofElona | 6 |
| Helluva Rimworld | 3259187548 | Ragtatter.HelluvaRim.Core | 6 |
| Huri | 1612305760 | Bichang.Huri | 6 |
| MMTankMOD | 2090348563 | dragon.MMTank.MOD | 6 |
| Ooka Miko[1.0] | 1536817379 | face.Miko | 6 |
| Poultry Variety Pack | 2749575684 |  | 6 |
| Pygmy muffalo | 1885527800 | dismarzero.VGP.Pygmymuffalo | 6 |
| ReGrowth 2 | 2260097569 | ReGrowth.BOTR.Core | 6 |
| RimOverhaul | 1760022158 | FunkyShit.RimOverhaul.Main | 6 |
| Rimsenal Faction Pack - Feral | 736207111 | rimsenal.feral | 6 |
| Rimstro | 1714572710 | Lat.Rimstro | 6 |
| Royal Thrumbos (Continued) | 2846919540 | Mlie.RoyalThrumbos | 6 |
| Sacred WhiteFox | 1612303131 | Bichang.WhiteFox | 6 |
| Space Worms (Continued) | 2105322804 | Mlie.SpaceWorms | 6 |
| Spidercamp's Horses (Continued) | 2580255266 | Mlie.SpidercampsHorses | 6 |
| Squirrel Variety Pack | 2737993245 |  | 6 |
| The Basilisk | 2609355756 | zal.basilisk | 6 |
| Thrumbo Extension | 859466666 | leafzxg.ThrumboExtension | 6 |
| Tower of Rimworld | 3335952183 | Kalido.TowerOfRimworld | 6 |
| Angora Rabbits | 2597840073 | dtf.angorarabbits | 5 |
| BorderCollies | 2261957667 | rtp.bordercollies | 5 |
| Dire Wolf | 2092915394 | forestfey.DireWolf | 5 |
| EM Insects And Plants (Continued) | 2025643074 | Mlie.EMInsectsAndPlants | 5 |
| Erin's Friendly Ferrets | 2433755150 | Erin.Ferret | 5 |
| Farming Expansion | 2258612562 | Mlie.FarmingExpansion | 5 |
| FFSmilodonPopulator | 1205493424 | forestfey.SmilodonPopulator | 5 |
| GREG | 3228302152 | tyrannidae.gregnfriends | 5 |
| Gulden Biome (Continued) | 3607066070 | pphhyy.GuldenNew | 5 |
| Little Critters | 3331281387 | tyrannidae.littlecritters | 5 |
| Miraffe | 2000687980 | SickBoyWi.Miraffe.OnePointFour | 5 |
| Patty's Bananimals | 3243777662 | patty.pattysbananimals.main | 5 |
| RhodesianRidgebacks | 2076237940 | rtp.rhodesianridgebacks | 5 |
| RimWorld - The Dark Descent (Continued) | 3312022150 | zal.darkdescent | 5 |
| Sanguinary Animals Reborn | 3521331935 | pphhyy.SanguinaryAnimals | 5 |
| The Wonderland of Mr Cringe | 2781994359 | aratocat.Wonderland | 5 |
| Waste Insect | 3186084287 | HaiLuan.WasteInsect | 5 |
| Weaponized Husbandry | 3253730985 | WeaponizedHusbandry.XeranDereth | 5 |
| Wild Kobolds (Continued) | 2472421258 | Mlie.WildKobolds | 5 |
| Xen's Spirit Wolf | 2092917194 | forestfey.SpiritWolf | 5 |
| Yinglets! | 2203632931 | Chrysopoeia.Yinglets | 5 |
| 虫娘 Insect Girls | 2451340446 | PuPa.InsectGirls | 5 |
| [WYD] Neutro Animals | 3209070506 | Wyr3d.NeutroAnimals | 4 |
| ↁ Elves (Continued) | 3272603920 | DevDesigner.Elves.Continued | 4 |
| A Regular Ol' Plumbus | 2210738958 | Xercaine.Plumbus | 4 |
| Call of Cthulhu - Cults (Continued) | 3588548484 | zal.cocc | 4 |
| Crystalloid | 1571323744 | atomicravioli.Crystalloid | 4 |
| CutePenguin (Continued) | 2268877264 | Mlie.CutePenguin | 4 |
| Darkspectre's Menagerie | 2961708261 | Metalocif.DarkSpectreMenagerie | 4 |
| Erin's Lizard Doggo | 2527471245 | Erin.LizzardDoggo | 4 |
| Erin's Palamutes | 2485624026 | Erin.Palamutes | 4 |
| Fabled Cervidae | 3400548142 | Scurvyez.FabledCervidae | 4 |
| Locust Swarms and Cicada Songs | 1999857175 | velcroboy333.LocustSwarmsAndCicadaSongs | 4 |
| Mashed's Scampuss | 2522749096 | SirMashedPotato.Scampuss | 4 |
| Moonjelly Xenotype | 3030254580 | SG.moonjelly | 4 |
| Primordial Geysers | 2896731795 | IronScruff.PrimordialGeysers | 4 |
| RadWorld | 2474160202 | Declinedkilr.RadWorld_copy | 4 |
| Rocky | 3362035760 | ShepirotGamer.Rocky | 4 |
| Shelmet + Helix Ideology | 2876489145 | Ammonite616.Shelmet | 4 |
| Sunset Weapon Technology 2 | 2890976130 | SunsetModerTeam.SunsetWeaponTechnology2 | 4 |
| Tribble Trouble | 2400590961 | zylle.TribbleTrouble | 4 |
| "Chocolate" BunBuns | 1123020884 | cucumpear.chocbunbuns | 3 |
| [1.3] SmurfeRim Ver4.0  | 912714690 | walkingproblem.smurf | 3 |
| [KCB] RimStory | 3473850830 | KCB.RimStory | 3 |
| [SZ]分居异爨——杂项内容和黑科技 Chinese Traditional Cultural Things Expanded Other Styles Pack | 2477792890 | ChiTeaditional.ExtraPack | 3 |
| [TY]派系扩展·光辉 Faction Glory | 2735917151 | Spread.TY.Glory | 3 |
| A Cornucopia of Unicorns | 1788976612 | cucumpear.unicorns | 3 |
| American Possum (Continued) | 2810369994 | zal.AmericanPossum | 3 |
| Bigfoots | 2894599725 | gurrukk.Bigfoots | 3 |
| BT's OnlyCows | 2888153277 | OnlCwsBT.Mod | 3 |
| Chromatic Sensitivity | 2856889316 | Taggerung.ChromaticSensitivity | 3 |
| Construction Expanded | 2794480005 | CS.CE | 3 |
| Duck's Funbox | 1659899962 |  | 3 |
| Dumbs' Dachshunds (Continued) | 3646509270 | zal.dumbsdachshunds | 3 |
| Dust Bunnies | 2659958183 | BlockHen.Animal.DustBunnies | 3 |
| Erin's Great Pyrenean Mountain Dogs | 2761001056 | Erin.MountainDog | 3 |
| ExoPlasteel Swarm | 3249761664 | EnderNyktos.ExoPlasteelSwarm | 3 |
| Hellsing ARMS Ultimate | 2834801420 | Baskerville.HellsingARMSUltimate | 3 |
| Hilda's Creatures - Deerfox (Continued) | 2818484342 | zal.deerfox | 3 |
| Insectoid Breeding | 3284525479 | SirToastyMuffin.InsectoidBreeding | 3 |
| InsectUpgrades | 1742165242 | TheGoofyOne.InsectUpgrades | 3 |
| Marilyn the Mincho Worshipper Witch ~ HAR ver. | 2604973449 | SutSutMan.MarilyntheMinchoWorshipperWitchHARver | 3 |
| Mashed's Spiribirds | 2839002794 | SirMashedPotato.Spiribirds | 3 |
| Mashed's Spiribugs | 2846527821 | SirMashedPotato.Spiribugs | 3 |
| MGS Item Pack (Continued) | 2779413411 | zal.mgsitems | 3 |
| More Consumables and Mutagens Reworked | 2045449646 | Meltup.MoreConsumablesAndMutagens.Reworked | 3 |
| Opossum Friends | 2718423420 | oracle.possumfriends | 3 |
| Pet Cucumber - Chonk Version | 2906214036 | Tigerblut.SeaCucumberChonk | 3 |
| Pink Material Sheep | 1543522877 | akairo.PinkMaterialSheep | 3 |
| Richard the Iron Horse (Continued) | 2778683768 | zal.richard | 3 |
| Rim-Effect Renegade: Core | 3473370247 | RimEffectRenegade.Core | 3 |
| RimElsen - Add-Ons | 3193471745 | hardrive360.rimelsen.addons | 3 |
| SCP | 2207934307 | ods.SCP.mod | 3 |
| tentacle-love | (local) tentacle-love |  | 3 |
| The Bat | 2657884546 | zal.bat | 3 |
| The Black Cat | 2657884748 | zal.cat | 3 |
| Tribbles! (Continued) | 2672501251 | zal.Tribbles | 3 |
| TurtleShroom Productions Proudly Presents: Make Honey EVEN MORE Compatible | 2959585309 | TSP.zal.patchhoney2 | 3 |
| TurtleShroom Productions Proudly Presents: Van Hellsing Expansion | 2872129323 | TSP.Baskerville.HellsingExpansion | 3 |
| UwU | 2781397266 | PunkyRoo.UwU | 3 |
| Westerado | 1389086625 |  | 3 |
| Xen's Big Animals | 848123718 |  | 3 |
| Yay Chocobos! (Continued) | 2855913498 | zal.Chocobos | 3 |
| Yeow | 2483471017 | DW.Yeow | 3 |
| モズアマゾン　―　百舌の早贄 | 3423968357 | Nozama.MOZUNOHAYANIE | 3 |

## Plants (363 mods with 3 or more hits, 568 with at least one)

| Mod | Workshop id | packageId | Hits |
|---|---|---|---|
| RimCuisine 2 Core (Continued) | 2562519366 | Mlie.RC2.Core | 595 |
| VGP Vegetable Garden | 2007061826 | dismarzero.VGP.VGPVegetableGarden | 440 |
| Biomes! Caverns | 2969748433 | BiomesTeam.BiomesCaverns | 326 |
| Mashed's Ashlands | 3109835541 | SirMashedPotato.Ashlands | 312 |
| Fantastic Flora(continued) | 2504647479 | Velcroboy333.FantasticFloraCont | 271 |
| TurtleShroom Productions Proudly Presents: CKAPP Tropical Rainforest Mod (Continued) | 3544154279 | Mlie.TropickappRainforestMod | 258 |
| Alpha Biomes | 1841354677 | sarg.alphabiomes | 206 |
| MorrowRim | 2443089362 | SirMashedPotato.MorrowRim | 179 |
| VGP Three Sisters Plants | 2007063848 | dismarzero.VGP.VGPThreeSistersPlants | 138 |
| VGP Xtra Trees and Flowers | 2007064094 | dismarzero.VGP.XtraTreesandFlowers | 132 |
| VGP Garden Resources | 2007063451 | dismarzero.VGP.VGPGardenResources | 129 |
| Lantern Hunters | 2866414675 | kdm.lanternhunters | 123 |
| Apothecary (Continued) | 2195469123 | Mlie.Apothecary | 120 |
| Witch's Garden (Continued) | 2644141682 | zal.witchsgarden | 112 |
| Witch's Garden (With Healroot) | 2835149383 | zal.witchsgardenhealroot | 112 |
| Wild Cultivation - Continued | 2587733212 | jelly.WildCultivation | 105 |
| Vanilla Plants Expanded - More Plants | 2748889667 | VanillaExpanded.VPlantsEMore | 102 |
| VV - New Harvest | 3448458106 | VVenchov.VVNewHarvest | 102 |
| Spidercamp's Decorative Plants (Continued) | 2453107898 | Mlie.SpidercampsDecorativePlants | 96 |
| CaveworldFlora (Continued) | 2259058735 | Mlie.CaveworldFlora | 91 |
| 【ZP】Rice cultivating civilization | 3046830338 | Udon.Ricecultivatingcivilization.for14 | 90 |
| [SZ] [综合内容+持续更新版] 含商咀徵——神州文化扩展 Chinese Traditional Cultural Things Expanded | 2877536640 | Dajian.ChiTeaditional.Expanded | 89 |
| Medieval Overhaul | 3219596926 | DankPyon.Medieval.Overhaul | 86 |
| Biomes! Islands | 2038001322 | BiomesTeam.BiomesIslands | 85 |
| 菜篮子工程（Shopping Basket Program）正式版1.06版本 | 3680328274 | shenpc.VegetableBasketProject | 85 |
| RimNature! [continued] | 2190520917 | RimNature.velcroboy333 | 84 |
| VGP More Veggies | 2007063278 | dismarzero.VGP.VGPMoreVeggies | 84 |
| Christmas Stuff - Advent calendar (Continued) | 2441048499 | Mlie.ChristmasStuffAdventCalendar | 77 |
| MorrowRim - Telvanni Technology | 2443090232 | SirMashedPotato.MorrowRim.TelvanniTechnology | 74 |
| RimFortress: Dwarven Plants | 2042926702 | dismarzero.VGP.RimFortressDwarvenPlants | 73 |
| Ecotech | 3740443679 | RA.Ecotech | 67 |
| ReGrowth 2 | 2260097569 | ReGrowth.BOTR.Core | 65 |
| RimCuisine 2: Smokes and Shrooms Expansion (Continued) | 2069579592 | Mlie.RC2.SaSE | 63 |
| Pawnmorpher | 1786466855 | tachyonite.pawnmorpherpublic | 58 |
| Biomes! Oasis | 2538518381 | BiomesTeam.Oasis | 55 |
| Westerado Wilderness (Continued) | 2237006050 | Mlie.WesteradoWilderness | 55 |
| Gulden Biome (Continued) | 3607066070 | pphhyy.GuldenNew | 54 |
| Wayward Biomes: Tidewrack Reef | 3698012987 | zylle.WaywardBiomes.Landreef | 54 |
| More Mushrooms | 3813323629 | izzypizzy.rimmushrooms | 49 |
| Caveworld Flora Unleashed | 3409043551 | Fluffysminion.ItW.CaveworldFloraUnleashed | 48 |
| More Trees (Continued) | 3157367665 | zal.moretrees | 48 |
| Outland - Toxic Forest | 2985460903 | Neronix17.Outland.ToxicForest | 48 |
| Fungi lite | 2129406860 | Druid.Fungilite | 45 |
| Planting for Everything | 3564935100 | MUAV.plantingforeverything | 45 |
| VGP Garden Medicine | 2007063140 | dismarzero.VGP.VGPGardenMedicine | 44 |
| Survivalist's Additions (Continued) | 3052462368 | Mlie.SurvivalistsAdditions | 43 |
| Vanilla Landmarks Expanded | 3656316229 | VanillaExpanded.VExplorationE | 42 |
| Zen Garden (Continued) | 2777931683 | Mlie.ZenGarden | 42 |
| [LTS]Biosphere | 3217394931 | LimeTreeSnake.Biosphere | 41 |
| [SZ] [旧版本适用+全版本纯净版] 含商咀徵——神州文化扩展 Chinese Traditional Cultural Things Expanded | 2371079000 | Dajian.ChiTeaditional.Expanded.OldMode | 41 |
| Tobe's Realistic Farming [TRF] | 1136426568 |  | 41 |
| Metaflora | 2782577156 | SA.Metaflora | 40 |
| The Poop Mod | 1728184416 | WindowsXP.ThePoopMod | 40 |
| Vanilla Plants Expanded | 2134308522 | VanillaExpanded.VPlantsE | 40 |
| Vanilla Plants Expanded - Mushrooms | 3006389281 | VanillaExpanded.VPlantsEMushrooms | 39 |
| VGP Garden Gourmet | 2007062982 | dismarzero.VGP.VGPGardenGourmet | 38 |
| [1.7]边缘仙路-俗世仙工 RimImmortal-Living | 3326145525 | RI.RimImmortal.Living | 37 |
| Westerado Wilderness | 1389096461 |  | 37 |
| Cultured Meat | 1420944836 | leion247153.CulturedHMeat | 36 |
| ZARS Core | 1502619368 | dracoix.zars.core | 36 |
| Save Our Ship 2 | 1909914131 | kentington.saveourship2 | 35 |
| Warhammer-ish:Dryad (Continued++) | 3563451515 | Mortimer.WarhammerishDryad | 35 |
| Underground Food | 1761270139 | RelaxedOtter.UndergroundFood | 34 |
| Choose Life (New Real Drugs)(Continued) | 2815563867 | zal.chooselife | 32 |
| Holliday Stuff (Continued) | 2310005890 | Mlie.HollidayStuff | 32 |
| Skunk Smokeleaf Overhaul | 2852740151 | LM.SkunkSmokeleafOverhaul | 32 |
| Wayward Biomes: Lotus Wilds | 3751454361 | zylle.WaywardBiomes.LotusWilds | 32 |
| Vanilla Events Expanded | 1938420742 | VanillaExpanded.VEE | 31 |
| Eternal Science | 3537565209 | LostS1ght.EternalScience.250601 | 30 |
| Futuristic Plants | 1826002391 | battlemage64.FuturisticPlants | 30 |
| MorrowRim - Ashlands Swamp | 2230936898 | SirMashedPotato.MorrowRim.AshSwamp | 30 |
| Social Supplements (Continued) | 2195052690 | Mlie.SocialSupplements | 30 |
| Vanilla Plants Expanded - Succulents | 2198652536 | VanillaExpanded.VPlantsESucculents | 30 |
| 华夏扩展 Chinese Comprehensive Expansion | 3221850511 | ninedaylongbow.ChineseComprehensiveExpansion | 30 |
| A RimWorld of Magic | 1201382956 | Torann.ARimworldOfMagic | 28 |
| CuproPanda's Drinks | 1543172057 | dismarzero.VGP.CuproPandasDrinks | 28 |
| Glowmoss | 2441383010 | DarkSunStudio.Glowmoss | 28 |
| ReGrowth: Boiling | 2981924439 | ReGrowth.BOTR.BoilingForest | 28 |
| Vanilla Plants Expanded - Flowers | 3748351639 | VanillaExpanded.VPEFlowers | 28 |
| [1.7]边缘仙路-羽化登仙 RimImmortal-Core | 3296476341 | RI.RimImmortal.Core | 27 |
| Kit's Brazilian Crops (Continued) | 2886512401 | zal.braziliancrops | 27 |
| Nature's Pretty Sweet (Continued) | 3542949511 | Mlie.NaturesPrettySweet | 27 |
| Oni of the Rim | 2891432261 | tarojun.morishep.onioftherim | 27 |
| Superhero Genes - Base | 2980061828 | SuperheroGenesBase.Mod | 27 |
| [1.7]边缘仙路-炊耕百味 RimImmortal-Farmcraft | 3655458570 | RI.RimImmortal.Farmcraft | 26 |
| Alpha Bees | 1558161673 | sarg.rimbees | 26 |
| Edo Themed Expansion | 2878807817 | Heis.Edo.Themed.Expansion | 26 |
| ReGrowth 2: Aspen | 2545774148 | ReGrowth.BOTR.AspenForest | 26 |
| Undergrounders: Complete | 2817357535 | BattIeBear.Undergrounders.Complete | 25 |
| EdenGarden | (local) EdenGarden |  | 24 |
| MorrowRim - Alcohol Remade | 2168688125 | SirMashedPotato.MorrowRim.AlcoholRemade | 24 |
| PVZRimWorld | 3676353877 | acct.PVZRimWorld | 23 |
| Advanced Biomes (Continued) | 3541022508 | Mlie.AdvancedBiomes | 22 |
| Sunset Technology 3 | 3601719516 | SunsetModerTeam.SunsetTechnology3 | 22 |
| Decorative trees (Continued) | 2670019924 | Mlie.DecorativeTrees | 21 |
| GroThing | 2976584286 | DanDMan.GroThingThings | 21 |
| RimVali: Far From Avalon | 2936412543 | Nesi.RimValiFFARW | 21 |
| Storytime Official Mod | 2411541093 | Jonah.Storytime | 21 |
| [1.7]边缘仙路-山海灵域 RimImmortal-Biome | 3624919432 | RI.RimImmortal.Biome | 20 |
| Biomes! Bunnies | 2874907777 | BiomesTeam.Bunnies | 20 |
| Erin's Japanese Furniture | 2354938860 | Erin.JapaneseFurniture | 20 |
| Nelim's Eden Garden (prohibited) | 3806763749 | nelim.edengarden | 20 |
| Pharma (Continued) | 2856432368 | zal.Pharma | 20 |
| ReGrowth: Volcanic Ice Sheet (Continued) | 3392275022 | Mlie.ReGrowthVolcanicIceSheet | 20 |
| Construction Expanded | 2794480005 | CS.CE | 19 |
| [SYR] Thrumkin Continued+ | 3307995997 | Sans.thrumkin | 18 |
| Lord of the Mysteries | 3809971059 | Reg.LordOfTheMysteries | 18 |
| Medical Supplements (Continued) | 2195037369 | Mlie.MedicalSupplements | 18 |
| VGP Garden Fabrics | 2007062162 | dismarzero.VGP.VGPGardenFabrics | 17 |
| VGP Garden Fabrics Simplified | 2007062335 | dismarzero.VGP.VGPGardenFabricsSimplified | 17 |
| Alpha Animals | 1541721856 | sarg.alphaanimals | 16 |
| Farmable Resources | 3253893274 | konstantynopolitaneczka.FarmableResources | 16 |
| Hybrid Forest | 3772744848 | Protok.PW.HybridForest | 16 |
| RadWorld | 2644582906 | Declinedkilr.RadWorld | 16 |
| RPG Adventure Flavour Pack | 2916348220 | MrSamuelStreamer.RPGAdventureFlavour | 16 |
| RPG Adventure Flavour Pack - Fork | 3342554570 | Joe.RPGAdventureFlavour.Fork | 16 |
| TiberiumRim | 1346865620 | telefonmast.tiberiumrim | 16 |
| Tribal Fungi Biome | 2182438464 | Druid.FungiBiome | 16 |
| Winter Taiga Biome 2 | 3666855302 | reel.wintertaigabiome2 | 16 |
| Flowers (Continued) | 2025555200 | Mlie.Flowers | 15 |
| Kai's Vending Machine | 3161655279 | kai.vendingmachine | 15 |
| Monster Hunter Rimworld Expansion | 2672503877 | Hol.MHRWE | 15 |
| PalRim | 3770344985 | Elvlin.PalRim | 15 |
| Raven Race - Embers in Shadow | 3781005562 | ZuoYao.RavenRace | 15 |
| TurtleShroom Productions Proudly Presents: Ancient Rim (Continued) | 3507862392 | Mlie.AncientRimCore | 15 |
| [SYR] Coffee and Tea (Continued) | 3263163331 | Mlie.SYRCoffeeAndTea | 14 |
| Bonsaiplus | 798086114 |  | 14 |
| Cuisine Story | 3790543283 | rimdream.rimcuisine | 14 |
| Houseplants Remastered | 2906302219 | HouseplantsRemastered.mp3 | 14 |
| I Am Hungry(continued) | 2094216512 | IAmHungry.velcroboy333 | 14 |
| Misc. Bees'n'Honey | 766264659 | Haplo.Miscellaneous.BeesNHoney | 14 |
| The Luckymoon Archite tech | 3742734590 | canamanyak.LuckymoonArchite | 14 |
| Zoo-家园（home） | 789775790 |  | 14 |
| Bubble's Drugs | 898273220 |  | 13 |
| [RF] Fishing-ReWork Seafood and Sushi Addon (Continued) | 2920099647 | Mlie.RFFishingReWorkSeafoodAndSushiAddon | 12 |
| DisplayStand | 2024956515 | Spencer.DisplayStand | 12 |
| Erin's Cottage Collection | 2977561141 | Erin.CottageCollection | 12 |
| Forsakens (Continued) | 3263003456 | zal.forsakens | 12 |
| Houseplants | 2188000240 | elkyelky.Houseplants | 12 |
| Los Carteles del Borde | 2195696516 | RimCartels.velcroboy333 | 12 |
| More Vanilla Biomes | 1931453053 | zylle.MoreVanillaBiomes | 12 |
| Rimcense: Neolithic Soothe | 2532255863 | Incense.velcroboy333 | 12 |
| RimLife Expansion Trading items | 2951594887 | daylight.RimLifeExTRGMod | 12 |
| Rimstro Farming Expansion | 3580027782 | Roo.rfe | 12 |
| RimTycoon - Core | 3817697186 | nela.rimtycoon.core | 12 |
| rjw-sexpanded-core | (local) rjw-sexpanded-core |  | 12 |
| Taki's Random Stuff (Continued) | 2483488820 | Mlie.TakisRandomStuff | 12 |
| Tribal Medicine | 2950258180 | Argon.TribalMedicineRemake | 12 |
| Utility Supplements (Continued) | 2195065488 | Mlie.UtilitySupplements | 12 |
| VGP Garden Drinks | 2167582651 | dismarzero.VGP.VGPGardenDrinks | 12 |
| [HAS] MedievalDiet | 3750840931 | BiscuitMiner.HAS.MedievalDiet | 11 |
| Flowers and Drugs(continued) | 2094362538 | FlowersAndDrugs.velcroboy333 | 11 |
| Mincho, The Mint Choco Slime ~ HAR ver. | 2477501851 | SutSutMan.MinchoTheMintChocoSlimeHARver | 11 |
| Night Variants | 3283439492 | Blind.Night | 11 |
| Writhing Tree | 3678181731 | Romyashi.WrithingTree | 11 |
| [旋风绘卷]Andery-Tech | 2085370932 | andery233xj.mod.AnderyTech | 10 |
| Alien Worlds - Gloomworld | 3704140230 | feb.alienworlds.gloomworld | 10 |
| Anima Expansion | 3532147582 | Romyashi.AnimaExpansion | 10 |
| Ascension - Immortal Cultivation | 2652340519 | anobis.epicmods.ascension | 10 |
| Clockwork And Steam (Continued) | 3316197028 | zal.clockworkandsteam | 10 |
| Erin's Hot Drinks | 2520989125 | Erin.HotDrink | 10 |
| FantasticWorlds(reworked) | 2270354898 | Velcroboy333.FW | 10 |
| Hakuro Xenohuman | 2911715839 | Hakuro.Xenohuman.septentrionrace | 10 |
| Miho, the celestial fox | 2816826107 | miho.fortifiedoutremer | 10 |
| Plant Human | 1572026865 | LingLuo.PlantHuman | 10 |
| Wanna Get High (Continued) | 2613804831 | zal.wannagethigh | 10 |
| Westerado (Continued) | 2236973780 | Mlie.Westerado | 10 |
| [T] ExpandedCrops (Continued) | 3009264708 | zal.expandedcrops | 9 |
| [TW1.6]幻彩林地 Rainbow forest | 3532501549 | TW.TangsBiome.RainbowForest | 9 |
| AkariSou in Rimworld | 3261648816 | Sahrachansama.AkariSouinRimworld | 9 |
| BetterBerries | 3688093473 | SlaughterNeko.BetterBerries | 9 |
| Biome Expansion: Redwood forest | 1935518604 | kikohi.BERF | 9 |
| Corruption: Worship | 2555397551 | CptVHOhu970.CorruptionWorship | 9 |
| Kit's Power Protein Continued  | 2880137308 | KIT.PowerProtein | 9 |
| Malay Themed Expansion | 2884249920 | NSTR.Malay.Themed.Expansion | 9 |
| Mona The Moon Bear (1.6 fork) | 3248186952 | kku.MonaTMB | 9 |
| OverflowingFlowers | 3005103112 | sumika.OverflowingFlowers | 9 |
| [KB] Aquacrops in Hydroponics - Vanilla Plants Expanded More Plants | 3503325204 | KB.Aquacrops.In.Hydroponics | 8 |
| Avali Farmables Continued | 3523156287 | Avali.farmables.continued | 8 |
| Dragons Descent | 2026992161 | onyxae.dragonsdescent | 8 |
| Grains and Brewing (1.4+) | 2897396824 | tidal.grainsandbrewing | 8 |
| Grub Farm (Continued) | 2018980438 | Mlie.GrubFarm | 8 |
| Homesteader | 3759238501 | AzraelGodKing.Homesteader | 8 |
| Hyper Shrooms and Flowers (Continued) | 3481714646 | ElTwoFour.HyperShroomsAndFlowers | 8 |
| Jecs Tobacco and Cigarettes (Continued) | 2208107297 | Mlie.JecsTobaccoAndCigarettes | 8 |
| Knot Root (Continued) | 2018961250 | Mlie.KnotRoot | 8 |
| Leather ＆ Milk Crops | 3818905174 | jonyh1127.leathermilkcrops | 8 |
| MDrugs (Continued) | 2862486497 | zal.MDrugs | 8 |
| MoeLotl: Rigor Mortis | 3454053400 | fxz.moelotlzombie.update | 8 |
| MorrowRim - Volcanic Ashlands | 2472730150 | SirMashedPotato.MorrowRim.VolcanicAshlands | 8 |
| MSS Tweaks and Fun | 3379574408 | MSS.FlavourPack | 8 |
| Obi Mods - Cupro's Alloys into Veggie Garden Resource Plants | 1281484599 |  | 8 |
| Oni Xenotype | 3311134271 | Eclair155.OniXeno | 8 |
| Primordial Geysers | 2896731795 | IronScruff.PrimordialGeysers | 8 |
| RadWorld | 2474160202 | Declinedkilr.RadWorld_copy | 8 |
| Realistic Plant Cycles 2.0 | 2406978493 | RealPlantCycles.velcroboy333 | 8 |
| RimWest | 3453765588 | ymaxeuss.rimwest | 8 |
| Sora's Foods + Flora Evolved | 1282767917 |  | 8 |
| Toxicity Evolved | 3262128970 | basilthebatlord.toxicityevolved | 8 |
| Undergrounders: Ghostwort and Glowstool | 2813966096 | BattIeBear.Undergrounders.Ghostwort | 8 |
| Utility Mushrooms | 2989453135 | Zazer45f.UtilityMushrooms | 8 |
| Vanilla Christmas Expanded | 3380695249 | VE.VanillaChristmasExpanded | 8 |
| VCE Unofficial Add-On: Christmas Cooking | 3668982717 | Argon.VCEU.Christmas | 8 |
| Zoo-Home Renew | 3811404731 | nelim.zoohome | 8 |
| ZooHomeRenew | (local) ZooHomeRenew |  | 8 |
| Cyber Plants - Beauty | 2923290415 | ruyu.cyberplantsbeauty | 7 |
| Dandelions | 2250969277 | GeoppettoHosseltoff.Dandelions | 7 |
| Dune (Continued) | 2154017463 | Mlie.Dune | 7 |
| EM Insects And Plants (Continued) | 2025643074 | Mlie.EMInsectsAndPlants | 7 |
| Go Explore! | 1814100216 | Albion.GoExplore | 7 |
| Potions (Continued) | 2595809112 | Mlie.Potions | 7 |
| Real World Food 2 (Continued) | 2256552171 | Mlie.RealWorldFood2 | 7 |
| RimCuisine — Cooking Research &amp; Discovery | 3800069063 | yuyang.rimcuisine | 7 |
| Sustainable Toxic Environment | 3254886145 | emitbreaker.MIM.WH40k.Tox.Core | 7 |
| SyrenitesMod | 3326074711 | IceLordSyren.SyrenitesMod | 7 |
| Vanilla-like wheat (Continued) | 2717707382 | Mlie.VanillalikeWheat | 7 |
| Viking Brand Whale Blubber (Continued) | 2210268220 | Mlie.VikingBrandWhaleBlubber | 7 |
| [1.7]边缘仙路-五行流转 RimImmortal-FiveElements | 3439473215 | RI.RimImmortal.FiveElements | 6 |
| [VSER] Industry | 2997037628 | VSER.Industry | 6 |
| 【1.6】Hello, Lansy Forked | 3180951208 | mg.ferianstory.lansy.fork | 6 |
| A Monkey Expansion (Continued) | 3166737970 | zal.monketime | 6 |
| Alpha Genes | 2891845502 | sarg.alphagenes | 6 |
| Call of Cthulhu - Cults (Continued) | 3588548484 | zal.cocc | 6 |
| Carnarodian, the two Mustelids Xenotypes and Factions | 3104049393 | Resurrectionem.LyunicaandSobolelyud | 6 |
| End times: Renn Organisms | 2811289481 | DanielRenner.RennOrganisms | 6 |
| Evelyn's Corporate additions! Weapons, Tools, and more! [In Development] | 2831690534 | Evelyn.EveCoMod | 6 |
| Farming Expansion | 2258612562 | Mlie.FarmingExpansion | 6 |
| Fermenter (Continued) | 2194522312 | Mlie.Fermenter | 6 |
| Fertility Drugs and Birth Control | 3330508312 | MxEmmin.FertilityDrugsAndBirthControl | 6 |
| Floran Root | 2967105902 | TitaniusRex.FloranRoot | 6 |
| Holiday Special Edition | 813190996 | spoonshortage.holidayse | 6 |
| JapaneseHomestead | (local) JapaneseHomestead |  | 6 |
| Magic Wands | 2519700416 | D4egon.MagicWand | 6 |
| MF Vanilla | 3725961309 | oracle.mfvanilla | 6 |
| MorrowRim - Alcohol | 2091165362 | SirMashedPotato.MorrowRim.Alcohol | 6 |
| Nelim's Japanese Homestead (unofficial) | 3806764776 | nelim.wa | 6 |
| RimLife Cultivation Plus | 3614595617 | daylight.RLEVVCultivationPlus | 6 |
| RimSeasoning | 2212032458 | tikubonn.RimSeasoning | 6 |
| Rimspite Gitz: Loonclans | 3735204214 | JTC.AOSgitz | 6 |
| rjw | (local) rjw |  | 6 |
| Stoneborn - Delights | 3106413957 | det.sbdelights | 6 |
| TurdleShroom Produmptions Poodly Presents: Fecal Matter Production | 3274707367 | TSP.BathroomHumor | 6 |
| Vanilla Brewing Expanded | 2186560858 | VanillaExpanded.VBrewE | 6 |
| Vanilla Cooking Expanded | 2134308519 | VanillaExpanded.VCookE | 6 |
| Vanilla Cooking Expanded - Sushi | 2158539170 | VanillaExpanded.VCookESushi | 6 |
| WA v1.0 | 1548358607 |  | 6 |
| [HAS] Pestilence &amp; Physic | 3772650173 | BiscuitMiner.HAS.PestilencePhysic | 5 |
| A Regular Ol' Plumbus | 2210738958 | Xercaine.Plumbus | 5 |
| Belant | 3543414807 | businburg.belant | 5 |
| Cane Aternitigno, The war dogs of battlefield Xenotypes and Faction | 3165847953 | Resurrectionem.CaneBellum | 5 |
| CCP's Plant Stuff | 1264725945 | cucumpear.plantstuff | 5 |
| Gerzee Expansion | 2446834016 | Brightsideguy.GerzeeExpansion | 5 |
| GingerAle | 2071744389 | SafetyMets.GingerAle | 5 |
| hydroponic fruit tree's for veggie garden | 855650291 |  | 5 |
| LT-GardeningRegrown | 1804422724 | MathewAlden.LTGardeningRegrown | 5 |
| Maelstrom's Materials | 2886501475 | Soul.MaelstromsMaterials | 5 |
| Maelstrom's Plants | 2895559489 | Soul.MaelstromsPlants | 5 |
| Quad Stuff | 1149926421 |  | 5 |
| Rim Expedition 33 | 3534663071 | warult.expedition33mod | 5 |
| RimVali: Far From Avalon | 2180380125 | NeziTheAvali.RimVali | 5 |
| RimWorld Survival Frontier | 3548195656 | lele.rimworldsurvivalfrontier | 5 |
| SafeJobWorld | 2043261353 | safe.job.world | 5 |
| Stellaris DEMO | 3769459524 | Feng.StellarisDEMO | 5 |
| Stoneborn - Cuisine | 3725224779 | det.sbcuisine | 5 |
| Sunset Weapon Technology 2 | 2890976130 | SunsetModerTeam.SunsetWeaponTechnology2 | 5 |
| Tall Grass: Hidden Danger | 3809413639 | local.tallgrass | 5 |
| Vanilla Factions Expanded - Medieval | 2023513450 | OskarPotocki.VanillaFactionsExpanded.MedievalModule | 5 |
| Zen Garden Plus | 2141107008 | ZGBooze.velcroboy333 | 5 |
| Zen Garden Plus Renew | 3811405357 | nelim.zengardenplus | 5 |
| ZenGardenPlusRenew | (local) ZenGardenPlusRenew |  | 5 |
| 中华老先人：Mingshu Faction | 3012932396 | WeiShanMaoWei.gudairen | 5 |
| [GP]Flowery Furniture | 3649367637 | Flower.Furniture.GP | 4 |
| [LTS]Furnishing | 2567438519 | LimeTreeSnake.Furnishing | 4 |
| [OA]Stepped Flower Cake | 3379736801 | WW.OberoniaAurea.SteppedFlowerCake | 4 |
| [SYR] Harpy | 2092823139 | syrchalis.harpy | 4 |
| Ancient &amp; Medieval Japan - Environment（中世日本 - 環境） | 3814638060 | sucro.ancientmedievaljapan.environment | 4 |
| Archean Willow Trees | 3539084138 | Goat.Archean.Willows | 4 |
| BaiYangTree | 3511712693 | QuanNengZheZhiXi.BaiYangTree | 4 |
| Bamp Xenotype | 3297545550 | Bamp.Gorani | 4 |
| Chromatic Sensitivity | 2856889316 | Taggerung.ChromaticSensitivity | 4 |
| Covenant Of Hir (Continued) | 3646443012 | Zaltys.CovenantofHirUpdated | 4 |
| EM Ancient Technology (Continued) | 2568842105 | Mlie.EMAncientTechnology | 4 |
| Farmable Neutroamine - Medieval | 2826944163 | JoeDaly.Neutro.Medieval | 4 |
| Frost and Fire (Continued) | 3243969146 | zal.frostandfire | 4 |
| GhillieModPack (Continued) | 2862485631 | zal.GMP | 4 |
| GlowRose | 2917180827 | denerose.GlowRose | 4 |
| Kwiver | 2120889697 | GarbageDayIsHereToStay.Kwiver.GDIHTSKWVR | 4 |
| LunaRose：BonBunny | 3657986169 | rw.LunaRose.Bonbunny | 4 |
| Mashed's Spiribirds | 2839002794 | SirMashedPotato.Spiribirds | 4 |
| Medieval Medicines Medieval Overhaul Edition | 2883228057 | JoeDaly.MedMeds.MO | 4 |
| MorrowRim - Grazelands | 2472729709 | SirMashedPotato.MorrowRim.Grazelands | 4 |
| Pirates! Gold | 2599107582 | zal.piratesgold | 4 |
| Red Candy Canes | 2779665969 | ThatBartGuy.Candy | 4 |
| Resident Rim | 3732795691 | ProstoMax.ResidentRim | 4 |
| RIM Enchantment Craft | 3666549755 | SunsetModerTeam.RIMEnchantmentExpansion | 4 |
| Rubber Trees! | 2839064255 | cubicPsycho.RTRubber | 4 |
| Simple Algae - 'VPE More Plants' Addon | 2963220393 | AlgaeCrop.VEPMPAddon | 4 |
| Soil improvement and Glass[1.0] | 1550258962 |  | 4 |
| T's Samurai Faction | 2559958496 | Trickity.Samurai.Faction | 4 |
| Tropical Textiles | 3517018242 | Tinda.TropicalTextiles | 4 |
| Undergrounders: Anticillin | 2814062724 | BattIeBear.Undergrounders.Anticillin | 4 |
| Vanilla Brewing Expanded - Coffees and Teas | 2275449762 | VanillaExpanded.VBrewECandT | 4 |
| Vanilla Factions Expanded - Classical | 2787850474 | OskarPotocki.VFE.Classical | 4 |
| Vanilla Ideology Expanded - Anima Theme | 2666998627 | VanillaExpanded.VIEAT | 4 |
| Vee's decorating | 1585057683 | Lat.VeeDeco | 4 |
| Vineshrooms - Vinesauce (Continued) | 3475363584 | vine.shrooms | 4 |
| Wulfs Aloe Vera | 1950553048 | bluewulf.AloeVera | 4 |
| WVC - Xenotypes and Genes | 2886992038 | wvc.sergkart.races.biotech | 4 |
| Yuran Shrine Japanese Architecture | 3671664434 | Caoyuanfei.YuranShrineJapaneseArchitecture | 4 |
| Zal's Chickpeas and Hummus | 2627028153 | zal.chickpeas | 4 |
| 土豆盛宴Potato meal | 2883013707 | LingLuo.Potato | 4 |
| [MQM] Prosperity | 3806440075 | friver.mqm.prosperity | 3 |
| Anima Gear - Continued | 3545349562 | xrushha.NOTDemo.AnimaGear | 3 |
| Anima Wizard Items | 3746760025 | SierraOnline.WizWar | 3 |
| Ari's Distillery | 3550086015 | ARIS.Dstl | 3 |
| Ashes | 2958504184 | Romyashi.Ashes | 3 |
| AshieruChan Animal Mod | 3578716757 | kayurayuka.ashieruchan.animalmod | 3 |
| DuelMonsterRimWorld | 3050289249 | DuelMonster.RimWorld | 3 |
| El's Ilk of the Old Gods | 3005403475 | ellit.IlkoftheOldOnes | 3 |
| El's Rebel Alliance | 2780886227 | ellit.Rebels | 3 |
| Epona Dynastic Rise | 3514746737 | Epona.EponaDynasticRise | 3 |
| Equiums Wall N Floor Art | 2016401914 | Hauvega.EquiumsSeries.EquiumsWallNFloorArt | 3 |
| Erin's Auraeyl | 3653150966 | Erin.Auraeyl | 3 |
| Gloomy Furniture Fix | 2987876242 | Gloomy.Furniture.Fix | 3 |
| GloomyFurniture (Continued) | 3240958004 | Gloomy.Furniture.Continued | 3 |
| GloomyFurniture (Continued) Unofficial Fix | 3532426842 | Gloomy.Furniture.Continued.Fix | 3 |
| GuerillaSphere - The Goanna Clade | 3245538232 | transslenderman.gs.goanna | 3 |
| Halloween Harvest | 3811893311 | tbmodding.halloweenharvest | 3 |
| Humanoid Dryad(Continued) | 3729421840 | moyuguguji.humanoiddryad | 3 |
| Hyperweave Plantation (Continued) | 3592666774 | zal.hyperweaveplantation | 3 |
| Justiciars of the Dark God | 3618401037 | Killathon.ArtificialBeings.JusticiarsOfTheDarkGod | 3 |
| Jute VPE More Plants fabric | 3536389544 | Distraction.JuteFabric | 3 |
| Kenshi Cuisine | 2600344770 | Super.Kenshicuisine | 3 |
| Lord of the Rims - Elves (Continued) | 3548255064 | zal.lotrelves | 3 |
| Marro | 2057712425 | zot.marro | 3 |
| Mashed's Lynians | 2871704782 | SirMashedPotato.Lynians | 3 |
| Mealroot | 3205633494 | TheLoneCyberman.Mealroot | 3 |
| Meme-Superpack | 2957903828 | MrSamuelStreamer.MemeSuperpack | 3 |
| Moonjelly Xenotype | 3030254580 | SG.moonjelly | 3 |
| MorrowRim - Bloodmoon | 2243604074 | SirMashedPotato.MorrowRim.Bloodmoon | 3 |
| Nuke's Drug Cocktails | 853758537 |  | 3 |
| Oats! | 1803357494 | ChrisBradel.Oats | 3 |
| Orostonian, the Frontiers Xenotypes and Factions | 3147447844 | Resurrectionem.Orostonian | 3 |
| Peanuts (And Peanut Accessories) | 1528059319 | ChrisBradel.Peanuts | 3 |
| Poppy Flowers | 855254064 |  | 3 |
| Quests on Request | 3818120341 | PaulDunstan.QuestsOnRequest | 3 |
| RimForge | 2505778174 | co.uk.epicguru.rimforge | 3 |
| RimKimetsu - Demon Slayer Rimworld Mod | 3641720143 | WILL.DemonSlayerRimworldMod | 3 |
| Ryu Vanilla Plants+ | 3700583256 | ryu.vanillaplants | 3 |
| Smokeleaf Industry (Continued) | 3795903934 | zal.smokeleafindustry | 3 |
| Smuggler's Run | 3613289193 | lambda.SmugglersRun | 3 |
| Steves Animals | 2479431577 | Scurvyez.Bastyon | 3 |
| Sunflower Seeds | 2560096262 | Verniy709.Sunflower.Seeds | 3 |
| Swarmpocalypse | 3447056193 | Luosheng.Swarmpocalypse | 3 |
| Sweet Wormwood | 861320529 |  | 3 |
| Synergy Flower (Continued) | 2805487274 | zal.SynergyFlower | 3 |
| TP Bedouin Faction Expanded | 3073603653 | Tanypredator.Bedouin.Faction.Expanded | 3 |
| TP Sea Plants | 3643012859 | TP.SeaPlants | 3 |
| Tusks and Claws - A Crashlands Inspired Mod | 2367686220 | ClossomMistake.Blegh | 3 |
| Vanilla Factions Expanded - Insectoids 2 | 3309003431 | OskarPotocki.VFE.Insectoid2 | 3 |
| Vanilla Races Expanded - Phytokin | 2927323805 | vanillaracesexpanded.phytokin | 3 |
| Wands and Spells (Continued) | 2694379637 | zal.wandsandspells | 3 |
| Westerado Provisions | 1389094379 |  | 3 |

