using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

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

            pawn.Drawer.renderer.SetAllGraphicsDirty();
            ctx.Assert(pawn.equipment.Primary == weapon, $"{nickname} should hold '{weaponDefName}'; the colonist holds {pawn.equipment.Primary?.def.defName ?? "nothing"}");
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

            if (pawn.drafter != null && DraftedBefore.TryGetValue(pawn, out bool before))
            {
                pawn.drafter.Drafted = before;
                DraftedBefore.Remove(pawn);
            }
        }
    }
}
