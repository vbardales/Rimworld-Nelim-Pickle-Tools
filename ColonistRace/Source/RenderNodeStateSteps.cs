using System;
using System.Collections;
using System.Linq;
using System.Reflection;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Says why a render node of a colonist does not draw. Everything is read by reflection, so a member the game version lacks prints "?" instead of failing.
    /// Written 2026-11-12 for ACBaGE (Ryu: body, shirt and pants nodes have an empty texture and do not render). NOT PLAYED.
    /// </summary>
    [PickleSteps]
    public class RenderNodeStateSteps
    {
        private const BindingFlags All = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;

        /// <summary>
        /// Logs ([render-state]) for every node of the colonist's render tree, south facing: the node class, its tag, the worker class, whether the worker lets it draw now
        /// (CanDrawNow), how many graphics it holds and the path and shader of the first one, its draw size, its colour, its parent chain, and the apparel it stands for.
        /// Read the nodes whose CanDrawNow is False or whose graphic count is 0: those draw nothing. Never fails.
        /// </summary>
        [Given("Nelim's Pickle Tools: the draw state of the render nodes of {string} is logged")]
        public void LogDrawState(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            pawn.Drawer.renderer.SetAllGraphicsDirty();
            PawnRenderTree tree = pawn.Drawer.renderer.renderTree;
            // Built with the flags the game draws with, then marked dirty again: a tree built here with None and left in place would be the tree of the capture (written 2026-11-19, AniS ticket 46a7: ApparelBody children=0; hypothesis, not proven).
            tree.EnsureInitialized(GameFlags());
            object parms = MakeParms(pawn);
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("[render-state] " + nickname + " (" + pawn.story?.bodyType?.defName + "), facing South, flags " + GameFlags() + ", parms " + (parms == null ? "NOT BUILT" : "built"));
            Dump(tree.rootNode, 0, sb, parms);
            Log.Message(sb.ToString());
            ctx.Attach("render-state", sb.ToString());
            pawn.Drawer.renderer.SetAllGraphicsDirty();
        }

        /// <summary>
        /// Rebuilds the render tree of a pawn (colonist by nickname) from what it wears now, with the flags the game draws with (clothes, headgear), and logs ([render-rebuilt]) the
        /// number of children of the ApparelBody and ApparelHead nodes against the number of garments worn. For a pawn drawn with no clothes although it wears some. Never fails.
        /// Written 2026-11-19 for AniS (Soren, bare torso). NOT PLAYED.
        /// </summary>
        [Given("Nelim's Pickle Tools: the render tree of {string} is rebuilt")]
        public void RebuildRenderTree(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            pawn.Drawer.renderer.SetAllGraphicsDirty();
            PawnRenderTree tree = pawn.Drawer.renderer.renderTree;
            tree.EnsureInitialized(GameFlags());
            int body = -1, head = -1;
            foreach (PawnRenderNode n in tree.rootNode.children ?? new PawnRenderNode[0])
                Count(n, ref body, ref head);
            string msg = "[render-rebuilt] " + nickname + ": worn " + pawn.apparel?.WornApparelCount + " (" + string.Join(", ", pawn.apparel?.WornApparel.Select(a => a.def.defName) ?? Enumerable.Empty<string>())
                + "), ApparelBody children " + body + ", ApparelHead children " + head + ", frame " + Time.frameCount;
            Log.Message(msg);
            ctx.Attach("render-rebuilt", msg);
        }

        private static void Count(PawnRenderNode node, ref int body, ref int head)
        {
            string tag = node.Props?.tagDef?.defName;
            if (tag == "ApparelBody") body = node.children?.Length ?? 0;
            else if (tag == "ApparelHead") head = node.children?.Length ?? 0;
            if (node.children == null) return;
            foreach (PawnRenderNode c in node.children) Count(c, ref body, ref head);
        }

        private static object MakeParms(Pawn pawn)
        {
            try
            {
                object p = Activator.CreateInstance(typeof(PawnDrawParms));
                Set(p, "pawn", pawn);
                Set(p, "facing", Rot4.South);
                Set(p, "rotDrawMode", RotDrawMode.Fresh);
                Set(p, "flags", GameFlags());
                Set(p, "tint", Color.white);
                Set(p, "matrix", Matrix4x4.identity);
                return p;
            }
            catch (Exception e) { Log.Warning("[render-state] parms: " + e.Message); return null; }
        }

        // The flags the game draws a pawn with on the map: clothes and headgear on. With None the apparel workers say CanDrawNow False (found 2026-11-12, ACBaGE ticket b326).
        private static PawnRenderFlags GameFlags()
        {
            PawnRenderFlags f = PawnRenderFlags.None;
            foreach (string n in new[] { "Clothes", "Headgear" })
                if (Enum.IsDefined(typeof(PawnRenderFlags), n)) f |= (PawnRenderFlags)Enum.Parse(typeof(PawnRenderFlags), n);
            return f;
        }

        private static string Transform(PawnRenderNode node, object parms)
        {
            object worker = Get(node, "Worker");
            if (worker == null || parms == null) return "?";
            var parts = new System.Collections.Generic.List<string>();
            try
            {
                MethodInfo off = worker.GetType().GetMethod("OffsetFor", All);
                if (off != null) { object[] a = { node, parms, Vector3.zero }; object r = off.Invoke(worker, a); parts.Add("offset=" + Str(r) + " pivot=" + Str(a[2])); }
            }
            catch (Exception e) { parts.Add("offset error " + (e.InnerException ?? e).Message); }
            foreach (string n in new[] { "ScaleFor", "AltitudeFor" })
                try { MethodInfo m = worker.GetType().GetMethod(n, All); if (m != null) parts.Add(n + "=" + Str(m.Invoke(worker, new object[] { node, parms }))); } catch (Exception e) { parts.Add(n + " error " + (e.InnerException ?? e).Message); }
            try
            {
                MethodInfo gm = node.GetType().GetMethod("GetMesh", All) ?? worker.GetType().GetMethod("GetMesh", All);
                if (gm != null)
                {
                    object mesh = gm.DeclaringType.IsInstanceOfType(node) ? gm.Invoke(node, new object[] { parms }) : gm.Invoke(worker, new object[] { parms });
                    Mesh um = mesh as Mesh;
                    parts.Add("mesh=" + (um == null ? Str(mesh) : um.name + " bounds=" + um.bounds.size));
                }
            }
            catch (Exception e) { parts.Add("mesh error " + (e.InnerException ?? e).Message); }
            return string.Join(" ", parts);
        }

        // The south material of a graphic: shader, main texture (name, size, readable), colour and its alpha, and whether a readable texture is fully transparent.
        private static string MaterialInfo(object graphic)
        {
            try
            {
                Material mat = Get(graphic, "MatSouth") as Material ?? Get(graphic, "MatSingle") as Material;
                if (mat == null) return "none";
                Texture tex = mat.mainTexture;
                string texInfo = tex == null ? "no main texture" : tex.name + " " + tex.width + "x" + tex.height + " readable=" + ((tex as Texture2D)?.isReadable.ToString() ?? "?");
                string opaque = "?";
                if (tex != null && tex.width > 0 && tex.height > 0)
                {
                    // Read through the GPU so that an unreadable texture can be counted too: blit to a temporary render texture, read it back.
                    RenderTexture rt = RenderTexture.GetTemporary(tex.width, tex.height, 0, RenderTextureFormat.ARGB32);
                    RenderTexture prev = RenderTexture.active;
                    Texture2D copy = new Texture2D(tex.width, tex.height, TextureFormat.RGBA32, false);
                    try
                    {
                        Graphics.Blit(tex, rt);
                        RenderTexture.active = rt;
                        copy.ReadPixels(new Rect(0, 0, tex.width, tex.height), 0, 0);
                        copy.Apply();
                    }
                    finally { RenderTexture.active = prev; RenderTexture.ReleaseTemporary(rt); }
                    Color32[] px = copy.GetPixels32();
                    UnityEngine.Object.Destroy(copy);
                    int visible = 0, opaqueN = 0;
                    for (int i = 0; i < px.Length; i++) { if (px[i].a > 16) visible++; if (px[i].a > 240) opaqueN++; }
                    opaque = visible + " visible and " + opaqueN + " opaque of " + px.Length + " pixels (" + (100f * opaqueN / Math.Max(1, px.Length)).ToString("0.0") + " % opaque, GPU copy)";
                }
                string mask = mat.HasProperty("_MaskTex") && mat.GetTexture("_MaskTex") != null ? " mask=" + mat.GetTexture("_MaskTex").name : string.Empty;
                return "shader=" + mat.shader?.name + " tex=" + texInfo + " pixels=" + opaque + " color=" + mat.color + mask + " renderQueue=" + mat.renderQueue;
            }
            catch (Exception e) { return "error " + e.Message; }
        }

        private static void Set(object boxed, string name, object value)
        {
            FieldInfo f = boxed.GetType().GetField(name, All);
            if (f != null && (value == null || f.FieldType.IsInstanceOfType(value))) f.SetValue(boxed, value);
        }

        private static object Get(object o, string name)
        {
            if (o == null) return null;
            try
            {
                Type t = o.GetType();
                PropertyInfo p = t.GetProperty(name, All);
                if (p != null && p.GetIndexParameters().Length == 0) return p.GetValue(o, null);
                FieldInfo f = t.GetField(name, All);
                if (f != null) return f.GetValue(o);
            }
            catch (Exception) { }
            return null;
        }

        private static string Str(object o) => o == null ? "?" : o.ToString();

        /// <summary>
        /// Logs ([pawn-draw]) where and how the game draws a colonist: race def, life stage and body size, spawned, draw position and its screen point with the camera root size,
        /// the draw mode, the body type, hediffs and genes. To tell a pawn drawn in the wrong place or at a zero size from a pawn whose body node does not draw. Never fails.
        /// Written 2026-11-12 for ACBaGE (a spawned colonist drawn as a head and a cape only). NOT PLAYED.
        /// </summary>
        [Given("Nelim's Pickle Tools: the draw position of {string} is logged")]
        public void LogDrawPosition(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("[pawn-draw] " + nickname + ": race " + pawn.def.defName + ", kind " + pawn.kindDef?.defName + ", humanlike " + pawn.RaceProps.Humanlike + ", life stage " + pawn.ageTracker?.CurLifeStage?.defName
                + ", biological age " + pawn.ageTracker?.AgeBiologicalYears + ", body size " + pawn.BodySize.ToString("0.00") + ", body type " + pawn.story?.bodyType?.defName + ", gender " + pawn.gender);
            Vector3 pos = pawn.DrawPos;
            Vector3 screen = Find.Camera != null ? Find.Camera.WorldToScreenPoint(pos) : Vector3.zero;
            sb.AppendLine("spawned " + pawn.Spawned + ", position " + pawn.Position + ", draw pos " + pos + ", screen " + screen + " of " + Screen.width + "x" + Screen.height + ", camera root size " + Find.CameraDriver.RootSize.ToString("0.00") + ", rotation " + pawn.Rotation);
            sb.AppendLine("draw mode " + pawn.Drawer.renderer.CurRotDrawMode + ", dead " + pawn.Dead + ", downed " + pawn.Downed);
            sb.AppendLine("hediffs: " + string.Join(", ", pawn.health.hediffSet.hediffs.Select(h => h.def.defName)));
            if (pawn.genes != null) sb.AppendLine("genes: " + string.Join(", ", pawn.genes.GenesListForReading.Select(g => g.def.defName + (g.Active ? string.Empty : "(inactive)"))));
            Log.Message(sb.ToString());
            ctx.Attach("pawn-draw", sb.ToString());
        }

        /// <summary>
        /// Logs ([draw-requests]) what the render tree of the colonist holds as draw requests after the game's own draw of the last frame (the VEF prefix on AppendDrawRequests and the CanDrawNow
        /// postfixes of other mods have then already acted): every list field of the tree whose element type carries a node, a mesh or a material is dumped element by element (node, mesh,
        /// material shader and texture, matrix position). Wait a frame after the pawn is placed. Reflection only: a field the game version lacks is simply not listed. Never fails. NOT PLAYED.
        /// </summary>
        [Given("Nelim's Pickle Tools: the draw requests of {string} are logged")]
        public void LogDrawRequests(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            PawnRenderTree tree = pawn.Drawer.renderer.renderTree;
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("[draw-requests] " + nickname + ", frame " + Time.frameCount);
            foreach (FieldInfo f in tree.GetType().GetFields(All))
            {
                object v = null;
                try { v = f.GetValue(tree); } catch (Exception) { }
                if (!(v is IEnumerable list) || v is string) continue;
                var items = list.Cast<object>().ToList();
                if (items.Count == 0) { sb.AppendLine("field " + f.Name + ": empty"); continue; }
                string typeName = items[0]?.GetType().Name ?? "?";
                bool interesting = items[0] != null && items[0].GetType().GetFields(All).Any(x => x.Name.IndexOf("mesh", StringComparison.OrdinalIgnoreCase) >= 0 || x.Name.IndexOf("material", StringComparison.OrdinalIgnoreCase) >= 0 || x.Name.IndexOf("node", StringComparison.OrdinalIgnoreCase) >= 0);
                sb.AppendLine("field " + f.Name + ": " + items.Count + " x " + typeName + (interesting ? string.Empty : " (not dumped)"));
                if (!interesting) continue;
                foreach (object it in items)
                {
                    var parts = new System.Collections.Generic.List<string>();
                    foreach (FieldInfo ef in it.GetType().GetFields(All))
                    {
                        object ev = null;
                        try { ev = ef.GetValue(it); } catch (Exception) { }
                        if (ev is PawnRenderNode n) parts.Add(ef.Name + "=" + (n.Props?.debugLabel ?? n.GetType().Name));
                        else if (ev is Mesh m) parts.Add(ef.Name + "=" + m.name);
                        else if (ev is Material mat) parts.Add(ef.Name + "=" + mat.shader?.name + "/" + (mat.mainTexture?.name ?? "no texture") + " a=" + mat.color.a.ToString("0.00"));
                        else if (ev is Matrix4x4 mx) parts.Add(ef.Name + "=pos " + mx.GetColumn(3) + " scale " + mx.lossyScale);
                    }
                    sb.AppendLine("  " + string.Join(" | ", parts));
                }
            }
            Log.Message(sb.ToString());
            ctx.Attach("draw-requests", sb.ToString());
        }

        private static void Dump(PawnRenderNode node, int depth, System.Text.StringBuilder sb, object parms)
        {
            if (node == null) return;
            string canDraw = "?";
            try
            {
                object worker = Get(node, "Worker");
                MethodInfo m = worker?.GetType().GetMethod("CanDrawNow", All);
                if (m != null && parms != null) canDraw = Str(m.Invoke(worker, new object[] { node, parms }));
            }
            catch (Exception e) { canDraw = "error " + (e.InnerException ?? e).Message; }

            string graphics = "?";
            object gs = Get(node, "Graphics") ?? Get(node, "graphics");
            if (gs is IEnumerable list && !(gs is string))
            {
                var items = list.Cast<object>().ToList();
                object first = items.FirstOrDefault();
                graphics = items.Count + (first == null ? string.Empty : " first=" + Str(Get(first, "path") ?? Get(first, "data")?.GetType().Name) + " shader=" + Str(Get(Get(first, "Shader"), "name") ?? Get(Get(first, "shader"), "name") ?? Get(first, "Shader")) + " material: " + MaterialInfo(first));
            }
            else
            {
                object g = Get(node, "primaryGraphic") ?? Get(node, "Graphic");
                if (g != null) graphics = "1 " + g.GetType().Name + " path=" + Str(Get(g, "path"));
            }

            string apparel = node is PawnRenderNode_Apparel a && a.apparel != null ? " apparel=" + a.apparel.def.defName + " layer=" + a.apparel.def.apparel.LastLayer?.defName : string.Empty;
            sb.AppendLine(new string(' ', depth * 2) + "- " + (node.Props?.debugLabel ?? node.GetType().Name) + " class=" + node.GetType().Name + " tag=" + node.Props?.tagDef?.defName
                + " worker=" + Get(node, "Worker")?.GetType().Name + " canDrawNow=" + canDraw + " graphics=" + graphics + " drawSize=" + Str(Get(node.Props, "drawSize"))
                + " color=" + Str(Get(node.Props, "colorType")) + " texPath=" + node.Props?.texPath + " children=" + (node.children?.Length ?? 0) + apparel + " transform: " + Transform(node, parms));
            if (node.children != null)
                foreach (PawnRenderNode child in node.children) Dump(child, depth + 1, sb, parms);
        }
    }
}
