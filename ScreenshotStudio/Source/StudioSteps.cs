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

        [When(Prefix + "studio presentation mode is enabled")]
        public async Task Presentation(PickleContext ctx)
        {
            if (!originalScreenshotMode.HasValue) originalScreenshotMode = Find.UIRoot.screenshotMode.Active;
            Find.UIRoot.screenshotMode.Active = true;
            await ctx.WaitFrames(2);
        }

        [AfterScenario]
        public void RestoreInterface()
        {
            if (originalScreenshotMode.HasValue && Find.UIRoot != null)
                Find.UIRoot.screenshotMode.Active = originalScreenshotMode.Value;
            originalScreenshotMode = null;
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
