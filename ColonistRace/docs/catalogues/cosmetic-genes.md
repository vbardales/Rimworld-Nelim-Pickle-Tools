# Cosmetic genes: every one on disk

Scan of 2026-11-03: `scripts/Search-Workshop.sh -p "<GeneDef[ >]" -i *.xml` over the Workshop and the local Mods folder (9706 folders read) for the mods, XML comments stripped, 1.6 or unversioned folders only, `ParentName` resolved inside each mod. **3293 distinct gene names in 257 sources (vanilla + mods).** A gene is listed as cosmetic when it (or its parent) sets a skin colour, a hair colour, a hair or beard tag filter, a head type, a body type, a `renderNodeProperties` (something drawn: ears, tails, horns, marks, wings), or a display category that contains "Cosmetic". The vanilla genes come from the game folder, not from the scan (Data/Core and Data/Biotech, `GeneDefs`): the 1.6 install and the 1.7.4976 install hold the same 72 cosmetic genes. A gene found is not a gene loaded: the mod must be in the mod list, and some genes also carry stats (a drawn gene may be a body part with an effect). This is names from the XML, not photographs: the photographed ones are in Genes d'apparence, Looks and Colours. A gene name may be found in two kinds (a horn that also sets a skin colour).

| Kind | Genes (name x mod) |
|---|---|
| hair style | 143 |
| beard | 151 |
| skin colour | 827 |
| head shape | 314 |
| drawn (ears, tails, horns, marks, wings...) | 1650 |
| body | 81 |
| other cosmetic category | 161 |
| hair colour | 490 |

| Mod | Workshop id | Cosmetic genes |
|---|---|---|
| Vanilla RimWorld (Core and Biotech, read from the game folder) | game (1.6 and 1.7 identical) | 72 |
| Outland - Genetics | 2910172297 | 283 |
| No Longer Human-Core | 3777374986 | 262 |
| Biotech Cosmetic Kit - Horns Halos and More | 2985847757 | 176 |
| Alpha Genes | 2891845502 | 138 |
| WVC - Xenotypes and Genes | 2886992038 | 113 |
| Star Wars Xenotypes | 2915192253 | 95 |
| [LFS] Genes Expanded - Hair | 3221946756 | 76 |
| [LFS] Genes Expanded - Skin Colors | 3214172563 | 75 |
| Paws Of Interest [ Xenotype Mod ] | 3764120996 | 74 |
| Anthros for Everyone | 3694051923 | 71 |
| Cyanobot's Genes | 2889844371 | 58 |
| Anthrosonae | 2902258418 | 58 |
| Seren, from Stardust [Biotech Fork] | 3726565301 | 56 |
| Big and Small - Genes & More | 2920751126 | 54 |
| [Alien/Race] Seren, from Stardust | 2704627783 | 49 |
| Yanzhiko Xenotype Collection | 3580656240 | 49 |
| Meteorifics Cosmetic Gene Pack | 2903706128 | 43 |
| Erin's Cosmetic Genes | 3658223466 | 38 |
| [LTS]Xenotech | 2877887281 | 37 |
| Helltaker Cosmetic Genes | 2955062315 | 36 |
| Atlyss Races / Core | 3521335460 | 35 |
| Biotech Expansion - Mammalia | 2878084431 | 31 |
| FIP - WestTek | 3592202407 | 31 |
| Inclusive Skin Tones 1.6 | 3551840130 | 29 |
| No Longer Human-Consortium Faction Pack | 3777379164 | 29 |
| Bagi Faction 1.6 | 3527337546 | 28 |
| Obsidia Expansion - Mothoids Xenotype | 2885653060 | 24 |
| Dr. Arch13's ArchoWonderium - The Xen Empire | 3407013231 | 24 |
| DuelMonsterRimWorld | 3050289249 | 23 |
| Cain's Gene Pack | 3819866589 | 23 |
| Fairycore - Spirit Wings | 3812515333 | 21 |
| Horns & Ears & Things | 2888651437 | 20 |
| Moonjelly Xenotype | 3030254580 | 20 |
| Sin's Softer Hair Colors | 3790361865 | 20 |
| Biotech Expansion - Mythic | 2883216840 | 19 |
| United weird Unimals | 2902436977 | 19 |
| Obsidia Expansion - Tailborne Xenotype | 3511930980 | 19 |
| [LFS] Genes Expanded - Horns | 3547798297 | 19 |
| Papou Xenotype: Emotional Birds (Continued) | 3571039438 | 19 |
| Big and Small - Centaurs Expanded | 3795221508 | 19 |
| DA Cosmetic Genes (1.6) | 3785491487 | 18 |
| transparent skin genes | 3031713201 | 17 |
| Biotech Expansion - Insectoid | 3219625470 | 17 |
| Erin's Rhy'aeth | 3707527452 | 16 |
| Faction - Elves | 3726293423 | 15 |
| Obsidia Expansion - Slimes Xenotype | 3331598962 | 13 |
| FIP - RobCo | 3563825876 | 13 |
| Obsidia Expansion - Axotl Xenotype | 3304340573 | 12 |
| Biotech Cosmetic Kit - Extras and Fix | 3662220025 | 12 |
| Rabbie The Moonrabbit race | 1837246563 | 11 |
| Rimsenal Xenotype Pack - Askbarn | 2918812858 | 11 |
| Orostonian, the Frontiers Xenotypes and Factions | 3147447844 | 11 |
| Epona Dynastic Rise | 3514746737 | 11 |
| Blanks. | 3668680336 | 11 |
| Oca's Anthrosonae | 3720732132 | 11 |
| Tribal Fungi Biome | 2182438464 | 10 |
| Zoroark - Xenotype | 3047455758 | 10 |
| Carnarodian, the two Mustelids Xenotypes and Factions | 3104049393 | 10 |
| Mona The Moon Bear (1.6 fork) | 3248186952 | 10 |
| Jaguar and Snow Leopard Xenotypes | 3297800460 | 10 |
| Sensmageddon | 3365152973 | 10 |
| Rim-Hivers! - Biotech | 3378615596 | 10 |
| BoneReapers ReMarrowed | 3516603515 | 10 |
| [S16] Beautiful Body Variants | 3556936541 | 10 |
| [SH]Gene Expand | 3558760095 | 10 |
| Spite the Sky: Fer'Liebor Xenotype | 3646000311 | 10 |
| 边缘仙路-镇邪诛鬼 RimImmortal-Exorcism[1.6] | 3663824172 | 10 |
| [AP] Lupine Xenotype | 2991428888 | 9 |
| Vanilla Skin Tone Genes | 3165888554 | 9 |
| [LFS] Genes Expanded - Wings | 3208605060 | 9 |
| Det's Xenotypes - Brawnum | 3429572581 | 9 |
| Awakened Apes | 3646217940 | 9 |
| Mauray | 3663680564 | 9 |
| Everybody's Different | 3750132342 | 9 |
| Miho, the celestial fox | 2816826107 | 8 |
| Dr. Arch13's ArchoWonderium - DigiFox (tm) | 2900653856 | 8 |
| Rimsenal Xenotype Pack - Harana | 3228637524 | 8 |
| Helltaker Cosmetic Genes (Skin Horns) | 3314993192 | 8 |
| Just About: Lions And Tigers (Continued) | 3320873214 | 8 |
| ME(b) - Krogan | 3524888108 | 8 |
| Lilin Wool Genes | 3696210405 | 8 |
| 鼠族（无外星人框架）/ Ratkin Without HAR | 3826752382 | 8 |
| Various Eyes Genes | 2880903154 | 7 |
| Identity | 2882253079 | 7 |
| Far Easterner, Ama the Three Raijus of the Far East Xenotypes and Factions | 2974761367 | 7 |
| ReSplice: Charmweavers | 3131996691 | 7 |
| Det's Xenotypes - Boglegs | 3146564944 | 7 |
| Starei's Florian Xenotype | 3310020641 | 7 |
| K's Snarelanterns | 3328218292 | 7 |
| Reese's Anomaly Genes | 3434828984 | 7 |
| Nottingham's Kholo 1.5.3 | 3474115586 | 7 |
| Nephilim Xenotype Reborn | 3542508261 | 7 |
| 圣蜣螂种族 | 3740297753 | 7 |
| Molong Xenotype | 3789407175 | 7 |
| local:rimholstaur | local:rimholstaur | 7 |
| Lantern Hunters | 2866414675 | 6 |
| Dr. Arch13's ArchoWonderium - Legendary Dragon (tm) | 3226197882 | 6 |
| Tower of Rimworld | 3335952183 | 6 |
| Big and Small - Simply Robots | 3360323573 | 6 |
| [DF] Gold Xenotype | 3438437353 | 6 |
| Roo's Faun Xenotype | 3547220635 | 6 |
| Monkey Xenotypes | 3566230987 | 6 |
| Cosmetic Genes- Extra | 3606047642 | 6 |
| Hawk's Gryphons | 3684749881 | 6 |
| Addie's Frost Fey | 3697314995 | 6 |
| Mantled Beasts | 3739973453 | 6 |
| Kimchianz Xenotype (Beta) | 3752498193 | 6 |
| Seraphim Xenotype Reborn | 3773065414 | 6 |
| Biotech Monke Xenotype (Continued) | 3797310379 | 6 |
| RWoM Custom Class Pack - Epic Battle Fantasy | 2803755648 | 5 |
| Integrated Genes | 2884115974 | 5 |
| Kijin Race 3.0 | 2884551646 | 5 |
| Ferian Race - Biotech | 2887426937 | 5 |
| FAE-Facial Animations Expanded | 2890697696 | 5 |
| Vanilla Races Expanded - Phytokin | 2927323805 | 5 |
| Vanilla Races Expanded - Pigskin | 3164798809 | 5 |
| Cane Aternitigno, The war dogs of battlefield Xenotypes and Faction | 3165847953 | 5 |
| Rimframe: Vatgrown Hate | 3431220821 | 5 |
| No Longer Human-Warhives Faction Pack | 3462391280 | 5 |
| Roo's Satyr Xenotype | 3548322381 | 5 |
| Roo's Minotaur Xenotype | 3548423129 | 5 |
| [LFS] Genes Expanded - Heads | 3549061328 | 5 |
| The Borg Collective | 3704848468 | 5 |
| Viltrumites in Rimworld | 3708277667 | 5 |
| Rim's Destiny: Exo | 3771229424 | 5 |
| Skinprint | 3815708054 | 5 |
| NewRatkinPlus | 1578693166 | 4 |
| Vanilla Races Expanded - Saurid | 2880990495 | 4 |
| Nose Sponge Plus+ | 2881450798 | 4 |
| Wild Factions - Damar | 2889581499 | 4 |
| Wild Factions - UXC | 2889924604 | 4 |
| Lapelli Race - Biotech | 2892301088 | 4 |
| BodyTypeMatters | 2916028877 | 4 |
| Roxborn | 3048382292 | 4 |
| Vanilla Races Expanded - Lycanthrope | 3114453100 | 4 |
| Thrumboian Race | 3257981328 | 4 |
| MakaiTech - Xenotype | 3268577147 | 4 |
| Bamp Xenotype | 3297545550 | 4 |
| MSS Tweaks and Fun | 3379574408 | 4 |
| Fabled Cervidae | 3400548142 | 4 |
| Totzi Xenotype Race | 3409222988 | 4 |
| Ratkin Xenotype Forked | 3509837826 | 4 |
| Cybranian - Oryx Xenotype | 3527163129 | 4 |
| RaddusX's Demons | 3531834757 | 4 |
| Unfortunate Xenotypes - Minua | 3566190392 | 4 |
| ME(b) - Turians | 3572135997 | 4 |
| Sergal Genes | 3639784628 | 4 |
| The Gilded Spiral - Spiralborn Xenotype | 3684159046 | 4 |
| [AV] Kosmian Xenotype | 3774474578 | 4 |
| TurtleShroom Productions Proudly Presents: Call of Cthulhu Factions (Continued) | 3780067307 | 4 |
| Ancient Chinese Beast And Gene Expanded Renew (unofficial) | 3806709132 | 4 |
| Geasbound Xenotype | 3819827851 | 4 |
| [Y]VRE Skin Colors Patch | 3822096385 | 4 |
| local:AncientChineseBeastAndGeneExpandedRenew | local:AncientChineseBeastAndGeneExpandedRenew | 4 |
| local:rjw-animal-gene-inheritance | local:rjw-animal-gene-inheritance | 4 |
| Lamias, Sirens, Snakemen, and other Serpents-like beings | 2908225858 | 3 |
| Vanilla Races Expanded - Highmate | 2995385834 | 3 |
| Rim-Gnoblins | 3018569666 | 3 |
| Rulzea Xenotype | 3020615186 | 3 |
| Erin's Corvyia | 3154954530 | 3 |
| The Profaned | 3202008037 | 3 |
| FRBE Addon - Gnolls | 3241073642 | 3 |
| ↁ Elves (Continued) | 3272603920 | 3 |
| Oni Xenotype | 3311134271 | 3 |
| Rim-Fogmen Continued! (1.6) (Biotech) | 3324678049 | 3 |
| The Cosmic Odyssey - Godwokens | 3453866993 | 3 |
| Rimzone: Sons and Daughters of Helghan | 3492260324 | 3 |
| 出于沙漠之花 | 3494511060 | 3 |
| Ashcat Xenotype | 3522775404 | 3 |
| Hyenid Xenotype | 3543131848 | 3 |
| Big and Small - Muriden | 3597814862 | 3 |
| Foxian League | 3639227864 | 3 |
| RimKimetsu - Demon Slayer Rimworld Mod | 3641720143 | 3 |
| Rimspite Gitz: Loonclans | 3735204214 | 3 |
| MUGB Goblin | 3768425355 | 3 |
| Big and Small - Catfolk | 3802375059 | 3 |
| Anthrosonae Mongoose | 3802945828 | 3 |
| Neco Arc Genes | 2953392432 | 2 |
| Vanilla Races Expanded - Sanguophage | 2963116383 | 2 |
| Nekomata Tail Genes | 2976801620 | 2 |
| World of Naruto | 3025338958 | 2 |
| Duztamva's Misc | 3231645315 | 2 |
| Selective Retexture Based on Gene | 3377855600 | 2 |
| Very scuffed 1.5 Sergals | 3469468302 | 2 |
| Spirits | 3472437470 | 2 |
| Doctor Mcninja Mod | 3511408960 | 2 |
| Posthuman Drift Warcat Xenotype | 3521815010 | 2 |
| Crream's Yetis | 3529805799 | 2 |
| Novabeast xenotype | 3532520652 | 2 |
| Goliann Xenotype | 3541961078 | 2 |
| GeneAndFactions | 3546863281 | 2 |
| Umamusume: Rim Derby | 3552197538 | 2 |
| Geist Xenotype | 3564732214 | 2 |
| RIMWAAAGH — Orks of RimWorld [1.6] — WIP | 3577775737 | 2 |
| Badger Xenotype | 3618642160 | 2 |
| Erin's Auraeyl | 3653150966 | 2 |
| Jujutsu Kaisen | 3658634704 | 2 |
| Skeletal Efflorescence | 3685431818 | 2 |
| NyanDark 40k - Space Maids | 3697034827 | 2 |
| Gloria A Las Plagas | 3708476081 | 2 |
| 햄스터 귀와 꼬리 (Hamster Ears and Tail) | 3718267131 | 2 |
| Vanillafied Vivi | 3739051552 | 2 |
| TouhouKyusakuStyle | 3769625965 | 2 |
| local:rjw-genes | local:rjw-genes | 2 |
| HousekeeperAssistanceCat | 1541620640 | 1 |
| Zeta Reticulans [Player/Hostile Factions] | 2241841840 | 1 |
| Biotech Expansion - Core | 2884018485 | 1 |
| Det's Xenotypes - Stoneborn | 2888722722 | 1 |
| Oni of the Rim | 2891432261 | 1 |
| Roo's HD Dreadlock Hairstyles | 2902544033 | 1 |
| Erin's Auronya | 2908837535 | 1 |
| More Biotech Style Genes - All in One | 2985153870 | 1 |
| Erin's Fenrisúlfr | 3020079359 | 1 |
| Nemi - magic rabbit | 3130332603 | 1 |
| CrusaderWhale | 3171384758 | 1 |
| FRBE Addon - Kuo Toa | 3242645366 | 1 |
| FRBE Addon - Sionnari | 3243761451 | 1 |
| Star Wars KotOR Resources and Materials | 3254370945 | 1 |
| Helluva Rimworld | 3259187548 | 1 |
| Characters - Blue Archive | 3284538085 | 1 |
| Nice Facial Animation | 3302079637 | 1 |
| Grimdark Recycling2 | 3363054797 | 1 |
| Jimothy's Genes! | 3371751009 | 1 |
| Star Wars KotOR Factions | 3379096669 | 1 |
| Highborn Xenotype | 3380776687 | 1 |
| Nice Facial Animation [ALT] | 3383871379 | 1 |
| Moth's Project Moon Things | 3384372059 | 1 |
| Helltaker Xenotypes | 3395078682 | 1 |
| Swarmpocalypse | 3447056193 | 1 |
| Pawns Have Mouths | 3458303799 | 1 |
| HelixLabor Syndicate | 3502230756 | 1 |
| make a zundamochi  +ankomochi | 3508333672 | 1 |
| Animal Genes | 3510541507 | 1 |
| Pesky's Bulwark Xenotype | 3521016438 | 1 |
| Det's Xenotypes - Half-foot | 3530817307 | 1 |
| Nimi's Nightmare | 3549623851 | 1 |
| Akaname | 3564157675 | 1 |
| ME(b) - Asari | 3567441469 | 1 |
| [kik] Wahsharch | 3601945326 | 1 |
| Bill Doors' Frostnova Expanded Unofficial by Haqimi | 3656575228 | 1 |
| RimZone Zero: Ellen Joe | 3657773966 | 1 |
| Gardevoirs evolution | 3668080626 | 1 |
| Koi's Mech-Androids for 1.6 | 3704669419 | 1 |
| StickWorld | 3704784635 | 1 |
| Bizarre Bloodlines | 3719429625 | 1 |
| Resident Rim | 3732795691 | 1 |
|  Yet another neko xenotype - Nekotech Xenotype | 3736684475 | 1 |
| Project Moon - Sweepers | 3761992483 | 1 |
| Avian Genes | 3769643744 | 1 |
| Kemirman | 3793645542 | 1 |
| Avian Xenotype - Eagle | 3808135566 | 1 |
| More Storylike Traits - Body and Mind 1.6 | 3811291787 | 1 |
| Body Hair Framework | 3823805934 | 1 |
| local:amor-tentaculum | local:amor-tentaculum | 1 |
| local:rjw-elt-patches | local:rjw-elt-patches | 1 |
| local:StorylikeBodyAndMind | local:StorylikeBodyAndMind | 1 |

## Vanilla RimWorld (Core and Biotech, read from the game folder) (72)

Workshop id game (1.6 and 1.7 identical).

- hair style (3): `Hair_BaldOnly`, `Hair_LongOnly`, `Hair_ShortOnly`
- beard (4): `Beard_Always`, `Beard_BushyOnly`, `Beard_NoBeardOnly`, `Furskin`
- skin colour (21): `Skin_Blue`, `Skin_DeepRed`, `Skin_DeepYellow`, `Skin_Green`, `Skin_InkBlack`, `Skin_LightGray`, `Skin_Melanin1`, `Skin_Melanin2`, `Skin_Melanin3`, `Skin_Melanin4`, `Skin_Melanin5`, `Skin_Melanin6`, `Skin_Melanin7`, `Skin_Melanin8`, `Skin_Melanin9`, `Skin_Orange`, `Skin_PaleRed`, `Skin_PaleYellow`, `Skin_Purple`, `Skin_SheerWhite`, `Skin_SlateGray`
- head shape (3): `Furskin`, `Head_Gaunt`, `Jaw_Heavy`
- drawn (ears, tails, horns, marks, wings...) (14): `Brow_Heavy`, `Ears_Cat`, `Ears_Floppy`, `Ears_Pig`, `Ears_Pointed`, `Eyes_Gray`, `Eyes_Red`, `FacialRidges`, `Furskin`, `Headbone_CenterHorn`, `Headbone_MiniHorns`, `Nose_Pig`, `Tail_Furry`, `Tail_Smooth`
- body (4): `Body_Fat`, `Body_Hulk`, `Body_Standard`, `Body_Thin`
- other cosmetic category (7): `Ears_Human`, `Headbone_Human`, `Jaw_Baseline`, `Nose_Human`, `VoicePig`, `VoiceRoar`, `Voice_Human`
- hair colour (18): `Hair_Blonde`, `Hair_BrightRed`, `Hair_DarkBlack`, `Hair_DarkBrown`, `Hair_DarkReddish`, `Hair_DarkSaturatedReddish`, `Hair_Gray`, `Hair_InkBlack`, `Hair_LightBlue`, `Hair_LightGreen`, `Hair_LightOrange`, `Hair_LightPurple`, `Hair_LightTeal`, `Hair_MidBlack`, `Hair_Pink`, `Hair_ReddishBrown`, `Hair_SandyBlonde`, `Hair_SnowWhite`

## Outland - Genetics (283)

Workshop id 2910172297.

- skin colour (38): `Outland_Skin_Azure`, `Outland_Skin_Brown`, `Outland_Skin_Copper`, `Outland_Skin_DeepAzure`, `Outland_Skin_DeepBlue`, `Outland_Skin_DeepBrown`, `Outland_Skin_DeepGreen`, `Outland_Skin_DeepLime`, `Outland_Skin_DeepMagenta`, `Outland_Skin_DeepOrange`, `Outland_Skin_DeepPink`, `Outland_Skin_DeepPurple`, `Outland_Skin_DeepSage`, `Outland_Skin_DeepViridian`, `Outland_Skin_Gold`, `Outland_Skin_Granite`, `Outland_Skin_Lime`, `Outland_Skin_Limestone`, `Outland_Skin_Magenta`, `Outland_Skin_Marble`, `Outland_Skin_PaleAzure`, `Outland_Skin_PaleBlue`, `Outland_Skin_PaleBrown`, `Outland_Skin_PaleGreen`, `Outland_Skin_PaleLime`, `Outland_Skin_PaleMagenta`, `Outland_Skin_PaleOrange`, `Outland_Skin_PalePink`, `Outland_Skin_PalePurple`, `Outland_Skin_PaleSage`, `Outland_Skin_PaleViridian`, `Outland_Skin_Pink`, `Outland_Skin_Red`, `Outland_Skin_Sage`, `Outland_Skin_Sandstone`, `Outland_Skin_Silver`, `Outland_Skin_Viridian`, `Outland_Skin_Yellow`
- hair colour (24): `Outland_HairColor_BrightAzure`, `Outland_HairColor_BrightBlue`, `Outland_HairColor_BrightGreen`, `Outland_HairColor_BrightLime`, `Outland_HairColor_BrightMagenta`, `Outland_HairColor_BrightOrange`, `Outland_HairColor_BrightPink`, `Outland_HairColor_BrightPurple`, `Outland_HairColor_BrightRed`, `Outland_HairColor_BrightSage`, `Outland_HairColor_BrightViridian`, `Outland_HairColor_BrightYellow`, `Outland_HairColor_DarkAzure`, `Outland_HairColor_DarkBlue`, `Outland_HairColor_DarkGreen`, `Outland_HairColor_DarkLime`, `Outland_HairColor_DarkMagenta`, `Outland_HairColor_DarkOrange`, `Outland_HairColor_DarkPink`, `Outland_HairColor_DarkPurple`, `Outland_HairColor_DarkRed`, `Outland_HairColor_DarkSage`, `Outland_HairColor_DarkViridian`, `Outland_HairColor_DarkYellow`
- hair style (6): `Outland_BaldFemale`, `Outland_BaldMale`, `Outland_ChitinousSkin`, `Outland_ChitinousSkinTinted`, `Outland_Headbone_ArmouredPlates`, `Outland_Headbone_Leafy`
- beard (6): `Outland_Beard_FurryOnly`, `Outland_BovineHead`, `Outland_ChitinousSkin`, `Outland_ChitinousSkinTinted`, `Outland_DraconicHead`, `Outland_RattyHead`
- head shape (20): `Outland_ArachnidHead`, `Outland_BovineHead`, `Outland_CanidHead`, `Outland_CephalomorphHead`, `Outland_ChitinousSkin`, `Outland_ChitinousSkinTinted`, `Outland_DestinyMarks`, `Outland_DraconicHead`, `Outland_FelineHead`, `Outland_FeybarkHead`, `Outland_GreaterGoblinoidHead`, `Outland_InsectHead`, `Outland_LesserGoblinoidHead`, `Outland_MonocularHead`, `Outland_MothHead`, `Outland_RattyHead`, `Outland_ScaleSkin`, `Outland_SvelteHead`, `Outland_TermiteHead`, `Outland_TrencherHead`
- drawn (ears, tails, horns, marks, wings...) (202): `Outland_Antenna_Feather`, `Outland_Antenna_Fluted`, `Outland_Antenna_Jointed`, `Outland_Antenna_Leaf`, `Outland_Antenna_Owl`, `Outland_Antenna_Segmented`, `Outland_Antenna_Socketed`, `Outland_ArachnidEyes_Blue`, `Outland_ArachnidEyes_Brown`, `Outland_ArachnidEyes_Cyan`, `Outland_ArachnidEyes_Gray`, `Outland_ArachnidEyes_Green`, `Outland_ArachnidEyes_LightBlue`, `Outland_ArachnidEyes_Lime`, `Outland_ArachnidEyes_Magenta`, `Outland_ArachnidEyes_Orange`, `Outland_ArachnidEyes_Pink`, `Outland_ArachnidEyes_Purple`, `Outland_ArachnidEyes_Red`, `Outland_ArachnidEyes_White`, `Outland_ArachnidEyes_Yellow`, `Outland_Back_FeathersBlack`, `Outland_Back_FeathersWhite`, `Outland_Beak_Hooked`, `Outland_Beak_PointedBeak`, `Outland_Beak_ShortBeak`, `Outland_BumFluff`, `Outland_Chest_Fur`, `Outland_ChinHorns`, `Outland_ChitinousSkin`, `Outland_ChitinousSkinTinted`, `Outland_CompositeEyes`, `Outland_CompositeEyes_Blue`, `Outland_CompositeEyes_Brown`, `Outland_CompositeEyes_Cyan`, `Outland_CompositeEyes_Gray`, `Outland_CompositeEyes_Green`, `Outland_CompositeEyes_LightBlue`, `Outland_CompositeEyes_Lime`, `Outland_CompositeEyes_Magenta`, `Outland_CompositeEyes_Orange`, `Outland_CompositeEyes_Pink`, `Outland_CompositeEyes_Purple`, `Outland_CompositeEyes_Red`, `Outland_CompositeEyes_White`, `Outland_CompositeEyes_Yellow`, `Outland_DestinyMarks`, `Outland_DistinctCheekbones`, `Outland_Ears_Akhkharu`, `Outland_Ears_BigEars`, `Outland_Ears_Bun`, `Outland_Ears_Curved`, `Outland_Ears_Doe`, `Outland_Ears_Fey`, `Outland_Ears_FlatPointed`, `Outland_Ears_Fleef`, `Outland_Ears_Flick`, `Outland_Ears_Flufftop`, `Outland_Ears_Foxie`, `Outland_Ears_Furred`, `Outland_Ears_Goblinoid`, `Outland_Ears_Jackal`, `Outland_Ears_Large`, `Outland_Ears_Nyoom`, `Outland_Ears_Ratty`, `Outland_Ears_Rounded`, `Outland_Ears_Serrated`, `Outland_Ears_Swish`, `Outland_Ears_Teddy`, `Outland_Ears_Ventral`, `Outland_Ears_Vigilant`, `Outland_Ears_Webbed`, `Outland_Ears_Wild`, `Outland_Ears_Woosh`, `Outland_ElvenEars`, `Outland_EyeVisual_Recessed`, `Outland_Eye_Blue`, `Outland_Eye_Brown`, `Outland_Eye_Cyan`, `Outland_Eye_Green`, `Outland_Eye_LightBlue`, `Outland_Eye_Lime`, `Outland_Eye_Magenta`, `Outland_Eye_Orange`, `Outland_Eye_Pink`, `Outland_Eye_Purple`, `Outland_Eye_White`, `Outland_Eye_Yellow`, `Outland_FaceTendrils`, `Outland_Furbody`, `Outland_Headbone_Antler`, `Outland_Headbone_ArmouredPlates`, `Outland_Headbone_Bean`, `Outland_Headbone_Benevolent`, `Outland_Headbone_Bonfire`, `Outland_Headbone_Bulb`, `Outland_Headbone_Bull`, `Outland_Headbone_Cherub`, `Outland_Headbone_Crescent`, `Outland_Headbone_CrownArcuate`, `Outland_Headbone_CrownClaws`, `Outland_Headbone_CrownHalberd`, `Outland_Headbone_CrownHandles`, `Outland_Headbone_CrownPhalanx`, `Outland_Headbone_CrownPredacious`, `Outland_Headbone_CrownReptile`, `Outland_Headbone_CrownSpinous`, `Outland_Headbone_Crystal`, `Outland_Headbone_Daemon`, `Outland_Headbone_DevilsTwist`, `Outland_Headbone_Dragon`, `Outland_Headbone_Drop`, `Outland_Headbone_Fawn`, `Outland_Headbone_Flame`, `Outland_Headbone_Forward`, `Outland_Headbone_Heart`, `Outland_Headbone_King`, `Outland_Headbone_Laurel`, `Outland_Headbone_Leafy`, `Outland_Headbone_LongProng`, `Outland_Headbone_PlatedUni`, `Outland_Headbone_Raffe`, `Outland_Headbone_Ram`, `Outland_Headbone_Rookie`, `Outland_Headbone_Rough`, `Outland_Headbone_Row`, `Outland_Headbone_Scalloped`, `Outland_Headbone_SmallUni`, `Outland_Headbone_SmolUni`, `Outland_Headbone_Splash`, `Outland_Headbone_Spring`, `Outland_Headbone_Straw`, `Outland_Headbone_Strong`, `Outland_Headbone_Thorn`, `Outland_Headbone_TwoProng`, `Outland_Headbone_Zilla`, `Outland_Headbone_ZillaEx`, `Outland_InsectBody`, `Outland_JawTusks`, `Outland_LongMouth`, `Outland_MonocularEye_Blue`, `Outland_MonocularEye_Brown`, `Outland_MonocularEye_Cyan`, `Outland_MonocularEye_Gray`, `Outland_MonocularEye_Green`, `Outland_MonocularEye_LightBlue`, `Outland_MonocularEye_Lime`, `Outland_MonocularEye_Magenta`, `Outland_MonocularEye_Orange`, `Outland_MonocularEye_Pink`, `Outland_MonocularEye_Purple`, `Outland_MonocularEye_Red`, `Outland_MonocularEye_White`, `Outland_MonocularEye_Yellow`, `Outland_NeckRuffle_Curly`, `Outland_NeckRuffle_Fuzzy`, `Outland_NeckRuffle_Spikey`, `Outland_NeckRuffle_Wavy`, `Outland_Nose_Akhkharu`, `Outland_Nose_BigNose`, `Outland_Nose_Goblinoid`, `Outland_Nose_Leathery`, `Outland_Nose_NoseSlits`, `Outland_RidgedSkin`, `Outland_ScaleSkin`, `Outland_Scalebody`, `Outland_Tail_Curly`, `Outland_Tail_Flame`, `Outland_Tail_Flop`, `Outland_Tail_Fluffage`, `Outland_Tail_Furball`, `Outland_Tail_Hook`, `Outland_Tail_Imp`, `Outland_Tail_Kink`, `Outland_Tail_Layered`, `Outland_Tail_Leathery`, `Outland_Tail_Plated`, `Outland_Tail_Pointed`, `Outland_Tail_Pom`, `Outland_Tail_Ratty`, `Outland_Tail_Rolled`, `Outland_Tail_Spray`, `Outland_Tail_Torrent`, `Outland_Teeth_Mandibles`, `Outland_Teeth_TusksLarge`, `Outland_Teeth_TusksSmall`, `Outland_Wings_Angel`, `Outland_Wings_Bird`, `Outland_Wings_Devil`, `Outland_Wings_FallenAngel`, `Outland_Wings_Fey`, `Outland_Wings_FlareBlue`, `Outland_Wings_FlareGreen`, `Outland_Wings_FlareRed`, `Outland_Wings_GlassyBlue`, `Outland_Wings_Imp`, `Outland_Wings_Insect`, `Outland_Wings_Plain`, `Outland_Wings_Pointed`, `Outland_Wings_Roundel`, `Outland_Wings_Striped`, `Outland_Wings_Wyvern`

## No Longer Human-Core (262)

Workshop id 3777374986.

- skin colour (190): `Skin_Aegean`, `Skin_Alpine`, `Skin_Amethyst`, `Skin_AncientCopper`, `Skin_Apatite`, `Skin_Aquamarine`, `Skin_ArmyGreen`, `Skin_Azalea`, `Skin_BitterRed`, `Skin_BlackIce`, `Skin_Blackberry`, `Skin_BlueGreen`, `Skin_BlueIce`, `Skin_BlueViolet`, `Skin_Blueberry`, `Skin_BogDweller`, `Skin_BoneWhite`, `Skin_BurntOrange`, `Skin_BurntRed`, `Skin_Caracal`, `Skin_Carrot`, `Skin_Cerulean`, `Skin_Charcoal`, `Skin_Cherry`, `Skin_ChthonicAmethyst`, `Skin_ChthonicBlue`, `Skin_ChthonicPurple`, `Skin_CloudyCrystal`, `Skin_Coffee`, `Skin_Cornflower`, `Skin_Crabshell`, `Skin_Dandelion`, `Skin_DarkPink`, `Skin_DeepLavender`, `Skin_DeepSea`, `Skin_DeepTeal`, `Skin_DeepUmber`, `Skin_DirtyBronze`, `Skin_DraconicMauve`, `Skin_DraconicOrange`, `Skin_DraconicRed`, `Skin_DraconicRose`, `Skin_DustyGreen`, `Skin_DustyPink`, `Skin_DustyPurple`, `Skin_DustySeafoam`, `Skin_DustyShell`, `Skin_FadingCrystal`, `Skin_FoolsGold`, `Skin_FrogBlue`, `Skin_FrogGreen`, `Skin_FrogIndigo`, `Skin_FrogLime`, `Skin_FrogOrange`, `Skin_FrogPine`, `Skin_FrogPurple`, `Skin_FrogRed`, `Skin_FrogSeafoam`, `Skin_FrogYellow`, `Skin_Frost`, `Skin_Ginger`, `Skin_GoblinGreen`, `Skin_Gold`, `Skin_Gorgonops`, `Skin_Grape`, `Skin_GreenGem`, `Skin_GrimBlue`, `Skin_GrimBrown`, `Skin_GrimGold`, `Skin_GrimGreen`, `Skin_GrimPurple`, `Skin_GrimRose`, `Skin_GrimTeal`, `Skin_GrimViolet`, `Skin_GrimYellow`, `Skin_GrizzlyBrown`, `Skin_Guava`, `Skin_Heather`, `Skin_Hemlock`, `Skin_Honey`, `Skin_HotPink`, `Skin_Iceberg`, `Skin_InsectBlue`, `Skin_InsectGreen`, `Skin_InsectOrange`, `Skin_InsectPink`, `Skin_InsectPurple`, `Skin_InsectRed`, `Skin_InsectRose`, `Skin_InsectTeal`, `Skin_InsectYellow`, `Skin_Iron`, `Skin_KraaVok`, `Skin_LakeBlue`, `Skin_Lapis`, `Skin_Larvikite`, `Skin_LavenderPink`, `Skin_LeatheryBeige`, `Skin_LeatheryMagenta`, `Skin_LeatheryOrange`, `Skin_LeatheryPink`, `Skin_LeatheryRed`, `Skin_LeatheryYellow`, `Skin_Lilac`, `Skin_Lime`, `Skin_LizardBlue`, `Skin_LizardGreen`, `Skin_Lycoris`, `Skin_Magenta`, `Skin_Mahogany`, `Skin_Malachite`, `Skin_Mango`, `Skin_Mauve`, `Skin_Megaspider`, `Skin_MidGray`, `Skin_MistyBlue`, `Skin_MountainAmber`, `Skin_MountainAmethyst`, `Skin_MountainCopper`, `Skin_MountainElectrum`, `Skin_MountainLapis`, `Skin_MountainSapphire`, `Skin_Muck`, `Skin_Mulberry`, `Skin_Mushroom`, `Skin_Mustard`, `Skin_Nectar`, `Skin_NeonPink`, `Skin_NeonTeal`, `Skin_Ochre`, `Skin_Ogre`, `Skin_Olivine`, `Skin_OrangeHibiscus`, `Skin_Orchid`, `Skin_PaleBlue`, `Skin_PaleGreen`, `Skin_PallidOrange`, `Skin_PastelGreen`, `Skin_PastelPink`, `Skin_Peach`, `Skin_Peppermint`, `Skin_Porcine`, `Skin_Raspberry`, `Skin_RawMeat`, `Skin_RedBrown`, `Skin_RedHibiscus`, `Skin_RedSand`, `Skin_Reptiloid`, `Skin_Rhubarb`, `Skin_Ruddy`, `Skin_Rust`, `Skin_RusticBrown`, `Skin_Sage`, `Skin_Salmon`, `Skin_SandyBronze`, `Skin_SandyBrown`, `Skin_SandyCopper`, `Skin_SandyOrange`, `Skin_SandyYellow`, `Skin_Seagrape`, `Skin_Shaddock`, `Skin_Sherbet`, `Skin_SilverBullet`, `Skin_SlimyGrass`, `Skin_SlimyLizard`, `Skin_SlimyWeed`, `Skin_SmokyBlue`, `Skin_SoftOrange`, `Skin_Spearmint`, `Skin_Spelopede`, `Skin_Spice`, `Skin_StormGray`, `Skin_Sunset`, `Skin_Swampy`, `Skin_Taupe`, `Skin_Toad`, `Skin_Tobacco`, `Skin_TropicalLime`, `Skin_TutuPink`, `Skin_Tyrian`, `Skin_Unripened`, `Skin_VelNar`, `Skin_VerdantLeaf`, `Skin_VerdantMoss`, `Skin_Verdelite`, `Skin_VibrantBlue`, `Skin_WarmAsh`, `Skin_Watermelon`, `Skin_Wisteria`, `Skin_YellowHibiscus`
- hair colour (72): `Hair_Ash`, `Hair_AspenLeaf`, `Hair_Bellflower`, `Hair_BioBlue`, `Hair_BioCeru`, `Hair_BioHotPink`, `Hair_BioJade`, `Hair_BioLime`, `Hair_BioOrange`, `Hair_BioPink`, `Hair_BioPurple`, `Hair_BioRed`, `Hair_BioSeaGreen`, `Hair_BioTeal`, `Hair_BioWhite`, `Hair_BioYellow`, `Hair_Blackberry`, `Hair_Blood`, `Hair_BloodOrange`, `Hair_BlueIce`, `Hair_BlueWool`, `Hair_Bluejay`, `Hair_Cordovan`, `Hair_Crabshell`, `Hair_DeepAlmond`, `Hair_DesertFlower`, `Hair_DustyLilac`, `Hair_EarthyBrown`, `Hair_EarthyGold`, `Hair_EarthyRed`, `Hair_Elderberry`, `Hair_ElectricPurple`, `Hair_Ember`, `Hair_FairBlue`, `Hair_Fern`, `Hair_FrogBlue`, `Hair_FrogGreen`, `Hair_FrogLime`, `Hair_FrogOrange`, `Hair_FrogRed`, `Hair_FrogTeal`, `Hair_FrogTurquoise`, `Hair_FrogYellow`, `Hair_Gold`, `Hair_HotPink`, `Hair_Lapis`, `Hair_LeafGreen`, `Hair_Lilac`, `Hair_Mango`, `Hair_Mauve`, `Hair_PaleBlue`, `Hair_PaleOrange`, `Hair_Permafrost`, `Hair_RedWalnut`, `Hair_Rosy`, `Hair_Sherbet`, `Hair_ShimmeringCyan`, `Hair_ShimmeringMagenta`, `Hair_ShimmeringPink`, `Hair_ShimmeringViolet`, `Hair_ShimmeringYellow`, `Hair_SnowySilver`, `Hair_StormCloud`, `Hair_SummerGreen`, `Hair_Tanager`, `Hair_TealGreen`, `Hair_Tulip`, `Hair_Turquoise`, `Hair_Verdant`, `Hair_WarmAsh`, `Hair_WhiteGray`, `Hair_Wisteria`

## Biotech Cosmetic Kit - Horns Halos and More (176)

Workshop id 2985847757.

- skin colour (11): `MMSkin_Burgundy`, `MMSkin_DeepGreen`, `MMSkin_DeepPurple`, `MMSkin_Golden`, `MMSkin_Lilac`, `MMSkin_PaleBlue`, `MMSkin_PaleGreen`, `MMSkin_PaleLilac`, `MMSkin_PalePurple`, `MMSkin_Pinkie`, `MMSkin_Teal`
- hair colour (8): `MMHair_Auburn`, `MMHair_BrimstoneHair`, `MMHair_Dark Purple`, `MMHair_LightBlue`, `MMHair_Minty`, `MMHair_Peachy`, `MMHair_Pinkie`, `MMHair_SwampyGreen`
- hair style (2): `MM_HeadTendrils`, `MM_HeadTendrilsStriped`
- body (9): `MMWings_FeatheredWaist`, `MMWings_FeatheredWaistDark`, `MMWings_FeatheredWaistH`, `MMWings_Seraph`, `MMWings_SeraphDark`, `MMWings_SeraphH`, `MMWings_Waist`, `MMWings_WaistDark`, `MMWings_WaistH`
- drawn (ears, tails, horns, marks, wings...) (157): `MMAura_DarkRedGlory`, `MMAura_GoldenGlory`, `MMEars_DroopyElf`, `MMEars_Elf`, `MMEars_Fishy`, `MMEars_FluffyDog`, `MMEars_Frilled`, `MMEars_Goblin`, `MMEars_KittyEars`, `MMEars_KittyEarsStriped`, `MMEars_Round`, `MMEyes_Black`, `MMEyes_Blue`, `MMEyes_Brown`, `MMEyes_Golden`, `MMEyes_Gray`, `MMEyes_Green`, `MMEyes_HotPink`, `MMEyes_Orange`, `MMEyes_Pink`, `MMEyes_Purple`, `MMEyes_Rainbow`, `MMEyes_Red`, `MMEyes_Teal`, `MMEyes_White`, `MMEyes_Yellow`, `MMHorns_Abstract`, `MMHorns_AbstractDark`, `MMHorns_AbstractKeratin`, `MMHorns_Crescent`, `MMHorns_CrescentDark`, `MMHorns_CrescentKeratin`, `MMHorns_DoubleCrown`, `MMHorns_DoubleCrownDark`, `MMHorns_DoubleCrownKeratin`, `MMHorns_Downturned`, `MMHorns_DownturnedDark`, `MMHorns_DownturnedKeratin`, `MMHorns_Forehead`, `MMHorns_ForeheadDark`, `MMHorns_ForeheadKeratin`, `MMHorns_FrontCurvedHorns`, `MMHorns_FrontCurvedHornsDark`, `MMHorns_FrontCurvedHornsKeratin`, `MMHorns_Great`, `MMHorns_GreatCurly`, `MMHorns_GreatCurlyDark`, `MMHorns_GreatCurlyKeratin`, `MMHorns_GreatDark`, `MMHorns_GreatKeratin`, `MMHorns_GreatScorpio`, `MMHorns_GreatScorpioDark`, `MMHorns_GreatScorpioKeratin`, `MMHorns_GreatSideways`, `MMHorns_GreatSidewaysDark`, `MMHorns_GreatSidewaysKeratin`, `MMHorns_Heart`, `MMHorns_HeartDark`, `MMHorns_HeartKeratin`, `MMHorns_LittleCurly`, `MMHorns_LittleCurlyDark`, `MMHorns_LittleCurlyKeratin`, `MMHorns_LittleSideways`, `MMHorns_LittleSidewaysDark`, `MMHorns_LittleSidewaysKeratin`, `MMHorns_Matriarch`, `MMHorns_MatriarchDark`, `MMHorns_MatriarchKeratin`, `MMHorns_Nubby`, `MMHorns_NubbyDA`, `MMHorns_NubbyDark`, `MMHorns_NubbyFA`, `MMHorns_NubbyKA`, `MMHorns_NubbyKeratin`, `MMHorns_PiercedSpiral`, `MMHorns_PiercedSpiralDark`, `MMHorns_PiercedSpiralKeratin`, `MMHorns_Pisces`, `MMHorns_PiscesDark`, `MMHorns_PiscesKeratin`, `MMHorns_PointyNubs`, `MMHorns_PointyNubsDark`, `MMHorns_PointyNubsKeratin`, `MMHorns_Random`, `MMHorns_RandomDark`, `MMHorns_RandomKeratin`, `MMHorns_Scorpio`, `MMHorns_ScorpioDark`, `MMHorns_ScorpioKeratin`, `MMHorns_Tall`, `MMHorns_TallDark`, `MMHorns_TallKeratin`, `MMHorns_Twirly`, `MMHorns_TwirlyDark`, `MMHorns_TwirlyKeratin`, `MMHorns_Upright`, `MMHorns_UprightDark`, `MMHorns_UprightKeratin`, `MMHorns_Wicked`, `MMHorns_WickedDark`, `MMHorns_WickedKeratin`, `MMNose_Hollow`, `MMNose_LittleAnimal`, `MMNose_Slit`, `MMNose_Strong`, `MMTail_Club`, `MMTail_Diamond`, `MMTail_Frilled`, `MMTail_Heart`, `MMTail_Spade`, `MMTail_Twirly`, `MMWings_Angel`, `MMWings_AngelDark`, `MMWings_AngelH`, `MMWings_ArchAngel`, `MMWings_ArchAngelDark`, `MMWings_ArchAngelH`, `MMWings_ArchDemon`, `MMWings_ArchDemonDark`, `MMWings_ArchDemonH`, `MMWings_Demon`, `MMWings_Demon (Dark)`, `MMWings_DemonH`, `MMWings_Fairy`, `MMWings_FeatheredWaist`, `MMWings_FeatheredWaistDark`, `MMWings_FeatheredWaistH`, `MMWings_Seraph`, `MMWings_SeraphDark`, `MMWings_SeraphH`, `MMWings_Waist`, `MMWings_WaistDark`, `MMWings_WaistH`, `MM_CrookedHalo`, `MM_CrookedHaloSilver`, `MM_GreatHalo`, `MM_GreatHaloSilver`, `MM_GreatSplitHalo`, `MM_GreatSplitHaloSilver`, `MM_Halo`, `MM_HaloSilver`, `MM_HeadTendrils`, `MM_HeadTendrilsStriped`, `MM_JawSpikesFleshy`, `MM_JawSpikesKeratin`, `MM_MiniJawStudsFleshy`, `MM_MiniJawStudsKeratin`, `MM_NoseRidgeF`, `MM_NoseRidgeK`, `MM_RandomHalo`, `MM_RandomHaloSilver`, `MM_SharpCheekbones`, `MM_SplitHalo`, `MM_SplitHaloSilver`, `MM_Unihorn`, `MM_UnihornDark`, `MM_UnihornKeratin`

## Alpha Genes (138)

Workshop id 2891845502.

- skin colour (21): `AG_FungalSkin`, `AG_Sensitivity_Lethal`, `AG_Shambler_VeryGaunt`, `AG_Skin_BlueFish`, `AG_Skin_DeepBlue`, `AG_Skin_DeepBlueFish`, `AG_Skin_DeepGreen`, `AG_Skin_DeepPurple`, `AG_Skin_DeeperRed`, `AG_Skin_Drakonori_PaleBlue`, `AG_Skin_Drakonori_PaleRed`, `AG_Skin_Gold`, `AG_Skin_PaleBlueFish`, `AG_Skin_PlantGreen`, `AG_Skin_Rot`, `AG_Skin_Silver`, `AG_Skin_TrueBlack`, `AG_SlimeBody`, `AG_VFEI_InsectoidSkin`, `AG_VFEI_VatGrownInsectoidSkin`, `VRE_SkinColor_OcularBark`
- hair colour (5): `AG_Hair_DeepOrange`, `AG_Hair_DeepRed`, `AG_Hair_Golden`, `AG_Hair_PaleGreen`, `VRE_HairColor_Ocular`
- hair style (8): `AG_AerofleetHead`, `AG_CancerousFace`, `AG_HornCrown`, `AG_NereidHead`, `AG_RockSpurs`, `AG_Shambler_VeryGaunt`, `AG_SlugFace`, `AG_UpperTentacles`
- beard (7): `AG_AerofleetHead`, `AG_FaceTentacles`, `AG_FoxFace`, `AG_NereidHead`, `AG_RockSpurs`, `AG_SlugFace`, `AG_VFEI_InsectoidMandibles`
- head shape (12): `AG_CancerousFace`, `AG_DrakonoriHead`, `AG_FeraliskEyes`, `AG_FoxFace`, `AG_NereidHead`, `AG_RockSpurs`, `AG_Shambler_VeryGaunt`, `AG_Skin_Gold`, `AG_Skin_Silver`, `AG_Skin_TrueBlack`, `AG_SlugFace`, `AG_VeryGauntHead`
- drawn (ears, tails, horns, marks, wings...) (107): `AG_AcidFangs`, `AG_AerofleetHead`, `AG_AnimusEars`, `AG_AntlerHorns`, `AG_BatWings`, `AG_BeeMandibles`, `AG_BeetleMandibles`, `AG_BodyTentacles`, `AG_BoomNodules`, `AG_BullHorns`, `AG_BumbledroneWings`, `AG_CancerousBody`, `AG_ChainsawHands`, `AG_ChameleonYakHorns`, `AG_CrabClaw`, `AG_DemonEars`, `AG_DemonHorns`, `AG_DemonHornsQuadruple`, `AG_DemonTail`, `AG_DemonWings`, `AG_DevilEyes`, `AG_DevilsheepHorns`, `AG_DownwardsAntennas`, `AG_DrainerWings`, `AG_DrakonoriBody`, `AG_DrakonoriWings`, `AG_Drakonori_Horns`, `AG_Drakonori_Tail`, `AG_EarWings`, `AG_EldritchHorns`, `AG_EyeOfShubNiggurath`, `AG_FaceTentacles`, `AG_FeatheredWings`, `AG_FeraliskEyes`, `AG_FleshBulb`, `AG_FleshSack`, `AG_FleshSpitter`, `AG_FormicAntennas`, `AG_ForsakenBody`, `AG_ForsakenBodyEmblem`, `AG_ForsakenEyes`, `AG_ForsakenHead`, `AG_ForsakenHeadEmblem`, `AG_ForsakenHornsBull`, `AG_ForsakenHornsCrown`, `AG_ForsakenHornsDevil`, `AG_ForsakenHornsGoat`, `AG_ForsakenHornsReptilian`, `AG_ForsakenHornsSheep`, `AG_ForsakenQuadruple`, `AG_FoxTail`, `AG_FungalClumps`, `AG_FungalSprout`, `AG_FungalTentacles`, `AG_GauntBody`, `AG_GreaterFleshWhip`, `AG_GreaterToughspikes`, `AG_HeavilyScarred`, `AG_HornCrown`, `AG_LongEars`, `AG_LowerAntennas`, `AG_MothAntennae`, `AG_MothWings`, `AG_NearBlindness`, `AG_NereidBody`, `AG_NereidFins`, `AG_NereidGlowlure`, `AG_NereidHead`, `AG_NereidTail`, `AG_OrnateEldritchHorns`, `AG_OutwardsAntennas`, `AG_PegasusWings`, `AG_PincerMandibles`, `AG_Proboscis`, `AG_RadYakEars`, `AG_RainbowWings`, `AG_RayHoundTentacles`, `AG_RockSpurs`, `AG_RockyBody`, `AG_RoxHorns`, `AG_RoxPelt`, `AG_ScalyBody`, `AG_ScytherHands`, `AG_Shambler_Acidic`, `AG_Shambler_Exploding`, `AG_SingleEar`, `AG_SingleWing`, `AG_Skin_Gold`, `AG_Skin_Silver`, `AG_Skin_TrueBlack`, `AG_SlimeBody`, `AG_SlugBody`, `AG_Stalks`, `AG_TentacleHorns`, `AG_TerrorMask`, `AG_TetraCoils`, `AG_ThirdEye`, `AG_Tusks`, `AG_TwitchingFingerspike`, `AG_TwitchingToughspikes`, `AG_TwitchingTrispikes`, `AG_UpperTentacles`, `AG_VFEI_Antennae`, `AG_VFEI_InsectoidMandibles`, `AG_VFEI_SegmentedEyes`, `AG_VenomFangs`, `AG_WaspWings`
- other cosmetic category (4): `AG_Digitigrade`, `AG_NoAntennae`, `AG_NoLowerAntennae`, `AG_NoTusks`

## WVC - Xenotypes and Genes (113)

Workshop id 2886992038.

- skin colour (26): `WVC_SkinColor_Any`, `WVC_SkinColor_Coral`, `WVC_SkinColor_DarkBlue`, `WVC_SkinColor_DemonRed`, `WVC_SkinColor_FleshPink`, `WVC_SkinColor_FleshRed`, `WVC_SkinColor_GlacialIce`, `WVC_SkinColor_Granite`, `WVC_SkinColor_Limestone`, `WVC_SkinColor_Marble`, `WVC_SkinColor_Metal`, `WVC_SkinColor_MilkWhite`, `WVC_SkinColor_OldBones`, `WVC_SkinColor_Rusted`, `WVC_SkinColor_Sand`, `WVC_SkinColor_Sandstone`, `WVC_SkinColor_Slate`, `WVC_SkinColor_Undead`, `WVC_SkinColor_b4c8ff_HEX`, `WVC_SkinColor_b4fff0_HEX`, `WVC_SkinColor_c8b4ff_HEX`, `WVC_SkinColor_c8ffb4_HEX`, `WVC_SkinColor_ffb4b4_HEX`, `WVC_SkinColor_ffb4dc_HEX`, `WVC_SkinColor_ffdcb4_HEX`, `WVC_SkinColor_fffab4_HEX`
- hair colour (18): `WVC_HairColor_Anomaly`, `WVC_HairColor_Coral`, `WVC_HairColor_GlacialIce`, `WVC_HairColor_Granite`, `WVC_HairColor_Limestone`, `WVC_HairColor_Marble`, `WVC_HairColor_Sand`, `WVC_HairColor_Sandstone`, `WVC_HairColor_Slate`, `WVC_HairColor_Undead`, `WVC_HairColor_b4c8ff_HEX`, `WVC_HairColor_b4fff0_HEX`, `WVC_HairColor_c8b4ff_HEX`, `WVC_HairColor_c8ffb4_HEX`, `WVC_HairColor_ffb4b4_HEX`, `WVC_HairColor_ffb4dc_HEX`, `WVC_HairColor_ffdcb4_HEX`, `WVC_HairColor_fffab4_HEX`
- hair style (5): `WVC_Hair_NonBald`, `WVC_Hair_PunkOnly`, `WVC_Hair_TribalOnly`, `WVC_HeadTentacles0c`, `WVC_SemifurSkin`
- beard (1): `WVC_DryadSkin`
- head shape (13): `WVC_BoneSkin`, `WVC_DryadSkin`, `WVC_FleshmassSkin`, `WVC_GauntSkin`, `WVC_GhoulSkin`, `WVC_NodeSkin`, `WVC_PatchSkin`, `WVC_RuneSkin`, `WVC_SemifurSkin`, `WVC_ShapeshiftSkin`, `WVC_StoneSkin`, `WVC_SyntSkin`, `WVC_TransparentSkin`
- body (1): `WVC_SyntSkin`
- drawn (ears, tails, horns, marks, wings...) (44): `WVC_BioferriteGrowths`, `WVC_BodyTentacles`, `WVC_BoneTailA`, `WVC_CatEarsA`, `WVC_CatTailA`, `WVC_CatTailB`, `WVC_ChestFur`, `WVC_CyberSkin`, `WVC_DemonTailA`, `WVC_DragonTailA`, `WVC_Ears_DoublePointedA`, `WVC_Ears_PointedA`, `WVC_Ears_PointedB`, `WVC_Eyes_Boneskin`, `WVC_Eyes_Colorful`, `WVC_Eyes_Holoeyes`, `WVC_FeatherSkin`, `WVC_FoxEarsA`, `WVC_HalfBone`, `WVC_HeadBoneBighorns`, `WVC_HeadBoneCurveHorns`, `WVC_HeadBoneDoubleHorn`, `WVC_HeadBoneHorns`, `WVC_HeadSkinHornB`, `WVC_HeadSkinHorns`, `WVC_HeadTentacles0c`, `WVC_LizardTailA`, `WVC_LongTentacleTail`, `WVC_MechaAI_SoftwareManipulation`, `WVC_MechaSkin`, `WVC_Mecha_AntennaTail`, `WVC_Mecha_ConnectorTail`, `WVC_Mecha_EarsCat`, `WVC_Mecha_RedFormerEarsDouble`, `WVC_Mecha_RedFormerSpikesDouble`, `WVC_Mecha_ScytheTail`, `WVC_Mecha_YellowFormerAntennaDouble`, `WVC_SkinnyTailA`, `WVC_TentacleTail`, `WVC_Toughspike`, `WVC_Wings_BoneWings`, `WVC_Wings_FeatheredWings`, `WVC_Wings_MembranousWings`, `WVC_Wings_TentacleWings`
- other cosmetic category (9): `WVC_BodySize_Average`, `WVC_BodySize_ChildlikeSmall`, `WVC_BodySize_Large`, `WVC_BodySize_Small`, `WVC_Chameleon`, `WVC_Feminine`, `WVC_HairColoredSkin`, `WVC_Mecha_NoTail`, `WVC_Wings_Baseliner`

## Star Wars Xenotypes (95)

Workshop id 2915192253.

- skin colour (9): `guy762_Skin_BrightGreen`, `guy762_Skin_DarkGreen`, `guy762_Skin_Lavender`, `guy762_Skin_MidGray`, `guy762_Skin_PaleOrange`, `guy762_Skin_SelkathBlue`, `guy762_Skin_SlateBlue`, `guy762_Skin_SlateRed`, `guy762_Skin_Turquoise`
- hair colour (6): `guy762_Hair_BrightOrange`, `guy762_Hair_DarkBlue`, `guy762_Hair_DarkRed`, `guy762_Hair_Lavender`, `guy762_Hair_SlateBlue`, `guy762_Hair_SlateRed`
- beard (2): `guy762_Beard_Chops`, `guy762_Furskin_shortfur`
- head shape (19): `Head_Bone`, `Head_Devolved`, `guy762_Furskin_shortfur`, `guy762_Head_anzellan`, `guy762_Head_duros`, `guy762_Head_gand`, `guy762_Head_geonosian`, `guy762_Head_gungan`, `guy762_Head_human`, `guy762_Head_hutt`, `guy762_Head_ithorian`, `guy762_Head_kubaz`, `guy762_Head_moncal`, `guy762_Head_quarren`, `guy762_Head_rodian`, `guy762_Head_selkath`, `guy762_Head_taung`, `guy762_Head_trandoshan`, `guy762_Head_wookiee`
- body (1): `guy762_Body_gaunt`
- drawn (ears, tails, horns, marks, wings...) (60): `GS_Eyes_Orange`, `GS_Eyes_Yellow`, `guy762_AbilityGene_forcesight`, `guy762_AbilityGene_forcesight_TFS`, `guy762_Beard_chinspines`, `guy762_Beard_chintendril`, `guy762_Beard_fishmouth`, `guy762_Beard_fourtusks`, `guy762_Beard_hugetusks`, `guy762_Beard_squidmouth`, `guy762_BodyAttachment_falleen`, `guy762_Brow_Ridged`, `guy762_Brow_facespines`, `guy762_Brow_pointy`, `guy762_Ears_BigCat`, `guy762_Ears_big`, `guy762_Ears_fin`, `guy762_Ears_round`, `guy762_Ears_smallwebbed`, `guy762_Ears_webbed`, `guy762_Ears_weirdflap`, `guy762_Eyes_Big`, `guy762_Eyes_BigBlue`, `guy762_Eyes_BigGreen`, `guy762_Eyes_BigGrey`, `guy762_Eyes_BigOrange`, `guy762_Eyes_BigRed`, `guy762_Eyes_BigYellow`, `guy762_Eyes_Blue`, `guy762_Eyes_FourBig`, `guy762_Eyes_Green`, `guy762_Eyes_HugeRed`, `guy762_Eyes_HugeYellow`, `guy762_Eyes_InvertedBlue`, `guy762_Eyes_InvertedGrey`, `guy762_Eyes_InvertedOrange`, `guy762_Eyes_InvertedYellow`, `guy762_Face_jowls`, `guy762_Face_jowlsBigHead`, `guy762_Face_pointyteeth`, `guy762_Face_tusks`, `guy762_FacialRidges_broad`, `guy762_FacialRidges_bumpy`, `guy762_FacialRidges_iridonian`, `guy762_Furskin_shortfur`, `guy762_Hair_rodian`, `guy762_Headbone_BigHorns`, `guy762_Headbone_nautolan`, `guy762_Headbone_rodian`, `guy762_Headbone_taung`, `guy762_Headbone_togruta`, `guy762_Headbone_trandoshan`, `guy762_Headbone_twilek`, `guy762_Headbone_zabrak`, `guy762_Mouth_sus`, `guy762_Nose_Cat`, `guy762_Nose_Dog`, `guy762_Nose_SmallPig`, `guy762_Nose_Snout`, `guy762_Tail_hutt`

## [LFS] Genes Expanded - Hair (76)

Workshop id 3221946756.

- hair colour (76): `GEH_Hair_Almond`, `GEH_Hair_Amethyst`, `GEH_Hair_BananaSplit`, `GEH_Hair_BeesWax`, `GEH_Hair_Black`, `GEH_Hair_BlueMarlin`, `GEH_Hair_BlueSuede`, `GEH_Hair_Bluegill`, `GEH_Hair_Blurple`, `GEH_Hair_Brown`, `GEH_Hair_Bubblegum`, `GEH_Hair_Burgundy`, `GEH_Hair_BurntOrange`, `GEH_Hair_Chesnut`, `GEH_Hair_Chocolate`, `GEH_Hair_Clay`, `GEH_Hair_Cobalt`, `GEH_Hair_CoolAzul`, `GEH_Hair_CoolMint`, `GEH_Hair_Copper`, `GEH_Hair_Cranberry`, `GEH_Hair_DeepSea`, `GEH_Hair_Denim`, `GEH_Hair_DesertCamo`, `GEH_Hair_DesertSand`, `GEH_Hair_Evergreen`, `GEH_Hair_Fern`, `GEH_Hair_FireRed`, `GEH_Hair_ForgedSteel`, `GEH_Hair_Fuchsia`, `GEH_Hair_GhostGrey`, `GEH_Hair_GoldFish`, `GEH_Hair_Grape`, `GEH_Hair_Guacamole`, `GEH_Hair_Gulfstream`, `GEH_Hair_IronOre`, `GEH_Hair_IslandLagoon`, `GEH_Hair_Jade`, `GEH_Hair_Kiwi`, `GEH_Hair_Lilac`, `GEH_Hair_MarsRed`, `GEH_Hair_MauiSurf`, `GEH_Hair_Merlot`, `GEH_Hair_MidasGold`, `GEH_Hair_OakLeaf`, `GEH_Hair_Olive`, `GEH_Hair_Orchid`, `GEH_Hair_PaleLavender`, `GEH_Hair_PeaSoup`, `GEH_Hair_Plum`, `GEH_Hair_Purple`, `GEH_Hair_PurpleHeart`, `GEH_Hair_Rainforest`, `GEH_Hair_Raspberry`, `GEH_Hair_Rattan`, `GEH_Hair_Redfish`, `GEH_Hair_RegalBlue`, `GEH_Hair_Rose`, `GEH_Hair_Sage`, `GEH_Hair_SilverShiner`, `GEH_Hair_SilverSmoke`, `GEH_Hair_SmokeScreen`, `GEH_Hair_StormCloud`, `GEH_Hair_SummerSky`, `GEH_Hair_Sunset`, `GEH_Hair_Tangerine`, `GEH_Hair_Taupe`, `GEH_Hair_TaxiCab`, `GEH_Hair_Teak`, `GEH_Hair_Teal`, `GEH_Hair_TidalPool`, `GEH_Hair_TinCan`, `GEH_Hair_Violet`, `GEH_Hair_White`, `GEH_Hair_WildBlueberry`, `GEH_Hair_Yellowfin`

## [LFS] Genes Expanded - Skin Colors (75)

Workshop id 3214172563.

- skin colour (75): `GES_Skin_Almond`, `GES_Skin_Amethyst`, `GES_Skin_BananaSplit`, `GES_Skin_BeesWax`, `GES_Skin_Black`, `GES_Skin_BlueMarlin`, `GES_Skin_BlueSuede`, `GES_Skin_Bluegill`, `GES_Skin_Brown`, `GES_Skin_Bubblegum`, `GES_Skin_Burgundy`, `GES_Skin_BurntOrange`, `GES_Skin_Chesnut`, `GES_Skin_Chocolate`, `GES_Skin_Clay`, `GES_Skin_Cobalt`, `GES_Skin_CoolAzul`, `GES_Skin_CoolMint`, `GES_Skin_Copper`, `GES_Skin_Cranberry`, `GES_Skin_DeepSea`, `GES_Skin_Denim`, `GES_Skin_DesertCamo`, `GES_Skin_DesertSand`, `GES_Skin_Evergreen`, `GES_Skin_Fern`, `GES_Skin_FireRed`, `GES_Skin_ForgedSteel`, `GES_Skin_Fuchsia`, `GES_Skin_GhostGrey`, `GES_Skin_GoldFish`, `GES_Skin_Grape`, `GES_Skin_Guacamole`, `GES_Skin_Gulfstream`, `GES_Skin_IronOre`, `GES_Skin_IslandLagoon`, `GES_Skin_Jade`, `GES_Skin_Kiwi`, `GES_Skin_Lilac`, `GES_Skin_MarsRed`, `GES_Skin_MauiSurf`, `GES_Skin_Merlot`, `GES_Skin_MidasGold`, `GES_Skin_OakLeaf`, `GES_Skin_Olive`, `GES_Skin_Orchid`, `GES_Skin_PaleLavender`, `GES_Skin_PeaSoup`, `GES_Skin_Plum`, `GES_Skin_Purple`, `GES_Skin_PurpleHeart`, `GES_Skin_Rainforest`, `GES_Skin_Raspberry`, `GES_Skin_Rattan`, `GES_Skin_Redfish`, `GES_Skin_RegalBlue`, `GES_Skin_Rose`, `GES_Skin_Sage`, `GES_Skin_SilverShiner`, `GES_Skin_SilverSmoke`, `GES_Skin_SmokeScreen`, `GES_Skin_StormCloud`, `GES_Skin_SummerSky`, `GES_Skin_Sunset`, `GES_Skin_Tangerine`, `GES_Skin_Taupe`, `GES_Skin_TaxiCab`, `GES_Skin_Teak`, `GES_Skin_Teal`, `GES_Skin_TidalPool`, `GES_Skin_TinCan`, `GES_Skin_Violet`, `GES_Skin_White`, `GES_Skin_WildBlueberry`, `GES_Skin_Yellowfin`

## Paws Of Interest [ Xenotype Mod ] (74)

Workshop id 3764120996.

- skin colour (22): `PoI_ActivatedCarbon_Skin`, `PoI_AnthraciteBlack_Skin`, `PoI_BahamaBlue_Skin`, `PoI_Brown_Skin`, `PoI_Bubble_Skin`, `PoI_Buckskin_Skin`, `PoI_Chiara_Skin`, `PoI_ComfortViolet _Skin`, `PoI_Coral_Skin`, `PoI_DarkBlue_Skin`, `PoI_FurWhite_Skin`, `PoI_LightBlue_Skin`, `PoI_Lime_Skin`, `PoI_LittleGirlPink_Skin`, `PoI_Popcorn_Skin`, `PoI_Sea_Skin`, `PoI_SimpleCream_Skin`, `PoI_SoftPink_Skin`, `PoI_SubtlePurple_Skin`, `PoI_TawnyLion_Skin`, `PoI_Trout_Skin`, `PoI_UpliftingOrange_Skin`
- head shape (13): `PoI_Absol_Head`, `PoI_Eevee_Head`, `PoI_Espeon_Head`, `PoI_Flareon_Head`, `PoI_Glaceon_Head`, `PoI_Goodra_Head`, `PoI_Leafeon_Head`, `PoI_Lopunny_Head`, `PoI_Marshmallow_Head`, `PoI_Netskie_Head`, `PoI_Skitty_Head`, `PoI_Umbreon_Head`, `PoI_Vaporeon_Head`
- drawn (ears, tails, horns, marks, wings...) (39): `PoI_Absol_Fluff`, `PoI_Absol_Gem`, `PoI_Absol_Horn`, `PoI_Absol_Tail`, `PoI_Eevee_Ears`, `PoI_Eevee_Fluff`, `PoI_Eevee_Tail`, `PoI_Espeon_Ears`, `PoI_Espeon_Fluff`, `PoI_Espeon_Gem`, `PoI_Espeon_Tail`, `PoI_Flareon_Ears`, `PoI_Flareon_HeadFluff`, `PoI_Flareon_Mane`, `PoI_Flareon_Tail`, `PoI_Glaceon_Ears`, `PoI_Glaceon_FrostCrown`, `PoI_Glaceon_Tail`, `PoI_Goodra_Antennae`, `PoI_Goodra_Ears`, `PoI_Goodra_Tail`, `PoI_Leafeon_Ears`, `PoI_Leafeon_FaceTuft`, `PoI_Leafeon_Leaf`, `PoI_Leafeon_Tail`, `PoI_Lopunny_Ears`, `PoI_Lopunny_Eyebrows`, `PoI_Lopunny_Tail`, `PoI_Marshmallow_Ears`, `PoI_Marshmallow_Tail`, `PoI_Netskie_Ears`, `PoI_Netskie_Tail`, `PoI_Skitty_Ears`, `PoI_Skitty_Tail`, `PoI_Umbreon_Ears`, `PoI_Umbreon_Tail`, `PoI_Vaporeon_Collar`, `PoI_Vaporeon_Ears`, `PoI_Vaporeon_Tail`

## Anthros for Everyone (71)

Workshop id 3694051923.

- skin colour (18): `Keno_AnimaSkinDark`, `Keno_AnimaSkinLight`, `Keno_AnimaSkinMedium`, `Keno_BrownSkin`, `Keno_ChocolateSkin`, `Keno_CreamSkin`, `Keno_DarkBrownSkin`, `Keno_GauranlenSkinDark`, `Keno_GauranlenSkinLight`, `Keno_GauranlenSkinMedium`, `Keno_InkBlackSkin`, `Keno_LightBrownSkin`, `Keno_LightTanSkin`, `Keno_PolluxSkinDark`, `Keno_PolluxSkinLight`, `Keno_PolluxSkinMedium`, `Keno_SlateGraySkin`, `Keno_TanSkin`
- head shape (8): `keno.BatHeadCosmetic`, `keno.BovineHeadCosmetic`, `keno.CervineHeadBarkskinUniversal`, `keno.CervineHeadCosmetic`, `keno.ElephantHeadCosmetic`, `keno.LupineHeadCosmetic`, `keno.RodentHeadCosmetic`, `keno.SheepHeadCosmetic`
- drawn (ears, tails, horns, marks, wings...) (27): `keno.AntlersCosmetic`, `keno.BatEarsCosmetic`, `keno.BatNoseCosmetic`, `keno.BovineEarsCosmetic`, `keno.BovineNoseCosmetic`, `keno.CervineEarsCosmetic`, `keno.CervineNoseCosmetic`, `keno.ChemPustulesCosmetic`, `keno.ElephantEarsCosmetic`, `keno.ElephantNoseCosmetic`, `keno.ElephantTailCosmetic`, `keno.HideboundWingsCosmetic`, `keno.KoboldHornsLongCosmetic`, `keno.KoboldHornsLongCurlCosmetic`, `keno.KoboldHornsStubbyCosmetic`, `keno.LupineNoseCosmetic`, `keno.RabbitEarsLoppedCosmetic`, `keno.RabbitEarsStraightCosmetic`, `keno.RabbitTailCosmetic`, `keno.RatEarsCosmetic`, `keno.RatTailCosmetic`, `keno.SheepEarsCosmetic`, `keno.SheepNoseCosmetic`, `keno.ShortNoseCosmetic`, `keno.SmallTailCosmetic`, `keno.VulpineEarsCosmetic`, `keno.VulpineTailCosmetic`
- other cosmetic category (18): `keno.animaDryadDeerPack`, `keno.barkkinPackGene`, `keno.blastheartPackGene`, `keno.bonecrownPackGene`, `keno.bruxaSanguophagePack`, `keno.cloudpuffPackGene`, `keno.devilpuffPackGene`, `keno.ekkimianSanguophagePack`, `keno.forestDryadDeerPack`, `keno.haytankardPackGene`, `keno.hidewingPackGene`, `keno.hidewingPackGeneColorless`, `keno.hindhopperPackGene`, `keno.polluxDryadDeerPack`, `keno.seertuskPackGene`, `keno.strigoiSanguophagePack`, `keno.wiretailPackGene`, `keno.wiretailPackGeneColorless`

## Cyanobot's Genes (58)

Workshop id 2889844371.

- skin colour (17): `CYB_Skin_AbyssBlue`, `CYB_Skin_Auburn`, `CYB_Skin_Dove`, `CYB_Skin_Dusk`, `CYB_Skin_Hazel`, `CYB_Skin_Iris`, `CYB_Skin_Lavender`, `CYB_Skin_Lilac`, `CYB_Skin_Mahogany`, `CYB_Skin_Mauve`, `CYB_Skin_MidnightBlue`, `CYB_Skin_PaleLilac`, `CYB_Skin_PallidPink`, `CYB_Skin_Pine`, `CYB_Skin_SlateBlue`, `CYB_Skin_Thistle`, `CYB_Skin_Walnut`
- hair colour (18): `CYB_Hair_Aubergine`, `CYB_Hair_BabyBlue`, `CYB_Hair_BluePurple`, `CYB_Hair_DustyGold`, `CYB_Hair_DustyGreen`, `CYB_Hair_DustyTeal`, `CYB_Hair_Fawn`, `CYB_Hair_Grackle`, `CYB_Hair_Licorice`, `CYB_Hair_Lilac`, `CYB_Hair_MidPurple`, `CYB_Hair_MistGreen`, `CYB_Hair_Mouse`, `CYB_Hair_Peach`, `CYB_Hair_Pearl`, `CYB_Hair_PredawnBlue`, `CYB_Hair_SmokeBlue`, `CYB_Hair_Violet`
- hair style (1): `CYB_Hair_Fringeless`
- head shape (1): `CYB_FaceTuft`
- drawn (ears, tails, horns, marks, wings...) (19): `CYB_CatEars`, `CYB_CatEarsFluffy`, `CYB_CatEarsLarge`, `CYB_CatEarsRound`, `CYB_ColorTabby`, `CYB_Eyes_Cat_Amber`, `CYB_Eyes_Cat_Blue`, `CYB_Eyes_Cat_Green`, `CYB_Eyes_Cat_Red`, `CYB_Eyes_Cyan`, `CYB_Eyes_Magenta`, `CYB_Eyes_Yellow`, `CYB_HeadFrill`, `CYB_SolidColor`, `CYB_Tail_Cat`, `CYB_Tail_Leathery`, `CYB_Tail_Tiger`, `CYB_TigerTabby`, `CYB_Tusks`
- other cosmetic category (2): `CYB_Blood_Black`, `CYB_Blood_Lilac`

## Anthrosonae (58)

Workshop id 2902258418.

- skin colour (15): `ATK_AnthrobearFur`, `ATK_AnthrocatFur`, `ATK_AnthrocowFur`, `ATK_AnthrodeerFur`, `ATK_AnthrodrakeSkin`, `ATK_AnthrofoxFur`, `ATK_AnthrogoatFur`, `ATK_AnthrogriffFur`, `ATK_AnthrohorseFur`, `ATK_AnthrohyenaFur`, `ATK_AnthropandaFur`, `ATK_AnthrorabbitFur`, `ATK_AnthrosharkSkin`, `ATK_AnthrowahFur`, `ATK_AnthrowolfFur`
- hair style (15): `ATK_AnthrobearFur`, `ATK_AnthrocatFur`, `ATK_AnthrocowFur`, `ATK_AnthrodeerFur`, `ATK_AnthrodrakeSkin`, `ATK_AnthrofoxFur`, `ATK_AnthrogoatFur`, `ATK_AnthrogriffFur`, `ATK_AnthrohorseFur`, `ATK_AnthrohyenaFur`, `ATK_AnthropandaFur`, `ATK_AnthrorabbitFur`, `ATK_AnthrosharkSkin`, `ATK_AnthrowahFur`, `ATK_AnthrowolfFur`
- beard (15): `ATK_AnthrobearFur`, `ATK_AnthrocatFur`, `ATK_AnthrocowFur`, `ATK_AnthrodeerFur`, `ATK_AnthrodrakeSkin`, `ATK_AnthrofoxFur`, `ATK_AnthrogoatFur`, `ATK_AnthrogriffFur`, `ATK_AnthrohorseFur`, `ATK_AnthrohyenaFur`, `ATK_AnthropandaFur`, `ATK_AnthrorabbitFur`, `ATK_AnthrosharkSkin`, `ATK_AnthrowahFur`, `ATK_AnthrowolfFur`
- head shape (15): `ATK_AnthrobearFur`, `ATK_AnthrocatFur`, `ATK_AnthrocowFur`, `ATK_AnthrodeerFur`, `ATK_AnthrodrakeSkin`, `ATK_AnthrofoxFur`, `ATK_AnthrogoatFur`, `ATK_AnthrogriffFur`, `ATK_AnthrohorseFur`, `ATK_AnthrohyenaFur`, `ATK_AnthropandaFur`, `ATK_AnthrorabbitFur`, `ATK_AnthrosharkSkin`, `ATK_AnthrowahFur`, `ATK_AnthrowolfFur`
- drawn (ears, tails, horns, marks, wings...) (58): `ATK_AnthrobearEars`, `ATK_AnthrobearFur`, `ATK_AnthrobearTail`, `ATK_AnthrocatEars`, `ATK_AnthrocatFur`, `ATK_AnthrocatTail`, `ATK_AnthrocheeFacialStripes`, `ATK_AnthrocowEars`, `ATK_AnthrocowFur`, `ATK_AnthrocowHeadbone`, `ATK_AnthrocowHeadbone_Long`, `ATK_AnthrocowTail`, `ATK_AnthrodeerEars`, `ATK_AnthrodeerFur`, `ATK_AnthrodeerHeadbone`, `ATK_AnthrodeerHeadbone_Short`, `ATK_AnthrodeerTail`, `ATK_AnthrodrakeEars`, `ATK_AnthrodrakeHeadbone`, `ATK_AnthrodrakeHeadbone_Spiraled`, `ATK_AnthrodrakeSkin`, `ATK_AnthrodrakeTail`, `ATK_AnthrofoxEars`, `ATK_AnthrofoxFacialStripes`, `ATK_AnthrofoxFur`, `ATK_AnthrofoxTail`, `ATK_AnthrogoatEars`, `ATK_AnthrogoatEars_Droopy`, `ATK_AnthrogoatFur`, `ATK_AnthrogoatHeadbone`, `ATK_AnthrogoatHeadbone_Short`, `ATK_AnthrogoatHeadbone_Spiraled`, `ATK_AnthrogoatTail`, `ATK_AnthrogriffBackbone`, `ATK_AnthrogriffEars`, `ATK_AnthrogriffFur`, `ATK_AnthrogriffTail`, `ATK_AnthrohorseEars`, `ATK_AnthrohorseFur`, `ATK_AnthrohorseTail`, `ATK_AnthrohyenaEars`, `ATK_AnthrohyenaFur`, `ATK_AnthrohyenaTail`, `ATK_AnthropandaEars`, `ATK_AnthropandaFur`, `ATK_AnthropandaTail`, `ATK_AnthrorabbitEars`, `ATK_AnthrorabbitFur`, `ATK_AnthrorabbitTail`, `ATK_AnthrosharkEars`, `ATK_AnthrosharkSkin`, `ATK_AnthrosharkTail`, `ATK_AnthrowahEars`, `ATK_AnthrowahFur`, `ATK_AnthrowahTail`, `ATK_AnthrowolfEars`, `ATK_AnthrowolfFur`, `ATK_AnthrowolfTail`

## Seren, from Stardust [Biotech Fork] (56)

Workshop id 3726565301.

- skin colour (13): `OL_SkinAlbino`, `OL_SkinCobalt`, `OL_SkinIndigo`, `OL_SkinMagenta`, `OL_SkinNebula`, `OL_SkinOrchid`, `OL_SkinPlanetary`, `OL_SkinPlum`, `OL_SkinRouge`, `OL_SkinRoyal`, `OL_SkinTeal`, `OL_SkinTwilight`, `OL_SkinViolet`
- hair colour (19): `OL_HairAegean`, `OL_HairAlbino`, `OL_HairAmaranth`, `OL_HairBerry`, `OL_HairBlush`, `OL_HairEggplant`, `OL_HairIndigo`, `OL_HairLapis`, `OL_HairLavender`, `OL_HairLilac`, `OL_HairMauve`, `OL_HairNavy`, `OL_HairPeriwinkle`, `OL_HairPlum`, `OL_HairPowder`, `OL_HairRose`, `OL_HairSky`, `OL_HairWine`, `OL_HairWisteria`
- drawn (ears, tails, horns, marks, wings...) (23): `OL_SerenEars`, `OL_SerenEyes`, `SerenBodyMask_01`, `SerenBodyMask_02`, `SerenBodyMask_03`, `SerenBodyMask_04`, `SerenBodyMask_05`, `SerenBodyMask_06`, `SerenMarkings_Big`, `SerenMarkings_Brows`, `SerenMarkings_Cheeks`, `SerenMarkings_Freckles`, `SerenMarkings_Small`, `SerenMarkings_Target`, `SerenMarkings_Tristar`, `SerenSensors_Back`, `SerenSensors_Branched`, `SerenSensors_Curled`, `SerenSensors_Curved`, `SerenSensors_Double`, `SerenSensors_Drop`, `SerenSensors_Spike`, `SerenSensors_Tall`
- other cosmetic category (1): `OL_SerenBlood`

## Big and Small - Genes & More (54)

Workshop id 2920751126.

- skin colour (16): `BS_BorealSkin`, `BS_BurgundySkin`, `BS_CreamSkin`, `BS_DeepVioletSkin`, `BS_LightGreenSkin`, `BS_SkinBloodRed`, `BS_SkinBurningOrange`, `BS_SkinFrostWhite`, `BS_SkinPermafrost`, `BS_Skin_DarkAsh`, `BS_Skin_Marble_White`, `BS_VeryLightOrange`, `VU_DarkPallorSkin`, `VU_LightPallorSkin`, `VU_NosferatuSkin`, `VU_ZombieSkin`
- hair colour (12): `BS_BloodHair`, `BS_BurgundyHair`, `BS_CreamHair`, `BS_DeepVioletHair`, `BS_HairFrostWhite`, `BS_HairPermafrost`, `BS_Hair_DarkGray`, `BS_Hair_TrueWhite`, `BS_MatteGreenHair`, `BS_MossGreenHair`, `Hair_MediumBlue`, `Hair_MediumRed`
- hair style (6): `BS_CreepyHaired`, `BS_DevourerHead`, `BS_SatanHead`, `BS_TrollHair`, `BS_TrollHairGreat`, `BS_TrollHairShort`
- beard (6): `BS_DevourerHead`, `BS_DragonHead`, `BS_SatanHead`, `BS_StonemaskHead`, `BS_TrollBeard`, `BS_WerewolfSnoot`
- head shape (9): `BS_BrokenTitanHead`, `BS_DevourerHead`, `BS_DragonHead`, `BS_FomorialHead_Savage`, `BS_GhoulHead`, `BS_OgreHead`, `BS_SatanHead`, `BS_StonemaskHead`, `BS_WerewolfSnoot`
- body (2): `BS_BrokenTitanBody`, `BS_OgreBody`
- drawn (ears, tails, horns, marks, wings...) (12): `BS_DessicatedBodyWithGreyHair`, `BS_DessicatedBodyWithHair`, `BS_FurryBody`, `BS_FuzzyBrows`, `BS_SpiderBody`, `BS_TrollBeard`, `BS_TrollHair`, `BS_TrollHairGreat`, `BS_TrollHairShort`, `BS_TrollNose`, `BS_TrollNoseAlways`, `BS_WerewolfSnoot`
- other cosmetic category (3): `BS_DessicatedBody`, `BS_MimicBody`, `Body_Androgynous`

## [Alien/Race] Seren, from Stardust (49)

Workshop id 2704627783.

- skin colour (13): `OL_SkinAlbino`, `OL_SkinCobalt`, `OL_SkinIndigo`, `OL_SkinMajenta`, `OL_SkinNebula`, `OL_SkinOrchid`, `OL_SkinPlanetary`, `OL_SkinPlum`, `OL_SkinRouge`, `OL_SkinRoyal`, `OL_SkinTeal`, `OL_SkinTwilight`, `OL_SkinViolet`
- hair colour (19): `OL_HairAegean`, `OL_HairAlbino`, `OL_HairAmaranth`, `OL_HairBerry`, `OL_HairBlush`, `OL_HairEggplant`, `OL_HairIndigo`, `OL_HairLapis`, `OL_HairLavender`, `OL_HairLilac`, `OL_HairMauve`, `OL_HairNavy`, `OL_HairPeriwinkle`, `OL_HairPlum`, `OL_HairPowder`, `OL_HairRose`, `OL_HairSky`, `OL_HairWine`, `OL_HairWisteria`
- drawn (ears, tails, horns, marks, wings...) (17): `OL_SerenEars`, `OL_SerenEyes`, `SerenMarkings_Big`, `SerenMarkings_Brows`, `SerenMarkings_Cheeks`, `SerenMarkings_Freckles`, `SerenMarkings_Small`, `SerenMarkings_Target`, `SerenMarkings_Tristar`, `SerenSensors_Back`, `SerenSensors_Branched`, `SerenSensors_Curled`, `SerenSensors_Curved`, `SerenSensors_Double`, `SerenSensors_Drop`, `SerenSensors_Spike`, `SerenSensors_Tall`
- other cosmetic category (7): `SerenMarkings_Big`, `SerenMarkings_Brows`, `SerenMarkings_Cheeks`, `SerenMarkings_Freckles`, `SerenMarkings_Small`, `SerenMarkings_Target`, `SerenMarkings_Tristar`

## Yanzhiko Xenotype Collection (49)

Workshop id 3580656240.

- skin colour (7): `TWC_YZSkinBrown`, `TWC_YZSkinDeepBrown`, `TWC_YZSkinDeepOrange`, `TWC_YZSkinGold`, `TWC_YZSkinPaleBrown`, `TWC_YZSkinPaleMagenta`, `TWC_YZSkinPalePink`
- hair style (25): `TWC_YZHead_BZoroark`, `TWC_YZHead_Braixen`, `TWC_YZHead_Cheetah`, `TWC_YZHead_Delphox`, `TWC_YZHead_Eevee`, `TWC_YZHead_Espeon`, `TWC_YZHead_Flareon`, `TWC_YZHead_Fressalfar`, `TWC_YZHead_Gardevoir`, `TWC_YZHead_Glaceon`, `TWC_YZHead_Icephox`, `TWC_YZHead_Jaguar`, `TWC_YZHead_Jolteon`, `TWC_YZHead_Kisalfar`, `TWC_YZHead_Leafeon`, `TWC_YZHead_Leo`, `TWC_YZHead_Lombax`, `TWC_YZHead_Meowstic`, `TWC_YZHead_Panther`, `TWC_YZHead_Sylveon`, `TWC_YZHead_Tigris`, `TWC_YZHead_Umbreon`, `TWC_YZHead_Vaporeon`, `TWC_YZHead_Vulpoid`, `TWC_YZHead_WZoroark`
- beard (25): `TWC_YZHead_BZoroark`, `TWC_YZHead_Braixen`, `TWC_YZHead_Cheetah`, `TWC_YZHead_Delphox`, `TWC_YZHead_Eevee`, `TWC_YZHead_Espeon`, `TWC_YZHead_Flareon`, `TWC_YZHead_Fressalfar`, `TWC_YZHead_Gardevoir`, `TWC_YZHead_Glaceon`, `TWC_YZHead_Icephox`, `TWC_YZHead_Jaguar`, `TWC_YZHead_Jolteon`, `TWC_YZHead_Kisalfar`, `TWC_YZHead_Leafeon`, `TWC_YZHead_Leo`, `TWC_YZHead_Lombax`, `TWC_YZHead_Meowstic`, `TWC_YZHead_Panther`, `TWC_YZHead_Sylveon`, `TWC_YZHead_Tigris`, `TWC_YZHead_Umbreon`, `TWC_YZHead_Vaporeon`, `TWC_YZHead_Vulpoid`, `TWC_YZHead_WZoroark`
- head shape (25): `TWC_YZHead_BZoroark`, `TWC_YZHead_Braixen`, `TWC_YZHead_Cheetah`, `TWC_YZHead_Delphox`, `TWC_YZHead_Eevee`, `TWC_YZHead_Espeon`, `TWC_YZHead_Flareon`, `TWC_YZHead_Fressalfar`, `TWC_YZHead_Gardevoir`, `TWC_YZHead_Glaceon`, `TWC_YZHead_Icephox`, `TWC_YZHead_Jaguar`, `TWC_YZHead_Jolteon`, `TWC_YZHead_Kisalfar`, `TWC_YZHead_Leafeon`, `TWC_YZHead_Leo`, `TWC_YZHead_Lombax`, `TWC_YZHead_Meowstic`, `TWC_YZHead_Panther`, `TWC_YZHead_Sylveon`, `TWC_YZHead_Tigris`, `TWC_YZHead_Umbreon`, `TWC_YZHead_Vaporeon`, `TWC_YZHead_Vulpoid`, `TWC_YZHead_WZoroark`
- body (17): `TWC_YZBody_Braixen`, `TWC_YZBody_Cheetah`, `TWC_YZBody_Delphox`, `TWC_YZBody_Eevee`, `TWC_YZBody_Espeon`, `TWC_YZBody_Flareon`, `TWC_YZBody_Gardevoir`, `TWC_YZBody_Glaceon`, `TWC_YZBody_Icephox`, `TWC_YZBody_Jolteon`, `TWC_YZBody_Leafeon`, `TWC_YZBody_Lombax`, `TWC_YZBody_Meowstic`, `TWC_YZBody_Sylveon`, `TWC_YZBody_Umbreon`, `TWC_YZBody_Vaporeon`, `TWC_YZBody_Vulpoid`

## Meteorifics Cosmetic Gene Pack (43)

Workshop id 2903706128.

- hair style (1): `MTR_Hair_ArtificalOnly`
- drawn (ears, tails, horns, marks, wings...) (39): `MTR_Angel_Wings`, `MTR_AnimalEar_Round`, `MTR_Antenna_Downcast`, `MTR_Antenna_Hopper`, `MTR_Antenna_Insect`, `MTR_Antenna_Moth`, `MTR_Antenna_Rolypoly`, `MTR_BigEars`, `MTR_BugLegs`, `MTR_Cow_Ears`, `MTR_Demon_Wings`, `MTR_Eyes_BlueBuggo`, `MTR_Eyes_CuteCheeks`, `MTR_Eyes_CuterCheeks`, `MTR_Eyes_CuteyCheeks`, `MTR_Eyes_GreenArachnid`, `MTR_Eyes_RedArachnid`, `MTR_Eyes_Whiskers`, `MTR_Eyes_YellowBuggo`, `MTR_Headbone_AngelHalo`, `MTR_Headbone_ChaosHorns`, `MTR_Headbone_DemonHorns`, `MTR_Headbone_OniHornSingle`, `MTR_Headbone_RabbitAntenna`, `MTR_InsectMandibles`, `MTR_Lumid_Antenna`, `MTR_Lumid_Eyes`, `MTR_Lumid_Wings`, `MTR_Nose_BiteBiteTeeth`, `MTR_Nose_ClownNose`, `MTR_Nose_PointyNose`, `MTR_Nose_Squidface`, `MTR_SquidArms`, `MTR_Tail_Chaos`, `MTR_Tail_Cow`, `MTR_Tail_Demon`, `MTR_Tail_Rabbit`, `MTR_Tail_Rat`, `MTR_Tail_Rigid`
- other cosmetic category (3): `MTR_Bad_Dodger`, `MTR_Icarus_Speed`, `MTR_Manipulator`

## Erin's Cosmetic Genes (38)

Workshop id 3658223466.

- drawn (ears, tails, horns, marks, wings...) (5): `ERN_AxolotlFloof`, `ERN_AxolotlSuperFloofDuo`, `ERN_AxolotlSuperFloofSingle`, `ERN_AxolotlSuperFloofTri`, `ERN_ElfEars`
- other cosmetic category (33): `ERN_BillieHorns`, `ERN_BlitzoHorns`, `ERN_CurvedHorns`, `ERN_Ears_Bat`, `ERN_Ears_Beat`, `ERN_Ears_Bunny`, `ERN_Ears_Bunnyflop`, `ERN_Ears_Chinchilla`, `ERN_Ears_Ferret`, `ERN_Ears_Goat`, `ERN_Ears_Horse`, `ERN_Ears_Mouse`, `ERN_Ears_MouseLarge`, `ERN_Ears_MouseLargeNicked`, `ERN_Ears_Opossum`, `ERN_Ears_Raccoon`, `ERN_Ears_RedPanda`, `ERN_FaunHorns`, `ERN_MaleficentHorns`, `ERN_SpikeHorns`, `ERN_Tail_Axolotl`, `ERN_Tail_AxolotlFloofy`, `ERN_Tail_Bunny`, `ERN_Tail_Ferret`, `ERN_Tail_Goat`, `ERN_Tail_Horse`, `ERN_Tail_Lizard`, `ERN_Tail_Mouse`, `ERN_Tail_Orca`, `ERN_Tail_Raccoon`, `ERN_Tail_RedPanda`, `ERN_Tail_Skunk`, `ERN_Tail_Squirrel`

## [LTS]Xenotech (37)

Workshop id 2877887281.

- drawn (ears, tails, horns, marks, wings...) (36): `LTS_AntGaster`, `LTS_Antenna`, `LTS_AntlersLarge`, `LTS_AntlersSmall`, `LTS_BackwardHorns`, `LTS_ChameleonTail`, `LTS_DeerEars`, `LTS_DoubleHorns`, `LTS_DownTusks`, `LTS_FeatheryHipWings`, `LTS_FeatheryHipWingsLong`, `LTS_FinnedEars`, `LTS_FishTail`, `LTS_FluffyTail`, `LTS_ForwardHorns`, `LTS_FoxTail`, `LTS_FrontalHorns`, `LTS_FuzzyEars`, `LTS_HipWings`, `LTS_LongEars`, `LTS_LongHorns`, `LTS_LongTail`, `LTS_MothAntennae`, `LTS_MothWings`, `LTS_PointedEars`, `LTS_PointedShortEars`, `LTS_RoundEars`, `LTS_Scaled`, `LTS_SlugAntennae`, `LTS_SlugTail`, `LTS_SpadeTail`, `LTS_SpikedHorns`, `LTS_TwinTail`, `LTS_UpTusks`, `LTS_WaspStinger`, `LTS_Whiskers`
- other cosmetic category (5): `LTS_Antenna`, `LTS_DownTusks`, `LTS_SplitTongue`, `LTS_UpTusks`, `LTS_Whiskers`

## Helltaker Cosmetic Genes (36)

Workshop id 2955062315.

- skin colour (1): `LMSkinDemon`
- drawn (ears, tails, horns, marks, wings...) (34): `LMChestFur`, `LMChestFurCurly`, `LMChestFurTiny`, `LMEarsCerberus`, `LMEarsGoatLongBald`, `LMEarsGoatLongFur`, `LMEarsGoatSmallBald`, `LMEarsGoatSmallFur`, `LMEarsGoatTinyBald`, `LMEarsGoatTinyFur`, `LMFurSmooth`, `LMHornsAbyss`, `LMHornsAbyssAncient`, `LMHornsGoat`, `LMHornsGoatAncient`, `LMHornsJudgment`, `LMHornsJudgmentAncient`, `LMHornsKrampus`, `LMHornsKrampusAncient`, `LMHornsQueen`, `LMHornsQueenAncient`, `LMHornsRegular`, `LMHornsRegularAncient`, `LMHornsSadistic`, `LMHornsSadisticAncient`, `LMHornsTiny`, `LMHornsTinyAncient`, `LMTailDemon`, `LMTailDemonSkin`, `LMTailGoat`, `LMTailKrampus`, `LMTailKrampusFur`, `LM_Halo`, `LM_Haloheart`
- other cosmetic category (1): `LM_noHalo`

## Atlyss Races | Core (35)

Workshop id 3521335460.

- skin colour (15): `AR_Colors_Skin_Byrdle_1`, `AR_Colors_Skin_Byrdle_2`, `AR_Colors_Skin_Byrdle_3`, `AR_Colors_Skin_Chang_1`, `AR_Colors_Skin_Chang_2`, `AR_Colors_Skin_Chang_3`, `AR_Colors_Skin_Imp_1`, `AR_Colors_Skin_Imp_2`, `AR_Colors_Skin_Imp_3`, `AR_Colors_Skin_Kubold_1`, `AR_Colors_Skin_Kubold_2`, `AR_Colors_Skin_Kubold_3`, `AR_Colors_Skin_Poon_1`, `AR_Colors_Skin_Poon_2`, `AR_Colors_Skin_Poon_3`
- hair style (5): `AR_Hair_Byrdle`, `AR_Head_Chang`, `AR_Head_Imp`, `AR_Head_Kubold`, `AR_Head_Poon`
- beard (5): `AR_Hair_Byrdle`, `AR_Head_Chang`, `AR_Head_Imp`, `AR_Head_Kubold`, `AR_Head_Poon`
- head shape (5): `AR_Head_Byrdle`, `AR_Head_Chang`, `AR_Head_Imp`, `AR_Head_Kubold`, `AR_Head_Poon`
- drawn (ears, tails, horns, marks, wings...) (15): `AR_Ears_Chang`, `AR_Ears_Imp`, `AR_Ears_Kubold`, `AR_Ears_Poon`, `AR_Hair_Byrdle`, `AR_Horns_Imp`, `AR_Horns_Kubold`, `AR_Horns_Poon`, `AR_Nose_Byrdle`, `AR_Nose_Chang`, `AR_Tail_Byrdle`, `AR_Tail_Chang`, `AR_Tail_Imp`, `AR_Tail_Kubold`, `AR_Tail_Poon`

## Biotech Expansion - Mammalia (31)

Workshop id 2878084431.

- head shape (7): `BTEMa_BatHead`, `BTEMa_BovineHead`, `BTEMa_CervineHead`, `BTEMa_ElephantHead`, `BTEMa_LupineHead`, `BTEMa_RodentHead`, `BTEMa_SheepHead`
- drawn (ears, tails, horns, marks, wings...) (24): `BTEMa_Antlers`, `BTEMa_BatEars`, `BTEMa_BovineEars`, `BTEMa_CervineEars`, `BTEMa_ChemPustules`, `BTEMa_ElephantEars`, `BTEMa_HideboundWings`, `BTEMa_NoseBat`, `BTEMa_NoseBovine`, `BTEMa_NoseCervine`, `BTEMa_NoseElephant`, `BTEMa_NoseSheep`, `BTEMa_NoseShort`, `BTEMa_Nose_Lupine`, `BTEMa_RabbitEarsLopped`, `BTEMa_RabbitEarsStraight`, `BTEMa_RatEars`, `BTEMa_SheepEars`, `BTEMa_TailElephant`, `BTEMa_TailRabbit`, `BTEMa_Tail_Rat`, `BTEMa_Tail_Small`, `BTEMa_Tail_Vulpine`, `BTEMa_VulpineEars`

## FIP - WestTek (31)

Workshop id 3592202407.

- skin colour (21): `WestTek_Ash`, `WestTek_Black`, `WestTek_Blonde`, `WestTek_BlueGray`, `WestTek_Brown`, `WestTek_Cream`, `WestTek_DarkBrown`, `WestTek_Gene_Nightkin`, `WestTek_Gene_SolarPowered`, `WestTek_Golden`, `WestTek_Gray`, `WestTek_Mint`, `WestTek_Moss`, `WestTek_Olive`, `WestTek_Purple`, `WestTek_Red`, `WestTek_Rust`, `WestTek_Silver`, `WestTek_Tan`, `WestTek_Teal`, `WestTek_White`
- hair colour (20): `WestTek_Ash`, `WestTek_Black`, `WestTek_Blonde`, `WestTek_BlueGray`, `WestTek_Brown`, `WestTek_Cream`, `WestTek_DarkBrown`, `WestTek_Gene_SolarPowered`, `WestTek_Golden`, `WestTek_Gray`, `WestTek_Mint`, `WestTek_Moss`, `WestTek_Olive`, `WestTek_Purple`, `WestTek_Red`, `WestTek_Rust`, `WestTek_Silver`, `WestTek_Tan`, `WestTek_Teal`, `WestTek_White`
- hair style (1): `WestTek_Gene_SkinwalkerRaccoonShape`
- beard (2): `WestTek_Gene_Plantskin`, `WestTek_Gene_SkinwalkerRaccoonShape`
- head shape (3): `WestTek_Gene_Plantskin`, `WestTek_Gene_SkinwalkerRaccoonShape`, `WestTek_Gene_SuperMutant`
- body (1): `WestTek_Gene_SuperMutant`
- drawn (ears, tails, horns, marks, wings...) (9): `WestTek_Gene_BAja`, `WestTek_Gene_CoonEars`, `WestTek_Gene_MErowi`, `WestTek_Gene_Plantskin`, `WestTek_Gene_RUffian`, `WestTek_Gene_SLanterFeatures`, `WestTek_Gene_SNuffy`, `WestTek_Gene_SkinwalkerRaccoonShape`, `WestTek_SaplingGrowth`

## Inclusive Skin Tones 1.6 (29)

Workshop id 3551840130.

- skin colour (29): `Skin_Melanin1`, `Skin_Melanin10`, `Skin_Melanin11`, `Skin_Melanin12`, `Skin_Melanin13`, `Skin_Melanin14`, `Skin_Melanin15`, `Skin_Melanin16`, `Skin_Melanin17`, `Skin_Melanin18`, `Skin_Melanin19`, `Skin_Melanin2`, `Skin_Melanin20`, `Skin_Melanin21`, `Skin_Melanin22`, `Skin_Melanin23`, `Skin_Melanin24`, `Skin_Melanin25`, `Skin_Melanin26`, `Skin_Melanin27`, `Skin_Melanin28`, `Skin_Melanin29`, `Skin_Melanin3`, `Skin_Melanin4`, `Skin_Melanin5`, `Skin_Melanin6`, `Skin_Melanin7`, `Skin_Melanin8`, `Skin_Melanin9`

## No Longer Human-Consortium Faction Pack (29)

Workshop id 3777379164.

- drawn (ears, tails, horns, marks, wings...) (29): `BlueEyes`, `BrightEyes`, `BurntEyes`, `CaveFaceplate`, `DesertFaceplate`, `DesertHorns`, `EmeraldEyes`, `FeatherMane`, `JadeEyes`, `JungleAntlers`, `JungleFaceplate`, `LahlitFaceplate`, `LahlitMane`, `LahlitTentacles`, `MagentaEyes`, `MountainFaceplate`, `MountainFrills`, `OrangeEyes`, `PinkEyes`, `PurpleEyes`, `SnowFaceplate`, `SnowHorns`, `Stripes`, `SwampFaceplate`, `SwampQuills`, `TealEyes`, `VerticalTusks`, `VolcanicFaceplate`, `YellowEyes`

## Bagi Faction 1.6 (28)

Workshop id 3527337546.

- skin colour (5): `SkinColor_Jellyfish`, `SkinColor_SuccuBagiA`, `SkinColor_SuccuBagiB`, `SkinColor_SuccuBagiC`, `SkinColor_succujelly`
- hair colour (5): `HairColor_Jellyfish`, `HairColor_SuccuBagiA`, `HairColor_SuccuBagiB`, `HairColor_SuccuBagiC`, `HairColor_succujelly`
- hair style (1): `Hair_SuccuBagi`
- beard (4): `birdBody`, `jellyfishBody`, `spiderLegs`, `succujellyBody`
- head shape (1): `Crest`
- body (8): `Crest`, `birdBody`, `horseLegs`, `horseTail`, `jellyfishBody`, `snakeTail`, `spiderLegs`, `succujellyBody`
- drawn (ears, tails, horns, marks, wings...) (15): `Crest`, `birdBody`, `birdCheek`, `birdWing`, `horseLegs`, `horseTail`, `jellyfishCore`, `jellyfishHead`, `jellyfishWomb`, `snakeTail`, `spiderEyes`, `spiderLegs`, `succujellyCore`, `succujellyHead`, `succujellyWomb`

## Obsidia Expansion - Mothoids Xenotype (24)

Workshop id 2885653060.

- skin colour (8): `OE_Skin_SilkyBlack`, `OE_Skin_SilkyBlueNight`, `OE_Skin_SilkyBrown`, `OE_Skin_SilkyDarkBrown`, `OE_Skin_SilkyLightBrown`, `OE_Skin_SilkyPurpleNight`, `OE_Skin_SilkyRedNight`, `OE_Skin_SilkyWhite`
- hair colour (8): `OE_Hair_SilkyBlack`, `OE_Hair_SilkyBlueNight`, `OE_Hair_SilkyBrown`, `OE_Hair_SilkyDarkBrown`, `OE_Hair_SilkyLightBrown`, `OE_Hair_SilkyPurpleNight`, `OE_Hair_SilkyRedNight`, `OE_Hair_SilkyWhite`
- drawn (ears, tails, horns, marks, wings...) (8): `OE_Eyes_Moth`, `OE_Headbone_MothAntennas`, `OE_Headbone_MothAntennasAtlant`, `OE_Headbone_MothAntennasPrime`, `OE_WingsAmalgam`, `OE_WingsAtlant`, `OE_WingsMoth`, `OE_WingsPrime`

## Dr. Arch13's ArchoWonderium - The Xen Empire (24)

Workshop id 3407013231.

- beard (6): `FenFur`, `FerFur`, `FridFur`, `LogFur`, `RacFur`, `XenFur`
- head shape (6): `FenFur`, `FerFur`, `FridFur`, `LogFur`, `RacFur`, `XenFur`
- drawn (ears, tails, horns, marks, wings...) (24): `FenEar`, `FenFur`, `FenHead`, `FenTail`, `FerEar`, `FerFur`, `FerHead`, `FerTail`, `FridEar`, `FridFur`, `FridHead`, `FridTail`, `LogEar`, `LogFur`, `LogHead`, `LogTail`, `RacEar`, `RacFur`, `RacHead`, `RacTail`, `XenEar`, `XenFur`, `XenHead`, `XenTail`

## DuelMonsterRimWorld (23)

Workshop id 3050289249.

- skin colour (1): `Skin_DMRW_VampireRed`
- hair style (1): `DragonmaidKitchen`
- body (5): `DMRW_Body_Female`, `DMRW_Body_Thin`, `DMRW_BustUpMagic`, `DragonmaidKitchen`, `DragonmaidLaundry`
- drawn (ears, tails, horns, marks, wings...) (20): `Atrax_Leg`, `DMRW_BustUpMagic`, `Devil_Claw`, `DragonmaidKitchen`, `DragonmaidLaundry`, `Ears_FireRat`, `Ears_Traptrix`, `Ears_WaterCat`, `Ears_WindFox`, `Ferrijit_Tail`, `Fire_Rat_Tail`, `Fraulein_Wing`, `Hair_ArachnocampaMucus`, `Hair_DionaeaTail`, `Hair_NepenthesTail`, `Hair_RafflesiaTail`, `Kitt_Tail`, `PinguiculaTail`, `Water_Cat_Tail`, `Wind_Fox_Tail`

## Cain's Gene Pack (23)

Workshop id 3819866589.

- skin colour (7): `Clockwork_Skin_Brass`, `Echoborn_Skin_Pallid`, `Geasbound_Skin_Fair`, `Geasbound_Skin_Ruddy`, `Hiisi_Skin_Moss`, `Imago_Skin_Chitin`, `Tuonela_Skin_Ashen`
- hair colour (2): `Backwardborn_Hair_Silver`, `Tonttu_Beard`
- beard (1): `Tonttu_Beard`
- head shape (1): `Hiisi_Nose`
- drawn (ears, tails, horns, marks, wings...) (13): `Backwardborn_Eyes_Sandglass`, `Clockwork_GearEyes`, `Clockwork_WindUpKey`, `Echoborn_Ears`, `Echoborn_SealedEyes`, `Geasbound_Freckles`, `Geasbound_WoadMarks`, `Hiisi_Ears`, `Imago_Form_Sage`, `Imago_Form_Warrior`, `Imago_Form_Worker`, `Tonttu_RedCap`, `Tuonela_MarkOfTuoni`

## Fairycore - Spirit Wings (21)

Workshop id 3812515333.

- drawn (ears, tails, horns, marks, wings...) (21): `FG_Pixie`, `FG_Wings_Beetle`, `FG_Wings_Birdwing`, `FG_Wings_BlueMorpho`, `FG_Wings_Cicada`, `FG_Wings_CommonBlue`, `FG_Wings_Damselfly`, `FG_Wings_Dragonfly`, `FG_Wings_Firefly`, `FG_Wings_Glasswing`, `FG_Wings_Grasshopper`, `FG_Wings_Lacewing`, `FG_Wings_LunaMoth`, `FG_Wings_Monarch`, `FG_Wings_Moth`, `FG_Wings_PaperKite`, `FG_Wings_Peacock`, `FG_Wings_PrayingMantis`, `FG_Wings_RedAdmiral`, `FG_Wings_Swallowtail`, `FG_Wings_Wasp`

## Horns & Ears & Things (20)

Workshop id 2888651437.

- drawn (ears, tails, horns, marks, wings...) (20): `Ears_KJ_deer_fluffy_ears`, `Ears_KJ_droopy_fluffy_ears`, `Ears_KJ_droopy_goblin_ears`, `Ears_KJ_fin_ears`, `Ears_KJ_goblin_ears`, `Ears_KJ_side_elf_ears`, `Ears_KJ_side_fluffy_ears`, `Ears_KJ_side_goblin_ears`, `Ears_KJ_small_elf_ears`, `Ears_KJ_tall_elf_ears`, `Ears_KJ_tall_fluffy_ears`, `Ears_KJ_tall_goblin_ears`, `Headbone_KJ_beast_horns`, `Headbone_KJ_curved_horns`, `Headbone_KJ_deer_antlers`, `Headbone_KJ_medium_horns`, `Headbone_KJ_ram_horns`, `Headbone_KJ_small_horns`, `Headbone_KJ_tall_horns`, `Headbone_KJ_thrumbo_horn`

## Moonjelly Xenotype (20)

Workshop id 3030254580.

- skin colour (19): `Moonjelly_Skin_blue`, `Moonjelly_Skin_dark`, `Moonjelly_Skin_dark_blue`, `Moonjelly_Skin_darkpink`, `Moonjelly_Skin_deeperyellow`, `Moonjelly_Skin_green`, `Moonjelly_Skin_green2`, `Moonjelly_Skin_indigo`, `Moonjelly_Skin_lavender`, `Moonjelly_Skin_lilac`, `Moonjelly_Skin_neon_green`, `Moonjelly_Skin_orange`, `Moonjelly_Skin_pink`, `Moonjelly_Skin_purple_deepish`, `Moonjelly_Skin_red`, `Moonjelly_Skin_sky`, `Moonjelly_Skin_white`, `Moonjelly_Skin_yellow`, `Moonjelly_Skin_yellowgreen`
- head shape (1): `Moonjelly_Head`

## Sin's Softer Hair Colors (20)

Workshop id 3790361865.

- hair colour (20): `Soft_Hair_AshyBlond`, `Soft_Hair_Auburn`, `Soft_Hair_BlueishBlack`, `Soft_Hair_BlueishGrey`, `Soft_Hair_DarkBrown`, `Soft_Hair_DarkGinger`, `Soft_Hair_DeepBlack`, `Soft_Hair_DirtyBlond`, `Soft_Hair_DustyPink`, `Soft_Hair_Ginger`, `Soft_Hair_GingerishBrown`, `Soft_Hair_LightAuburn`, `Soft_Hair_LightBlond`, `Soft_Hair_LightDustyPink`, `Soft_Hair_LightPinkishBrown`, `Soft_Hair_MousyBrown`, `Soft_Hair_PinkishBrown`, `Soft_Hair_SoftBrown`, `Soft_Hair_StrawberryBlond`, `Soft_Hair_VeryDarkGinger`

## Biotech Expansion - Mythic (19)

Workshop id 2883216840.

- head shape (3): `BTEMy_DraconicHead`, `BTEMy_FluffyFoxHead`, `BTEMy_PhoenixHead`
- drawn (ears, tails, horns, marks, wings...) (17): `BTEMy_AdamantScales`, `BTEMy_AurumThirst`, `BTEMy_DraconicHorns`, `BTEMy_DraconicNose`, `BTEMy_DraconicTail`, `BTEMy_DraconicWings`, `BTEMy_DraconicWingsNoAurum`, `BTEMy_FluffyFoxHead`, `BTEMy_GoldenFlare`, `BTEMy_MultiFoxTail`, `BTEMy_PhoenixCrest`, `BTEMy_PhoenixNose`, `BTEMy_PhoenixTail`, `BTEMy_PhoenixWings`, `BTEMy_PhoenixWingsNoAurum`, `BTEMy_PrismaticFlare`, `BTEMy_ReveredEmbodiment`

## United weird Unimals (19)

Workshop id 2902436977.

- skin colour (2): `Skin_ColdentPink`, `Skin_FCBrown`
- hair style (1): `Gel_Hair_Only`
- body (1): `Vamp_Body`
- drawn (ears, tails, horns, marks, wings...) (16): `Coldent_Body`, `Coldent_Ears`, `Coldent_Mouth`, `Coldent_Tail`, `FC_Body`, `FC_Ears`, `FC_Eyes`, `FC_Tail`, `Gel_Body`, `Hathr_Body`, `Hathr_Eyes`, `Myco_Body`, `Myco_Shroom`, `Vamp_Body`, `Vamp_Ears`, `Vamp_Wings`

## Obsidia Expansion - Tailborne Xenotype (19)

Workshop id 3511930980.

- skin colour (6): `OE_Skin_TailborneBlack`, `OE_Skin_TailborneBrown`, `OE_Skin_TailborneCream`, `OE_Skin_TailborneGray`, `OE_Skin_TailbornePetal`, `OE_Skin_TailborneRose`
- hair colour (6): `OE_Hair_TailborneBlack`, `OE_Hair_TailborneBrown`, `OE_Hair_TailborneCream`, `OE_Hair_TailborneGray`, `OE_Hair_TailbornePetal`, `OE_Hair_TailborneRose`
- hair style (1): `OE_RatscourgeHead`
- beard (1): `OE_RatscourgeHead`
- head shape (1): `OE_RatscourgeHead`
- drawn (ears, tails, horns, marks, wings...) (4): `OE_MousariEars`, `OE_RatscourgeEars`, `OE_TailborneTail`, `OE_TailborneWhiskers`
- other cosmetic category (2): `OE_MousariBody`, `OE_RatscourgeBody`

## [LFS] Genes Expanded - Horns (19)

Workshop id 3547798297.

- drawn (ears, tails, horns, marks, wings...) (19): `GEH_Horn1`, `GEH_Horn10`, `GEH_Horn11`, `GEH_Horn12`, `GEH_Horn13`, `GEH_Horn14`, `GEH_Horn15`, `GEH_Horn16`, `GEH_Horn17`, `GEH_Horn18`, `GEH_Horn19`, `GEH_Horn2`, `GEH_Horn3`, `GEH_Horn4`, `GEH_Horn5`, `GEH_Horn6`, `GEH_Horn7`, `GEH_Horn8`, `GEH_Horn9`

## Papou Xenotype: Emotional Birds (Continued) (19)

Workshop id 3571039438.

- skin colour (2): `papagoSkinColor1`, `papagoSkinColor2`
- hair colour (2): `papagoHairRed`, `papagoHairYellow`
- beard (2): `papagoBody1`, `papagoBody2`
- body (2): `papagoBody1`, `papagoBody2`
- drawn (ears, tails, horns, marks, wings...) (15): `papagoBody1`, `papagoBody2`, `papagoCheek0`, `papagoCheek1`, `papagoEar0`, `papagoEar1`, `papagoEar2`, `papagoEar3`, `papagoEar4`, `papagoTail`, `papagoWing0`, `papagoWing1`, `papagoWing2`, `papagoWing3`, `papagoWing4`

## Big and Small - Centaurs Expanded (19)

Workshop id 3795221508.

- skin colour (1): `DZ_Skin_Thrumbo`
- hair colour (2): `DZ_Hair_RoyalThrumbo`, `DZ_Hair_Thrumbo`
- drawn (ears, tails, horns, marks, wings...) (16): `DZ_AlphaThrumboHorn`, `DZ_CentaurBody`, `DZ_CentaurBody_AlphaThrumbo`, `DZ_CentaurBody_Cosmetic`, `DZ_CentaurBody_Direhorse`, `DZ_CentaurBody_Direhorse_Cosmetic`, `DZ_CentaurBody_Light`, `DZ_CentaurBody_RoyalThrumbo`, `DZ_CentaurBody_RoyalThrumbo_Cosmetic`, `DZ_CentaurBody_Thrumbo`, `DZ_CentaurBody_Thrumbo_Cosmetic`, `DZ_CentaurBody_Wooly`, `DZ_CentaurEars`, `DZ_NightmareEars`, `DZ_RoyalThrumboHorn`, `DZ_ThrumboHorn`

## DA Cosmetic Genes (1.6) (18)

Workshop id 3785491487.

- drawn (ears, tails, horns, marks, wings...) (5): `Tail_DA_BovineTail`, `Tail_DA_DemonoidTail`, `Tail_DA_FelineTail_A`, `Tail_DA_FelineTail_B`, `Tail_DA_LagomorphTail`
- other cosmetic category (13): `Ears_DA_BovineEars`, `Ears_DA_ElvenLopEars`, `Ears_DA_ElvenPointyEars`, `Ears_DA_Feline_Ears_A`, `Ears_DA_Feline_Ears_B`, `Ears_DA_Feline_Ears_C`, `Ears_DA_GoblinEars`, `Ears_DA_LagomorphEars`, `Ears_DA_OrcEars`, `Headbone_DA_BovineHorns`, `Headbone_DA_DemonoidHorns`, `Nose_DA_GoblinNose`, `Nose_DA_OrcNose`

## transparent skin genes (17)

Workshop id 3031713201.

- skin colour (17): `TXeno_TransparentSkinGenes_Basic`, `TXeno_TransparentSkinGenes_Blue`, `TXeno_TransparentSkinGenes_BlueBright`, `TXeno_TransparentSkinGenes_BlueDark`, `TXeno_TransparentSkinGenes_Brown`, `TXeno_TransparentSkinGenes_Green`, `TXeno_TransparentSkinGenes_GreenBright`, `TXeno_TransparentSkinGenes_GreenDark`, `TXeno_TransparentSkinGenes_Orange`, `TXeno_TransparentSkinGenes_Pink`, `TXeno_TransparentSkinGenes_Red`, `TXeno_TransparentSkinGenes_RedBright`, `TXeno_TransparentSkinGenes_RedDark`, `TXeno_TransparentSkinGenes_Shadow`, `TXeno_TransparentSkinGenes_Tan`, `TXeno_TransparentSkinGenes_White`, `TXeno_TransparentSkinGenes_Yellow`

## Biotech Expansion - Insectoid (17)

Workshop id 3219625470.

- skin colour (5): `BTEIst_HiveQueenSkin`, `BTEIst_LocustSkin`, `BTEIst_MegascarabSkin`, `BTEIst_MegaspiderSkin`, `BTEIst_SpelopedeSkin`
- head shape (5): `BTEIst_HiveQueenHead`, `BTEIst_LocustHead`, `BTEIst_MegascarabHead`, `BTEIst_MegaspiderHead`, `BTEIst_SpelopedeHead`
- drawn (ears, tails, horns, marks, wings...) (8): `BTEIst_HiveQueenTail`, `BTEIst_LocustTail`, `BTEIst_LocustWings`, `BTEIst_MegascarabTail`, `BTEIst_MegaspiderHead`, `BTEIst_MegaspiderTail`, `BTEIst_SpelopedeTail`, `BTEIst_ToxicHalo`

## Erin's Rhy'aeth (16)

Workshop id 3707527452.

- skin colour (10): `ERN_RhyaethBlackScales`, `ERN_RhyaethBlueScales`, `ERN_RhyaethBronzeScales`, `ERN_RhyaethCopperScales`, `ERN_RhyaethGoldScales`, `ERN_RhyaethGreenScales`, `ERN_RhyaethPurpleScales`, `ERN_RhyaethRedScales`, `ERN_RhyaethSilverScales`, `ERN_RhyaethWhiteScales`
- hair style (1): `ERN_RhyaethBody`
- head shape (1): `ERN_RhyaethHead`
- drawn (ears, tails, horns, marks, wings...) (1): `ERN_RhyaethBody`
- other cosmetic category (4): `ERN_RhyaethEars`, `ERN_RhyaethFaceFrills`, `ERN_RhyaethFaceHorns`, `ERN_RhyaethFaceWhiskers`

## Faction - Elves (15)

Workshop id 3726293423.

- skin colour (3): `Skin_DarkGrayishPink`, `Skin_DarkGrayishPurple`, `Skin_DarkPurple`
- hair colour (4): `Hair_AshBrown`, `Hair_AuburnRed`, `Hair_CopperRed`, `Hair_MahoganyRed`
- head shape (1): `Jaw_Thin`
- drawn (ears, tails, horns, marks, wings...) (7): `Ears_HighSharp`, `Ears_LowSharp`, `Ears_MidSharp`, `Eyes_BlueEye`, `Eyes_GreenEye`, `Eyes_PurpleEye`, `Eyes_YellowEye`

## Obsidia Expansion - Slimes Xenotype (13)

Workshop id 3331598962.

- skin colour (4): `OE_Skin_BlueSlime`, `OE_Skin_DarkSlime`, `OE_Skin_GreenSlime`, `OE_Skin_PinkSlime`
- hair colour (4): `OE_Hair_BlueSlime`, `OE_Hair_DarkSlime`, `OE_Hair_GreenSlime`, `OE_Hair_PinkSlime`
- drawn (ears, tails, horns, marks, wings...) (5): `OE_Headbone_SlimeBloodyAntenna`, `OE_Headbone_SlimePrimeAntenna`, `OE_Headbone_SlimeWasteAntenna`, `OE_SlimeBody`, `OE_SlimeFloater`

## FIP - RobCo (13)

Workshop id 3563825876.

- hair style (2): `RobCo_Gene_SynthBody`, `RobCo_Gene_ThinkTankCore`
- beard (2): `RobCo_Gene_SynthBody`, `RobCo_Gene_ThinkTankCore`
- head shape (2): `RobCo_Gene_SynthBody`, `RobCo_Gene_ThinkTankCore`
- drawn (ears, tails, horns, marks, wings...) (1): `RobCo_Gene_ThinkTankEyes`
- other cosmetic category (10): `RobCo_Gene_BiogelBlack`, `RobCo_Gene_BiogelBlue`, `RobCo_Gene_BiogelCyan`, `RobCo_Gene_BiogelGreen`, `RobCo_Gene_BiogelOrange`, `RobCo_Gene_BiogelPink`, `RobCo_Gene_BiogelPurple`, `RobCo_Gene_BiogelRed`, `RobCo_Gene_BiogelWhite`, `RobCo_Gene_BiogelYellow`

## Obsidia Expansion - Axotl Xenotype (12)

Workshop id 3304340573.

- skin colour (5): `OE_Skin_AxotlAlbino`, `OE_Skin_AxotlEnigma`, `OE_Skin_AxotlLavender`, `OE_Skin_AxotlMelanoid`, `OE_Skin_AxotlMosaic`
- hair colour (5): `OE_Hair_AxotlAlbino`, `OE_Hair_AxotlEnigma`, `OE_Hair_AxotlLavender`, `OE_Hair_AxotlMelanoid`, `OE_Hair_AxotlMosaic`
- drawn (ears, tails, horns, marks, wings...) (2): `OE_AxotlTail`, `OE_Headbone_AxotlGills`

## Biotech Cosmetic Kit - Extras and Fix (12)

Workshop id 3662220025.

- drawn (ears, tails, horns, marks, wings...) (12): `MMHorns_HeadDeviWings`, `MMHorns_HeadDeviWingsDark`, `MMHorns_HeadDeviWingsH`, `MMHorns_HeadWings`, `MMHorns_HeadWingsDark`, `MMHorns_HeadWingsFM`, `MMHorns_HeadWingsH`, `MMWings_LuceFM`, `MMWings_LuceFMWaist`, `MMWings_MultiDevi`, `MMWings_MultiDeviDark`, `MMWings_MultiDeviH`

## Rabbie The Moonrabbit race (11)

Workshop id 1837246563.

- hair colour (11): `Hair_RB_Aqua`, `Hair_RB_Brown`, `Hair_RB_CharcoalBlack`, `Hair_RB_DarkRose`, `Hair_RB_GBlond`, `Hair_RB_GoldRose`, `Hair_RB_LCocoa`, `Hair_RB_LPurple`, `Hair_RB_SugarAsh`, `Hair_RB_WBlond`, `Hair_RB_White`

## Rimsenal Xenotype Pack - Askbarn (11)

Workshop id 2918812858.

- skin colour (2): `Skin_BlueGray`, `Skin_OceanGray`
- hair colour (2): `Gene_Hair_Blue_Sky`, `Gene_Hair_Bright_Teal`
- head shape (1): `Pointy_Average_Head`
- drawn (ears, tails, horns, marks, wings...) (6): `BladedTail`, `Race_Gene_AmberEyes`, `Race_Gene_BEA`, `Race_Gene_GlowingWhiteEyes`, `Race_Gene_PEA`, `SpikedTail`

## Orostonian, the Frontiers Xenotypes and Factions (11)

Workshop id 3147447844.

- hair colour (3): `OSNHair_CrotalidHair1`, `OSNHair_CrotalidHair2`, `OSNHair_CrotalidHair3`
- beard (1): `OrostonianFace`
- head shape (1): `OrostonianFace`
- drawn (ears, tails, horns, marks, wings...) (7): `CoytlianEars`, `CoytlianTail`, `CrotalidTail`, `OsorirenEars`, `OsorirenTail`, `TurrinoEars`, `TurrinoTail`

## Epona Dynastic Rise (11)

Workshop id 3514746737.

- hair colour (11): `Hair_Epona_Black`, `Hair_Epona_DarkBrown`, `Hair_Epona_DarkOrange`, `Hair_Epona_LightBlue`, `Hair_Epona_LightGray`, `Hair_Epona_LightGreen`, `Hair_Epona_LightOliveGreen`, `Hair_Epona_LightOrange`, `Hair_Epona_LightPink`, `Hair_Epona_VeryLightGray`, `Hair_Epona_VeryLightGray_2`

## Blanks. (11)

Workshop id 3668680336.

- hair colour (10): `Hair_BrightRed_IncreasedWeight_Blank`, `Hair_Icecap_White`, `Hair_IcyCyan_Kirby`, `Hair_Kirby_Pink`, `Hair_LightOrange_IncreasedWeight_Blank`, `Hair_Ryzza_Blue`, `Hair_Salix_Green`, `Hair_Shuki_Spindle`, `Hair_Shuko_Pink`, `Hair_Winifred_Blond`
- hair style (1): `Blank_Hair_Gene`

## Oca's Anthrosonae (11)

Workshop id 3720732132.

- skin colour (3): `OCARINA_AnthroboghoundFur`, `OCARINA_AnthroraccFur`, `OCARINA_AnthroskunkFur`
- head shape (3): `OCARINA_AnthroboghoundFur`, `OCARINA_AnthroraccFur`, `OCARINA_AnthroskunkFur`
- drawn (ears, tails, horns, marks, wings...) (8): `OCARINA_AnthroboghoundEars`, `OCARINA_AnthroboghoundEarsFloppy`, `OCARINA_AnthroboghoundEarsInvert`, `OCARINA_AnthroboghoundTail`, `OCARINA_AnthroraccEars`, `OCARINA_AnthroraccTail`, `OCARINA_AnthroskunkEars`, `OCARINA_AnthroskunkTail`

## Tribal Fungi Biome (10)

Workshop id 2182438464.

- skin colour (10): `DruidFungiBlue`, `DruidFungiGreen`, `DruidFungiLightGreen`, `DruidFungiMoreGreen`, `DruidFungiOrange`, `DruidFungiPink`, `DruidFungiPurple`, `DruidFungiRed`, `DruidFungiTurkis`, `DruidFungiYellow`

## Zoroark - Xenotype (10)

Workshop id 3047455758.

- hair style (2): `BZoroarkHairbackGene`, `WZoroarkHairbackGene`
- beard (2): `BZoroarkHeadGene`, `WZoroarkHeadGene`
- head shape (2): `BZoroarkHeadGene`, `WZoroarkHeadGene`
- drawn (ears, tails, horns, marks, wings...) (8): `BZoroarkBodyGene`, `BZoroarkEarGene`, `BZoroarkEyeGene`, `BZoroarkHairbackGene`, `WZoroarkBodyGene`, `WZoroarkEarGene`, `WZoroarkEyeGene`, `WZoroarkHairbackGene`

## Carnarodian, the two Mustelids Xenotypes and Factions (10)

Workshop id 3104049393.

- skin colour (3): `LnS_Skin1`, `LnS_Skin2`, `LnS_Skin3`
- hair colour (2): `LnSHair_Marten`, `LnSHair_Sable`
- beard (1): `LnS_Face`
- head shape (1): `LnS_Face`
- drawn (ears, tails, horns, marks, wings...) (4): `LyunicaEars`, `LyunicaTail`, `SobolelyudEars`, `SobolelyudTail`

## Mona The Moon Bear (1.6 fork) (10)

Workshop id 3248186952.

- hair colour (5): `Hair_MonaBloodyRed`, `Hair_MonaBlue`, `Hair_MonaGreyGreen`, `Hair_MonaLightBrown`, `Hair_MonaLightPurple`
- hair style (1): `Hair_Mona`
- beard (1): `Mona`
- head shape (1): `Mona`
- body (1): `Mona`
- drawn (ears, tails, horns, marks, wings...) (4): `Ears_Mona`, `Mona`, `Mona_Moon`, `Tail_Mona`

## Jaguar and Snow Leopard Xenotypes (10)

Workshop id 3297800460.

- hair style (2): `CYB_Head_Onca`, `CYB_Head_Uncia`
- beard (2): `CYB_Head_Onca`, `CYB_Head_Uncia`
- head shape (2): `CYB_Head_Onca`, `CYB_Head_Uncia`
- drawn (ears, tails, horns, marks, wings...) (8): `CYB_Ears_Onca`, `CYB_Ears_Uncia`, `CYB_FelidTuft_Long`, `CYB_FelidTuft_Short`, `CYB_Fur_Onca`, `CYB_Fur_Uncia`, `CYB_Tail_Onca`, `CYB_Tail_Uncia`

## Sensmageddon (10)

Workshop id 3365152973.

- hair style (1): `SMG_NailPaint`
- head shape (5): `SMG_Head_Auricle`, `SMG_Head_Lingua`, `SMG_Head_Oculus`, `SMG_Head_Phalange`, `SMG_Head_Probosci`
- drawn (ears, tails, horns, marks, wings...) (4): `SMG_OculusBlue`, `SMG_OculusBrown`, `SMG_OculusGreen`, `SMG_OculusHazel`

## Rim-Hivers! - Biotech (10)

Workshop id 3378615596.

- skin colour (6): `Chitin_HiverSouthern`, `Chitin_HiverSouthernDark`, `Chitin_HiverSouthernOG`, `Chitin_HiverWestern`, `Chitin_HiverWesternDark`, `Chitin_HiverWesternOG`
- hair style (4): `RH_HiverDroneCaste`, `RH_HiverPrinceCaste`, `RH_HiverRoyalCaste`, `RH_HiverSoldierCaste`
- beard (4): `RH_HiverDroneCaste`, `RH_HiverPrinceCaste`, `RH_HiverRoyalCaste`, `RH_HiverSoldierCaste`
- head shape (4): `RH_HiverDroneCaste`, `RH_HiverPrinceCaste`, `RH_HiverRoyalCaste`, `RH_HiverSoldierCaste`
- drawn (ears, tails, horns, marks, wings...) (4): `RH_HiverDroneCaste`, `RH_HiverPrinceCaste`, `RH_HiverRoyalCaste`, `RH_HiverSoldierCaste`

## BoneReapers ReMarrowed (10)

Workshop id 3516603515.

- hair style (4): `pphhyy_ApokryphosHead`, `pphhyy_ArchonHead`, `pphhyy_SepelireHead`, `pphhyy_ThetesHead`
- beard (4): `pphhyy_ApokryphosHead`, `pphhyy_ArchonHead`, `pphhyy_SepelireHead`, `pphhyy_ThetesHead`
- head shape (4): `pphhyy_ApokryphosHead`, `pphhyy_ArchonHead`, `pphhyy_SepelireHead`, `pphhyy_ThetesHead`
- body (5): `pphhyy_ApokryphosBody`, `pphhyy_ArchonBody`, `pphhyy_PhalangiteBody`, `pphhyy_SepelireBody`, `pphhyy_ThetesBody`
- drawn (ears, tails, horns, marks, wings...) (6): `pphhyy_ApokryphosBody`, `pphhyy_ArchonBody`, `pphhyy_BoneReaperFlight`, `pphhyy_PhalangiteBody`, `pphhyy_SepelireBody`, `pphhyy_ThetesBody`

## [S16] Beautiful Body Variants (10)

Workshop id 3556936541.

- drawn (ears, tails, horns, marks, wings...) (10): `S16_FBV_Abs_A`, `S16_FBV_Abs_B`, `S16_FBV_Abs_C`, `S16_FBV_Standard_A`, `S16_FBV_Standard_A_Weight`, `S16_FBV_Standard_A_Weight_More`, `S16_FBV_Standard_B`, `S16_FBV_Standard_B_Weight`, `S16_FBV_Standard_C`, `S16_FBV_Standard_C_Weight`

## [SH]Gene Expand (10)

Workshop id 3558760095.

- drawn (ears, tails, horns, marks, wings...) (8): `SHGE_AngelWings`, `SHGE_Ears_Feather`, `SHGE_Ears_LittlePointed`, `SHGE_Halo_Angel`, `SHGE_Halo_Artificial`, `SHGE_LittleDevilWings`, `SHGE_MembranousWings`, `SHGE_TwinWings`
- other cosmetic category (2): `SHGE_FemaleOnly`, `SHGE_MaleOnly`

## Spite the Sky: Fer'Liebor Xenotype (10)

Workshop id 3646000311.

- hair colour (5): `Hair_PaleBlondeish`, `Hair_PaleBlueish`, `Hair_PaleBrownish`, `Hair_PaleGrayish`, `Hair_PaleRedish`
- hair style (1): `Fer_Liebor_Hair`
- head shape (1): `Fer_Liebor_Head`
- drawn (ears, tails, horns, marks, wings...) (3): `Fer_Liebor_Ear`, `Fer_Liebor_Fur`, `Fer_Liebor_Tail`

## 边缘仙路-镇邪诛鬼 RimImmortal-Exorcism[1.6] (10)

Workshop id 3663824172.

- skin colour (4): `RI_Gene_ZombieSkinA`, `RI_Gene_ZombieSkinB`, `RI_Gene_ZombieSkinC`, `RI_Gene_ZombieSkinD`
- head shape (1): `RI_GeneHead_NecrosapiensHead`
- body (2): `RI_Gene_ZombieStandard`, `RI_Gene_ZombieThin`
- drawn (ears, tails, horns, marks, wings...) (3): `RI_Gene_BoneHorns`, `RI_Gene_BoneTail`, `RI_Gene_ZombieRedEyes`

## [AP] Lupine Xenotype (9)

Workshop id 2991428888.

- skin colour (3): `AP_Lupine_BlackFurSkin`, `AP_Lupine_GlisterFurSkin`, `AP_Lupine_WhiteFurSkin`
- hair style (3): `AP_Lupine_Black_Head`, `AP_Lupine_Glister_Head`, `AP_Lupine_White_Head`
- beard (3): `AP_Lupine_Black_Head`, `AP_Lupine_Glister_Head`, `AP_Lupine_White_Head`
- head shape (3): `AP_Lupine_Black_Head`, `AP_Lupine_Glister_Head`, `AP_Lupine_White_Head`
- drawn (ears, tails, horns, marks, wings...) (3): `AP_Lupine_Black_Body`, `AP_Lupine_Glister_Body`, `AP_Lupine_White_Body`

## Vanilla Skin Tone Genes (9)

Workshop id 3165888554.

- skin colour (9): `VSTG_Skin_1`, `VSTG_Skin_2`, `VSTG_Skin_3`, `VSTG_Skin_4`, `VSTG_Skin_5`, `VSTG_Skin_6`, `VSTG_Skin_7`, `VSTG_Skin_8`, `VSTG_Skin_9`

## [LFS] Genes Expanded - Wings (9)

Workshop id 3208605060.

- drawn (ears, tails, horns, marks, wings...) (9): `GEW_Angel_Wings`, `GEW_Boney_Wings`, `GEW_DarkAngel_Wings`, `GEW_Demon_Wings`, `GEW_Fairy_Wings`, `GEW_Genetic_Wings`, `GEW_Insectoid_Wings`, `GEW_Moth_Wings`, `GEW_Slime_Wings`

## Det's Xenotypes - Brawnum (9)

Workshop id 3429572581.

- skin colour (5): `DV_Skin_AshBrown`, `DV_Skin_Charcoal`, `DV_Skin_Cream`, `DV_Skin_EarthBrown`, `DV_Skin_WoodBrown`
- head shape (1): `DV_Nose_Snout`
- drawn (ears, tails, horns, marks, wings...) (4): `DV_Ears_Drooped`, `DV_Jaw_Bonechin`, `DV_Nose_Snout`, `DV_ShoulderFur`

## Awakened Apes (9)

Workshop id 3646217940.

- skin colour (4): `BananaSkinColor`, `ChimpSkin`, `MonkeySkin`, `OranGutanSkin`
- head shape (3): `ChimpHead`, `GorillaHead`, `OrangutanHead`
- drawn (ears, tails, horns, marks, wings...) (1): `MonkeyTail_Skin`
- other cosmetic category (1): `VoiceApe`

## Mauray (9)

Workshop id 3663680564.

- head shape (1): `Mauray_Head`
- drawn (ears, tails, horns, marks, wings...) (8): `Mauray_EarsC`, `Mauray_EarsF`, `Mauray_EarsH`, `Mauray_EarsP`, `Mauray_EarsT`, `Mauray_EarsW`, `Mauray_Head`, `Mauray_Tail`
- other cosmetic category (1): `FelineVoice`

## Everybody's Different (9)

Workshop id 3750132342.

- other cosmetic category (9): `EBD_Frame_MidMid`, `EBD_Frame_MidSlight`, `EBD_Frame_MidStout`, `EBD_Frame_ShortMid`, `EBD_Frame_ShortSlight`, `EBD_Frame_ShortStout`, `EBD_Frame_TallMid`, `EBD_Frame_TallSlight`, `EBD_Frame_TallStout`

## Miho, the celestial fox (8)

Workshop id 2816826107.

- hair colour (7): `Hair_Miho_Ash`, `Hair_Miho_Orange`, `Hair_Miho_Pink`, `Hair_Miho_Red`, `Hair_Miho_Sky`, `Hair_Miho_SpaceBlonde`, `Hair_Miho_Violet`
- body (1): `Ears_Voidborn_Miho`

## Dr. Arch13's ArchoWonderium - DigiFox (tm) (8)

Workshop id 2900653856.

- skin colour (1): `DigiFoxYellow`
- hair colour (1): `Hair_DigiFox`
- beard (1): `DigiFoxFur`
- head shape (1): `DigiFoxFur`
- drawn (ears, tails, horns, marks, wings...) (6): `DigiFluff`, `DigiFoxEars`, `DigiFoxEyes`, `DigiFoxFur`, `DigiFoxTail`, `DigiFoxWings`

## Rimsenal Xenotype Pack - Harana (8)

Workshop id 3228637524.

- skin colour (1): `Skin_HPale`
- hair colour (1): `Gene_Hair_Heather_Indigo`
- head shape (2): `Narrow_Normal_Head`, `Narrow_Pointy_Head`
- drawn (ears, tails, horns, marks, wings...) (4): `CrowTail`, `Gene_Hwing`, `Race_Gene_FeatherE`, `Tired_Eyes`

## Helltaker Cosmetic Genes (Skin Horns) (8)

Workshop id 3314993192.

- drawn (ears, tails, horns, marks, wings...) (8): `LMHornsAbyssSkin`, `LMHornsGoatSkin`, `LMHornsJudgmentSkin`, `LMHornsKrampusSkin`, `LMHornsQueenSkin`, `LMHornsRegularSkin`, `LMHornsSadisticSkin`, `LMHornsTinySkin`

## Just About: Lions And Tigers (Continued) (8)

Workshop id 3320873214.

- hair style (2): `JAR_LeoSkin`, `JAR_TigrisSkin`
- head shape (2): `JAR_LeoSkin`, `JAR_TigrisSkin`
- drawn (ears, tails, horns, marks, wings...) (8): `JAR_LeoEars`, `JAR_LeoSkin`, `JAR_LeoTail`, `JAR_Leo_Tuft`, `JAR_TigrisEars`, `JAR_TigrisSkin`, `JAR_TigrisTail`, `JAR_Tigris_Tuft`

## ME(b) - Krogan (8)

Workshop id 3524888108.

- hair style (1): `Krogan_Head`
- beard (1): `Krogan_Head`
- head shape (1): `Krogan_Head`
- drawn (ears, tails, horns, marks, wings...) (7): `Krogan_Crest`, `Krogan_Crest_Blue`, `Krogan_Crest_Dark`, `Krogan_Crest_Grey`, `Krogan_Crest_Red`, `Krogan_Crest_White`, `Krogan_Crest_Yellow`

## Lilin Wool Genes (8)

Workshop id 3696210405.

- hair colour (8): `KNV_woolgene_creamy`, `KNV_woolgene_darkgrey`, `KNV_woolgene_desertsand`, `KNV_woolgene_lightgrey`, `KNV_woolgene_palebrown`, `KNV_woolgene_pinkbrown`, `KNV_woolgene_red`, `KNV_woolgene_white`

## 鼠族（无外星人框架）/ Ratkin Without HAR (8)

Workshop id 3826752382.

- skin colour (2): `RK_Gene_Skin`, `RK_Skin_PureWhite`
- hair colour (1): `RK_Gene_Hair`
- hair style (1): `RK_Gene_Hair`
- head shape (1): `RK_Gene_Head`
- body (2): `RK_Gene_Body`, `RK_Gene_SmallBody`
- drawn (ears, tails, horns, marks, wings...) (3): `RK_Gene_LargeEars`, `RK_Gene_SmallBody`, `RK_Gene_ThinTail`

## Various Eyes Genes (7)

Workshop id 2880903154.

- drawn (ears, tails, horns, marks, wings...) (7): `Eyes_Blue_eyes`, `Eyes_Green_eyes`, `Eyes_Orange_eyes`, `Eyes_Purple_eyes`, `Eyes_SnowWhite_eyes`, `Eyes_Teal_eyes`, `Eyes_Yellow_eyes`

## Identity (7)

Workshop id 2882253079.

- hair colour (4): `Hair_FlarenOrange`, `Hair_HotRed`, `Hair_Midnight`, `Hair_Turquoise`
- beard (1): `Furskin`
- head shape (2): `FluffyFurskin`, `PlasteelFurskin`

## Far Easterner, Ama the Three Raijus of the Far East Xenotypes and Factions (7)

Workshop id 2974761367.

- skin colour (1): `AMASkin`
- beard (1): `Ama_Face`
- head shape (1): `Ama_Face`
- drawn (ears, tails, horns, marks, wings...) (5): `AMAEar`, `AMATail`, `AMA_DragonHorn`, `AMA_Feather`, `AMA_HaetaeHorn`

## ReSplice: Charmweavers (7)

Workshop id 3131996691.

- skin colour (1): `RS_Skin_PaleGreen`
- drawn (ears, tails, horns, marks, wings...) (6): `RS_Eyes_Pink`, `RS_Headbone_LargeHorns`, `RS_Headbone_MediumHorns`, `RS_Headbone_RamHorns`, `RS_Tail_Spiked`, `RS_Wing_Batlike`

## Det's Xenotypes - Boglegs (7)

Workshop id 3146564944.

- skin colour (5): `Skin_BrownMuddy`, `Skin_CyanMuddy`, `Skin_GreenMuddy`, `Skin_OliveMuddy`, `Skin_YellowMuddy`
- drawn (ears, tails, horns, marks, wings...) (2): `DV_Jaw_FatSac`, `DV_Nose_Whiskers`

## Starei's Florian Xenotype (7)

Workshop id 3310020641.

- skin colour (2): `ST_Skin_LimeGreen`, `ST_Skin_WarmGreen`
- hair colour (4): `ST_Hair_DarkGreen`, `ST_Hair_MutedGreen`, `ST_Hair_SwampGreen`, `ST_Hair_WarmGreen`
- other cosmetic category (1): `ST_GreenBlood`

## K's Snarelanterns (7)

Workshop id 3328218292.

- drawn (ears, tails, horns, marks, wings...) (7): `K_SnarelanternEscaFemale_Blue`, `K_SnarelanternEscaFemale_Cyan`, `K_SnarelanternEscaFemale_Green`, `K_SnarelanternEscaFemale_Magenta`, `K_SnarelanternEscaFemale_Orange`, `K_SnarelanternEscaFemale_Red`, `K_SnarelanternEscaFemale_Yellow`

## Reese's Anomaly Genes (7)

Workshop id 3434828984.

- hair style (1): `ReeseGenes_HairCultist`
- head shape (4): `ReeseGenes_HeadLeathery`, `ReeseGenes_HeadScholar`, `ReeseGenes_HeadTimeless`, `ReeseGenes_HeadTormented`
- drawn (ears, tails, horns, marks, wings...) (2): `ReeseGenes_BodyLeathery`, `ReeseGenes_BodyTormented`

## Nottingham's Kholo 1.5.3 (7)

Workshop id 3474115586.

- beard (2): `NK_KholoHead`, `NK_KholoHeadDark`
- head shape (2): `NK_KholoHead`, `NK_KholoHeadDark`
- drawn (ears, tails, horns, marks, wings...) (5): `NK_Ears_Kholo`, `NK_KholoSkin_Cave`, `NK_KholoSkin_Spot`, `NK_KholoSkin_Stripe`, `NK_KholoSkin_Winter`

## Nephilim Xenotype Reborn (7)

Workshop id 3542508261.

- skin colour (1): `GS_Skin_Platinum`
- hair colour (1): `Hair_Platinum`
- drawn (ears, tails, horns, marks, wings...) (5): `GS_Ear_Wings`, `GS_Eyes_Yellowy`, `GS_Halo`, `GS_Saint_Halo`, `GS_WingsB`

## 圣蜣螂种族 (7)

Workshop id 3740297753.

- skin colour (1): `Scarab_Skin_White`
- head shape (1): `ScarabSaintGene`
- drawn (ears, tails, horns, marks, wings...) (2): `ScarabSaintGene`, `Scarab_Antenna_Sense`
- other cosmetic category (4): `ScarabEyes_Black`, `Scarab_Biomass_Digestion`, `Scarab_Carapace_Growth`, `Scarab_CustomHair`

## Molong Xenotype (7)

Workshop id 3789407175.

- skin colour (3): `GS_Skin_VBlue`, `GS_Skin_VRed`, `GS_Skin_VYellow`
- head shape (1): `GS_FiendHead`
- drawn (ears, tails, horns, marks, wings...) (3): `GS_BigNose`, `GS_Ears_MFiend`, `GS_Headbone_Skinhorns`

## local:rimholstaur (7)

Workshop id local:rimholstaur.

- skin colour (3): `Skin_Black`, `Skin_Chocolate`, `Skin_Light`
- drawn (ears, tails, horns, marks, wings...) (4): `Ears_Cow`, `Horns_Cow`, `S_Fluff_Cow`, `Tail_Cow`

## Lantern Hunters (6)

Workshop id 2866414675.

- hair colour (6): `Hair_Blue_LH`, `Hair_Cyan_LH`, `Hair_Green_LH`, `Hair_Pink_LH`, `Hair_Purple_LH`, `Hair_Red_LH`

## Dr. Arch13's ArchoWonderium - Legendary Dragon (tm) (6)

Workshop id 3226197882.

- beard (1): `LDragon_Scales`
- head shape (1): `LDragon_Scales`
- drawn (ears, tails, horns, marks, wings...) (6): `LDragon_Antenna`, `LDragon_Head`, `LDragon_Horn`, `LDragon_Scales`, `LDragon_Tail`, `LDragon_Wings`

## Tower of Rimworld (6)

Workshop id 3335952183.

- skin colour (2): `ToR_Skin_ForestMossGreen`, `ToR_Skin_SageGreen`
- hair colour (2): `ToR_Hair_IcyBlue`, `ToR_Hair_NightBlue`
- head shape (2): `ToR_Head_Alien`, `ToR_Head_Parakewl`

## Big and Small - Simply Robots (6)

Workshop id 3360323573.

- skin colour (2): `BS_Skin_AndroidGrey`, `BS_Skin_AndroidWhite`
- hair style (2): `BS_CommandoHead`, `BS_TVHead`
- beard (2): `BS_CommandoHead`, `BS_TVHead`
- body (2): `BS_CommandoBody`, `BS_SimpleRobotBody`

## [DF] Gold Xenotype (6)

Workshop id 3438437353.

- skin colour (2): `Gene_goldColorSkin`, `Gene_goldHead`
- hair colour (1): `Gene_goldHair`
- beard (1): `Gene_goldBeardless`
- head shape (1): `Gene_goldHead`
- body (1): `Gene_goldStandard`
- drawn (ears, tails, horns, marks, wings...) (2): `Gene_goldHead`, `Gene_goldSkin`

## Roo's Faun Xenotype (6)

Workshop id 3547220635.

- head shape (1): `RBSF_DeerHead`
- drawn (ears, tails, horns, marks, wings...) (5): `RBM_UnguligradeLegs`, `RBSF_DeerEars`, `RBSF_DeerHorns`, `RBSF_HorizontalPupils`, `RBSF_SerenAntlers`

## Monkey Xenotypes (6)

Workshop id 3566230987.

- skin colour (2): `BananaSkinColor`, `OranGutanSkin`
- head shape (3): `ChimpHead`, `GorillaHead`, `OrangutanHead`
- other cosmetic category (1): `VoiceGorilla`

## Cosmetic Genes- Extra (6)

Workshop id 3606047642.

- drawn (ears, tails, horns, marks, wings...) (6): `MTR_Antenna_Centipede`, `MTR_Feelers_Moth`, `MTR_Moth_Collar`, `MTR_Moth_Wings`, `MTR_Tail_Centipede`, `MTR_Tail_Moth`

## Hawk's Gryphons (6)

Workshop id 3684749881.

- skin colour (6): `Gryphon_Skin`, `Gryphon_Skin_Dark`, `Gryphon_Skin_black`, `Gryphon_Skin_brown`, `Gryphon_Skin_darkbrown`, `Gryphon_Skin_green`

## Addie's Frost Fey (6)

Workshop id 3697314995.

- hair colour (3): `Addie_Hair_BlueRaspberry`, `Addie_Hair_Frosty`, `Addie_Hair_Glacial`
- drawn (ears, tails, horns, marks, wings...) (3): `Addie_PaleBlueEyes`, `Addie_RimeBlueEyes`, `Addie_StrikingEyes`

## Mantled Beasts (6)

Workshop id 3739973453.

- skin colour (1): `OCARINA_MantledBeastsFur`
- hair style (2): `OCARINA_MantledBeastsFur`, `OCARINA_MantledBeastsHair`
- beard (1): `OCARINA_MantledBeastsFur`
- head shape (1): `OCARINA_MantledBeastsFur`
- drawn (ears, tails, horns, marks, wings...) (3): `OCARINA_MantledBeastsEars`, `OCARINA_MantledBeastsFur`, `OCARINA_MantledBeastsTail`
- other cosmetic category (2): `OCARINA_MantledBeastsEyesight`, `OCARINA_MantledBeastsPaws`

## Kimchianz Xenotype (Beta) (6)

Workshop id 3752498193.

- hair colour (3): `KCA_Hair_Cabbianz`, `KCA_Hair_Kimchianz`, `KCA_Hair_WhiteKimchianz`
- hair style (3): `KCA_Hair_Cabbianz`, `KCA_Hair_Kimchianz`, `KCA_Hair_WhiteKimchianz`
- beard (3): `KCA_Hair_Cabbianz`, `KCA_Hair_Kimchianz`, `KCA_Hair_WhiteKimchianz`
- head shape (2): `KCA_Body_Cabbianz`, `KCA_Body_Kimchianz`
- body (2): `KCA_Body_Cabbianz`, `KCA_Body_Kimchianz`
- other cosmetic category (1): `KCA_Cabbianz_Weakness`

## Seraphim Xenotype Reborn (6)

Workshop id 3773065414.

- skin colour (1): `GS_Skin_PureWhite`
- head shape (1): `Head_Seraph`
- drawn (ears, tails, horns, marks, wings...) (4): `GS_Seraph_Halo_Arch`, `GS_Seraph_Wings`, `GS_Wing_ears`, `GS_WingsC`

## Biotech Monke Xenotype (Continued) (6)

Workshop id 3797310379.

- skin colour (1): `Skin_Tan`
- hair style (1): `Hair_Monke`
- head shape (1): `Nose_Monke`
- drawn (ears, tails, horns, marks, wings...) (4): `Beard_Monke`, `Ears_Monke`, `Monke_Furskin`, `Nose_Monke`

## RWoM Custom Class Pack - Epic Battle Fantasy (5)

Workshop id 2803755648.

- skin colour (2): `Skin_Mauve`, `Skin_Mud`
- hair colour (1): `EBF_SaiyanHair`
- hair style (1): `EBF_SaiyanHair`
- other cosmetic category (2): `EBF_CrackedHead`, `EBF_SmolCat`

## Integrated Genes (5)

Workshop id 2884115974.

- skin colour (2): `Turn_Gene_SkinBrightOrange`, `Turn_Gene_SkinFleshColor`
- drawn (ears, tails, horns, marks, wings...) (3): `Turn_Gene_DryadFace`, `Turn_Gene_Eyes_Vacuous`, `Turn_Gene_HeadboneCrown`

## Kijin Race 3.0 (5)

Workshop id 2884551646.

- hair colour (2): `Hair_KijinDarkRed`, `Hair_KijinPink`
- head shape (1): `Head_Kijin`
- drawn (ears, tails, horns, marks, wings...) (2): `Headbone_KijinHornBlack`, `Headbone_KijinHornWhite`

## Ferian Race - Biotech (5)

Workshop id 2887426937.

- skin colour (2): `Ferian_skin`, `Skin_White`
- hair style (1): `Hair_Ferian`
- beard (1): `Ferian_skin`
- head shape (1): `Ferian_skin`
- drawn (ears, tails, horns, marks, wings...) (3): `Ears_Ferian`, `Ferian_Furry`, `Ferian_skin`

## FAE-Facial Animations Expanded (5)

Workshop id 2890697696.

- drawn (ears, tails, horns, marks, wings...) (5): `Cheeks_FacialGills`, `Cheeks_Fluffy`, `Face_Gaunt`, `Large_Cranium`, `Nose_ShortSnout`

## Vanilla Races Expanded - Phytokin (5)

Workshop id 2927323805.

- hair colour (3): `VRE_HairColor_Anima`, `VRE_HairColor_Gauranlen`, `VRE_HairColor_Pollux`
- hair style (1): `VRE_FoliageHair`
- head shape (1): `VRE_BarkSkin`
- drawn (ears, tails, horns, marks, wings...) (1): `VRE_BarkSkin`

## Vanilla Races Expanded - Pigskin (5)

Workshop id 3164798809.

- skin colour (3): `VRE_AuburnSkin`, `VRE_ChocolateSkin`, `VRE_HazelnutSkin`
- drawn (ears, tails, horns, marks, wings...) (2): `VRE_CurledTail`, `VRE_MouthTusks`

## Cane Aternitigno, The war dogs of battlefield Xenotypes and Faction (5)

Workshop id 3165847953.

- beard (1): `CG_Face`
- head shape (1): `CG_Face`
- drawn (ears, tails, horns, marks, wings...) (4): `CGEars_FloppyLong`, `CGEars_FloppyShort`, `CGEars_MalteseEars`, `CGTail_Dog`

## Rimframe: Vatgrown Hate (5)

Workshop id 3431220821.

- skin colour (1): `Skin_Gpale`
- head shape (1): `G_Clonerot`
- drawn (ears, tails, horns, marks, wings...) (3): `Eyes_GRed`, `Eyes_Gorange`, `Eyes_Gyellow`

## No Longer Human-Warhives Faction Pack (5)

Workshop id 3462391280.

- head shape (1): `Head_Insect`
- drawn (ears, tails, horns, marks, wings...) (4): `HeadFrills`, `InsectMandibles`, `OksarzjFaceplate`, `SideFrills`

## Roo's Satyr Xenotype (5)

Workshop id 3548322381.

- drawn (ears, tails, horns, marks, wings...) (5): `RBM_UnguligradeLegs`, `RBSF_GoatEars`, `RBSF_GoatHorns`, `RBSF_HorizontalPupils`, `RBSF_SerenGoatHorns`

## Roo's Minotaur Xenotype (5)

Workshop id 3548423129.

- skin colour (1): `RBM_EarthySkin`
- head shape (1): `RBM_BovineHead`
- drawn (ears, tails, horns, marks, wings...) (4): `RBM_BovineEars`, `RBM_BovineHead`, `RBM_BovineHorns`, `RBM_UnguligradeLegs`

## [LFS] Genes Expanded - Heads (5)

Workshop id 3549061328.

- head shape (5): `GEHD_Amphibian_Head`, `GEHD_Insectoid_Head`, `GEHD_Rockey_Head`, `GEHD_Scale_Head`, `GEHD_Slime_Head`

## The Borg Collective (5)

Workshop id 3704848468.

- head shape (2): `Borg_Gene_Drone`, `Borg_Gene_Queen`
- drawn (ears, tails, horns, marks, wings...) (5): `Borg_Gene_Assimilate`, `Borg_Gene_Drone`, `Borg_Gene_HeavyArmorVisual`, `Borg_Gene_LightArmorVisual`, `Borg_Gene_Queen`

## Viltrumites in Rimworld (5)

Workshop id 3708277667.

- skin colour (4): `Skin_ThraxanHybridBlack`, `Skin_ThraxanHybridTan`, `Skin_ThraxanViolet`, `Skin_UnopanOrange`
- beard (1): `Beard_MoustacheOnly`

## Rim's Destiny: Exo (5)

Workshop id 3771229424.

- head shape (1): `RD_ExoHead`
- drawn (ears, tails, horns, marks, wings...) (5): `RD_ExoCrest`, `RD_ExoHead`, `RD_ExoHorn`, `RD_ExoPlates`, `RD_Exo_Eyes`

## Skinprint (5)

Workshop id 3815708054.

- other cosmetic category (5): `SP_BeautyMoles`, `SP_Birthmark`, `SP_Freckles`, `SP_Piebald`, `SP_Vitiligo`

## NewRatkinPlus (4)

Workshop id 1578693166.

- skin colour (1): `RK_Skin_PureWhite`
- head shape (1): `RK_Gene_CuteFace`
- body (1): `RK_Gene_SmallBody`
- drawn (ears, tails, horns, marks, wings...) (1): `RK_Gene_SmallBody`
- other cosmetic category (1): `RK_Gene_LargeEars`

## Vanilla Races Expanded - Saurid (4)

Workshop id 2880990495.

- hair style (1): `VRESaurids_CenterFrill`
- head shape (1): `VRESaurids_ScaleSkin`
- drawn (ears, tails, horns, marks, wings...) (3): `VRESaurids_FrilledEars`, `VRESaurids_GeckoTail`, `VRESaurids_ScaleSkin`

## Nose Sponge Plus+ (4)

Workshop id 2881450798.

- hair style (1): `Male_noHair`
- drawn (ears, tails, horns, marks, wings...) (3): `NoseSponge`, `balance_tail`, `fluffy_tail`

## Wild Factions - Damar (4)

Workshop id 2889581499.

- hair colour (4): `Capra_Gene_Hair_Black`, `Capra_Gene_Hair_Brown`, `Capra_Gene_Hair_Grey`, `Capra_Gene_Hair_White`

## Wild Factions - UXC (4)

Workshop id 2889924604.

- hair colour (4): `Capra_Gene_Hair_Black`, `Capra_Gene_Hair_Brown`, `Capra_Gene_Hair_Grey`, `Capra_Gene_Hair_White`

## Lapelli Race - Biotech (4)

Workshop id 2892301088.

- skin colour (1): `Lapelli_skin`
- beard (1): `Lapelli_skin`
- head shape (1): `Lapelli_skin`
- drawn (ears, tails, horns, marks, wings...) (4): `Ears_Lapelli`, `Lapelli_Tail`, `Lapelli_Wing`, `Lapelli_skin`

## BodyTypeMatters (4)

Workshop id 2916028877.

- body (4): `Body_Fat_Germ`, `Body_Hulk_Germ`, `Body_Standard_Germ`, `Body_Thin_Germ`

## Roxborn (4)

Workshop id 3048382292.

- skin colour (1): `RB_Roxskin`
- hair colour (2): `RB_Hair_RoxDarkGrey`, `RB_Hair_RoxLightGrey`
- hair style (1): `RB_Hair_RoxOnly`

## Vanilla Races Expanded - Lycanthrope (4)

Workshop id 3114453100.

- beard (1): `VRE_OnlySideburns`
- drawn (ears, tails, horns, marks, wings...) (3): `VRE_CanineNose`, `VRE_CanineTail`, `VRE_ChestFur`

## Thrumboian Race (4)

Workshop id 3257981328.

- skin colour (1): `Skin_ThrumboWhite`
- hair colour (1): `Hair_ThrumboWhite`
- drawn (ears, tails, horns, marks, wings...) (2): `Headbone_AlphaThrumboianHorn`, `Headbone_ThrumboianHorn`

## MakaiTech - Xenotype (4)

Workshop id 3268577147.

- drawn (ears, tails, horns, marks, wings...) (2): `Makai_AdeltiaHorns`, `Makai_DemonianHorns`
- other cosmetic category (2): `Makai_AdeltiaFrame`, `Makai_FairinFrame`

## Bamp Xenotype (4)

Workshop id 3297545550.

- hair style (1): `Hair_Bamp`
- beard (1): `Bamp_Hair`
- head shape (1): `Bamp_Hair`
- drawn (ears, tails, horns, marks, wings...) (2): `Ears_Bamp`, `Tail_Bamp`

## MSS Tweaks and Fun (4)

Workshop id 3379574408.

- skin colour (1): `MSS_LeaperBody`
- beard (1): `MSS_LeaperTongue`
- head shape (2): `MSS_ChestnutHead`, `MSS_LeaperHead`
- drawn (ears, tails, horns, marks, wings...) (2): `MSS_LeaperBody`, `MSS_LeaperTongue`

## Fabled Cervidae (4)

Workshop id 3400548142.

- skin colour (4): `FC_Skin_Auravine`, `FC_Skin_Infernihart`, `FC_Skin_Mirelung`, `FC_Skin_Scire`

## Totzi Xenotype Race (4)

Workshop id 3409222988.

- head shape (2): `Head_TZ`, `Head_TZF`
- drawn (ears, tails, horns, marks, wings...) (2): `Ears_TZ`, `Ears_TZF`

## Ratkin Xenotype Forked (4)

Workshop id 3509837826.

- hair style (1): `Ratkin_Hair`
- head shape (1): `Ratkin_Head`
- drawn (ears, tails, horns, marks, wings...) (2): `Ratkin_Ear`, `Ratkin_Tail`

## Cybranian - Oryx Xenotype (4)

Workshop id 3527163129.

- hair style (1): `Hair_Oryx`
- beard (1): `Hair_Oryx`
- head shape (1): `Head_Oryx`
- drawn (ears, tails, horns, marks, wings...) (3): `Hair_Oryx`, `Nose_Oryx`, `Tail_Oryx`

## RaddusX's Demons (4)

Workshop id 3531834757.

- drawn (ears, tails, horns, marks, wings...) (4): `RaddusX_Demons_Incubus_Horns_Gene`, `RaddusX_Demons_Succubus_Horns_Gene`, `RaddusX_Demons_Tail_Gene`, `RaddusX_Demons_Wings_Gene`

## Unfortunate Xenotypes - Minua (4)

Workshop id 3566190392.

- drawn (ears, tails, horns, marks, wings...) (4): `AniridicEyes`, `MurineEars`, `MurineNose`, `MurineTail`

## ME(b) - Turians (4)

Workshop id 3572135997.

- skin colour (3): `Skin_TurianBlue`, `Skin_TurianBrown`, `Skin_TurianGreen`
- hair style (1): `Turian_Head`
- beard (1): `Turian_Head`
- head shape (1): `Turian_Head`

## Sergal Genes (4)

Workshop id 3639784628.

- head shape (1): `Drifter_SergalHead`
- drawn (ears, tails, horns, marks, wings...) (3): `Drifter_SergalBody`, `Drifter_SergalEars`, `Drifter_SergalTail`

## The Gilded Spiral - Spiralborn Xenotype (4)

Workshop id 3684159046.

- hair colour (2): `Addie_Hair_Maroon`, `Addie_Hair_Violet`
- drawn (ears, tails, horns, marks, wings...) (2): `Addie_AmberEyes`, `Addie_KintsugiBody`

## [AV] Kosmian Xenotype (4)

Workshop id 3774474578.

- skin colour (1): `AV_Chromalog`
- hair colour (1): `AV_Chromalog`
- head shape (2): `AV_NightskyHead`, `AV_NightskySkinPattern`
- drawn (ears, tails, horns, marks, wings...) (2): `AV_NightskySkinPattern`, `AV_NightskyTail`

## TurtleShroom Productions Proudly Presents: Call of Cthulhu Factions (Continued) (4)

Workshop id 3780067307.

- head shape (1): `ROM_InnsmouthLook_Head`
- drawn (ears, tails, horns, marks, wings...) (3): `ROM_InnsmouthLook_Ears`, `ROM_InnsmouthLook_Eyes`, `ROM_InnsmouthLook_Headbone_Fin`

## Ancient Chinese Beast And Gene Expanded Renew (unofficial) (4)

Workshop id 3806709132.

- drawn (ears, tails, horns, marks, wings...) (4): `SZGene_MingShe_WindWing`, `SZGene_QiongQi_FlyingStrike`, `SZGene_SeXie_Shoot`, `SZGene_YearBeast_Horn`

## Geasbound Xenotype (4)

Workshop id 3819827851.

- skin colour (2): `Geasbound_Skin_Fair`, `Geasbound_Skin_Ruddy`
- drawn (ears, tails, horns, marks, wings...) (2): `Geasbound_Freckles`, `Geasbound_WoadMarks`

## [Y]VRE Skin Colors Patch (4)

Workshop id 3822096385.

- skin colour (4): `Fungoid_Skin_Orange`, `Genie_Skin_Blue`, `Saurid_Skin_Green`, `Waster_Skin_Brown`

## local:AncientChineseBeastAndGeneExpandedRenew (4)

Workshop id local:AncientChineseBeastAndGeneExpandedRenew.

- drawn (ears, tails, horns, marks, wings...) (4): `SZGene_MingShe_WindWing`, `SZGene_QiongQi_FlyingStrike`, `SZGene_SeXie_Shoot`, `SZGene_YearBeast_Horn`

## local:rjw-animal-gene-inheritance (4)

Workshop id local:rjw-animal-gene-inheritance.

- beard (1): `AGI_Thin_Fur`
- drawn (ears, tails, horns, marks, wings...) (4): `AGI_FurryOvalPointed_Ears`, `AGI_Short_Furred_Ears`, `AGI_Tail`, `AGI_Thin_Fur`

## Lamias, Sirens, Snakemen, and other Serpents-like beings (3)

Workshop id 2908225858.

- hair style (1): `BS_GorgonHair`
- head shape (1): `LoS_SnekSnoot`
- other cosmetic category (1): `AG_BullHorns_LOSAlternative`

## Vanilla Races Expanded - Highmate (3)

Workshop id 2995385834.

- hair style (1): `VRE_HighmateHair`
- drawn (ears, tails, horns, marks, wings...) (2): `VRE_FelineTail`, `VRE_PerfectBody`

## Rim-Gnoblins (3)

Workshop id 3018569666.

- skin colour (1): `Skin_GoblinDarkGreen`
- drawn (ears, tails, horns, marks, wings...) (2): `RG_GoblinEars`, `RG_GoblinNose`

## Rulzea Xenotype (3)

Workshop id 3020615186.

- beard (3): `GS_Rabbit_FurskinA`, `GS_Rabbit_FurskinB`, `GS_Rabbit_FurskinC`
- head shape (3): `GS_Rabbit_FurskinA`, `GS_Rabbit_FurskinB`, `GS_Rabbit_FurskinC`

## Erin's Corvyia (3)

Workshop id 3154954530.

- hair style (1): `ERN_CorvyiaBody`
- head shape (1): `ERN_CorvyiaHead`
- body (2): `ERN_AllFemale`, `ERN_CorvyiaBody`
- drawn (ears, tails, horns, marks, wings...) (1): `ERN_CorvyiaBody`

## The Profaned (3)

Workshop id 3202008037.

- skin colour (3): `BotchJob_RottingFlesh`, `BotchJob_RottingFleshBasic`, `BotchJob_SkeletalBody`
- beard (2): `BotchJob_RottingFlesh`, `BotchJob_SkeletalBody`
- head shape (2): `BotchJob_RottingFlesh`, `BotchJob_SkeletalBody`
- drawn (ears, tails, horns, marks, wings...) (2): `BotchJob_RottingFlesh`, `BotchJob_SkeletalBody`

## FRBE Addon - Gnolls (3)

Workshop id 3241073642.

- hair style (1): `SAB_GnollHead`
- beard (1): `SAB_GnollHead`
- head shape (1): `SAB_GnollHead`
- drawn (ears, tails, horns, marks, wings...) (2): `SAB_Ears_Fan`, `SAB_HyenaSkin`

## ↁ Elves (Continued) (3)

Workshop id 3272603920.

- skin colour (2): `DevDesigner_PaleSkin`, `DevDesigner_WhiteSkin`
- drawn (ears, tails, horns, marks, wings...) (1): `DevDesigner_DryadEars`

## Oni Xenotype (3)

Workshop id 3311134271.

- head shape (1): `OX_Oni_Head`
- drawn (ears, tails, horns, marks, wings...) (2): `OX_Eyes_Yellow`, `OX_Oni_Ear`

## Rim-Fogmen Continued! (1.6) (Biotech) (3)

Workshop id 3324678049.

- skin colour (3): `Chitin_HiverFog`, `Chitin_HiverFogDark`, `Chitin_HiverFogOG`

## The Cosmic Odyssey - Godwokens (3)

Workshop id 3453866993.

- drawn (ears, tails, horns, marks, wings...) (3): `ALE_Arcane_Circuit_Major`, `ALE_Arcane_Circuit_Minor`, `ALE_Arcane_Circuit_OD`

## Rimzone: Sons and Daughters of Helghan (3)

Workshop id 3492260324.

- skin colour (2): `Skin_HGpale`, `Skin_HGpalee`
- hair style (1): `Hair_Helghast`

## 出于沙漠之花 (3)

Workshop id 3494511060.

- skin colour (3): `SPSkin_NO1`, `SPSkin_NO2`, `SPSkin_NO3`

## Ashcat Xenotype (3)

Workshop id 3522775404.

- drawn (ears, tails, horns, marks, wings...) (3): `AC_Ears`, `AC_Eyes`, `AC_TrippleTail`

## Hyenid Xenotype (3)

Workshop id 3543131848.

- beard (1): `fullHyenid`
- head shape (1): `fullHyenid`
- drawn (ears, tails, horns, marks, wings...) (3): `fullHyenid`, `hyenidEars`, `hyneidTail`

## Big and Small - Muriden (3)

Workshop id 3597814862.

- drawn (ears, tails, horns, marks, wings...) (3): `Tail_Castoran`, `Tail_Muriden`, `Tail_Sciurus`

## Foxian League (3)

Workshop id 3639227864.

- drawn (ears, tails, horns, marks, wings...) (3): `FL_FoxEar`, `FL_FoxTail`, `FL_NineFoxTail`

## RimKimetsu - Demon Slayer Rimworld Mod (3)

Workshop id 3641720143.

- drawn (ears, tails, horns, marks, wings...) (3): `AA_DemonHorn_Curved`, `AA_DemonHorn_Devil`, `AA_DemonHorn_Swept`

## Rimspite Gitz: Loonclans (3)

Workshop id 3735204214.

- skin colour (3): `Skin_BoggleEyeGreen`, `Skin_JerryCustomGrotGreen`, `Skin_ZarbagGreen`

## MUGB Goblin (3)

Workshop id 3768425355.

- skin colour (2): `MUGB_Gene_GoblinCore`, `MUGB_Gene_HobgoblinFrame`
- head shape (2): `MUGB_Gene_GoblinCore`, `MUGB_Gene_HobgoblinFrame`
- body (2): `MUGB_Gene_GoblinCore`, `MUGB_Gene_HobgoblinFrame`
- drawn (ears, tails, horns, marks, wings...) (2): `MUGB_Gene_GoblinCore`, `MUGB_Gene_HobgoblinFrame`
- other cosmetic category (1): `MUGB_Gene_CrossEyed`

## Big and Small - Catfolk (3)

Workshop id 3802375059.

- drawn (ears, tails, horns, marks, wings...) (3): `DZ_CatfolkEars`, `DZ_CatfolkTail`, `DZ_PantheraTail`

## Anthrosonae Mongoose (3)

Workshop id 3802945828.

- skin colour (1): `LythC_AnthromongooseFur`
- head shape (1): `LythC_AnthromongooseFur`
- drawn (ears, tails, horns, marks, wings...) (2): `LythC_AnthromongooseEars`, `LythC_AnthromongooseTail`

## Neco Arc Genes (2)

Workshop id 2953392432.

- drawn (ears, tails, horns, marks, wings...) (2): `EarsNeco`, `EyesNeco`

## Vanilla Races Expanded - Sanguophage (2)

Workshop id 2963116383.

- hair style (1): `VRE_SanguineHair`
- drawn (ears, tails, horns, marks, wings...) (1): `VRE_BatNose`

## Nekomata Tail Genes (2)

Workshop id 2976801620.

- drawn (ears, tails, horns, marks, wings...) (2): `Tail_Nekomata`, `Tail_Nekomata_Psychic`

## World of Naruto (2)

Workshop id 3025338958.

- drawn (ears, tails, horns, marks, wings...) (2): `WN_Byakugan`, `WN_Sharingan`

## Duztamva's Misc (2)

Workshop id 3231645315.

- hair colour (2): `MarketHair_DarkBlue`, `MarketHair_RedOrange`

## Selective Retexture Based on Gene (2)

Workshop id 3377855600.

- body (2): `Gene_RealisticBody`, `Gene_XevaFemale`

## Very scuffed 1.5 Sergals (2)

Workshop id 3469468302.

- beard (1): `Fluffskin`
- head shape (1): `Fluffskin`
- drawn (ears, tails, horns, marks, wings...) (2): `Fluffskin`, `Tail_Sergal`

## Spirits (2)

Workshop id 3472437470.

- skin colour (1): `REDS_Body_Ectoplasm`
- hair colour (1): `REDS_Hair_Ectoplasm`
- drawn (ears, tails, horns, marks, wings...) (1): `REDS_Body_Ectoplasm`

## Doctor Mcninja Mod (2)

Workshop id 3511408960.

- beard (1): `Gorillaskin`
- head shape (2): `Gorillaskin`, `RadlanderHead`
- drawn (ears, tails, horns, marks, wings...) (1): `Gorillaskin`

## Posthuman Drift Warcat Xenotype (2)

Workshop id 3521815010.

- drawn (ears, tails, horns, marks, wings...) (2): `XylEyes_Yellow`, `XylFacialStripes`

## Crream's Yetis (2)

Workshop id 3529805799.

- beard (2): `BlueYetiskin`, `PinkYetiskin`
- head shape (2): `BlueYetiskin`, `PinkYetiskin`
- drawn (ears, tails, horns, marks, wings...) (2): `BlueYetiskin`, `PinkYetiskin`

## Novabeast xenotype (2)

Workshop id 3532520652.

- head shape (1): `FZ_Novabeast_Head`
- drawn (ears, tails, horns, marks, wings...) (1): `FZ_Novabeast_Tail`

## Goliann Xenotype (2)

Workshop id 3541961078.

- skin colour (1): `GS_Skin_Lavender_Purple`
- head shape (1): `GS_Warden_Head`

## GeneAndFactions (2)

Workshop id 3546863281.

- drawn (ears, tails, horns, marks, wings...) (2): `GF_CatEar`, `GF_SharkTail`

## Umamusume: Rim Derby (2)

Workshop id 3552197538.

- drawn (ears, tails, horns, marks, wings...) (2): `Ears_Umamusume`, `Tail_Umamusume`

## Geist Xenotype (2)

Workshop id 3564732214.

- head shape (1): `GS_Skullplate_Head`
- drawn (ears, tails, horns, marks, wings...) (1): `GS_Veilhorn`

## RIMWAAAGH — Orks of RimWorld [1.6] — WIP (2)

Workshop id 3577775737.

- head shape (2): `Why_Gene_OrkFace`, `Why_Gene_SnotlingFace`

## Badger Xenotype (2)

Workshop id 3618642160.

- head shape (1): `Bageard_Ears`
- drawn (ears, tails, horns, marks, wings...) (2): `Bageard_Ears`, `Bageard_FacialMark`

## Erin's Auraeyl (2)

Workshop id 3653150966.

- hair style (1): `ERN_AuraeylBody`
- head shape (1): `ERN_AuraeylHead`
- body (1): `ERN_AuraeylBody`
- drawn (ears, tails, horns, marks, wings...) (1): `ERN_AuraeylBody`

## Jujutsu Kaisen (2)

Workshop id 3658634704.

- drawn (ears, tails, horns, marks, wings...) (2): `JJK_Gene_KenjakuCT`, `JJK_Gene_SixEyes`

## Skeletal Efflorescence (2)

Workshop id 3685431818.

- head shape (2): `Eo3_AnomalyFace_Head`, `Eo3_TinyFace_Head`

## NyanDark 40k - Space Maids (2)

Workshop id 3697034827.

- skin colour (1): `BEWH_PrimarchSpecificGeneSpaceMaids`
- hair colour (1): `BEWH_PrimarchSpecificGeneSpaceMaids`
- drawn (ears, tails, horns, marks, wings...) (1): `BEWH_ChapterSpaceMaidsCatEars`

## Gloria A Las Plagas (2)

Workshop id 3708476081.

- hair style (2): `CCDevelopment_LasPlagas_Guadana_Head_Gene`, `CCDevelopment_LasPlagas_Mandibula_Head_Gene`
- beard (2): `CCDevelopment_LasPlagas_Guadana_Head_Gene`, `CCDevelopment_LasPlagas_Mandibula_Head_Gene`
- head shape (2): `CCDevelopment_LasPlagas_Guadana_Head_Gene`, `CCDevelopment_LasPlagas_Mandibula_Head_Gene`

## 햄스터 귀와 꼬리 (Hamster Ears and Tail) (2)

Workshop id 3718267131.

- drawn (ears, tails, horns, marks, wings...) (2): `Ears_Hamster`, `Tail_Hamster`

## Vanillafied Vivi (2)

Workshop id 3739051552.

- drawn (ears, tails, horns, marks, wings...) (2): `VVV_CosmeticAntennae`, `VVV_CosmeticWings`

## TouhouKyusakuStyle (2)

Workshop id 3769625965.

- drawn (ears, tails, horns, marks, wings...) (2): `HKTK_GengetsuWings_Gene`, `HKTK_KurumiWings_Gene`

## local:rjw-genes (2)

Workshop id local:rjw-genes.

- drawn (ears, tails, horns, marks, wings...) (2): `rjw_genes_succubus_tail`, `rjw_genes_succubus_wings`

## HousekeeperAssistanceCat (1)

Workshop id 1541620640.

- drawn (ears, tails, horns, marks, wings...) (1): `HKCat_TailNekomata`

## Zeta Reticulans [Player/Hostile Factions] (1)

Workshop id 2241841840.

- skin colour (1): `ZetaSkin_Melanin1`

## Biotech Expansion - Core (1)

Workshop id 2884018485.

- drawn (ears, tails, horns, marks, wings...) (1): `BTE_BeardlessFurskin`

## Det's Xenotypes - Stoneborn (1)

Workshop id 2888722722.

- head shape (1): `DV_BushyEyebrows`
- drawn (ears, tails, horns, marks, wings...) (1): `DV_BushyEyebrows`

## Oni of the Rim (1)

Workshop id 2891432261.

- drawn (ears, tails, horns, marks, wings...) (1): `OotR_Oni_LifelessEyes`

## Roo's HD Dreadlock Hairstyles (1)

Workshop id 2902544033.

- hair style (1): `Hair_DreadlocksOnly`

## Erin's Auronya (1)

Workshop id 2908837535.

- head shape (1): `ERN_AuronyaHead`

## More Biotech Style Genes - All in One (1)

Workshop id 2985153870.

- hair style (1): `MBSG_Hairless`
- beard (1): `MBSG_Hairless`

## Erin's Fenrisúlfr (1)

Workshop id 3020079359.

- head shape (1): `ERN_FenrisulfrHead`

## Nemi - magic rabbit (1)

Workshop id 3130332603.

- skin colour (1): `Nemi_Race`

## CrusaderWhale (1)

Workshop id 3171384758.

- skin colour (1): `OceanalVitality`

## FRBE Addon - Kuo Toa (1)

Workshop id 3242645366.

- hair style (1): `SAB_KTHead`
- beard (1): `SAB_KTHead`
- head shape (1): `SAB_KTHead`
- drawn (ears, tails, horns, marks, wings...) (1): `SAB_KTHead`

## FRBE Addon - Sionnari (1)

Workshop id 3243761451.

- hair style (1): `SAB_VulpineHead`
- beard (1): `SAB_VulpineHead`
- head shape (1): `SAB_VulpineHead`

## Star Wars KotOR Resources and Materials (1)

Workshop id 3254370945.

- head shape (1): `guy762_DebugHead_nullForDroids`

## Helluva Rimworld (1)

Workshop id 3259187548.

- hair style (1): `HelluvaRimworld_ImpSpike`

## Characters - Blue Archive (1)

Workshop id 3284538085.

- drawn (ears, tails, horns, marks, wings...) (1): `BA_KivotosStudentGeneral`

## Nice Facial Animation (1)

Workshop id 3302079637.

- beard (1): `Furskin`
- head shape (1): `Furskin`
- drawn (ears, tails, horns, marks, wings...) (1): `Furskin`

## Grimdark Recycling2 (1)

Workshop id 3363054797.

- head shape (1): `HT_Psychobodyfur`
- body (1): `HT_Psychobodyfur`
- drawn (ears, tails, horns, marks, wings...) (1): `HT_Psychobodyfur`

## Jimothy's Genes! (1)

Workshop id 3371751009.

- head shape (1): `JInv_HumanGene`

## Star Wars KotOR Factions (1)

Workshop id 3379096669.

- skin colour (1): `guy762_gene_sion`
- hair style (1): `guy762_gene_sion`
- beard (1): `guy762_gene_sion`
- drawn (ears, tails, horns, marks, wings...) (1): `guy762_gene_sion`

## Highborn Xenotype (1)

Workshop id 3380776687.

- head shape (1): `HBX_DaintyHead`

## Nice Facial Animation [ALT] (1)

Workshop id 3383871379.

- beard (1): `Furskin`
- head shape (1): `Furskin`
- drawn (ears, tails, horns, marks, wings...) (1): `Furskin`

## Moth's Project Moon Things (1)

Workshop id 3384372059.

- head shape (1): `Funeral_Head`

## Helltaker Xenotypes (1)

Workshop id 3395078682.

- skin colour (1): `SHX_Pale_Skin`

## Swarmpocalypse (1)

Workshop id 3447056193.

- drawn (ears, tails, horns, marks, wings...) (1): `LS_DragonHorns`

## Pawns Have Mouths (1)

Workshop id 3458303799.

- drawn (ears, tails, horns, marks, wings...) (1): `Mouth_Standard`

## HelixLabor Syndicate (1)

Workshop id 3502230756.

- other cosmetic category (1): `callousedflesh`

## make a zundamochi  +ankomochi (1)

Workshop id 3508333672.

- drawn (ears, tails, horns, marks, wings...) (1): `Ears_zunda`

## Animal Genes (1)

Workshop id 3510541507.

- skin colour (1): `ANG_Skin_DarkGray`

## Pesky's Bulwark Xenotype (1)

Workshop id 3521016438.

- drawn (ears, tails, horns, marks, wings...) (1): `Bulwark_Wings`

## Det's Xenotypes - Half-foot (1)

Workshop id 3530817307.

- head shape (1): `DV_Ears_Broad`
- drawn (ears, tails, horns, marks, wings...) (1): `DV_Ears_Broad`

## Nimi's Nightmare (1)

Workshop id 3549623851.

- drawn (ears, tails, horns, marks, wings...) (1): `Nimi_Gene_Tapir`

## Akaname (1)

Workshop id 3564157675.

- drawn (ears, tails, horns, marks, wings...) (1): `MGEI_FilthLicker`

## ME(b) - Asari (1)

Workshop id 3567441469.

- drawn (ears, tails, horns, marks, wings...) (1): `Asari_Crest`

## [kik] Wahsharch (1)

Workshop id 3601945326.

- drawn (ears, tails, horns, marks, wings...) (1): `Wahsharch_kikGene`

## Bill Doors' Frostnova Expanded Unofficial by Haqimi (1)

Workshop id 3656575228.

- drawn (ears, tails, horns, marks, wings...) (1): `BDFNE_Gene_EarAndTail`

## RimZone Zero: Ellen Joe (1)

Workshop id 3657773966.

- drawn (ears, tails, horns, marks, wings...) (1): `Thiren_SharkTail`

## Gardevoirs evolution (1)

Workshop id 3668080626.

- drawn (ears, tails, horns, marks, wings...) (1): `Galladebody`

## Koi's Mech-Androids for 1.6 (1)

Workshop id 3704669419.

- skin colour (1): `Noisy_Skin_Ancient`

## StickWorld (1)

Workshop id 3704784635.

- body (1): `Stickman_ThinBody`

## Bizarre Bloodlines (1)

Workshop id 3719429625.

- skin colour (1): `Bizarre_Gene_GreenSkin`

## Resident Rim (1)

Workshop id 3732795691.

- skin colour (1): `RE_ZombieSkin`
- drawn (ears, tails, horns, marks, wings...) (1): `RE_ZombieSkin`

##  Yet another neko xenotype - Nekotech Xenotype (1)

Workshop id 3736684475.

- hair colour (1): `Nekotech_BlueHair`

## Project Moon - Sweepers (1)

Workshop id 3761992483.

- skin colour (1): `PM_SuitBound`
- hair colour (1): `PM_SuitBound`

## Avian Genes (1)

Workshop id 3769643744.

- drawn (ears, tails, horns, marks, wings...) (1): `Drifter_AvianTail`

## Kemirman (1)

Workshop id 3793645542.

- hair style (1): `Kemir_CapybaraFur`
- beard (1): `Kemir_CapybaraFur`
- head shape (1): `Kemir_CapybaraFur`
- drawn (ears, tails, horns, marks, wings...) (1): `Kemir_CapybaraFur`

## Avian Xenotype - Eagle (1)

Workshop id 3808135566.

- head shape (1): `Drifter_Avian_Eagle_Fur`
- drawn (ears, tails, horns, marks, wings...) (1): `Drifter_Avian_Eagle_Fur`

## More Storylike Traits - Body and Mind 1.6 (1)

Workshop id 3811291787.

- other cosmetic category (1): `Storylike_Gene_Obese`

## Body Hair Framework (1)

Workshop id 3823805934.

- other cosmetic category (1): `BHF_NoBodyHair`

## local:amor-tentaculum (1)

Workshop id local:amor-tentaculum.

- other cosmetic category (1): `TStrip`

## local:rjw-elt-patches (1)

Workshop id local:rjw-elt-patches.

- drawn (ears, tails, horns, marks, wings...) (1): `ElToro_CosmeticFurskin`

## local:StorylikeBodyAndMind (1)

Workshop id local:StorylikeBodyAndMind.

- other cosmetic category (1): `Storylike_Gene_Obese`

