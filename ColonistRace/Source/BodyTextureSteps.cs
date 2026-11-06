using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that read the texture path of the body graphic a pawn is drawn with: the body node of the render tree (tag Body, <c>PawnRenderNode_Body</c>), its
    /// primary graphic (a <c>Graphic_Multi</c> for a humanlike body). A gene, a body type patch or a mod that swaps the naked body shows up here, so the effect is
    /// assertable instead of read by eye. Written 2026-11-06 for BiotechBodies (BiB). NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class BodyTextureSteps
    {
        private const BindingFlags Any = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;

        private static List<PawnRenderNode> BodyNodes(Pawn pawn)
        {
            var found = new List<PawnRenderNode>();
            PawnRenderTree tree = pawn.Drawer?.renderer?.renderTree;
            if (tree == null) return found;
            tree.EnsureInitialized(PawnRenderFlags.None);
            if (tree.rootNode == null) return found;
            var todo = new Stack<PawnRenderNode>();
            todo.Push(tree.rootNode);
            while (todo.Count > 0)
            {
                PawnRenderNode node = todo.Pop();
                bool body = (node.Props?.tagDef != null && node.Props.tagDef == PawnRenderNodeTagDefOf.Body) || node.GetType().Name == "PawnRenderNode_Body";
                if (body) found.Add(node);
                if (node.children != null) foreach (PawnRenderNode child in node.children) todo.Push(child);
            }

            return found;
        }

        // The path the graphic was made from: data.texPath, else the field path of a multi graphic.
        private static string PathOf(PawnRenderNode node)
        {
            Graphic graphic = node.PrimaryGraphic;
            if (graphic == null) return null;
            string path = graphic.data?.texPath;
            if (!string.IsNullOrEmpty(path)) return path;
            path = graphic.GetType().GetField("path", Any)?.GetValue(graphic) as string;
            return string.IsNullOrEmpty(path) ? null : path;
        }

        private static string Normal(string path) => (path ?? string.Empty).Replace('\\', '/').Trim('/');

        private static string Describe(Pawn pawn, List<PawnRenderNode> nodes)
        {
            string list = nodes.Count == 0 ? "no body render node" : string.Join("; ", nodes.Select(n => n.GetType().Name + " draws '" + (PathOf(n) ?? "(no graphic)") + "'"));
            return $"body type {pawn.story?.bodyType?.defName ?? "(none)"}, {list}";
        }

        private static List<string> Paths(PickleContext ctx, Pawn pawn, string nickname, out List<PawnRenderNode> nodes)
        {
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
            nodes = BodyNodes(pawn);
            ctx.Require(nodes.Count > 0, $"{nickname} has no body render node (not spawned, or no render tree): " + Describe(pawn, nodes));
            return nodes.Select(PathOf).Where(p => p != null).Select(Normal).ToList();
        }

        /// <summary>
        /// Asserts that the body of a colonist or animal is drawn from exactly this texture path (relative to Textures, no direction suffix, slashes either way,
        /// case ignored): the path of the graphic of the body node of the render tree. The failure lists every body node with its path and the body type.
        /// </summary>
        /// <param name="nickname">the pawn's short name</param>
        /// <param name="texturePath">for example <c>BiB/Vanilla/Things/Pawn/Humanlike/Bodies/Naked_Male</c></param>
        [Then("Nelim's Pickle Tools: the body of {string} is drawn from the texture path {string}")]
        public void BodyDrawnFrom(PickleContext ctx, string nickname, string texturePath)
        {
            Pawn pawn = PawnByName(ctx, nickname);
            List<string> paths = Paths(ctx, pawn, nickname, out List<PawnRenderNode> nodes);
            string expected = Normal(texturePath);
            Log.Message("[body-texture] " + nickname + ": " + Describe(pawn, nodes));
            ctx.Assert(paths.Any(p => string.Equals(p, expected, StringComparison.OrdinalIgnoreCase)), $"the body of {nickname} is not drawn from '{expected}': " + Describe(pawn, nodes));
        }

        /// <summary>Asserts that the body path starts with the text given (case ignored, slashes either way): for a folder prefix such as <c>BiB/Vanilla/</c>.</summary>
        [Then("Nelim's Pickle Tools: the body of {string} is drawn from a texture path starting with {string}")]
        public void BodyDrawnStartingWith(PickleContext ctx, string nickname, string prefix)
        {
            Pawn pawn = PawnByName(ctx, nickname);
            List<string> paths = Paths(ctx, pawn, nickname, out List<PawnRenderNode> nodes);
            string start = Normal(prefix);
            Log.Message("[body-texture] " + nickname + ": " + Describe(pawn, nodes));
            ctx.Assert(paths.Any(p => p.StartsWith(start, StringComparison.OrdinalIgnoreCase)), $"the body of {nickname} is not drawn from a texture path starting with '{start}': " + Describe(pawn, nodes));
        }

        /// <summary>Asserts that no body node path starts with the text given (case ignored, slashes either way). Fails when the body has no graphic path to read, so an absent body does not pass.</summary>
        [Then("Nelim's Pickle Tools: the body of {string} is not drawn from a texture path starting with {string}")]
        public void BodyNotDrawnStartingWith(PickleContext ctx, string nickname, string prefix)
        {
            Pawn pawn = PawnByName(ctx, nickname);
            List<string> paths = Paths(ctx, pawn, nickname, out List<PawnRenderNode> nodes);
            string start = Normal(prefix);
            Log.Message("[body-texture] " + nickname + ": " + Describe(pawn, nodes));
            ctx.Require(paths.Count > 0, $"the body of {nickname} has no readable texture path: " + Describe(pawn, nodes));
            ctx.Assert(!paths.Any(p => p.StartsWith(start, StringComparison.OrdinalIgnoreCase)), $"the body of {nickname} is drawn from a texture path starting with '{start}': " + Describe(pawn, nodes));
        }

        /// <summary>Logs ([body-texture], and the attachment <c>body-texture</c>) the body render nodes of a pawn with their texture paths. Never fails.</summary>
        [Given("Nelim's Pickle Tools: the body texture of {string} is logged")]
        public void BodyLogged(PickleContext ctx, string nickname)
        {
            Pawn pawn = PawnByName(ctx, nickname);
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
            string text = Describe(pawn, BodyNodes(pawn));
            Log.Message("[body-texture] " + nickname + ": " + text);
            ctx.Attach("body-texture", nickname + ": " + text);
        }

        // A colonist by nickname first, then any spawned pawn (animal or other) by short name.
        private static Pawn PawnByName(PickleContext ctx, string name)
        {
            Pawn pawn = Find.CurrentMap?.mapPawns.AllPawnsSpawned.FirstOrDefault(p => p.Name != null && string.Equals(p.LabelShort, name, StringComparison.OrdinalIgnoreCase));
            ctx.Require(pawn != null, $"no pawn named '{name}' is spawned on the current map");
            return pawn;
        }
    }
}
