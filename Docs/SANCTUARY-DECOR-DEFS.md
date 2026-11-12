# Decor defs available in the sanctuary map (2026-11-07)

Read by a script from the Defs of the 31 mods of `Tests/Pickle/wsl-deps.sanctuary-decor-mods.map` (name patterns, not exhaustive; `T:` means ThingDef or TerrainDef). Used to write batch 5 (NSB verdict on 3a, 3b, 4a). Verify a name in a run (a decor with no def fails the step) before relying on it.

| Need | Defs (mod) |
|---|---|
| Throne, high seat, armchair | `milple_Throne`, `milple_GrandThrone`, `milple_Armchair` (Korean Style Furniture); `Yuran_chair_Throne`, `Yuran_chair_one`, `Yuran_chair_two` (Yuran); `RLE_LeatherChair`, `RLE_RelaxChair`, `RLE_SimpleChair` (Rim Life furniture); `MUS_Fishing_CaneChair` |
| Statues, sculptures | `Yuran_Statue_lion`, `_buddha`, `_Bosatsu`, `_KongKim`, `_fox`, `_rabbit`, `_mouse`, `_stoneone`, `_stonetwo`, `_gorinto`, `_tower`, `_pagoda`, `_baldachine` (and `...small` variants) (Yuran) |
| Columns, pillars | `Yuran_Column_one/two/three`, `Yuran_woodColumnBase`, `AKN_PillarA/B`, `MUS_Fishingstyle_Column`, `MUS_Fishingstyle_DecorativeColumn` |
| Banners, flags, drapes | `Yuran_FlagBase`, `Yuran_FlagFaction`, `Yuran_FlagFactionSmall`, `YR_Drape_Base`, `YR_Drape_sakura`, `YR_BigDrape_sakura`, `WMFF_WallDrape` |
| Hanging scrolls, paintings | `Yuran_scroll_*` (30 names, e.g. `Yuran_scroll_BDX`), `DecorativePainting_*` (vanilla, used in 3a/3b), `RLE_ArialeAndonOil` |
| Rugs, carpets | `MUS_Fishing_RattanCarpet`; carpets as floor: `RLE_HGSinpCarpetSynthread`, `RLE_BeautyCarpDevilstrandCloth`; gilded floor: `RLE_SquareGoldTile`, `RLE_CoordGoldTile`; jade floor: `RLE_StoneSimpleJade`, `RLE_JadeBeautyStone` (terrain) |
| Cabinets, sideboards, bookcases | `YR_SmallBookcase`, `Yuran_OldCabinet`, `Yuran_BigOldCabinet`, `Yuran_LowCabinet`, `Yuran_LowBigCabinet`, `YR_Cupboard`, `MUS_Fishing_RattanCabinet`, `Shelf` (vanilla, faces the wrong way at 185,124) |
| Candles, warm light | `Yuran_CandleStand_one/two/three`, `ED_Candles`, `AtwoodCandles`, `AtwoodCandlesB`, `milple_TorchLampR`, `milple_TorchWallLamp`, `YR_Random_lantern` |
| Pots for plants | `PlantPot` (vanilla), `KCB_Potting_A` to `_H`, `MUS_Fishing_Potting`, `Erin_BonsaiPot`, `YR_ArtPot` |
| Cushions, zabuton, mats | `Erin_Zabuton`, `RLE_SimpleCushion`, `ED_Doormat` |
| Screen | `Erin_Shoji` |
| Fence | `LP_PlayFence` (Little Playgrounds) only; no hedge def found. Low hedges: use `Plant_Bush` in a line |
| Troughs, hay, feeders | none found by name; `ED_PetBowl`, `bambooBundle`, `Yuran_PenMarker`, `LP_ShadeCanopy` are the proven ones |
| Tableware, tablecloth | none found by name in these mods (Tabletop Decorations `milple_*` tabletop pieces: `milple_VaseB`, `milple_Table1x2c`, `milple_CStoolS` proven) |
| Hedge-like plants | `SCSunflowerBush`, `SCFloweringPincushionCactus`, `Plant_Bush` |
