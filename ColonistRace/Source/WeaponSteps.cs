using System.Collections.Generic;
using System.Linq;
using HarmonyLib;
using RimWorks.Pickle;
using RimWorld;
using Verse;
using Verse.AI;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// A weapon in a colonist's hands for a photograph. The game draws an equipped weapon only while the pawn is drafted (or aiming), so the
    /// step equips the weapon and drafts the colonist; the second step puts everything back. Written 2026-10-18 for EntityGazing's gallery
    /// (a colonist wielding a weapon). The weapon names are in docs/CATALOGUE-WEAPONS-CRAFTS.md. Not played.
    /// </summary>
    [PickleSteps]
    public class WeaponSteps
    {
        private static readonly Dictionary<Pawn, bool> DraftedBefore = new Dictionary<Pawn, bool>();
        private static readonly List<ThingWithComps> Wielded = new List<ThingWithComps>();

        /// <summary>
        /// Gives the colonist a new weapon of the def (by defName, made of its default stuff) and drafts the colonist so the game draws it. The weapon
        /// the colonist held goes to the inventory. Fails when the def is unknown or not a weapon, or the colonist cannot wield it (a violence-incapable pawn).
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} wields {string}")]
        public void Wields(PickleContext ctx, string nickname, string weaponDefName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.equipment != null, $"pawn '{nickname}' has no equipment tracker");
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(weaponDefName);
            ctx.Require(def != null && def.IsWeapon, $"'{weaponDefName}' is not a weapon def");
            ThingWithComps held = pawn.equipment.Primary;
            if (held != null)
            {
                pawn.equipment.TryTransferEquipmentToContainer(held, pawn.inventory.innerContainer);
            }

            var weapon = (ThingWithComps)ThingMaker.MakeThing(def, def.MadeFromStuff ? GenStuff.DefaultStuffFor(def) : null);
            pawn.equipment.AddEquipment(weapon);
            Wielded.Add(weapon);
            if (pawn.drafter != null)
            {
                if (!DraftedBefore.ContainsKey(pawn))
                {
                    DraftedBefore[pawn] = pawn.Drafted;
                }

                pawn.drafter.Drafted = true;
                ctx.Assert(pawn.Drafted, $"{nickname} should be drafted so the game draws the weapon; the drafter refused (violence-incapable or downed pawn?)");
            }

            // PawnRenderUtility.DrawEquipmentAndApparelExtras draws nothing unless the pawn has a current job that may show the weapon (ticket f256, 2026-10-24:
            // drafted, carryOpenly true, weapon held, job none, no weapon in the capture). A drafted pawn gets Wait_Combat from the game's own tick, which a paused game never runs.
            if (pawn.jobs != null && (pawn.CurJob == null || pawn.CurJob.def.neverShowWeapon))
            {
                pawn.jobs.StartJob(JobMaker.MakeJob(JobDefOf.Wait_Combat), JobCondition.InterruptForced);
                ctx.Assert(pawn.CurJob != null && !pawn.CurJob.def.neverShowWeapon, $"{nickname} should have a job that shows the weapon (Wait_Combat); the current job is {pawn.CurJob?.def.defName ?? "none"}");
            }

            pawn.Drawer.renderer.SetAllGraphicsDirty();
            ctx.Assert(pawn.equipment.Primary == weapon, $"{nickname} should hold '{weaponDefName}'; the colonist holds {pawn.equipment.Primary?.def.defName ?? "nothing"}");
        }

        /// <summary>
        /// Writes what the game decides about drawing the colonist's weapon to the game log, line prefix "[wield-diag]": draft state, the game's own
        /// "carry the weapon openly" verdict, the held weapon and its graphic, the job, and the pawn render tree (node class, worker class, label).
        /// A diagnostic for the weapon gallery, where a wielded weapon was equipped and drafted but not drawn (ticket ea83). Reads only.
        /// </summary>
        [Then("Nelim's Pickle Tools: the weapon render of {string} is logged")]
        public void WeaponRenderLogged(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ThingWithComps primary = pawn.equipment?.Primary;
            Log.Message($"[wield-diag] {nickname} drafted={pawn.Drafted} carryOpenly={PawnRenderUtility.CarryWeaponOpenly(pawn)} rot={pawn.Rotation} spawned={pawn.Spawned} " +
                $"job={pawn.CurJobDef?.defName ?? "none"} carried={pawn.carryTracker?.CarriedThing?.def.defName ?? "none"} stance={pawn.stances?.curStance?.GetType().Name ?? "none"}");
            Log.Message($"[wield-diag] primary={primary?.def.defName ?? "none"} graphic={primary?.Graphic?.GetType().Name ?? "none"} path={(primary?.Graphic as Graphic_Single)?.path ?? primary?.def.graphicData?.texPath ?? "?"} equipment={string.Join(",", pawn.equipment?.AllEquipmentListForReading.Select(t => t.def.defName) ?? Enumerable.Empty<string>())}");
            object tree = Traverse.Create(pawn.Drawer.renderer).Field("renderTree").GetValue();
            if (tree == null)
            {
                Log.Message("[wield-diag] render tree not found on the renderer");
                return;
            }

            object root = Traverse.Create(tree).Field("rootNode").GetValue();
            LogNode(root, 0, pawn);
        }

        private static void LogNode(object node, int depth, Pawn pawn)
        {
            if (node == null || depth > 12)
            {
                return;
            }

            Traverse t = Traverse.Create(node);
            object props = t.Property("Props").GetValue() ?? t.Field("props").GetValue();
            Traverse p = Traverse.Create(props);
            Log.Message($"[wield-diag] {new string(' ', depth * 2)}{node.GetType().Name} label={p.Field("debugLabel").GetValue()} tag={p.Field("tagDef").GetValue()} worker={p.Field("workerClass").GetValue()} visible={p.Field("alwaysVisible").GetValue()}");
            if (node is PawnRenderNode rn && p.Field("debugLabel").GetValue() as string == "Weapon/carried thing")
            {
                Graphic g = null;
                try { g = Traverse.Create(rn).Method("GraphicFor", new[] { typeof(Pawn) }, new object[] { pawn }).GetValue<Graphic>(); }
                catch (System.Exception e) { Log.Message("[wield-diag] weapon node GraphicFor failed: " + e.GetType().Name + " " + e.Message); }
                Log.Message($"[wield-diag] weapon node graphic={(g == null ? "null" : g.GetType().Name + " " + ((g as Graphic_Single)?.path ?? g.data?.texPath) + " drawSize=" + g.drawSize)} " +
                    $"drawData={(p.Field("drawData").GetValue() == null ? "none" : "set")} node.Graphics={(rn.Graphics?.Count.ToString() ?? "null")} " +
                    $"meshSet={(t.Field("meshSet").GetValue() == null ? "null" : "set")} parentDepth={depth}");
            }

            if (t.Field("children").GetValue() is System.Collections.IEnumerable children)
            {
                foreach (object child in children)
                {
                    LogNode(child, depth + 1, pawn);
                }
            }
        }

        /// <summary>Takes the weapons these steps gave away from the colonist and puts the draft state back as it was before the first one.</summary>
        [When("Nelim's Pickle Tools: {string} puts its weapon away")]
        public void PutsAway(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Release(pawn);
            pawn.Drawer.renderer.SetAllGraphicsDirty();
        }

        [AfterScenario]
        public void ReleaseAll()
        {
            foreach (Pawn pawn in DraftedBefore.Keys.ToList())
            {
                try
                {
                    Release(pawn);
                }
                catch (System.Exception e)
                {
                    Log.Warning("[wield] could not take the weapon back from a pawn of a replaced game: " + e.GetType().Name);
                }
            }

            Wielded.Clear();
            DraftedBefore.Clear();
        }

        private static void Release(Pawn pawn)
        {
            foreach (ThingWithComps weapon in Wielded.Where(w => pawn.equipment != null && pawn.equipment.AllEquipmentListForReading.Contains(w)).ToList())
            {
                pawn.equipment.Remove(weapon);
                weapon.Destroy();
                Wielded.Remove(weapon);
            }

            if (pawn.jobs?.curJob != null && pawn.jobs.curJob.def == JobDefOf.Wait_Combat && DraftedBefore.ContainsKey(pawn))
            {
                pawn.jobs.EndCurrentJob(JobCondition.InterruptForced, false);
            }

            if (pawn.drafter != null && DraftedBefore.TryGetValue(pawn, out bool before))
            {
                pawn.drafter.Drafted = before;
                DraftedBefore.Remove(pawn);
            }
        }
    }
}
