using RimWorld;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    public partial class StudioSteps
    {
        private static readonly int[,] Beds = {
            {-16,12},{16,12},{-16,-12},{16,-12},{-40,14},{40,14},
            {-40,-18},{40,-18},{-13,40},{13,40},{-13,-42},{13,-42},
            {24,-34},{35,-27},{28,-19},{-29,-26}
        };
        private static bool InFlowerBed(int x,int z)
        {
            for(int i=0;i<Beds.GetLength(0);i++)
                if((x-Beds[i,0])*(x-Beds[i,0])+(z-Beds[i,1])*(z-Beds[i,1])<13) return true;
            return false;
        }
        private static void DecorateZenGardens(Map map)
        {
            // An asymmetric pond with a little island and a walkable timber bridge.
            for(int z=16;z<=39;z++)
                for(int x=16;x<=41;x++)
                {
                    double r=(x-28)*(x-28)/110.0+(z-27)*(z-27)/80.0;
                    if(r>1.22)continue;
                    if(r>1) Floor(map,x,z,"Gravel","Structure_GrayLight");
                    else map.terrainGrid.SetTerrain(Cell(x,z),Def<TerrainDef>(r<.70?"WaterDeep":"WaterShallow"));
                }
            for(int z=26;z<=28;z++)
                for(int x=16;x<=40;x++) Floor(map,x,z,"Bridge","Structure_BrownDark");
            for(int z=30;z<=34;z++)
                for(int x=29;x<=33;x++)
                    if((x-31)*(x-31)+(z-32)*(z-32)<=5)
                        map.terrainGrid.SetTerrain(Cell(x,z),Def<TerrainDef>("MossyTerrain"));
            Bonsai(map,31,32);
            // A pale dry garden. Curved gravel bands circle three groups of natural stones.
            for(int z=19;z<=35;z++)
                for(int x=-38;x<=-18;x++)
                {
                    bool edge=x==-38||x==-18||z==19||z==35;
                    double a=System.Math.Sqrt((x+33)*(x+33)+(z-29)*(z-29));
                    double b=System.Math.Sqrt((x+24)*(x+24)+(z-25)*(z-25));
                    bool rake=System.Math.Min(a,b)%3<.65;
                    Floor(map,x,z,edge?"TileSlate":rake?"Gravel":"Sand",edge?"Structure_BrownDark":rake?"Structure_GrayLight":"Structure_Cream");
                }
            // Keep the central verification cell as clean sand.
            Floor(map,-28,27,"Sand","Structure_Cream");
            foreach(var p in new[]{new IntVec3(-33,0,29),new IntVec3(-32,0,29),new IntVec3(-33,0,30),new IntVec3(-24,0,25),new IntVec3(-23,0,25),new IntVec3(-29,0,22)})
                Spawn(map,"ChunkGranite",p.x,p.z,null,Rot4.North,null);
            // Stone steps through the meadow, separated by planted ground.
            for(int i=0;i<7;i++)
            {
                Floor(map, -29+i*2,-20-i,"TileSlate","Structure_GrayLight");
                Floor(map, 24+i*2,-16-i*2,"TileSlate","Structure_GrayLight");
            }
            Bonsai(map,-36,18); Bonsai(map,-20,36);
            Bonsai(map,-39,-7); Bonsai(map,39,7);
            Bonsai(map,-8,38); Bonsai(map,8,-39);
            foreach(var p in new[]{new IntVec3(-18,0,3),new IntVec3(18,0,-3),new IntVec3(-3,0,21),new IntVec3(3,0,-21),new IntVec3(16,0,30),new IntVec3(40,0,24),new IntVec3(-40,0,20),new IntVec3(-17,0,34)})
            {
                Floor(map,p.x,p.z,"TileSlate","Structure_GrayLight");
                var lamp=Spawn(map,"TorchLamp",p.x,p.z,null,Rot4.North,null);
                lamp.SetStyleDef(Def<ThingStyleDef>("Rustic_TorchLamp"));
                lamp.TryGetComp<CompRefuelable>()?.Refuel(100f);
            }
        }
        private static void Bonsai(Map map,int x,int z)
        {
            var pot=Spawn(map,"PlantPot_Bonsai",x,z,"BlocksGranite",Rot4.North,Dark);
            var plant=(Plant)ThingMaker.MakeThing(Def<ThingDef>("Plant_TreeBonsai"));
            plant.Growth=1f;
            GenSpawn.Spawn(plant,Cell(x,z),map);
        }
    }
}
