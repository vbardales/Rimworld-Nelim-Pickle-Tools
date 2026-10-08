# The two shared fixtures: `test-colony` and `nelim-zen-meadow-studio`
> **2026-10-08: the fixture `nelim-zen-meadow-studio` and the whole flower meadow / zen studio were deleted** (owner decision: galleries are shot at the Sanctuary, save `Nelims-tribe`, mod SanctuaryBacklot). The text below describes what existed and is kept as history; `I frame the studio` now fails with where to go.

What a suite can assume about the maps it loads. **Read from the `.rws` files on 2026-09-29 by the Night Change
session (a static read, never loaded in a game for this page)**, with one relayed observation marked as such.
Coordinates are `(x, z)`, the way Pickle's steps and `IntVec3` spell them. "Free" below means *no thing at all
stands on the cell* in the save; **terrain (water, mountain floor, rock) was NOT decoded**, so a free cell can
still be unbuildable. Check with a step that fails loudly when the spot is unusable (Night Change's bedroom
builder asserts the room is indoor, and `Driver.SpawnAt` asserts every spawn).

The reading script is `Read-Fixture.ps1` in the Night Change session's scratchpad; it is not kept. To redo the
count, load the file as XML (`savegame/game/maps/li/things/thing`) and group by `def`.

| | `test-colony` | `nelim-zen-meadow-studio` |
| --- | --- | --- |
| Where | Pickle's own fixture (`Pickle/Fixtures/test-colony.rws` in the Workshop item 3791648678) | `ScreenshotStudio/Mod/Pickle/Fixtures/`, built by `ScreenshotStudio` (`the flower meadow studio is prepared`) |
| Game version saved with | 1.6.4633 | 1.6.4871 |
| Scenario, start tile | Crashlanded, tile 113288 | Crashlanded, tile 113288 (same world) |
| Map size | **250 x 250** | **250 x 250** |
| Things on the map | 1,693 | 28,100 |
| Game tick at load | 67,868 | 75,388 |
| Weather | Clear | (not read) |
| Maps | 1 | 1 |
| Mods it was saved with | Core, Royalty, Ideology, Biotech, Anomaly, Odyssey, Harmony, Pickle (plus two unrelated development mods) | the five DLC, Harmony, RimLogging, Pickle, PickleTools companions |

## `test-colony`

**Colonists** (present in the save, not spawned by a step): **Jet** (114, 203), **Larson** (109, 203),
**Morrison** (110, 203), and a macaw **Clover** (135, 168). Kind `Colonist`, faction the player's. Worn at load:
Jet basic shirt, pants, advanced helmet; Larson collar shirt, flak pants; Morrison collar shirt, pants, flak vest.
Four unowned donkeys stand around (136-140, 171-178).
*Relayed, not checked here:* the Epona Instruments suite reports finding colonists named **"Jet" and "Keeper"** by
name; the save read here holds Jet, Larson and Morrison, so either a step renames a pawn or that suite runs on a
different build of the fixture. Do not rely on the third name without loading the save.

**Hostile insects are already on the map**, which matters to any test that reads the danger watcher or that
puts a pawn to sleep: hive (41, 47) with two egg sacs (35, 46) and (39, 49) and glow pods (40, 51), (36, 51);
second hive (92, 155) with a glow pod (93, 156); six insects in faction 11 near (90-96, 157-161) (two
megaspiders, three megascarabs, a locust). Whether they raise the story danger at load was not measured.

**Structures.** A ruin of 230 walls and ancient props in the band **x 89-136, z 141-167**: wall blocks at
(103-106, 141-145), (89-99, 151-162), and a roofed complex (124-136, 159-167) with doors (130, 167), (140, 164),
(136, 161), (131, 159), (136, 154), (140, 159); five beds in a row (131-135, 166); a cooler (132, 150); six
batteries (144-149, 162); wind turbines (147, 171), (147, 184); solar panels (145, 174), (145, 178), (149, 180);
hidden conduits along x=131 and z=163; ancient wrecks (cars, engine blocks, cryptosleep caskets, exostrider
parts) in the same area. Two stockpile zones; six areas in the area manager. 802 rubble filth things, mostly
in that band.

**Plants and items.** 109 grass, 19 saguaro, 13 pincushion cactus, 6 drago trees, a few bushes: a sparse
desert, so most of the 250 x 250 map carries nothing. Items: 18 steel, 5 wood logs, 6 survival meals, 2 medicine.

**Free space.** Outside the band above and the two hive sites, the map is thing-free: 44,229 origins for a
9 x 9 square and 49,152 for a 7 x 7 square have no thing on any cell, and **(30, 30) is one of them** (the
nearest hive is at (35, 46), 10 cells away, so a suite building there should clear hostile things first).
The relayed observation: repeated construction near **(144-148, 155)** raised no placement failure across several
Epona scenarios (a music spot at (146, 155), a table at (148, 155), items at (144, 155)); that is inside the
ruin band and next to the batteries, and nothing wider was surveyed.

**Needs Ideology (relayed, not checked here).** The AncientSalvage session reported on 2026-10-01 (evidence in
`AncientSalvage/Tests/Pickle/Evidence/full-sans-ideology-en-2930cfd`) that `test-colony`, saved with the five DLC, does not
play in a pass that removes Ideology: every scenario that loads it fails with "Exception ticking Larson ...
NullReferenceException at Verse.Pawn_AgeTracker.AgeTickInterval", vanilla frames only. No control run without that mod. A pass
without Ideology therefore cannot use this fixture; no Ideology-free fixture is known or planned here.

**Not established:** biome and terrain of any cell, rivers or lakes, roofs (a roof grid exists, its content was
not read), the research state, the hour of day at load (only the tick is known), beds owned by colonists.

## `nelim-zen-meadow-studio`

A dressed variant of the same world, made for presentation captures. Same 250 x 250 map, same start tile, same
ruin, plus a built garden (28,100 things, of which 25,373 grass, 970 dandelions, 628 daylilies, 302 pine trees,
128 roses).

**Colonists** (seven humans and the macaw): Jet, Larson, Morrison and Clover **all at (125, 81)** (stacked on one
cell); **Ambre** (96, 125), **Flore** (153, 125), **Soleil** (125, 154), **Miel** (154, 98). Worn: Ambre and
Flore basic shirt and pants; Soleil collar shirt and pants; Miel pants and collar shirt.

**Built things**: 268 walls, 3 doors, 3 beds at (119, 157), (125, 157), (131, 157); dining chairs
(151, 122), (155, 122), (123, 152), (127, 152); end tables (120, 158), (126, 158), (132, 158); tables 2x2
(153, 122), (125, 152); shelves (101, 120), (159, 120), (119, 92), (131, 92); stools (92, 128), (98, 128);
seven bonsai pots; eight torch lamps; a tailoring bench (92, 130), a stonecutter's table (98, 130), a
sculpting table (92, 121), a stove (150, 130), a butcher table (157, 130).

**Free space:** none in the sense above: grass covers the map. A step that builds here must clear plants
(Night Change's `Driver.Clear` destroys every destroyable non-pawn thing on the cells it needs). No hostile
things are on this map.

**Zones, from `ScreenshotStudio/Source/StudioSteps.cs` (2026-09-29, read from source, not loaded in a game;
searched for a screenshot of the whole studio to check against and found none)**, all offsets from the map
centre `(125, 125)`:

- **Indoor (the four pavilions, cutaway roofs, no roof over any of them):** workshop around **(96, 125)**
  (`I frame the studio "workshop"`, zoom 12) — tailoring bench, stonecutter, sculpting table, two stools, a
  shelf; kitchen around **(154, 125)** — stove, butcher table, a 2x2 table, two dining chairs, a shelf; home
  around **(125, 154)** — three beds, three end tables, a 2x2 table, two dining chairs; **display** around
  **(125, 96)** — furniture on the edges only, its own centre cell **(125, 96)** kept clear on purpose ("a large
  empty centre for mod demonstrations", the source's own words) and asserted standable by `the flower meadow
  studio is intact`.
- **The central mosaic ("the smiley"):** a **33 x 33** tile block, roughly **x 109-141, z 109-141**, painted
  cell by cell from `IconMosaic.Rows` (an ASCII bitmap in source): a black (`K`) outline, one yellow (`Y`) patch
  near the top, one single white (`W`) pixel, the rest orange (`O`) — over 300 painted tiles, **most of them
  orange**, with **solid orange blocks several cells wide and tall inside the shape** (not one single named
  3x3 zone, several). Framed by `I frame the studio "emblem"` (zoom 20) or `"overview"` (zoom 45, the whole
  studio). Checked cell by cell by `the flower meadow studio is intact`, so this shape is asserted on every
  build of the fixture, not just read once.
- **Outdoor named shots**, same offset scheme: flowers **(154, 98)**, pond **(153, 152)** (deep water at
  (152,148), a bridge at (151,152)), zen **(97, 152)** (dry sand), all zoom 12-16. Outside the built pavilions
  and the mosaic, the rest of the 250 x 250 map keeps the ruin, hives and sparse desert of `test-colony` (this
  page's other column): the studio preparation only touches a ~90-cell radius around the centre.

## What to do with this

- **Pick an origin from the first table**, not by feel, and make the builder assert what it needs (indoor room,
  spawns succeeded). Night Change builds a 7 x 7 walled and roofed bedroom at **x=30 z=30 on `test-colony`**.
- **On `test-colony` clear hostile things before a test that reads the danger watcher.** Night Change's
  bedroom builder does (its refusal scenarios spawn their own raider).
- **Name pawns that exist in the file you load.** `Jet`, `Larson`, `Morrison` are in both; the studio adds four.
- **What still needs a running game:** terrain, roofs, the hour at load, whether the insects raise the danger.
  Add the answers here when a run has them.
