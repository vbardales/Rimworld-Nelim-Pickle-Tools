# Looks: hairstyles, beards, head types, tattoos, bodies

Read on 2026-10-18 from run `20261018-003441-640-4813` (feature `pickletools-look-catalogue`, commit d4f4e67 plus the map of 83d1d3e; `Tests/Pickle/Evidence/look-catalogue`), with the mods of `wsl-deps.look-catalogue.map`: vanilla and DLCs (Royalty, Ideology, Biotech, Anomaly, Odyssey), the Sanctuary body and facial animation mods. A mod missing from the list lacks its names. Names are the defNames the look steps take (`Nelim's Pickle Tools: "<pawn>" hairstyle is "<name>"`, and the matching beard, head type and tattoo steps of ColonistRace; the body type has no look step yet (the list is for choosing a pawn body, e.g. through a ColonistRace body step if one is added)). A hairstyle may carry a gender in the log; a head type too; a tattoo its type (Face or Body). Photographs of each value: not taken yet.

## Hairstyles (80)

Step texts: `"<pawn>" hairstyle is "<defName>"`

| Mod | Names |
|---|---|
| Anomaly | (18) DoubleTuft, Ghoul_Furious, Ghoul_Hungry, Ghoul_Ravenous, Ghoul_Twisted, Ghoul_Vengeful, Ghoul_Warped, Ghoul_Wicked, LargeTuft, LongMess, LongOily, Parted, PatchyShave, RoughShave, ShavedMohawk, ShortCut, SideCut, SideSpikes |
| Core | (51) Afro, Bald, Bob (Female), Bowlcut (Male), BraidedKnot, Bravo (Male), BriefPonytail (Male), Burgundy (Male), Cleopatra (Female), Curly (Female), Cute (Female), Decent (Female), Elder (Male), FancyBun (Female), Firestarter (MaleUsually), Flowy (Female), Fringe (Female), Frozen (Female), GreasySwoop (Male), Junkie (FemaleUsually), Keeper (FemaleUsually), Lackland (Male), Locks (MaleUsually), Long (Female), Messy (Male), Mohawk (MaleUsually), Mop (MaleUsually), Pigtails (Female), Ponytails (Female), Primal (FemaleUsually), Princess (Female), Randy (MaleUsually), Recruit (Male), Revolt (Male), Rockstar (Male), Rookie (MaleUsually), Savage (MaleUsually), Scatman (Male), ScorpionTail, Scrapper (FemaleUsually), Senorita (Female), Shaved, ShaveTopBraid, Snazzy (Male), Spikes (MaleUsually), Sticky, Topdog (Male), Troubadour (Male), Tuft (MaleUsually), Warden (FemaleUsually), Wavy |
| Royalty | (11) Anne (Female), Artist (Female), Elisabeth (Female), Henry (Male), Jane (Female), Lisa (Female), Mary (Female), Richard (Male), Stephen (Male), Victoria (Female), William (Male) |

## Beards (41)

Step texts: `"<pawn>" beard is "<defName>"`

| Mod | Names |
|---|---|
| Biotech | (10) BeardFurskinKnots, BeardFurskinMegabraid, BeardFurskinMonkey, BeardFurskinMoustache, BeardFurskinScruffy, BeardFurskinSenile, BeardFurskinSideChops, BeardFurskinSideTufts, BeardFurskinStrongChops, FurskinCurlyMoustache |
| Core | (31) Anchor, BeardCurly, Boxed, Braided, Bushy, BushyStyled, Circle, Classy, Curtain, Ducktail, Fork, French, Full, Goatee, Lincoln, LongDutch, Machete, Moustache, MuttonChops, NoBeard, Norse, OldDutch, Seer, SideWhiskers, SoulPatch, StacheAndChops, Stubble, TriBraid, Urist, VanDyke, Wizard |

## Head types (37)

Step texts: `"<pawn>" head type is "<defName>"`

| Mod | Names |
|---|---|
| Anomaly | (10) CultEscapee, DarkScholar_Female (Female), DarkScholar_Male (Male), Ghoul_Heavy, Ghoul_Narrow, Ghoul_Normal, Ghoul_Wide, Leathery_Female (Female), Leathery_Male (Male), TimelessOne |
| Biotech | (13) Female_HeavyJawNormal (Female), Furskin_Average1, Furskin_Average2, Furskin_Average3, Furskin_Gaunt, Furskin_Heavy1, Furskin_Heavy2, Furskin_Heavy3, Furskin_Narrow1, Furskin_Narrow2, Furskin_Narrow3, Gaunt, Male_HeavyJawNormal (Male) |
| Core | (14) Female_AverageNormal (Female), Female_AveragePointy (Female), Female_AverageWide (Female), Female_NarrowNormal (Female), Female_NarrowPointy (Female), Female_NarrowWide (Female), Male_AverageNormal (Male), Male_AveragePointy (Male), Male_AverageWide (Male), Male_NarrowNormal (Male), Male_NarrowPointy (Male), Male_NarrowWide (Male), Skull, Stump |

## Tattoos (31)

Step texts: `"<pawn>" face tattoo is "<defName>"` and `"<pawn>" body tattoo is "<defName>"` (the Face or Body type is shown in brackets)

| Mod | Names |
|---|---|
| Core | (2) NoTattoo_Body (Body), NoTattoo_Face (Face) |
| Ideology | (29) Body_Buttons (Body), Body_Cross (Body), Body_Heart (Body), Body_Insect (Body), Body_Jester (Body), Body_Moon (Body), Body_Power (Body), Body_Rings (Body), Body_Royal (Body), Body_Scar (Body), Body_Skeleton (Body), Body_Skull (Body), Body_Spike (Body), Body_Sun (Body), Body_Tiger (Body), Body_Wings (Body), Face_Cobweb (Face), Face_Eclipse (Face), Face_Headshot (Face), Face_Line (Face), Face_Love (Face), Face_Oracle (Face), Face_Pantheon (Face), Face_Spider (Face), Face_Stars (Face), Face_Tear (Face), Face_Tiger (Face), Face_Warpaint (Face), Face_Worried (Face) |

## Body types (7)

Step texts: none yet in the look steps (the values are listed for the sessions that choose a body)

| Mod | Names |
|---|---|
| Biotech | (2) Baby, Child |
| Core | (5) Fat, Female, Hulk, Male, Thin |

