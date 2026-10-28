# Seren, from Stardust [Biotech Fork]: catalogue

Read 2026-10-25 from the mod folder (Workshop 3726565301, packageId `odysseylotus.serenbiotech`, supports 1.6 and 1.7; 1.6 and 1.7 hold the same defs). Names only: this catalogue is what the XML defines, not a photograph. Colour, look and ear genes (hair, skin, markings, sensors, ears, eyes, body masks) are in `genes.md`; this file lists the rest and, above all, the face parts, which are loaded by a compatibility folder and not by the main defs.

Mod folder: `C:/Program Files (x86)/Steam/steamapps/workshop/content/294100/3726565301`.

## Which face set is loaded

`LoadFolders.xml` picks one face-part set by active mods. Defs of a set that is not loaded do not exist: asking the step for one of them fails.

| Set (folder under `1.6/Compatibility/`) | Loaded when |
|---|---|
| Facial Animations - Experimentals | `Nals.FacialAnimation` and `Nals.FacialAnimationExperimentals` active. **This is the set of the NSB map `wsl-deps.sanctuary-seren.map`.** |
| Facial Animations - Vanilla Textures Expanded | `Nals.FacialAnimation` and `VanillaExpanded.VTEXE.FacialAnims` active, Experimentals not active |
| Facial Animations - NiceFA | `Andromeda.FacialAnimation` (or `.ALT`) active |

All face parts target the gene `OL_SerenEyes` (skin parts target a marking gene): a pawn without `OL_SerenEyes` does not get them.

## Experimentals set (the one NSB loads)

| Part | defNames | Notes |
|---|---|---|
| Head (3) | SerenHeadNormal, SerenHeadPointy, SerenHeadSquare | texPath `Things/Pawn/Seren/Heads_Blank/<Name>` |
| Lids (7) | SerenLidNormal, SerenLidGeek, SerenLidPointy, SerenLidFlashy, SerenLidQuite, SerenLidSleepy, SerenLidSharp | `SerenLidGeek` is `gender` Female only. `Quite` is the spelling in the def |
| Eyeballs (4) | SerenEyesNormal, SerenEyesDull, SerenEyesIntense, SerenEyesEmpty | probability 1 (Normal), 0.25, 0.25, 0.1 |
| Brows (2) | SerenBrowNormal, SerenBrowThick | |
| Mouth (2) | SerenMouthNormal, SerenMouthHappy | `SerenMouthHappy` has probability 0: never random, set it by name only |
| Emotion (1) | SerenEmotionNormal | an `EmotionTypeDef`, not a face part of the Nelim step |
| Skin (7) | SerenBrows, SerenCenterLarge, SerenCenterSmall, SerenCheeks, SerenFreckles, SerenTarget, SerenTriStar | each targets one marking gene: SerenMarkings_Brows, _Big, _Small, _Cheeks, _Freckles, _Target, _Tristar |

The patch of this set removes the `renderNodeProperties` of `OL_SerenEyes` and of the 7 marking genes (the face parts draw them instead) and swaps the ear texture to `Things/Seren/Ears/FacialAnimations/SerenEars`.

## Names NSB failed on: `SerenLidCheerful` and `SerenLidSimple`

They do not exist in any set. Nearest names:

| Asked | Set | Real defName | Texture |
|---|---|---|---|
| SerenLidCheerful | Vanilla Textures Expanded only | **OL_SerenLidCheerfulFA** | `Things/Pawn/Seren/Lids/Cheerful` |
| SerenLidSimple | Vanilla Textures Expanded only | **OL_SerenLidSimpleFA** | `Things/Pawn/Seren/Lids/Simple` |

These two are not loaded with Experimentals. To have a cheerful or simple Seren lid on the NSB map, either load the VTE facial animation set (`VanillaExpanded.VTEXE.FacialAnims`, and then Experimentals must be off: the folders are exclusive), or pick an Experimentals lid: for a cheerful look `SerenLidFlashy` or `SerenLidNormal`, for a plain one `SerenLidNormal`. Only a photograph of each tells which fits; none is made yet.

## Vanilla Textures Expanded set (not loaded by NSB)

The VTE set builds its parts inside one patch (it needs the mod `Vanilla Textures Expanded - [NL] Facial Animation`), and keeps the vanilla head types.

| Part | defNames |
|---|---|
| Eyeballs (4) | OL_SerenEyeNormalFA, OL_SerenEyeWideFA, OL_SerenEyePointyFA, OL_SerenEyeDullFA (Female only) |
| Lids (11) | OL_SerenLidNormalFA, OL_SerenLidAlmondFA, OL_SerenLidCheerfulFA, OL_SerenLidUnimpressedFA (texture `Sleepy`), OL_SerenLidFlirtyFA (texture `Flashy`), OL_SerenLidStuffedFA, OL_SerenLidHardenedFA, OL_SerenLidSimpleFA, OL_SerenLidSquintingFA, OL_SerenBionicLeftFA, OL_SerenBionicRightFA (the two bionic ones have probability 0) |
| Brows (1) | OL_SerenBrowNone |
| Skin (7) | same names as Experimentals (SerenBrows ... SerenTriStar) |
| Colour | OL_SerenEyes_FAColor |

Its second patch (`Remove_Biotech_Markings_When_FA`) removes the render nodes of the eyes and the markings, as Experimentals does.

## NiceFA set (not loaded by NSB)

| Part | defNames |
|---|---|
| Head (6) | SerenHeadNormal, SerenHeadNormalPointy, SerenHeadNormalWide, SerenHeadNarrow, SerenHeadNarrowPointy, SerenHeadNarrowWide |
| Lids (6) | SerenLidNormal, SerenLidStuffed, SerenLidWide, SerenLidAccentuated, SerenBionicLeft, SerenBionicRight (the two bionic ones have probability 0) |
| Eyeballs (8) | SerenEyesNormal, SerenEyesDull, SerenEyesBright, SerenEyesIntense, SerenEyesFragmented, SerenEyesEmpty, SerenEyeBionicLeft, SerenEyeBionicRight (the two bionic ones have probability 0) |
| Brows (5) | SerenBrowNormal, SerenBrowWide, SerenBrowMighty, SerenBrowThick, SerenBrowTanuki |
| Mouth (1) | SerenMouthNormal |
| Skin (7) | SerenBrows, SerenCenterLarge, SerenCenterSmall, SerenCheeks, SerenFreckles, SerenTarget, SerenTriStar |

The head, lid, eye and brow defNames of NiceFA and Experimentals overlap (`SerenHeadNormal`, `SerenLidNormal`, ...) but never load together: the three sets are exclusive.

## Genes not photographed in `genes.md`

| Gene | What it is |
|---|---|
| OL_SerenPhysiology | core gene of the xenotype (label "seren physiology") |
| OL_SerenBlood | Seren blood: blood colour, leather `OL_SerenLeather`, filth `OL_SerenBloodFilth`, `OL_SerenBloodSmear` |
| OL_DarkVision | dark vision |
| OL_ElongatedFingers | elongated fingers (hands) |

Genes of colour: 13 skin (`OL_Skin<Teal, Cobalt, Indigo, Royal, Violet, Plum, Orchid, Magenta, Rouge, Albino, Twilight, Nebula, Planetary>`) and 19 hair (`OL_Hair<Sky, Powder, Periwinkle, Aegean, Navy, Lapis, Lilac, Lavender, Mauve, Indigo, Eggplant, Plum, Wisteria, Blush, Rose, Berry, Wine, Amaranth, Albino>`): hex in `genes.md`.

## Xenotype

One: **OL_SerenBase** (label "seren"). Genes: OL_SerenPhysiology, OL_SerenBlood, OL_SerenEyes, OL_SerenEars, OL_DarkVision, OL_ElongatedFingers, Hair_Grayless, Beard_NoBeardOnly (Ideology), Body_Thin, Body_Standard, Libido_Low, and the pools above (13 skin, 19 hair, 8 sensors, 7 markings, 6 body masks). Name makers: `NamerSerenMale`, `NamerSerenFemale` (name banks `SerenFirstMale`, `SerenFirstFemale`, `SerenLast`, `SerenDeity` in `Common/Languages/English/Strings/NameBanks/`).

## Pawn kinds

Concrete kinds (all race Human, xenotype OL_SerenBase). Step `a colonist of kind "<defName>"`.

| Group | defNames |
|---|---|
| Player | OL_SerenColonist, OL_SerenSettlersPlayer |
| Civil | OL_SerenRefugee, OL_SerenSlave, OL_SerenWanderer, OL_SerenCivilLeader, OL_SerenTrader |
| Rough (raiders) | OL_SerenGrenadier, OL_SerenSimpleGunner, OL_SerenLightGunner, OL_SerenGunner, OL_SerenHeavyGunner, OL_SerenSniper, OL_SerenMeleeUltratech (label "seren combatant"), OL_SerenCommander |
| Royalty | OL_SerenAstropath, OL_SerenStellaregis, OL_SerenPureOne (psycaster models, Royalty only) |

Abstract (not usable): OL_SerenPawnkindBase, OL_SerenCivilModel, OL_SerenRoughModel, OL_SerenPlayerModel, OL_SerenPsycasterModel. Vanilla Psycasts Expanded adds more in `Compatibility/VanillaPsycastsExpanded/Defs/PawnKindDefs/PawnKinds_Seren_VPE.xml`, not listed here.

## Other defs

| Kind | defNames |
|---|---|
| Factions | OL_CivilSerenFaction ("seren civil colony"), OL_SerenRoughFaction ("rough seren faction"), OL_SerenPlayerColony ("Seren colony") |
| Scenarios | OL_SerenPrisonCrash ("Seren Prison Ship Crash"), OL_SerenRelocated ("Forced Relocation") |
| Items | OL_SerenLeather, OL_SerenSensor_Item ("seren sensor"), OL_Drug_Serenity (drug "serenity", hediffs OL_SerenityHigh, OL_SerenityTolerance, OL_SerenityAddiction, OL_SerenityWithdrawal) |
| Filth | OL_SerenBloodFilth, OL_SerenBloodSmear |
| Culture (Ideology) | `Cultures_Seren.xml` |
| Backstories | 58 `SerenBackstories.xml` entries (children: SerenOrphan ... SerenQuietChild; adults: SerenPOW ... SerenPriest) |

## Photographs

Sheets are in `ColonistRace/docs/img/looks/<NNN> <label> - <mod> - <page>.jpg` (one tile per value in `looks/tiles/<NNN>-<key>.jpg`).

| What | Sheet | State |
|---|---|---|
| Skin colour genes (13) | `skingene-seren-from-stardust-biotech-fork-1.jpg` | done |
| Hair colour genes (19) | `hairgene-seren-from-stardust-biotech-fork-1.jpg` | done |
| Look genes (23): markings 7, sensors (horns) 8, ears, eyes, body masks 6 | `lookgene-seren-from-stardust-biotech-fork-1.jpg` | done |
| Face parts (Experimentals: 3 heads, 7 lids, 4 eyeballs, 2 brows, 2 mouths) and 7 marking skins | `parts-seren-*` (to build) | filed 2026-10-25, feature `pickletools-seren-face-gallery` (generator `docs/Generate-SerenGallery.js`, map `wsl-deps.seren-face-gallery.map`) |
| The whole Seren pawn, female (Nelim) and male (Soren), front, side, back | `seren-xeno-*` | same feature |

Not photographed: pawn kinds (their look comes from random gear and the same xenotype, so a portrait of each shows nothing the xenotype photograph does not), and the face sets of VTE and NiceFA (not loaded by NSB).

## What to do for the looks of Ada and Koji

1. The face is picked by name per part: head, lids, eyes, brows, mouth and skin come from the Experimentals table above. Every name there exists on the NSB map.
2. A face part only draws on a pawn that has the gene `OL_SerenEyes`; a skin part only with its marking gene.
3. The photographs of the Experimentals face parts are in the table above (filed, not yet read).
