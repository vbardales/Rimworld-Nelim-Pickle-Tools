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
            tree.EnsureInitialized(PawnRenderFlags.None);
            object parms = MakeParms(pawn);
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("[render-state] " + nickname + " (" + pawn.story?.bodyType?.defName + "), facing South, flags " + GameFlags() + ", parms " + (parms == null ? "NOT BUILT" : "built"));
            Dump(tree.rootNode, 0, sb, parms);
            Log.Message(sb.ToString());
            ctx.Attach("render-state", sb.ToString());
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
                if (tex is Texture2D t2 && t2.isReadable)
                {
                    Color32[] px = t2.GetPixels32();
                    int visible = 0;
                    for (int i = 0; i < px.Length; i += 7) if (px[i].a > 16) visible++;
                    opaque = visible + " of " + (px.Length + 6) / 7 + " sampled pixels visible";
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
                graphics = items.Count + (first == null ? string.Empty : " first=" + Str(Get(first, "path") ?? Get(first, "data")?.GetType().Name) + " shader=" + Str(Get(Get(first, "Shader"), "name") ?? Get(Get(first, "shader"), "name") ?? Get(first, "Shader"))) + " material: " + MaterialInfo(first));
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
