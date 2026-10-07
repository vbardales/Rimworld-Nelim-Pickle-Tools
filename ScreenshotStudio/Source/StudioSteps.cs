using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    [PickleSteps]
    public partial class StudioSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";
        private const int CX = 125, CZ = 125, Radius = 90;
        private bool? originalScreenshotMode;
        private bool[] originalOverlays;
        private bool? originalColonistBar, originalLearningHelper;
        private static readonly Color Amber = new Color(0.90f, 0.51f, 0.08f);
        private static readonly Color Dark = new Color(0.22f, 0.15f, 0.10f);
        private static T Def<T>(string name) where T : Def => DefDatabase<T>.GetNamed(name);
        private static IntVec3 Cell(int x, int z) => new IntVec3(CX + x, 0, CZ + z);

        [Given(Prefix + "the flower meadow studio is prepared", TimeoutSeconds = 120)]
        public async Task Prepare(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null && map.Size.x > CX + Radius && map.Size.z > CZ + Radius,
                "Load the studio-base fixture first; the studio needs cells (35,35) to (215,215).");
            Find.TickManager.CurTimeSpeed = TimeSpeed.Paused;
            // Explicit opt-in scenic preparation; never run as an automatic scenario hook.
            var rect = new CellRect(CX - Radius, CZ - Radius, Radius * 2 + 1, Radius * 2 + 1);
            foreach (var pawn in map.mapPawns.AllPawnsSpawned.ToList())
                if (rect.Contains(pawn.Position))
                {
                    pawn.jobs?.StopAll();
                    pawn.pather?.StopDead();
                }
            foreach (var zone in map.zoneManager.AllZones.ToList())
                if (zone.Cells.Any(c => rect.Contains(c))) zone.Delete();
            foreach (var thing in map.listerThings.AllThings.ToList())
            {
                if (!rect.Contains(thing.Position)) continue;
                if (thing is Pawn pawn)
                {
                    if (pawn.Faction == Faction.OfPlayer) { pawn.Position = Cell(0, -44); pawn.Notify_Teleported(); }
                    else thing.DeSpawn();
                }
                else thing.Destroy(DestroyMode.Vanish);
            }
            TerrainDef soil = Def<TerrainDef>("MossyTerrain");
            foreach (var cell in rect.Cells)
            {
                map.roofGrid.SetRoof(cell, null);
                map.terrainGrid.SetTerrain(cell, soil);
                map.terrainGrid.SetTerrainColor(cell, null);
                map.snowGrid.SetDepth(cell, 0);
            }
            map.fogGrid.ClearAllFog();
            await ctx.WaitFrames(2);

            // Narrow amber paths leave most of the area as a meadow.
            for (int z = -41; z <= 41; z++)
                for (int x = -41; x <= 41; x++)
                {
                    double r = Math.Sqrt(x * x + z * z);
                    if ((r >= 19 && r <= 21) || (Math.Abs(x) <= 1 && Math.Abs(z) < 38)
                        || (Math.Abs(z) <= 1 && Math.Abs(x) < 38))
                        Floor(map, x, z, "TileSandstone", "Structure_Cream");
                }
            // The central tiled emblem is sampled from the owner's supplied queue.png.
            for (int row = 0; row < IconMosaic.Rows.Length; row++)
                for (int col = 0; col < IconMosaic.Rows[row].Length; col++)
                {
                    char pixel = IconMosaic.Rows[row][col];
                    if (pixel == '.') continue;
                    string color = pixel == 'K' ? "Structure_Black" : pixel == 'W' ? "Structure_White"
                        : pixel == 'Y' ? "Structure_YellowPastel" : "Structure_OrangePastel";
                    Floor(map, col - 16, 16 - row, "PavedTile", color);
                }
            // Four small pavilions, cutaway roofs for close-up captures.
            Room(map, -36, -8, 15, 17, "east");
            Room(map, 22, -8, 15, 17, "west");
            Room(map, -9, 23, 19, 13, "south");
            Room(map, -9, -36, 19, 13, "north");
            Spawn(map, "HandTailoringBench", -33, 5, "WoodLog", Rot4.North, Amber);
            Spawn(map, "TableStonecutter", -27, 5, "WoodLog", Rot4.North, Amber);
            Spawn(map, "TableSculpting", -33, -4, "WoodLog", Rot4.North, Amber);
            Spawn(map, "Shelf", -24, -5, "WoodLog", Rot4.North, Dark);
            Spawn(map, "Stool", -33, 3, "WoodLog", Rot4.North, Amber);
            Spawn(map, "Stool", -27, 3, "WoodLog", Rot4.North, Amber);
            Spawn(map, "FueledStove", 25, 5, null, Rot4.North, null);
            Spawn(map, "TableButcher", 32, 5, "WoodLog", Rot4.North, Dark);
            Spawn(map, "Table2x2c", 28, -3, "WoodLog", Rot4.North, Amber);
            foreach (int x in new[] {26, 30}) Spawn(map, "DiningChair", x, -3, "WoodLog", Rot4.North, Amber);
            Spawn(map, "Shelf", 34, -5, "WoodLog", Rot4.North, Dark);
            foreach (int x in new[] {-6, 0, 6})
            {
                Spawn(map, "Bed", x, 32, "WoodLog", Rot4.North, Amber);
                Spawn(map, "EndTable", x + 1, 33, "WoodLog", Rot4.North, Dark);
            }
            Spawn(map, "Table2x2c", 0, 27, "WoodLog", Rot4.North, Amber);
            Spawn(map, "DiningChair", -2, 27, "WoodLog", Rot4.East, Amber);
            Spawn(map, "DiningChair", 2, 27, "WoodLog", Rot4.West, Amber);
            // South pavilion intentionally has a large empty centre for mod demonstrations.
            Spawn(map, "Shelf", -6, -33, "WoodLog", Rot4.North, Dark);
            Spawn(map, "Shelf", 6, -33, "WoodLog", Rot4.North, Dark);
            DecorateZenGardens(map);

            Rand.PushState(22092026);
            try
            {
                for (int z = -Radius; z <= Radius; z++)
                    for (int x = -Radius; x <= Radius; x++)
                    {
                        var cell = Cell(x, z);
                        if (map.terrainGrid.TerrainAt(cell) != soil || cell.GetThingList(map).Count != 0) continue;
                        bool glade = (x - 29)*(x - 29) + (z + 27)*(z + 27) < 36;
                        bool orchard = Math.Abs(x) > 39 || Math.Abs(z) > 40;
                        bool flowerBed = InFlowerBed(x,z) || (orchard && Rand.Value < .08f);
                        if (glade && Rand.Value < .25f) continue;
                        string plant = orchard && Rand.Value < .012f ? "Plant_TreePine"
                            : flowerBed && Rand.Value < .65f ? (Rand.Value < .60f ? "Plant_Dandelion" : "Plant_Daylily")
                            : flowerBed && Rand.Value < .15f ? "Plant_Rose" : "Plant_Grass";
                        if (Rand.Value > .92f) continue;
                        var p = (Plant)ThingMaker.MakeThing(Def<ThingDef>(plant));
                        p.Growth = plant == "Plant_Grass" ? Rand.Range(.55f, 1f) : 1f;
                        GenSpawn.Spawn(p, cell, map);
                    }
            }
            finally { Rand.PopState(); }
            // Four named actors can be reused by future scenarios; other existing pawns stay outside the frame.
            string[] names = {"Ambre", "Flore", "Soleil", "Miel"};
            int[,] places = {{-29, 0}, {28, 0}, {0, 29}, {29, -27}};
            for (int i = 0; i < names.Length; i++)
            {
                var pawn = map.mapPawns.FreeColonistsSpawned.FirstOrDefault(p => p.Name?.ToStringShort == names[i]);
                if (pawn == null)
                {
                    Rand.PushState(22092026 + i);
                    try { pawn = PawnGenerator.GeneratePawn(PawnKindDefOf.Colonist, Faction.OfPlayer); }
                    finally { Rand.PopState(); }
                    pawn.Name = new NameTriple(names[i], names[i], "Prairie");
                    GenSpawn.Spawn(pawn, Cell(places[i, 0], places[i, 1]), map);
                }
                else { pawn.Position = Cell(places[i, 0], places[i, 1]); pawn.Notify_Teleported(); }
                if (pawn.apparel != null)
                    foreach (var apparel in pawn.apparel.WornApparel) apparel.TryGetComp<CompColorable>()?.SetColor(Amber);
            }
            Find.Selector.ClearSelection();
            Find.TickManager.CurTimeSpeed = TimeSpeed.Paused;
            await ctx.WaitFrames(5);
        }

        private static void Floor(Map map, int x, int z, string terrain, string color)
        {
            map.terrainGrid.SetTerrain(Cell(x, z), Def<TerrainDef>(terrain));
            map.terrainGrid.SetTerrainColor(Cell(x, z), Def<ColorDef>(color));
        }
        private static void Room(Map map, int x0, int z0, int width, int height, string doorSide)
        {
            for (int z = z0-2; z <= z0+height+1; z++)
                for (int x = x0-2; x <= x0+width+1; x++)
                    Floor(map, x,z,"WoodPlankFloor","Structure_BrownDark");
            for (int z = z0; z < z0 + height; z++)
                for (int x = x0; x < x0 + width; x++)
                {
                    bool edgeX = x == x0 || x == x0 + width - 1;
                    bool edgeZ = z == z0 || z == z0 + height - 1;
                    Floor(map, x, z, "WoodPlankFloor", "Structure_BrownDark");
                    if (!edgeX && !edgeZ && (x-x0)%4 != 0 && (z-z0)%7 != 0)
                        Floor(map, x,z,"StrawMatting","Structure_GreenSwamp");
                    bool opening = (doorSide == "east" && x == x0+width-1 && Math.Abs(z-(z0+height/2))<=2)
                        || (doorSide == "west" && x == x0 && Math.Abs(z-(z0+height/2))<=2)
                        || (doorSide == "north" && z == z0+height-1 && Math.Abs(x-(x0+width/2))<=2)
                        || (doorSide == "south" && z == z0 && Math.Abs(x-(x0+width/2))<=2);
                    if ((edgeX || edgeZ) && !opening)
                    {
                        bool post = (edgeX && (z-z0)%4==0) || (edgeZ && (x-x0)%4==0) || (edgeX&&edgeZ);
                        Spawn(map,"Wall",x,z,"WoodLog",Rot4.North,post ? Dark : new Color(.78f,.73f,.58f));
                    }
                    // Roofs are omitted deliberately: this is a paused photographic set.
                }
        }
        private static Thing Spawn(Map map, string def, int x, int z, string stuff, Rot4 rot, Color? paint)
        {
            var td = Def<ThingDef>(def);
            Thing thing = ThingMaker.MakeThing(td, td.MadeFromStuff ? Def<ThingDef>(stuff ?? "WoodLog") : null);
            if (td.CanHaveFaction) thing.SetFaction(Faction.OfPlayer);
            thing.TryGetComp<CompQuality>()?.SetQuality(QualityCategory.Good, ArtGenerationContext.Colony);
            if (paint.HasValue) thing.TryGetComp<CompColorable>()?.SetColor(paint.Value);
            GenSpawn.Spawn(thing, Cell(x, z), map, rot, WipeMode.Vanish);
            return thing;
        }

        [When(Prefix + "I frame the studio {string}")]
        public async Task Frame(PickleContext ctx, string shot)
        {
            int x = 0, z = 0; float size;
            switch (shot)
            {
                case "overview": size = 45; break;
                case "emblem": size = 20; break;
                case "workshop": x = -29; size = 12; break;
                case "kitchen": x = 29; size = 12; break;
                case "home": z = 29; size = 12; break;
                case "display": z = -29; size = 12; break;
                case "flowers": x = 29; z = -27; size = 12; break;
                case "pond": x = 28; z = 27; size = 16; break;
                case "zen": x = -28; z = 27; size = 15; break;
                default: throw new ArgumentException("Unknown studio shot: " + shot);
            }
            Find.Selector.ClearSelection();
            Find.CameraDriver.JumpToCurrentMapLoc(Cell(x,z));
            Find.CameraDriver.SetRootSize(size);
            await ctx.WaitFrames(3);
        }

        // The named places of the Sanctuaire de Nelim (the save "Nelims-tribe", docs/SANCTUAIRE-LIEUX.md): absolute map cells, not offsets
        // from the studio centre, with the camera root size that frames each one. A suite names the place and never writes a coordinate.
        private static readonly (string Name, int X, int Z, float Size)[] SanctuarySites =
        {
            ("overview-north", 125, 185, 60), ("overview-south", 125, 65, 60), ("house", 190, 115, 15), ("hearth-hall", 181, 115, 12), ("sleeping-nook", 177, 121, 6.5f), ("sofa-corner", 187, 123, 3.5f), ("dining-nook", 176, 108, 3.7f), ("fire-pit", 181, 115, 5f), ("cloister", 179, 130, 7f), ("statue-garden", 155, 97, 13), ("prestige-hall", 196, 111, 8.5f), ("ritual-hall", 206, 117, 8f), ("terrace", 197, 123, 9f), ("plant-garden", 190, 85, 11), ("hut", 141, 72, 9),
            ("river-bridge", 135, 126, 11), ("left-bank", 112, 111, 18.2f), ("right-bank", 144, 132, 11), ("fishing-zone", 114, 68, 12), ("water-garden", 167, 173, 14), ("gravel-yard", 170, 143, 11.2f), ("emerald-clearing", 197, 152, 9), ("enclosure", 158, 224, 22), ("workshops", 203, 237, 11), ("barn", 193, 237, 10.5f), ("preindustrial-workshop", 205, 237, 10.5f), ("postindustrial-workshop", 214, 237, 18), ("enclosure-south", 149, 214, 12), ("enclosure-north", 166, 235, 13),
            ("rice-paddies", 229, 114, 20), ("cotton-field", 211, 114, 15), ("rice-paddy", 230, 122, 8), ("flower-garden", 154, 105, 5), ("exhibition-zone", 218, 166, 18), ("calm-zone", 200, 187, 11), ("calm-zone-close", 200, 185, 2.8f), ("bare-clearing", 195, 152, 5), ("dump", 49, 236, 20), ("smiley-southwest", 67, 177, 15), ("smiley-bottom-west", 139, 56, 15),
            ("smiley-bottom-centre", 185, 56, 15), ("smiley-bottom-east", 230, 56, 15), ("smiley-west", 93, 100, 15),
            ("smiley-river", 113, 160, 15), ("smiley-north", 176, 202, 15), ("window-backdrop-for-width", 162, 49, 18), ("window-backdrop-for-height", 90, 140, 47),
        };

        // Names that stay valid but point to another place (a duplicate Virginie asked to merge), and names that were removed (with what to use instead).
        private static readonly System.Collections.Generic.Dictionary<string, string> SanctuaryAliases = new System.Collections.Generic.Dictionary<string, string>
        {
            { "tea-room", "hut" }, { "exhibition-area", "exhibition-zone" }, { "cream-clearing", "calm-zone" }, { "grand-place", "exhibition-zone" },
            { "statue-plaza", "statue-garden" }, { "hermit-hall", "hearth-hall" },
            { "salle-des-rituels", "ritual-hall" }, { "salle-de-l-ideologie", "ritual-hall" }, { "veranda", "terrace" },
            { "clearing-a", "emerald-clearing" }, { "emerald-podium", "emerald-clearing" }, { "great-courtyard", "emerald-clearing" }, { "podium", "emerald-clearing" }, { "river", "left-bank" }, { "water-zone", "water-garden" },
        };
        private static readonly System.Collections.Generic.Dictionary<string, string> SanctuaryRetired = new System.Collections.Generic.Dictionary<string, string>
        {
            { "forest-edge", "removed 2026-10-05" }, { "river-upstream", "removed 2026-10-05" }, { "river-exit", "removed 2026-10-05" }, { "power-cell", "removed 2026-10-05; the cell is beside \"clearing-a\"" },
            { "animal-pen", "removed 2026-10-05; the pens moved up, use \"enclosure\"" }, { "bamboo-south", "removed 2026-10-05; ask Pickle Tools for a place instead of clearing the bamboo" }, { "bamboo-west", "removed 2026-10-05" },
        };

        // The game keeps the camera root size between 11 and 60 (CameraMapConfig.sizeRange); SimpleCameraSetting and Camera+ widen it the same way. A tighter or wider frame needs the range widened first.
        private static void LiftZoomLimit()
        {
            object config = Find.CameraDriver?.config;
            var field = config?.GetType().GetField("sizeRange");
            if (field != null && field.FieldType == typeof(FloatRange)) field.SetValue(config, new FloatRange(2f, 130f));
            else Log.Warning("[frame] CameraMapConfig.sizeRange not found: the zoom stays limited to the game's own range");
        }

        private static (string Name, int X, int Z, float Size) FindSite(PickleContext ctx, string place)
        {
            // "Salon de thé", "salon_de_the" and "salon-de-the" are one name: accents dropped, case folded, spaces and underscores turned into hyphens.
            place = new string(place.Normalize(System.Text.NormalizationForm.FormD).Where(c => System.Globalization.CharUnicodeInfo.GetUnicodeCategory(c) != System.Globalization.UnicodeCategory.NonSpacingMark).ToArray()).Trim().ToLowerInvariant().Replace(' ', '-').Replace('_', '-').Replace('\x27', '-');
            string name = SanctuaryAliases.TryGetValue(place, out string target) ? target : place;
            string reason;
            ctx.Require(!SanctuaryRetired.TryGetValue(place, out reason), "The sanctuary place \"" + place + "\" is gone (" + reason + "); known: " + string.Join(", ", SanctuarySites.Select(s => s.Name)));
            var site = SanctuarySites.FirstOrDefault(s => s.Name == name);
            ctx.Require(site.Name != null, "Unknown sanctuary place \"" + place + "\"; known: " + string.Join(", ", SanctuarySites.Select(s => s.Name)));
            return site;
        }

        [Given(Prefix + "I am at the sanctuary {string}", TimeoutSeconds = 60f)]
        [When(Prefix + "I frame the sanctuary {string}", TimeoutSeconds = 60f)]
        public async Task FrameSanctuary(PickleContext ctx, string place)
        {
            var site = FindSite(ctx, place);
            // The bare clearing is the podium square without its green carpet: the floor is bared as the place is framed.
            if (site.Name == "bare-clearing") BareFloor(ctx, "bare-clearing");
            ctx.Require(Find.CurrentMap != null && Find.CurrentMap.Size.x >= 250 && Find.CurrentMap.Size.z >= 250, "Load the save \"Nelims-tribe\" first (a 250 by 250 map)");
            LiftZoomLimit();
            Find.Selector.ClearSelection();
            Find.CameraDriver.JumpToCurrentMapLoc(new IntVec3(site.X, 0, site.Z));
            Find.CameraDriver.SetRootSize(site.Size);
            await ctx.WaitFrames(90); // the game eases the zoom over several frames (CameraZoom waits 90 too)
            // The sky glow eases towards its target frame by frame (after a hour or a weather change it keeps moving for a while): wait until it holds still, so that two shots of one run have the same light.
            float last = -1f; int still = 0;
            for (int i = 0; i < 600 && still < 20; i++)
            {
                float glow = Find.CurrentMap.skyManager.CurSkyGlow;
                still = Math.Abs(glow - last) < 0.0005f ? still + 1 : 0;
                last = glow;
                await ctx.WaitFrames(1);
            }
            Log.Message("[frame] " + place + ": asked (" + site.X + ", " + site.Z + ") zoom " + site.Size + ", camera at " + Find.CameraDriver.MapPosition + ", root size " + Find.CameraDriver.RootSize.ToString("0.0") + ", sky glow " + last.ToString("0.00"));
        }

        // The cells a named place covers, as (minX, maxX, minZ, maxZ). Rooms are listed because their walls and doors stay; every other
        // place is the square of its camera size around its centre.
        private static readonly System.Collections.Generic.Dictionary<string, int[]> SanctuaryRooms = new System.Collections.Generic.Dictionary<string, int[]>
        {
            ["hearth-hall"] = new[] { 172, 190, 106, 124 }, ["prestige-hall"] = new[] { 193, 200, 106, 117 },
            ["ritual-hall"] = new[] { 202, 209, 114, 123 }, ["terrace"] = new[] { 193, 200, 118, 124 }, ["barn"] = new[] { 188, 198, 230, 244 }, ["preindustrial-workshop"] = new[] { 200, 210, 230, 244 }, ["postindustrial-workshop"] = new[] { 212, 217, 230, 244 }, ["cloister"] = new[] { 167, 192, 126, 131 },
        };

        private static int[] SanctuaryArea((string Name, int X, int Z, float Size) site)
        {
            int[] r;
            if (SanctuaryRooms.TryGetValue(site.Name, out r)) return r;
            int hx = Mathf.CeilToInt(site.Size * 16f / 9f), hz = Mathf.CeilToInt(site.Size);
            return new[] { site.X - hx, site.X + hx, site.Z - hz, site.Z + hz };
        }

        // Empties a named place of everything a mod could trip over: furniture, items, plants, filth, corpses. Walls, doors and
        // pawns stay. The save is not touched on disk, so a scenario that empties a place only changes its own run.
        [Given(Prefix + "the sanctuary {string} is emptied")]
        [When(Prefix + "I empty the sanctuary {string}")]
        public void EmptySanctuary(PickleContext ctx, string place)
        {
            var site = FindSite(ctx, place);
            Map map = Find.CurrentMap;
            ctx.Require(map != null && map.Size.x >= 250, "Load the save \"Nelims-tribe\" first");
            int[] r = SanctuaryArea(site);
            var doomed = map.listerThings.AllThings.Where(t => t.Position.x >= r[0] && t.Position.x <= r[1] && t.Position.z >= r[2] && t.Position.z <= r[3]
                && !(t is Pawn) && t.def.category != ThingCategory.Ethereal && t.def.category != ThingCategory.Projectile
                && !(t.def.building != null && (t.def.IsDoor || t.def.defName.EndsWith("Wall") || t.def.building.isNaturalRock))).ToList();
            foreach (var t in doomed) if (!t.Destroyed) t.Destroy();
        }

        // Bares the floor of a named place: every cell of the place gets the terrain of the ground just west of it, without paint, so a
        // laid floor, a carpet or a marking painted on the ground (the green podium square) shows the bare ground. Roofs and things stay.
        [Given(Prefix + "the floor of the sanctuary {string} is bared")]
        [When(Prefix + "I bare the floor of the sanctuary {string}")]
        public void BareFloor(PickleContext ctx, string place)
        {
            var site = FindSite(ctx, place);
            Map map = Find.CurrentMap;
            ctx.Require(map != null && map.Size.x >= 250, "Load the save \"Nelims-tribe\" first");
            int[] r = SanctuaryArea(site);
            var west = new IntVec3(Math.Max(0, r[0] - 3), 0, (r[2] + r[3]) / 2);
            TerrainDef ground = west.GetTerrain(map);
            if (ground == null || ground.IsWater || ground.passability == Traversability.Impassable) ground = Def<TerrainDef>("Soil");
            for (int x = r[0]; x <= r[1]; x++)
                for (int z = r[2]; z <= r[3]; z++)
                {
                    var c = new IntVec3(x, 0, z);
                    if (!c.InBounds(map) || c.GetTerrain(map).IsWater) continue;
                    map.terrainGrid.SetTerrain(c, ground);
                    map.terrainGrid.SetTerrainColor(c, null);
                }
        }

        // A flower border around a free square, for the photographs: two to four cells wide, thinning outwards, the square itself untouched.
        // Cells that hold a building, water or soil that grows nothing are skipped; an existing plant on a chosen cell is replaced.
        [Given(Prefix + "a flower border is planted around the square from \\({int}, {int}\\) to \\({int}, {int}\\)")]
        public void FlowerBorder(PickleContext ctx, int x1, int z1, int x2, int z2)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            string[] kinds = { "Plant_Dandelion", "Plant_Dandelion", "Plant_Daylily", "Plant_Rose" };

            for (int x = x1 - 4; x <= x2 + 4; x++)
                for (int z = z1 - 4; z <= z2 + 4; z++)
                {
                    int d = Math.Max(Math.Max(x1 - x, x - x2), Math.Max(z1 - z, z - z2));   // 1 = the ring touching the square
                    if (d < 1 || d > 4) continue;
                    if (Rand.Value > (d <= 2 ? 0.75f : 0.40f)) continue;
                    var c = new IntVec3(x, 0, z);
                    if (!c.InBounds(map) || c.GetFirstBuilding(map) != null || c.GetFirstItem(map) != null) continue;
                    var def = Def<ThingDef>(kinds[Rand.Range(0, kinds.Length)]);
                    if (c.GetTerrain(map).fertility <= 0f || c.GetTerrain(map).IsWater) continue;
                    var old = c.GetPlant(map);
                    if (old != null) old.Destroy();
                    var p = (Plant)ThingMaker.MakeThing(def);
                    p.Growth = 1f;
                    GenSpawn.Spawn(p, c, map);
                }
        }

        // Sends the animals standing in a named place away (despawned, not killed), for a photograph or a scene that wants the place to itself.
        // The colonists stay. Same area as "is emptied".
        [Given(Prefix + "the animals are removed from the sanctuary {string}")]
        public void RemoveAnimals(PickleContext ctx, string place)
        {
            var site = FindSite(ctx, place);
            Map map = Find.CurrentMap;
            ctx.Require(map != null && map.Size.x >= 250, "Load the save \"Nelims-tribe\" first");
            int[] r = SanctuaryArea(site);
            var animals = map.mapPawns.AllPawnsSpawned.Where(p => p.RaceProps.Animal && p.Position.x >= r[0] && p.Position.x <= r[1] && p.Position.z >= r[2] && p.Position.z <= r[3]).ToList();
            foreach (var a in animals) a.DeSpawn();
        }

        // Sends every animal on the map away (despawned, not killed): for a frame wider than a place's own area, or a place the animals keep wandering back to.
        [Given(Prefix + "all animals are removed")]
        [When(Prefix + "I remove all animals")]
        public void RemoveAllAnimals(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            foreach (var a in map.mapPawns.AllPawnsSpawned.Where(p => p.RaceProps.Animal).ToList()) a.DeSpawn();
        }

        // Moves the player's colonists (Nelim) to a far corner of the map, for a frame that must hold only the set. They are not removed: they are
        // standing there when the scenario goes on. Pawns that cannot be placed stay where they are.
        [Given(Prefix + "the colonists are sent to the map corner")]
        [When(Prefix + "I send the colonists to the map corner")]
        public void SendColonistsAway(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            var corners = new[] { new IntVec3(4, 0, 4), new IntVec3(map.Size.x - 5, 0, 4), new IntVec3(4, 0, map.Size.z - 5), new IntVec3(map.Size.x - 5, 0, map.Size.z - 5) };
            foreach (var pawn in map.mapPawns.FreeColonistsSpawned.ToList())
            {
                IntVec3 cell = IntVec3.Invalid;
                foreach (var corner in corners)
                    if (CellFinder.TryFindRandomCellNear(corner, map, 40, c => c.Standable(map) && c.GetFirstPawn(map) == null, out cell)) break;
                ctx.Require(cell.IsValid, "No free standable cell near any map corner for " + pawn.LabelShort);
                pawn.jobs?.StopAll();
                pawn.pather?.StopDead();
                pawn.Position = cell;
                pawn.Notify_Teleported();
                Log.Message("[colonists away] " + pawn.LabelShort + " moved to (" + cell.x + ", " + cell.z + ")");
            }
        }

        // Opens the sky over a named place: every roof on its cells is removed, walls stay. A roofed room is lit by lamps only; with the roof gone it
        // is lit by the sun, so the photograph is bright. Same area as "is emptied".
        [Given(Prefix + "the roof is removed from the sanctuary {string}")]
        public void RemoveRoof(PickleContext ctx, string place)
        {
            var site = FindSite(ctx, place);
            Map map = Find.CurrentMap;
            ctx.Require(map != null && map.Size.x >= 250, "Load the save \"Nelims-tribe\" first");
            int[] r = SanctuaryArea(site);
            for (int x = r[0]; x <= r[1]; x++)
                for (int z = r[2]; z <= r[3]; z++)
                {
                    var c = new IntVec3(x, 0, z);
                    if (c.InBounds(map) && map.roofGrid.RoofAt(c) != null && !map.roofGrid.RoofAt(c).isThickRoof) map.roofGrid.SetRoof(c, null);
                }
        }

        // Lets the game build its power nets now. A loaded or freshly spawned map holds its connections as pending work that only a tick would do, and the
        // scenes run paused; connecting components by hand on top of that registers them twice, so the game is asked to do it itself.
        // A building spawned next to a transmitter by a scene is usually connected on spawn; this makes it certain, and a net that still
        // shows the unpowered icon after it is a real shortage (the supply is lower than the demand), not a missing connection.
        [Given(Prefix + "the power network is refreshed")]
        public async Task RefreshPower(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            map.powerNetManager.UpdatePowerNetsAndConnections_First();
            await ctx.WaitFrames(3);
        }

        // Two checks for what a mod does at load without a screen to read it from: a window of a given type on the stack, and a collection kept by a
        // world component. Both look by the type's simple name (the window) or full name (the component), so a scenario names what it means.
        [Then(Prefix + "no window of the type {string} is open")]
        public void NoWindowOfType(PickleContext ctx, string typeName)
        {
            var open = Find.WindowStack.Windows.Where(w => w.GetType().Name == typeName).ToList();
            ctx.Assert(open.Count == 0, "The window " + typeName + " is open (" + open.Count + ")");
        }

        [Then(Prefix + "the world component {string} holds at least {int} entries in its field {string}")]
        public void WorldComponentEntries(PickleContext ctx, string typeName, int atLeast, string field)
        {
            var comp = Find.World.components.FirstOrDefault(c => c.GetType().FullName == typeName);
            ctx.Require(comp != null, "No world component " + typeName + "; found: " + string.Join(", ", Find.World.components.Select(c => c.GetType().FullName).Where(n => n.IndexOf("Faction", StringComparison.OrdinalIgnoreCase) >= 0)));
            var f = comp.GetType().GetField(field, System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.NonPublic);
            ctx.Require(f != null, "No field " + field + " on " + typeName);
            var value = f.GetValue(comp) as System.Collections.IEnumerable;
            int n = 0; if (value != null) foreach (var _ in value) n++;
            ctx.Assert(n >= atLeast, typeName + "." + field + " holds " + n + " entries, expected at least " + atLeast);
        }

        // Makes the map a one-colonist map: every humanlike pawn but the named one, and every humanlike corpse, vanishes. Animals stay.
        [Given(Prefix + "all humans but {string} are removed")]
        public void RemoveOtherHumans(PickleContext ctx, string keep)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            ctx.Require(map.mapPawns.AllPawnsSpawned.Any(p => p.Name != null && p.Name.ToStringShort == keep), "No pawn named " + keep + " on the map");
            foreach (var p in map.mapPawns.AllPawnsSpawned.Where(p => p.RaceProps.Humanlike && (p.Name == null || p.Name.ToStringShort != keep)).ToList()) p.Destroy(DestroyMode.Vanish);
            foreach (var c in map.listerThings.AllThings.OfType<Corpse>().Where(c => c.InnerPawn != null && c.InnerPawn.RaceProps.Humanlike).ToList()) c.Destroy(DestroyMode.Vanish);
            ctx.Assert(map.mapPawns.AllPawnsSpawned.Count(p => p.RaceProps.Humanlike) == 1, "Expected one human left");
        }

        // Tidies the map: every haulable item that lies outside a stockpile or a storage building is merged into full stacks and put into the
        // stockpile zones. Nothing is deleted; the stockpile must have room.
        [Given(Prefix + "all loose items are put away")]
        public void PutAwayLooseItems(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            var cells = map.zoneManager.AllZones.OfType<Zone_Stockpile>().SelectMany(z => z.Cells).ToList();
            ctx.Require(cells.Count > 0, "The map has no stockpile zone to put items into");
            var loose = map.listerThings.AllThings.Where(t => t.def.category == ThingCategory.Item && t.Spawned && t.def.EverHaulable
                && map.haulDestinationManager.SlotGroupAt(t.Position) == null).ToList();
            var toPlace = new System.Collections.Generic.List<Thing>();
            foreach (var g in loose.GroupBy(t => t.def))
            {
                var kept = new System.Collections.Generic.List<Thing>();
                foreach (var t in g)
                {
                    bool merged = false;
                    foreach (var s in kept)
                        if (s.stackCount < s.def.stackLimit && s.CanStackWith(t)) { s.TryAbsorbStack(t, true); if (t.Destroyed || t.stackCount <= 0) { merged = true; break; } }
                    if (!merged && !t.Destroyed) kept.Add(t);
                }
                toPlace.AddRange(kept);
            }
            var free = new System.Collections.Generic.Queue<IntVec3>(cells.Where(c => c.GetFirstItem(map) == null && c.GetFirstBuilding(map) == null));
            ctx.Require(free.Count >= toPlace.Count, "The stockpiles have " + free.Count + " free cells for " + toPlace.Count + " stacks");
            foreach (var t in toPlace)
            {
                if (t.Spawned) t.DeSpawn();
                GenPlace.TryPlaceThing(t, free.Dequeue(), map, ThingPlaceMode.Direct);
            }
            int left = map.listerThings.AllThings.Count(t => t.def.category == ThingCategory.Item && t.Spawned && t.def.EverHaulable && map.haulDestinationManager.SlotGroupAt(t.Position) == null);
            ctx.Assert(left == 0, left + " items are still outside a stockpile (" + toPlace.Count + " stacks were placed)");
        }

        // Sets a colonist's food need to full.
        [Given(Prefix + "the pawn {string} is fully fed")]
        public void FullyFed(PickleContext ctx, string name)
        {
            var p = Find.CurrentMap.mapPawns.AllPawnsSpawned.FirstOrDefault(x => x.Name != null && x.Name.ToStringShort == name);
            ctx.Require(p != null && p.needs != null && p.needs.food != null, "No pawn named " + name + " with a food need");
            p.needs.food.CurLevel = p.needs.food.MaxLevel;
        }

        // Removes every piece of filth on the map (blood, dirt, ash, vomit, insect jelly): it only spoils the photographs.
        [Given(Prefix + "all filth is cleaned")]
        public void CleanFilth(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            foreach (var f in map.listerThings.AllThings.OfType<Filth>().ToList()) if (!f.Destroyed) f.Destroy();
            ctx.Assert(!map.listerThings.AllThings.OfType<Filth>().Any(), "Some filth is still on the map");
        }

        // Puts the research tree back to nothing researched: the Sanctuaire is a blank colony, so a mod that tests a research gate sees the gate.
        [Given(Prefix + "all research is reset")]
        public void ResetResearch(PickleContext ctx)
        {
            Find.ResearchManager.ResetAllProgress();
            ctx.Assert(!DefDatabase<ResearchProjectDef>.AllDefsListForReading.Any(r => r.IsFinished && r.baseCost > 0f), "Some research is still finished");
        }

        [Then(Prefix + "the flower meadow studio is intact")]
        public void Check(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Assert(map != null, "No loaded studio");
            ctx.Assert(map.listerThings.ThingsOfDef(Def<ThingDef>("Plant_Dandelion")).Count > 200, "Expected a flowering meadow");
            ctx.Assert(map.listerThings.ThingsOfDef(Def<ThingDef>("Plant_Daylily")).Count > 100, "Expected orange daylilies");
            ctx.Assert(Cell(0,-29).Standable(map), "The demonstration stage must remain clear");
            ctx.Assert(map.mapPawns.FreeColonistsSpawned.Any(p => p.Name?.ToStringShort == "Flore"), "Missing named studio actor");
            ctx.Assert(map.terrainGrid.ColorAt(Cell(0,0)) != null, "Missing central mosaic paint");
            ctx.Assert(map.listerThings.ThingsOfDef(Def<ThingDef>("HandTailoringBench")).Any(t => t.Position == Cell(-33,5)), "Missing workshop bench");
            int checkedTiles = 0;
            for (int row = 0; row < IconMosaic.Rows.Length; row++)
                for (int col = 0; col < IconMosaic.Rows[row].Length; col++)
                {
                    char pixel = IconMosaic.Rows[row][col];
                    if (pixel == '.') continue;
                    string expected = pixel == 'K' ? "Structure_Black" : pixel == 'W' ? "Structure_White"
                        : pixel == 'Y' ? "Structure_YellowPastel" : "Structure_OrangePastel";
                    ctx.Assert(map.terrainGrid.ColorAt(Cell(col - 16, 16 - row))?.defName == expected,
                        "Mosaic paint differs at tile " + col + "," + row);
                    checkedTiles++;
                }
            ctx.Assert(checkedTiles > 300, "Incomplete emblem matrix");
            ctx.Assert(map.terrainGrid.TerrainAt(Cell(27,23)).defName == "WaterDeep", "Missing garden pond");
            ctx.Assert(map.terrainGrid.TerrainAt(Cell(26,27)).defName == "Bridge", "Missing timber footbridge");
            ctx.Assert(map.listerThings.ThingsOfDef(Def<ThingDef>("Plant_TreeBonsai")).Count >= 4, "Missing bonsai plants");
            ctx.Assert(map.terrainGrid.TerrainAt(Cell(-28,27)).defName == "Sand", "Missing dry garden");
        }

        // Interface kept (a menu capture), but without the colonist bar at the top centre (it shows the colonist's name and portrait).
        [Given(Prefix + "the colonist bar is hidden")]
        [When(Prefix + "I hide the colonist bar")]
        public void HideColonistBar(PickleContext ctx)
        {
            if (!originalColonistBar.HasValue) originalColonistBar = Find.PlaySettings.showColonistBar;
            Find.PlaySettings.showColonistBar = false;
            // The bar draws from a cached list that only rebuilds when it is marked dirty: the flag alone leaves it on screen.
            Find.ColonistBar?.MarkColonistsDirty();
        }

        private static void ClearActiveConcepts()
        {
            var readout = Find.Tutor?.learningReadout;
            var field = readout == null ? null : typeof(LearningReadout).GetField("activeConcepts", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Public);
            var value = field?.GetValue(readout);
            if (value is System.Collections.IList list) list.Clear();
            else if (value is System.Collections.IDictionary dict) dict.Clear();
        }

        // Interface kept, but without the mouse-over tooltips (a hover left on the subject). Needs Harmony; without it the scenario goes on with a warning.
        [Given(Prefix + "the tooltips are hidden")]
        [When(Prefix + "I hide the tooltips")]
        public void HideTooltips(PickleContext ctx)
        {
            try { OverlaySuppression.HideTooltips(); }
            catch (Exception e) when (e is System.IO.FileNotFoundException || e is TypeLoadException || e is TypeInitializationException) { Log.Warning("[tooltips] stay drawn: Harmony is not loaded"); }
        }

        // Interface kept (tabs, buttons), but without the resource list on the left.
        [Given(Prefix + "the resource readout is hidden")]
        [When(Prefix + "I hide the resource readout")]
        public void HideResourceReadout(PickleContext ctx)
        {
            try { OverlaySuppression.HideReadout(); }
            catch (Exception e) when (e is System.IO.FileNotFoundException || e is TypeLoadException || e is TypeInitializationException) { Log.Warning("[readout] stays drawn: Harmony is not loaded"); }
        }

        // Interface kept (tabs, buttons), but without the alert boxes at the bottom right.
        [Given(Prefix + "the alerts are hidden")]
        [When(Prefix + "I hide the alerts")]
        public void HideAlerts(PickleContext ctx)
        {
            try { OverlaySuppression.HideAlerts(); }
            catch (Exception e) when (e is System.IO.FileNotFoundException || e is TypeLoadException || e is TypeInitializationException) { Log.Warning("[alerts] stay drawn: Harmony is not loaded"); }
        }

        // Interface kept, but without the learning helper's tip boxes (top right).
        [Given(Prefix + "the learning helper is hidden")]
        [When(Prefix + "I hide the learning helper")]
        public void HideLearningHelper(PickleContext ctx)
        {
            if (!originalLearningHelper.HasValue) originalLearningHelper = Find.PlaySettings.showLearningHelper;
            Find.PlaySettings.showLearningHelper = false;
            // Without the patch a concept the game activates later (camera dolly, bills tab...) brings the box back: the readout shows itself while any concept is active.
            try { OverlaySuppression.HideHelper(); }
            catch (Exception e) when (e is System.IO.FileNotFoundException || e is TypeLoadException || e is TypeInitializationException) { Log.Warning("[learning helper] new cards are not blocked: Harmony is not loaded"); }
            ClearActiveConcepts();
        }

        [When(Prefix + "studio presentation mode is enabled")]
        public async Task Presentation(PickleContext ctx)
        {
            if (!originalScreenshotMode.HasValue) originalScreenshotMode = Find.UIRoot.screenshotMode.Active;
            Find.UIRoot.screenshotMode.Active = true;
            // Stack counts and name labels: no setting in the game, so a patch skips them. Without Harmony the scenario goes on and says so.
            try { OverlaySuppression.Begin(); }
            catch (Exception e) when (e is System.IO.FileNotFoundException || e is TypeLoadException || e is TypeInitializationException) { Log.Warning("[presentation] stack counts and name labels stay drawn: Harmony is not loaded (" + e.GetType().Name + ")"); }
            // Overlays the interface switch leaves on the map: zone markers, beauty and room numbers, the learning helper.
            if (originalOverlays == null) originalOverlays = new[] { Find.PlaySettings.showZones, Find.PlaySettings.showBeauty, Find.PlaySettings.showRoomStats, Find.PlaySettings.showLearningHelper };
            Find.PlaySettings.showZones = false; Find.PlaySettings.showBeauty = false; Find.PlaySettings.showRoomStats = false; Find.PlaySettings.showLearningHelper = false;
            await ctx.WaitFrames(2);
        }

        [AfterScenario]
        public void RestoreInterface()
        {
            if (originalScreenshotMode.HasValue && Find.UIRoot != null)
                Find.UIRoot.screenshotMode.Active = originalScreenshotMode.Value;
            originalScreenshotMode = null;
            OverlaySuppression.End();
            if (originalColonistBar.HasValue && Find.PlaySettings != null) { Find.PlaySettings.showColonistBar = originalColonistBar.Value; Find.ColonistBar?.MarkColonistsDirty(); }
            if (originalLearningHelper.HasValue && Find.PlaySettings != null) Find.PlaySettings.showLearningHelper = originalLearningHelper.Value;
            originalColonistBar = null; originalLearningHelper = null;
            if (originalOverlays != null && Find.PlaySettings != null)
            {
                var o = originalOverlays;
                Find.PlaySettings.showZones = o[0]; Find.PlaySettings.showBeauty = o[1]; Find.PlaySettings.showRoomStats = o[2]; Find.PlaySettings.showLearningHelper = o[3];
            }
            originalOverlays = null;
        }

        [When(Prefix + "I save the flower meadow studio", TimeoutSeconds = 60)]
        public void Save(PickleContext ctx)
        {
            string name = "Nelim-Zen-Meadow-Studio";
            GameDataSaveLoader.SaveGame(name);
            string path = GenFilePaths.FilePathForSavedGame(name);
            ctx.Assert(File.Exists(path) && new FileInfo(path).Length > 10000, "Studio save was not written");
        }
    }
}
