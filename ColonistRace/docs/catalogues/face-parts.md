# Face parts and kits: the dictionary

Read on 2026-10-09 from run ff33 (`PickleTools/evidence/face-list3`, step `Nelim's Pickle Tools: the facial animations are listed`), with the standard mod list of the Sanctuary map (`wsl-deps.sanctuary.map`). A mod list that lacks a mod lacks its names: the step fails and prints the valid ones. Photos of each value: not taken yet (planned, one contact sheet per part).

Steps (all start with `Nelim's Pickle Tools: `): `"<pawn>" mouth is "<name>"`, `brows are`, `lids are`, `face skin is`, `eyeballs are`, `face head shape is`, and the whole-face `"<pawn>" face kit is "<kit>"`.

**Photographs (2026-10-09, runs 90ae, 58ce, 504a; Tests/Pickle/.../pickletools-face-parts-gallery.feature).** One photograph per value, in the order of the tables, on Nelim of the save Nelims-tribe at 20 degrees. Each scenario starts from the kit neutral and sets one part value after another, so a photograph also shows the parts set earlier in the same scenario (the cheek mark of a skin stays on the later eyeball photographs): read the changed part, not the whole face. Sheets: docs/Make-PartSheets.ps1.

## Mouths (38)

Step texts: `"<pawn>" mouth is "<defName>"`

| Mod | Names |
|---|---|
| (none, Facial Animation core) | (11) MouthEdnaLipsMale, MouthLipsBigMale, MouthLipsSimpleMale, MouthLipsSimpleSmileMale, MouthLipsSmallSmileMale, MouthLipsSmirkMale, MouthLipsTinySmileMale, MouthLipsWorriedMale, MouthLittle, MouthNone, MouthSubtle |
| [NL] Facial Animation - Experimentals | (1) MouthNormal |
| Akeron Extras - Facial Animations | (3) AKN_MouthCourageous, AKN_MouthEmpathetic, AKN_MouthSwift |
| Vanilla Textures Expanded - [NL] Facial Animation | (23) MouthCaveman, MouthCheekFrown, MouthClassicSmile, MouthEdnaLips, MouthFatCheeks, MouthHawk, MouthLipsBig, MouthLipsSimple, MouthLipsSimpleSmile, MouthLipsSmallSmile, MouthLipsSmirk, MouthLipsTinySmile, MouthLipsWorried, MouthLittleFrown, MouthLittleGrin, MouthLittleSuperSmirk, MouthMrStreamer, MouthSad, MouthScowl, MouthSimpleMouth, MouthSmile, MouthSmirkSmile, MouthSmug |

## Brows (15)

Step texts: `"<pawn>" brows are "<defName>"`

| Mod | Names |
|---|---|
| [NL] Facial Animation - Experimentals | (1) BrowNormal |
| Akeron Extras - Facial Animations | (3) AKN_BrowCourageous, AKN_BrowEmpathetic, AKN_BrowSwift |
| Vanilla Textures Expanded - [NL] Facial Animation | (11) BrowEven, BrowFurryMonobrow, BrowFuzzy, BrowNone, BrowRaised, BrowSquare, BrowStreamer, BrowThin, BrowTriangle, MonoBrow, MonoScarredBrows |

## Lids (24)

Step texts: `"<pawn>" lids are "<defName>"`

| Mod | Names |
|---|---|
| (none) | (17) BIGEYE, LidAlmond, LidCheerful, LidFlashy, LidFlirty, LidHardened, LidNone, LidNormal, LidPointy, LidQuite, LidShort, LidSimple, LidSleepy, LidSquinting, LidStuffed, LidThick, LidUnimpressed |
| [VK]FacialAnimation add closed eyes | (2) LidVK_ClosedEyes, LidVK_SmilingEyes |
| Vanilla Textures Expanded - [NL] Facial Animation | (3) BionicBoth, BionicLeft, BionicRight |
| Visual beauty for Facial Animation | (2) Biotech_Eyes_Beauty, Biotech_Eyes_Beauty2 |

## Skins (22)

Step texts: `"<pawn>" face skin is "<defName>"`

| Mod | Names |
|---|---|
| [NL] Facial Animation - Experimentals | (3) SkinLeftChin, SkinNormal, SkinRightEye |
| Akeron Extras - Facial Animations | (1) AKN_SkinSnoot |
| Vanilla Textures Expanded - [NL] Facial Animation | (18) SkinBandaid, SkinBruise, SkinCheekbones, SkinCheekScar, SkinChinCleft, SkinCrowsFeet, SkinDecrepit, SkinEyeshadow, SkinForeheadScar, SkinForheadWrinkles, SkinFreckles, SkinFreckles2, SkinFreckles3, SkinFrownLines, SkinFurrows, SkinRosyCheeks, SkinSmileLines, SkinTiredEyes |

(`SkinForheadWrinkles` is spelled that way in the mod.)

## Eyeballs (10)

Step texts: `"<pawn>" eyeballs are "<defName>"`

| Mod | Names |
|---|---|
| (none) | (7) BIGEYE, EyeBig, EyeNone, EyeNormal, EyeSmall, EyeThin, EyeWide |
| EyeGenes3 | (3) Courageous, Empathetic, Swift |

## Head shapes (5)

Step texts: `"<pawn>" face head shape is "<defName>"`

| Mod | Names |
|---|---|
| [NL] Facial Animation - Experimentals | (3) HeadNormal, HeadPointy, HeadSquare |
| Visual beauty for Facial Animation | (2) Beauty, Beauty2 |

## Rhyaeth Facial Animation (Workshop 3736699447, packageId lucius.rhyaethfa)

Read 2026-11-03 from the mod folder (supports 1.6 and 1.7; needs Nals Facial Animation and Erin's Rhy'aeth). Names only, not photographed. It defines **no FaceAnimationDef**: no expression or animation of its own (see face-animations.md). It adds face parts, all with `targetGeneDefs` `ERN_RhyaethHead`, so they apply to a pawn that has that gene. A patch removes `forcedHeadTypes` from `ERN_RhyaethHead`: the head then comes from the FA head part below.

| Part | Step | Names |
|---|---|---|
| Head shape (1) | `face head shape is` | ERN_FA_Rhyaeth_Head |
| Mouth (2) | `mouth is` | ERN_FA_Rhyaeth_Mouth, ERN_FA_Rhyaeth_InvisibleMouth (probability 0) |
| Brow (1) | `brows are` | ERN_FA_Rhyaeth_Brow (colour of the skin) |
| Eyeball (1) | `eyeballs are` | ERN_FA_Rhyaeth_Eye (black; colourable with Eye Genes 3) |
| Lid (1) | `lids are` | ERN_FA_Rhyaeth_Lid |

The brow, eyeball and lid come from a compatibility folder, loaded only with Vanilla Textures Expanded facial animations (`VanillaExpanded.VTEXE.FacialAnims`) or with Moving Vanilla Eyes / Vanilla Experimentals (`sd.fa.movingvanillaeyes`); the texture changes with the set (static, moving). Without one of them the mod adds only the head and the two mouths. The step `face skin is` has no Rhy'aeth skin: the skin parts stay those of the other sets.

Open, not proved in game: whether the vanilla mouths, brows and lids of Facial Animation stay selectable on a pawn with `ERN_RhyaethHead`. The part steps set a part by name without checking `targetGeneDefs`, so they accept any of them; whether the game keeps the vanilla part when the pawn is drawn is not read.

## Heat

A kit or part step leaves the heat face (sweat, blush) of the room. To photograph a clean face, follow the parts or kit with `facial expression is "normal"` (proved on a photo, run 4a58); see FACIAL-ANIMATIONS.md for the 55 animations.
