using System;
using System.Linq;
using System.Reflection;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Body Hair Framework (lucius.bodyhairframework, Workshop 3823805934) steps, for the mods built on it (True Body Hair
    /// morton.truebodyhair, 3825963278: MortonFlameLowerBody, MortonSomecurlsLowerBody...). The framework keeps one style per
    /// slot (BHF_Torso, BHF_LowerBody, BHF_Back) in a pawn comp, and draws each as a render node coloured like the hair.
    /// Everything is reached by reflection: the framework is optional, this assembly never references it.
    ///
    /// Written 2026-11-04 for the Sanctuary Backlot underwear shot (NSB request through the Ticket Manager). NOT PLAYED:
    /// compiled against the reference assemblies only. The framework declares supportedVersions 1.7 only.
    /// </summary>
    [PickleSteps]
    public class BodyHairSteps
    {
        private const string NodePrefix = "Body hair: ";

        private static Type Named(PickleContext ctx, string fullName)
        {
            Type t = GenTypes.AllTypes.FirstOrDefault(x => x.FullName == fullName);
            ctx.Require(t != null, $"type {fullName} not found: Body Hair Framework (lucius.bodyhairframework) is not loaded");
            return t;
        }

        private static Def FindDef(PickleContext ctx, Type defType, string name)
        {
            Def def = GenDefDatabase.GetDef(defType, name, false);
            ctx.Require(def != null, $"no {defType.Name} named '{name}'");
            return def;
        }

        /// <summary>Resolves the slot, accepting the short name ("LowerBody") or the def name ("BHF_LowerBody").</summary>
        private static Def FindSlot(PickleContext ctx, string slot)
        {
            Type slotType = Named(ctx, "BodyHair.BHF_BodyHairSlotDef");
            string name = slot.StartsWith("BHF_", StringComparison.Ordinal) ? slot : "BHF_" + slot;
            return FindDef(ctx, slotType, name);
        }

        private static ThingComp CompOf(PickleContext ctx, Pawn pawn, string nickname)
        {
            Type compType = Named(ctx, "BodyHair.BHF_BodyHairComp");
            ThingComp comp = pawn.AllComps.FirstOrDefault(c => compType.IsInstanceOfType(c));
            ctx.Require(comp != null, $"pawn '{nickname}' has no body hair comp (not a humanlike pawn, or the framework's patch did not apply)");
            return comp;
        }

        /// <summary>
        /// Sets the style of one slot of the colonist and redraws the pawn. The slot is "Torso", "LowerBody" or "Back" (or the def name
        /// "BHF_LowerBody"); the style is a body hair def name such as "MortonFlameLowerBody", or "BHF_None" for no hair in that slot.
        /// Fails when the style belongs to another slot, or when the pawn cannot use it (gender, body type and required gene
        /// are the framework's own rules).
        /// </summary>
        [When("Nelim's Pickle Tools: the body hair {string} of {string} is set to {string}")]
        public void SetStyle(PickleContext ctx, string slot, string nickname, string style)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ThingComp comp = CompOf(ctx, pawn, nickname);
            Def slotDef = FindSlot(ctx, slot);
            Def styleDef = FindDef(ctx, Named(ctx, "BodyHair.BHF_BodyHairDef"), style);

            MethodInfo canUse = styleDef.GetType().GetMethod("CanUse", new[] { typeof(Pawn) });
            ctx.Require(
                styleDef.defName == "BHF_None" || (bool)canUse.Invoke(styleDef, new object[] { pawn }),
                $"the framework says {nickname} cannot use '{style}' (gender, body type '{pawn.story?.bodyType?.defName}' or required gene)");

            MethodInfo setStyle = comp.GetType().GetMethod("SetStyle", new[] { slotDef.GetType(), styleDef.GetType() });
            ctx.Require(setStyle != null, "BHF_BodyHairComp.SetStyle(slot, style) not found: the framework changed");
            try
            {
                setStyle.Invoke(comp, new object[] { slotDef, styleDef });
            }
            catch (TargetInvocationException e)
            {
                throw new InvalidOperationException($"SetStyle refused '{style}' for slot '{slotDef.defName}': {e.InnerException?.Message}", e.InnerException);
            }
        }

        /// <summary>
        /// Asserts that the slot holds the style and that the pawn's render tree really draws it: a node "Body hair: &lt;slot&gt;" exists,
        /// with a texture, tinted like the pawn's hair colour (to 0.02). "BHF_None" asserts the slot holds no style and draws no node.
        /// </summary>
        [Then("Nelim's Pickle Tools: the body hair {string} of {string} is drawn as {string}")]
        public void IsDrawnAs(PickleContext ctx, string slot, string nickname, string style)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ThingComp comp = CompOf(ctx, pawn, nickname);
            Def slotDef = FindSlot(ctx, slot);

            MethodInfo currentFor = comp.GetType().GetMethod("CurrentFor", new[] { slotDef.GetType() });
            ctx.Require(currentFor != null, "BHF_BodyHairComp.CurrentFor(slot) not found: the framework changed");
            Def current = (Def)currentFor.Invoke(comp, new object[] { slotDef });
            ctx.Assert(
                string.Equals(current?.defName, style, StringComparison.Ordinal),
                $"{nickname}'s slot {slotDef.defName} holds '{current?.defName}', not '{style}'");

            pawn.Drawer.renderer.SetAllGraphicsDirty();
            PawnRenderTree tree = pawn.Drawer.renderer.renderTree;
            tree.EnsureInitialized(PawnRenderFlags.None);

            PawnRenderNode node = Find(tree.rootNode, NodePrefix + slotDef.defName);
            if (style == "BHF_None")
            {
                ctx.Assert(node == null, $"{nickname}'s slot {slotDef.defName} holds no style yet a render node '{NodePrefix}{slotDef.defName}' is drawn");
                return;
            }

            ctx.Assert(node != null, $"{nickname} holds '{style}' in {slotDef.defName} but the render tree has no node '{NodePrefix}{slotDef.defName}' (style not drawable for this body type?)");
            ctx.Assert(!string.IsNullOrEmpty(node.Props.texPath), $"the node '{NodePrefix}{slotDef.defName}' has no texture path");
            Color drawn = node.ColorFor(pawn);
            Color hair = pawn.story.HairColor;
            ctx.Assert(
                Mathf.Abs(drawn.r - hair.r) < 0.02f && Mathf.Abs(drawn.g - hair.g) < 0.02f && Mathf.Abs(drawn.b - hair.b) < 0.02f,
                $"'{style}' is drawn in {drawn}, not in the hair colour {hair}");
        }

        /// <summary>
        /// Logs the render tree of the colonist ([render-nodes]): one line per node, indented by depth, with its label, its tag, its base
        /// layer (<c>Props.baseLayer</c>) and, for an apparel node, the garment and its layer. To see why body hair is drawn over or under a
        /// garment: the draw order is the base layer, the higher drawn last. Never fails. Written 2026-11-05 for the Sanctuary Backlot swim shot.
        /// </summary>
        [Given("Nelim's Pickle Tools: the render nodes of {string} are logged")]
        public void LogRenderNodes(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            pawn.Drawer.renderer.SetAllGraphicsDirty();
            PawnRenderTree tree = pawn.Drawer.renderer.renderTree;
            tree.EnsureInitialized(PawnRenderFlags.None);
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("[render-nodes] " + nickname + " (" + pawn.story?.bodyType?.defName + ")");
            Dump(tree.rootNode, 0, sb);
            Log.Message(sb.ToString());
        }

        private static void Dump(PawnRenderNode node, int depth, System.Text.StringBuilder sb)
        {
            if (node == null)
            {
                return;
            }

            string apparel = node is PawnRenderNode_Apparel a && a.apparel != null
                ? " apparel=" + a.apparel.def.defName + " layer=" + a.apparel.def.apparel.LastLayer?.defName + " drawOrder=" + a.apparel.def.apparel.LastLayer?.drawOrder
                : string.Empty;
            sb.AppendLine(new string(' ', depth * 2) + "- " + (node.Props?.debugLabel ?? node.GetType().Name) + " tag=" + node.Props?.tagDef?.defName +
                          " baseLayer=" + node.Props?.baseLayer + apparel + " tex=" + node.Props?.texPath);
            if (node.children != null)
            {
                foreach (PawnRenderNode child in node.children)
                {
                    Dump(child, depth + 1, sb);
                }
            }
        }

        private static PawnRenderNode Find(PawnRenderNode node, string debugLabel)
        {
            if (node == null)
            {
                return null;
            }

            if (node.Props != null && node.Props.debugLabel == debugLabel)
            {
                return node;
            }

            if (node.children != null)
            {
                foreach (PawnRenderNode child in node.children)
                {
                    PawnRenderNode found = Find(child, debugLabel);
                    if (found != null)
                    {
                        return found;
                    }
                }
            }

            return null;
        }
    }
}
