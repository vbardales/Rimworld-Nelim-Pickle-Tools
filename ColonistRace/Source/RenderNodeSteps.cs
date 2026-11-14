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
    /// Steps that read every layer a colonist is drawn with, to find which one paints a stray mark on a face (a blush, a patch): the whole render tree
    /// (node type, tag, def, parent, texture path, colour, whether it draws), the hediffs, the style items (tattoos, beard, hair) and the apparel.
    /// A step can also take one node out of the tree to see whether the mark goes with it. Written 2026-11-13 for APerfectMindInAPerfectBody. NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class RenderNodeSteps
    {
        private const BindingFlags Any = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;

        private static PawnRenderTree Tree(PickleContext ctx, Pawn pawn, string nickname)
        {
            PawnRenderTree tree = pawn.Drawer?.renderer?.renderTree;
            ctx.Require(tree != null, nickname + " has no render tree");
            tree.EnsureInitialized(PawnRenderFlags.None);
            ctx.Require(tree.rootNode != null, nickname + " has no render tree root");
            return tree;
        }

        private static IEnumerable<PawnRenderNode> Walk(PawnRenderNode root)
        {
            var todo = new Stack<PawnRenderNode>();
            todo.Push(root);
            while (todo.Count > 0)
            {
                PawnRenderNode node = todo.Pop();
                yield return node;
                if (node.children != null) for (int i = node.children.Length - 1; i >= 0; i--) todo.Push(node.children[i]);
            }
        }

        // 2026-11-14 (aPMiaPB, tickets d52a, 1f5d, fc78): taking a node out of its parent's children did NOT reach the screenshot (hiding the head node itself
        // left the face drawn). The game's own switch is the flag the dev render-tree window toggles, debugEnabled: the node stays in the tree and is skipped at draw.
        private static void HideNode(PawnRenderNode node)
        {
            node.debugEnabled = false;
        }

        private static string PathOf(PawnRenderNode node)
        {
            try
            {
                Graphic graphic = node.PrimaryGraphic;
                if (graphic == null) return "(no graphic)";
                string path = graphic.data?.texPath;
                if (string.IsNullOrEmpty(path)) path = graphic.GetType().GetField("path", Any)?.GetValue(graphic) as string;
                if (string.IsNullOrEmpty(path)) { try { path = graphic.MatSouth?.mainTexture?.name; } catch { } }
                return (path ?? "(unknown path)") + " [" + graphic.GetType().Name + ", colour " + graphic.Color + "]";
            }
            catch (Exception e) { return "(unreadable: " + e.GetType().Name + ")"; }
        }

        private static string Describe(PawnRenderNode node)
        {
            string tag = node.Props?.tagDef?.defName ?? "-";
            string parent = node.parent == null ? "root" : node.parent.GetType().Name;
            string worker = node.Props?.workerClass?.Name ?? "-";
            string mod = node.Props?.tagDef?.modContentPack?.Name ?? "-";
            return node.GetType().Name + " enabled=" + node.debugEnabled + " tag=" + tag + " parent=" + parent + " worker=" + worker + " tagMod=" + mod + " draws " + PathOf(node);
        }

        /// <summary>
        /// Logs (<c>[render-nodes]</c>) and attaches every render node of a colonist (type, tag, parent, visible flag, worker, texture path with the graphic class and colour),
        /// then the hediffs, the style items (hair, beard, face tattoo, body tattoo) and the worn apparel. Never fails.
        /// </summary>
        [Given("Nelim's Pickle Tools: the render nodes and layers of {string} are logged")]
        public void NodesLogged(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            PawnRenderTree tree = Tree(ctx, pawn, nickname);
            var lines = Walk(tree.rootNode).Select(Describe).ToList();
            string hediffs = pawn.health?.hediffSet == null ? "(none)" : string.Join(", ", pawn.health.hediffSet.hediffs.Select(h => h.def.defName + (h.Part != null ? "@" + h.Part.def.defName : "")));
            string style = pawn.style == null ? "(no style tracker)" : "hair " + pawn.story?.hairDef?.defName + ", beard " + pawn.style.beardDef?.defName + ", face tattoo " + pawn.style.FaceTattoo?.defName + ", body tattoo " + pawn.style.BodyTattoo?.defName;
            string apparel = pawn.apparel == null ? "(none)" : string.Join(", ", pawn.apparel.WornApparel.Select(a => a.def.defName));
            string text = lines.Count + " render node(s):\n  " + string.Join("\n  ", lines) + "\nhediffs: " + hediffs + "\nstyle: " + style + "\napparel: " + apparel;
            Log.Message("[render-nodes] " + nickname + ": " + text);
            ctx.Attach("render-nodes", nickname + ": " + text);
        }

        /// <summary>
        /// Switches off the drawing (the game's own debugEnabled flag, as the dev render-tree window does; the node stays in the tree) of every node whose type name or tag contains the text (ignoring case; for example <c>Tattoo</c>, <c>Blush</c>, <c>Head</c>),
        /// so the next capture shows whether the mark goes with it. The flag resets when the game rebuilds the tree (a garment or a look change): hide, then shoot at once.
        /// Fails when no node matches; the failure lists the nodes. Logs <c>[render-nodes]</c> with what was hidden.
        /// </summary>
        [When("Nelim's Pickle Tools: the render nodes of {string} matching {string} are hidden")]
        public void NodesHidden(PickleContext ctx, string nickname, string text)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            PawnRenderTree tree = Tree(ctx, pawn, nickname);
            var hit = Walk(tree.rootNode).Where(n => n.parent != null && (n.GetType().Name.IndexOf(text, StringComparison.OrdinalIgnoreCase) >= 0
                || (n.Props?.tagDef?.defName ?? "").IndexOf(text, StringComparison.OrdinalIgnoreCase) >= 0)).ToList();
            ctx.Require(hit.Count > 0, nickname + " has no render node matching '" + text + "'; nodes: " + string.Join("; ", Walk(tree.rootNode).Select(n => n.GetType().Name + "/" + (n.Props?.tagDef?.defName ?? "-"))));
            foreach (PawnRenderNode node in hit) HideNode(node);
            Log.Message("[render-nodes] " + nickname + ": hidden " + hit.Count + " node(s) matching '" + text + "': " + string.Join("; ", hit.Select(n => n.GetType().Name)));
        }

        /// <summary>
        /// Switches off the drawing (the game's own debugEnabled flag, as the dev render-tree window does; the node stays in the tree) of every node that DRAWS a texture whose path contains the text (ignoring case; for example <c>blush_cover</c>):
        /// for a layer that has the same node type as the rest of the face (the Facial Animation part nodes) and no tag. The path is the one the log step shows
        /// (graphic texPath, or the path field, or the texture name). The tree comes back when the game rebuilds it: hide, then shoot at once. Fails when no
        /// node draws such a path; the failure lists every node with its path. Logs <c>[render-nodes]</c> with what was hidden. Written 2026-11-13 for APerfectMindInAPerfectBody. NOT PLAYED when written.
        /// </summary>
        [When("Nelim's Pickle Tools: the render nodes of {string} drawing {string} are hidden")]
        public void NodesDrawingHidden(PickleContext ctx, string nickname, string pathPart)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            PawnRenderTree tree = Tree(ctx, pawn, nickname);
            var hit = Walk(tree.rootNode).Where(n => n.parent != null && PathOf(n).IndexOf(pathPart, StringComparison.OrdinalIgnoreCase) >= 0).ToList();
            ctx.Require(hit.Count > 0, nickname + " has no render node drawing '" + pathPart + "'; nodes: " + string.Join("; ", Walk(tree.rootNode).Select(n => n.GetType().Name + " " + PathOf(n))));
            foreach (PawnRenderNode node in hit) HideNode(node);
            Log.Message("[render-nodes] " + nickname + ": hidden " + hit.Count + " node(s) drawing '" + pathPart + "': " + string.Join("; ", hit.Select(n => PathOf(n))));
        }
    }
}
