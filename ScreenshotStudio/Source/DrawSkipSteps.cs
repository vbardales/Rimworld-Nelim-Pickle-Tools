using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using HarmonyLib;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// Hides what a class of a mod draws by itself, for the rest of the scenario. Written 2026-11-09 for AncientChineseBeastAndGeneExpandedRenew (scene 6:
    /// Ability_BerserkRing.Draw puts a 22.9-tile plane over the whole frame, it is not a Mote thing, so hiding a mote def would not touch it).
    /// The step skips the void methods named Draw (instance, any visibility) declared by the type, or by the nearest base class that declares one and
    /// is not a type of the game (Verse, RimWorld, Unity). The methods are patched once with Harmony; a flag decides, so the patch is inert after the
    /// scenario. Compiled, not played.
    /// </summary>
    [PickleSteps]
    public class DrawSkipSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";
        private static Harmony harmony;
        private static readonly HashSet<MethodBase> Patched = new HashSet<MethodBase>();
        private static readonly HashSet<MethodBase> Skipped = new HashSet<MethodBase>();

        private static bool IsGameType(Type t)
        {
            string ns = t.Namespace ?? "";
            string asm = t.Assembly.GetName().Name;
            return asm == "Assembly-CSharp" || asm.StartsWith("UnityEngine") || asm == "mscorlib" || asm == "System" || ns == "Verse" || ns.StartsWith("Verse.") || ns == "RimWorld" || ns.StartsWith("RimWorld.");
        }

        private static Type FindType(string name)
        {
            foreach (Assembly a in AppDomain.CurrentDomain.GetAssemblies())
            {
                Type[] types;
                try { types = a.GetTypes(); }
                catch (ReflectionTypeLoadException e) { types = e.Types.Where(t => t != null).ToArray(); }
                Type found = types.FirstOrDefault(t => t.FullName == name) ?? types.FirstOrDefault(t => t.Name == name);
                if (found != null) return found;
            }
            return null;
        }

        /// <summary>
        /// Skips the Draw methods of a class until the scenario ends. <paramref name="typeName"/> is the full name or the short name of the class, for
        /// instance <c>Ability_BerserkRing</c>. Fails when the type is not loaded or has no void Draw method to skip.
        /// </summary>
        [Given(Prefix + "the drawing of the class {string} is skipped")]
        public void SkipDraw(PickleContext ctx, string typeName)
        {
            Type type = FindType(typeName);
            ctx.Require(type != null, "no class named '" + typeName + "' is loaded (full name or short name)");
            var methods = new List<MethodInfo>();
            for (Type t = type; t != null && !IsGameType(t); t = t.BaseType)
            {
                methods = t.GetMethods(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.DeclaredOnly)
                    .Where(m => m.Name == "Draw" && m.ReturnType == typeof(void) && !m.IsAbstract).ToList();
                if (methods.Count > 0) break;
            }
            ctx.Require(methods.Count > 0, "the class '" + type.FullName + "' (and its bases outside the game) declares no void method named Draw");
            if (harmony == null) harmony = new Harmony("nelim.pickletools.drawskip");
            foreach (MethodInfo m in methods)
            {
                if (Patched.Add(m)) harmony.Patch(m, prefix: new HarmonyMethod(typeof(DrawSkipSteps), nameof(Prefix_Draw)));
                Skipped.Add(m);
            }
            Log.Message("[draw-skip] " + methods.Count + " Draw method(s) of " + methods[0].DeclaringType.FullName + " are skipped");
        }

        private static bool Prefix_Draw(MethodBase __originalMethod) => !Skipped.Contains(__originalMethod);

        [AfterScenario]
        public void ReleaseDraw()
        {
            Skipped.Clear();
        }
    }
}
