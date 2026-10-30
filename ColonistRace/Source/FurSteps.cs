using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that read what the fur of a colonist really draws: the render nodes of the pawn (PawnRenderNode_Fur) and the texture path of each one.
    /// A fur def keeps its body graphics in a dictionary per body type (<c>bodyTypeGraphicPaths</c>), which the def field steps cannot read; the render
    /// node is the proof that a patch of that dictionary reaches the screen. Written 2026-10-31 for RhyaethWdiRealisticBodiesPatch (RWRBP). NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class FurSteps
    {
        private const BindingFlags Any = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;

        private static List<PawnRenderNode> FurNodes(Pawn pawn)
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
                if (node.GetType().Name.IndexOf("Fur", StringComparison.OrdinalIgnoreCase) >= 0) found.Add(node);
                if (node.children != null) foreach (PawnRenderNode child in node.children) todo.Push(child);
            }
            return found;
        }

        // The texture path a node draws: the graphic's own path (data.texPath, or the field path of a multi graphic), else the name of the texture of its material.
        private static string PathOf(PawnRenderNode node, out string how)
        {
            Graphic graphic = node.PrimaryGraphic;
            how = "";
            if (graphic == null) { how = "no graphic"; return null; }
            string path = graphic.data?.texPath;
            if (!string.IsNullOrEmpty(path)) { how = "graphic data texPath"; return path; }
            FieldInfo field = graphic.GetType().GetField("path", Any);
            path = field?.GetValue(graphic) as string;
            if (!string.IsNullOrEmpty(path)) { how = "graphic field path"; return path; }
            try { path = graphic.MatSouth?.mainTexture?.name; how = "south material texture name"; } catch { path = null; }
            return path;
        }

        private static string Describe(Pawn pawn, List<PawnRenderNode> nodes)
        {
            string furDef = pawn.story?.furDef?.defName ?? "(none)";
            string body = pawn.story?.bodyType?.defName ?? "(none)";
            string perType = "";
            object dict = pawn.story?.furDef == null ? null : pawn.story.furDef.GetType().GetField("bodyTypeGraphicPaths", Any)?.GetValue(pawn.story.furDef);
            if (dict is System.Collections.IDictionary d)
                perType = string.Join(", ", d.Keys.Cast<object>().Select(k => (k as Def)?.defName + "=" + d[k]));
            string list = nodes.Count == 0 ? "no fur render node" : string.Join("; ", nodes.Select(n => { string p = PathOf(n, out string how); return n.GetType().Name + " draws '" + (p ?? "(unknown)") + "' (" + how + ")"; }));
            return $"furDef {furDef}, body type {body}, nodes: {list}; bodyTypeGraphicPaths of the fur def: {(perType.Length == 0 ? "(none or not readable)" : perType)}";
        }

        /// <summary>
        /// Asserts that the fur render node of a colonist draws the texture path given (relative to Textures, with no direction suffix: <c>Pawn/ScalySkin/ScalySkin_Male</c>).
        /// The path read from the node may carry a direction suffix (<c>_south</c>) or a body type of the fur def: a match is the node's path equal to the expected one, or the
        /// expected one followed by an underscore suffix. The failure lists every fur node with its path, the fur def, the body type and the per body type paths of the def.
        /// </summary>
        [Then("Nelim's Pickle Tools: the fur of {string} is drawn from {string}")]
        public void FurDrawnFrom(PickleContext ctx, string nickname, string expectedPath)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            List<PawnRenderNode> nodes = FurNodes(pawn);
            string expected = expectedPath.Replace('\\', '/').Trim('/');
            bool ok = nodes.Any(n =>
            {
                string p = PathOf(n, out _)?.Replace('\\', '/');
                return p != null && (string.Equals(p, expected, StringComparison.OrdinalIgnoreCase) || p.StartsWith(expected + "_", StringComparison.OrdinalIgnoreCase));
            });
            Log.Message("[fur] " + nickname + ": " + Describe(pawn, nodes));
            ctx.Assert(ok, $"the fur of {nickname} is not drawn from '{expected}': " + Describe(pawn, nodes));
        }

        /// <summary>Logs (<c>[fur]</c>) every fur render node of a colonist with its texture path, the fur def, the body type and the per body type paths of the def. Never fails.</summary>
        [Given("Nelim's Pickle Tools: the fur nodes of {string} are logged")]
        public void FurLogged(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            string text = Describe(pawn, FurNodes(pawn));
            Log.Message("[fur] " + nickname + ": " + text);
            ctx.Attach("fur-nodes", nickname + ": " + text);
        }
    }
}
