using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that read what the game tells the player: the live messages at the top of the screen, the open windows and their text, and the game log.
    /// Written 2026-11-18 for Between Sus (S20, S21, S24, S26: a refusal message, a console window, no raw BS_ key in French). Compiled, NOT PLAYED.
    /// Everything private is read by reflection, so a game version that moved a member fails with a message that says so.
    /// </summary>
    [PickleSteps]
    public class ScreenTextSteps
    {
        private const BindingFlags All = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;

        /// <summary>
        /// Asserts one of the live messages the game shows now (<c>Messages.liveMessages</c>, the lines at the top of the screen that fade after a few
        /// seconds) contains the text, case ignored. Call it right after the action that causes the message. The failure lists the live messages.
        /// </summary>
        [Then("Nelim's Pickle Tools: the last message shown contains {string}")]
        public void LastMessageContains(PickleContext ctx, string text)
        {
            List<string> live = LiveMessages(ctx);
            ctx.Assert(live.Any(m => m.IndexOf(text, StringComparison.OrdinalIgnoreCase) >= 0),
                $"no live message contains '{text}'; the live messages are " + (live.Count == 0 ? "none" : string.Join(" | ", live)));
        }

        /// <summary>Asserts a window is open: a window whose class name (the short or the full name, case ignored) is the text.</summary>
        [Then("Nelim's Pickle Tools: the window {string} is open")]
        public void WindowIsOpen(PickleContext ctx, string className)
        {
            ctx.Assert(FindWindow(className) != null, $"no window '{className}' is open; the open windows are " + OpenWindowNames());
        }

        /// <summary>
        /// Asserts an open window (by class name) holds a text, case ignored. The text of a window is every string its fields and its properties hold,
        /// one level deep, and the text of the node of a dialog tree: it is what the window was built from, not a read of the pixels.
        /// </summary>
        [Then("Nelim's Pickle Tools: the window {string} contains {string}")]
        public void WindowContains(PickleContext ctx, string className, string text)
        {
            Window w = FindWindow(className);
            ctx.Require(w != null, $"no window '{className}' is open; the open windows are " + OpenWindowNames());
            List<string> strings = WindowStrings(w);
            ctx.Assert(strings.Any(s => s.IndexOf(text, StringComparison.OrdinalIgnoreCase) >= 0),
                $"the window '{className}' does not contain '{text}'; it holds " + string.Join(" | ", strings.Take(30)));
        }

        /// <summary>Closes the open window of that class name (the game's own Close, as its close button does). Fails when none is open.</summary>
        [When("Nelim's Pickle Tools: I close the window {string}")]
        public void CloseWindow(PickleContext ctx, string className)
        {
            Window w = FindWindow(className);
            ctx.Require(w != null, $"no window '{className}' is open; the open windows are " + OpenWindowNames());
            w.Close(false);
            ctx.Assert(!Find.WindowStack.Windows.Contains(w), $"the window '{className}' is still open after Close");
        }

        /// <summary>
        /// Asserts no line of the game log (<c>Log.Messages</c>, errors and warnings included) matches the regular expression (case ignored): for
        /// <c>BS_[A-Za-z0-9_]+</c> it proves no raw translation key was logged. The failure shows the first three matches.
        /// </summary>
        [Then("Nelim's Pickle Tools: no text matching {string} is in the game log")]
        public void NoLogText(PickleContext ctx, string pattern)
        {
            Regex re = new Regex(pattern, RegexOptions.IgnoreCase);
            var hits = new List<string>();
            foreach (object o in Log.Messages)
            {
                string t = o.GetType().GetField("text", All)?.GetValue(o) as string ?? o.ToString();
                Match m = re.Match(t ?? "");
                if (m.Success) hits.Add(m.Value + " in: " + Trim(t));
            }
            ctx.Assert(hits.Count == 0, $"{hits.Count} log line(s) match '{pattern}': " + string.Join(" || ", hits.Take(3)));
        }

        /// <summary>
        /// Asserts no text held by an open window matches the regular expression (case ignored) and no live message does: the "no raw key on screen"
        /// check. Open the windows first (the architect tab, a console, the colonist's bio); only what is open now is read.
        /// </summary>
        [Then("Nelim's Pickle Tools: no label on screen matches {string}")]
        public void NoScreenLabel(PickleContext ctx, string pattern)
        {
            Regex re = new Regex(pattern, RegexOptions.IgnoreCase);
            var hits = new List<string>();
            foreach (string m in LiveMessages(ctx)) if (re.IsMatch(m)) hits.Add("live message: " + Trim(m));
            foreach (Window w in Find.WindowStack.Windows)
                foreach (string s in WindowStrings(w))
                    if (re.IsMatch(s)) hits.Add(w.GetType().Name + ": " + Trim(s));
            ctx.Assert(hits.Count == 0, $"{hits.Count} text(s) on screen match '{pattern}': " + string.Join(" || ", hits.Take(3)));
        }

        /// <summary>
        /// Picks the option of the float menu that is open now (the top FloatMenu of the window stack, a gizmo's menu or a right click) whose label
        /// contains the text, case ignored: it runs the option as a click does, then closes the menu, so the step works again after the next gizmo
        /// click. Fails when no float menu is open, when no option matches (listing the labels) or when the option is greyed out (a disabled option
        /// runs nothing). Read the message the option shows with <c>the last message shown contains</c>. Compiled, NOT PLAYED.
        /// </summary>
        [When("Nelim's Pickle Tools: I pick the option {string} of the open float menu")]
        public void PickFloatMenuOption(PickleContext ctx, string label)
        {
            FloatMenu menu = Find.WindowStack.Windows.OfType<FloatMenu>().LastOrDefault();
            ctx.Require(menu != null, "no float menu is open; the open windows are " + OpenWindowNames());
            FieldInfo f = typeof(FloatMenu).GetField("options", All);
            ctx.Require(f != null, "FloatMenu.options does not exist any more (the game changed): update this step");
            var options = ((IEnumerable)f.GetValue(menu)).Cast<FloatMenuOption>().ToList();
            FloatMenuOption opt = options.FirstOrDefault(o => o.Label != null && o.Label.IndexOf(label, StringComparison.OrdinalIgnoreCase) >= 0);
            ctx.Require(opt != null, $"no option of the open float menu contains '{label}'; the options are " + string.Join(" | ", options.Select(o => o.Label)));
            ctx.Require(!opt.Disabled, $"the option '{opt.Label}' is greyed out: it runs nothing");
            opt.Chosen(true, menu);
            menu.Close(false);
        }

        private static List<string> LiveMessages(PickleContext ctx)
        {
            FieldInfo f = typeof(Messages).GetField("liveMessages", All);
            ctx.Require(f != null, "Messages.liveMessages does not exist any more (the game changed): update this step");
            var list = new List<string>();
            foreach (object o in (IEnumerable)f.GetValue(null))
            {
                string t = o.GetType().GetField("text", All)?.GetValue(o)?.ToString() ?? o.GetType().GetProperty("text", All)?.GetValue(o, null)?.ToString();
                if (t != null) list.Add(t);
            }
            return list;
        }

        private static Window FindWindow(string className)
        {
            return Find.WindowStack.Windows.FirstOrDefault(w =>
                string.Equals(w.GetType().Name, className, StringComparison.OrdinalIgnoreCase)
                || string.Equals(w.GetType().FullName, className, StringComparison.OrdinalIgnoreCase));
        }

        private static string OpenWindowNames()
        {
            var names = Find.WindowStack.Windows.Select(w => w.GetType().Name).ToList();
            return names.Count == 0 ? "none" : string.Join(", ", names);
        }

        // Every string a window holds, one level deep: fields and properties of the window, plus the text of a dialog tree node and of its options.
        private static List<string> WindowStrings(Window w)
        {
            var strings = new List<string>();
            Collect(w, strings, 1);
            return strings.Where(s => !string.IsNullOrWhiteSpace(s)).Distinct().ToList();
        }

        private static void Collect(object o, List<string> strings, int depth)
        {
            if (o == null) return;
            Type t = o.GetType();
            foreach (FieldInfo f in t.GetFields(All).Where(x => !x.IsStatic))
            {
                object v;
                try { v = f.GetValue(o); } catch { continue; }
                Add(v, strings, depth);
            }
            foreach (PropertyInfo p in t.GetProperties(All).Where(x => x.GetIndexParameters().Length == 0 && x.CanRead && x.GetMethod != null && !x.GetMethod.IsStatic))
            {
                if (p.PropertyType != typeof(string) && p.PropertyType.Name != "TaggedString") continue;
                object v;
                try { v = p.GetValue(o, null); } catch { continue; }
                Add(v, strings, 0);
            }
        }

        private static void Add(object v, List<string> strings, int depth)
        {
            if (v == null) return;
            if (v is string s) { strings.Add(s); return; }
            if (v.GetType().Name == "TaggedString") { strings.Add(v.ToString()); return; }
            if (depth <= 0) return;
            string n = v.GetType().Name;
            // The node of a dialog tree and its options hold the text the player reads.
            if (n == "DiaNode" || n == "DiaOption" || n.StartsWith("Dia")) Collect(v, strings, 0);
            else if (v is IEnumerable e && !(v is IDictionary))
                foreach (object item in e.Cast<object>().Take(60))
                {
                    if (item is string si) strings.Add(si);
                    else if (item != null && item.GetType().Name.StartsWith("Dia")) Collect(item, strings, 0);
                }
        }

        private static string Trim(string t)
        {
            t = (t ?? "").Replace("\n", " ");
            return t.Length > 160 ? t.Substring(0, 160) + "..." : t;
        }
    }
}
