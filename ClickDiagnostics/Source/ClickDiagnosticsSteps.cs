using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorks.Pickle.Input;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ClickDiagnostics
{
    /// <summary>
    /// Three steps for a click that must land, and a report that says why when it did not.
    /// <para>
    /// Pickle resolves a button's tag and takes the click at the widget: since Pickle 6.0.0 nothing moves a real
    /// pointer, and a click lands when the armed rectangle matches the one the button is drawn at. Two things it
    /// cannot see make that fail with a message that names nothing: the button was still MOVING (the armed
    /// rectangle is never matched), or something sat on top of it, or the window holding it was not receiving
    /// input. The steps below wait, check, and on a lost click print the point at the button's centre, every
    /// button drawn there, and the window stack.
    /// </para>
    /// <para>
    /// Buttons are named by the translation key their label comes from, so a scenario keeps working in any
    /// language, as <c>I click button keyed</c> does.
    /// </para>
    /// The patterns start with "Nelim's Pickle Tools:" so they can never be ambiguous with a step Pickle
    /// ships later under its own words.
    /// </summary>
    [PickleSteps]
    public class ClickDiagnosticsSteps
    {
        // Twelve frames were enough on 2026-09-21, when the layout settled after about ten; on 2026-09-25 the
        // same window (Work Tab) stayed narrow past twelve frames and widened after the wait had passed, so the
        // click landed on the button at its narrow position and the layout moved before the release. A count of
        // frames says little on a software renderer, so the button has to stand still for a duration too.
        private const int FramesToStandStill = 60;
        private const double SecondsToStandStill = 2.0;
        private const int FramesToGiveUp = 300;

        // Pickle kills a step at its declared timeout with a bare message. Under a software renderer the
        // game may run at a few frames a second, so 300 frames can outlast that: give up on the clock too.
        private const int SecondsToGiveUp = 25;
        private const int FramesToOpen = 60;

        // What Pickle's tag store held right after the hover step, kept for the failure message of the click.
        private static string storeAfterHover = "(no hover step ran before the click)";

        /// <summary>
        /// Parks the pointer: drops whatever hover Pickle had armed, so no control is drawn as hovered and no tooltip or
        /// selection bracket draws over the subject of a capture. Since Pickle 6.0.0 nothing moves a real pointer, so the
        /// coordinates are only checked to be on the screen (GUI space, top-left origin) and the real pointer stays where the
        /// display put it; a headless run never moves it.
        /// </summary>
        [When("Nelim's Pickle Tools: I move the mouse to \\({int}, {int}\\)")]
        public async Task MoveMouseTo(PickleContext ctx, int x, int y)
        {
            ctx.Require(
                x >= 0 && y >= 0 && x <= UI.screenWidth && y <= UI.screenHeight,
                $"the point ({x}, {y}) is outside the screen, which is {UI.screenWidth} by {UI.screenHeight} in GUI space");
            var request = HarmonyLib.AccessTools.TypeByName("RimWorks.Pickle.Input.InteractionRequest");
            var clear = request == null ? null : HarmonyLib.AccessTools.Method(request, "Clear", Type.EmptyTypes);
            ctx.Require(clear != null, "RimWorks.Pickle.Input.InteractionRequest.Clear() is not there in this Pickle build: it moved, this step has to follow");
            clear.Invoke(null, null);
            await ctx.WaitFrames(2);
        }

        /// <summary>
        /// Waits until the button has been drawn at the same place for sixty frames in a row and two seconds.
        /// </summary>
        // Measured on Work Studio's button under Work Tab: the tab window is drawn narrow for about ten
        // frames after it opens and then widens to the full screen, and the button is anchored to its right
        // edge, so it MOVES (raw x 975 for frames 216-225, 1748 from frame 226). Pickle's rectangle was
        // right at every instant; the click was pressed at 975, the layout moved before the release, and
        // nothing opened. A player does not click within a fifth of a second of opening a tab, and a test
        // has to wait as long as she would.
        [When("Nelim's Pickle Tools: the button keyed {string} has stood still", TimeoutSeconds = 30)]
        public async Task ButtonHasStoodStill(PickleContext ctx, string key)
        {
            var label = Label(ctx, key);
            ButtonProbe.EnsureInstalled();

            Rect? last = null;
            var stable = 0;
            var clock = Stopwatch.StartNew();
            var still = Stopwatch.StartNew();
            var frame = 0;
            for (; frame < FramesToGiveUp && (stable < FramesToStandStill || still.Elapsed.TotalSeconds < SecondsToStandStill)
                   && clock.Elapsed.TotalSeconds < SecondsToGiveUp; frame++)
            {
                await ctx.WaitFrames(1);
                var now = ButtonProbe.LatestRect(label);
                var unchanged = now.HasValue && last.HasValue && now.Value == last.Value;
                stable = unchanged ? stable + 1 : 0;
                if (!unchanged)
                {
                    still.Restart();
                }

                last = now;
            }

            var settled = stable >= FramesToStandStill && still.Elapsed.TotalSeconds >= SecondsToStandStill;

            var waited = $"{frame} frames in {clock.Elapsed.TotalSeconds:0.#} s" +
                (frame < FramesToGiveUp && !settled
                    ? $" (the {SecondsToGiveUp} s clock ended the wait before the {FramesToGiveUp}-frame limit)" : "");
            ctx.Assert(last.HasValue,
                $"no button labelled '{label}' (key '{key}') was drawn in {waited}, so there is nothing to wait for");
            ctx.Assert(settled,
                $"the button '{label}' never stood still for {FramesToStandStill} frames and {SecondsToStandStill} s in a row in {waited}; last seen at {last}. " +
                "Clicking a control that is still moving loses the click between press and release.");
        }

        /// <summary>
        /// Hovers the button and asserts the window under the pointer is the named one, and that it receives
        /// input.
        /// </summary>
        // Pickle's failure for a covered button is "tag not found", which reads like the button is missing
        // when something is sitting on it. The hover makes the button draw, so its rectangle is known; the point asked
        // about is its centre. GetWindowAt only asks which rectangle holds the point; it cannot see a window that does
        // not hold it but absorbs input around itself, which is why GetsInput is asked too.
        [Then("Nelim's Pickle Tools: the button keyed {string} is reachable in {string}", TimeoutSeconds = 30)]
        public async Task ButtonIsReachable(PickleContext ctx, string key, string windowName)
        {
            var label = Label(ctx, key);
            ButtonProbe.EnsureInstalled();
            await ctx.Hover($"btn:{label}");
            await ctx.WaitFrames(2);

            var pointer = CentreOf(ctx, label);
            storeAfterHover = $"  centre of the button {pointer}\n{ButtonProbe.DescribeTagStore(label)}";
            AssertReachable(ctx, label, pointer, windowName);
        }

        private const int FramesToFindNth = 120;

        // Pickle's tag store drops a tag two buttons claim, so the nth button is found from the probe's own record of
        // what was drawn (ButtonText overloads, in draw order) and handed to Pickle's interaction request, which matches a
        // widget by its rectangle. Both are internal to Pickle: reflected, and a missing member says so by name.
        private static async Task<Rect> NthRect(PickleContext ctx, string label, string key, int number)
        {
            ctx.Require(number >= 1, $"button numbers start at 1, got {number}");
            ButtonProbe.EnsureInstalled();
            List<Rect> rects = null;
            for (var frame = 0; frame < FramesToFindNth; frame++)
            {
                rects = ButtonProbe.AllRects(label);
                if (rects.Count >= number)
                {
                    return rects[number - 1];
                }

                await ctx.WaitFrames(1);
            }

            ctx.Assert(false,
                $"button number {number} labelled '{label}' (key '{key}') was not drawn within {FramesToFindNth} frames: " +
                $"{rects?.Count ?? 0} such button(s) seen, at {(rects == null ? "(none)" : string.Join(", ", rects))}");
            return default;
        }

        private static MethodInfo RequestMethod(PickleContext ctx, string name)
        {
            var type = HarmonyLib.AccessTools.TypeByName("RimWorks.Pickle.Input.InteractionRequest");
            var method = type == null ? null : HarmonyLib.AccessTools.Method(type, name);
            ctx.Require(method != null, $"RimWorks.Pickle.Input.InteractionRequest.{name} is not there in this Pickle build: it moved, this step has to follow");
            return method;
        }

        /// <summary>
        /// Same check as <c>the button keyed ... is reachable in</c>, for the nth button (1 = first drawn) when several
        /// buttons share a label, which Pickle's own lookup refuses.
        /// </summary>
        [Then("Nelim's Pickle Tools: the button keyed {string} number {int} is reachable in {string}", TimeoutSeconds = 30)]
        public async Task NthButtonIsReachable(PickleContext ctx, string key, int number, string windowName)
        {
            var label = Label(ctx, key);
            var rect = await NthRect(ctx, label, key, number);
            RequestMethod(ctx, "SetHover").Invoke(null, new object[] { rect });
            await ctx.WaitFrames(2);
            AssertReachable(ctx, label, rect.center / Prefs.UIScale, windowName);
        }

        /// <summary>Waits until the nth button of that label has been drawn at the same place for sixty frames and two seconds.</summary>
        [When("Nelim's Pickle Tools: the button keyed {string} number {int} has stood still", TimeoutSeconds = 30)]
        public async Task NthButtonHasStoodStill(PickleContext ctx, string key, int number)
        {
            var label = Label(ctx, key);
            ButtonProbe.EnsureInstalled();
            Rect? last = null;
            var stable = 0;
            var clock = Stopwatch.StartNew();
            var still = Stopwatch.StartNew();
            var frame = 0;
            for (; frame < FramesToGiveUp && (stable < FramesToStandStill || still.Elapsed.TotalSeconds < SecondsToStandStill)
                   && clock.Elapsed.TotalSeconds < SecondsToGiveUp; frame++)
            {
                await ctx.WaitFrames(1);
                var all = ButtonProbe.AllRects(label);
                Rect? now = all.Count >= number ? all[number - 1] : (Rect?)null;
                var unchanged = now.HasValue && last.HasValue && now.Value == last.Value;
                stable = unchanged ? stable + 1 : 0;
                if (!unchanged)
                {
                    still.Restart();
                }

                last = now;
            }

            var waited = $"{frame} frames in {clock.Elapsed.TotalSeconds:0.#} s";
            ctx.Assert(last.HasValue, $"button number {number} labelled '{label}' (key '{key}') was not drawn in {waited}");
            ctx.Assert(stable >= FramesToStandStill && still.Elapsed.TotalSeconds >= SecondsToStandStill,
                $"button number {number} '{label}' never stood still for {FramesToStandStill} frames and {SecondsToStandStill} s in {waited}; last seen at {last}");
        }

        /// <summary>
        /// Clicks the nth button (1 = first drawn) of a label several buttons share, by arming Pickle's click on that
        /// button's rectangle: the widget that draws at it takes the click, as for a tagged button.
        /// </summary>
        [When("Nelim's Pickle Tools: I click the button keyed {string} number {int}", TimeoutSeconds = 30)]
        public async Task ClickNthButton(PickleContext ctx, string key, int number)
        {
            var label = Label(ctx, key);
            var rect = await NthRect(ctx, label, key, number);
            RequestMethod(ctx, "ArmClick").Invoke(null, new object[] { rect });
            var fired = HarmonyLib.AccessTools.Property(
                HarmonyLib.AccessTools.TypeByName("RimWorks.Pickle.Input.InteractionRequest"), "ClickFired");
            ctx.Require(fired != null, "RimWorks.Pickle.Input.InteractionRequest.ClickFired is not there in this Pickle build");
            var clock = Stopwatch.StartNew();
            while (!(bool)fired.GetValue(null) && clock.Elapsed.TotalSeconds < 2)
            {
                await ctx.WaitFrames(1);
            }

            if (!(bool)fired.GetValue(null))
            {
                RequestMethod(ctx, "Clear").Invoke(null, null);
                ctx.Assert(false,
                    $"button number {number} '{label}' (key '{key}') at {rect} took no click in 2 s: no Widgets.ButtonText there fired it " +
                    $"(covered, or drawn without a click check).\nWindow stack, top first:\n{DescribeStack(rect.center / Prefs.UIScale)}");
            }

            await ctx.WaitFrames(2);
        }

        // The pointer is the centre of the button in GUI space; the window under it must be the named one and receive input.
        private static void AssertReachable(PickleContext ctx, string label, Vector2 pointer, string windowName)
        {
            var under = Find.WindowStack.GetWindowAt(pointer);
            ctx.Assert(under != null,
                $"'{label}' is under no window at all; the centre of the button is at {pointer}\nWindow stack, top first:\n{DescribeStack(pointer)}");

            ctx.Assert(Find.WindowStack.GetsInput(under),
                $"'{label}' is drawn in {under.GetType().Name}, but that window is not receiving input: a window above it " +
                $"absorbs everything around itself, so a click would be swallowed.\nWindow stack, top first:\n{DescribeStack(pointer)}");

            ctx.Assert(IsNamed(under.GetType(), windowName),
                $"'{label}' is under another window: {under.GetType().FullName} [{under.GetType().Assembly.GetName().Name}], " +
                $"where {windowName} was expected. The click would go to that window, and Pickle would report the tag as missing." +
                $"\nWindow stack, top first:\n{DescribeStack(pointer)}");
        }

        /// <summary>
        /// Clicks the button and waits for the named window to open; when it does not, says what the click met.
        /// </summary>
        // The report used to be "window should be open; open windows: ImmediateWindow, ImmediateWindow" - two
        // names that identify nothing. The point asked about is the centre of the rectangle the probe saw the button
        // drawn at; the tag store's own rectangle is printed beside it, so a disagreement between the two says the
        // stored rectangle is not where the button is drawn. The stack is read while it is still as the click left it.
        [When("Nelim's Pickle Tools: I click the button keyed {string} and the window {string} opens", TimeoutSeconds = 30)]
        public async Task ClickAndExpectWindow(PickleContext ctx, string key, string windowName)
        {
            var label = Label(ctx, key);
            ButtonProbe.EnsureInstalled();

            // Windows of that name already open: a click that opened nothing must not pass because one
            // was sitting on the stack from an earlier step.
            var alreadyOpen = new HashSet<Window>(
                Find.WindowStack.Windows.Where(window => IsNamed(window.GetType(), windowName)));

            var storeBeforeClick = ButtonProbe.DescribeTagStore(label);
            await ctx.Click($"btn:{label}");

            for (var frame = 0; frame < FramesToOpen; frame++)
            {
                await ctx.WaitFrames(1);
                if (Find.WindowStack.Windows.Any(window => IsNamed(window.GetType(), windowName) && !alreadyOpen.Contains(window)))
                {
                    return;
                }
            }

            var pointer = ButtonProbe.LatestRect(label).HasValue ? CentreOf(ctx, label) : Vector2.zero;
            var absorber = Find.WindowStack.Windows.Any(window => window.absorbInputAroundWindow);

            ctx.Assert(false,
                $"the click on '{label}' (key '{key}') reached no window named {windowName} in {FramesToOpen} frames. " +
                (absorber
                    ? "A window on the stack absorbs input around itself - see below."
                    : "No window on the stack absorbs input, so nothing sits above the button; this message does not say " +
                      "which cause it was: compare where the button was drawn with the rectangle Pickle stored, both printed below.") +
                $"\nCentre of the button as drawn {pointer}." +
                "\nPickle's tag store right after the hover step:\n" + storeAfterHover +
                "\nPickle's tag store just before the click:\n" + storeBeforeClick +
                "\nWhere the button was drawn, as the probe saw it (the click goes to the centre of the STORED rectangle):\n" +
                ButtonProbe.DescribeText(label) +
                "\nButtons drawn at that point, in draw order (Pickle does not tag image buttons):\n" +
                ButtonProbe.Describe(pointer) +
                "\nWindow stack, top first:\n" + DescribeStack(pointer));
        }

        // A key nothing translates would build the label from the key itself and look for a button that does
        // not exist, so the miss would read as a dead button.
        private static string Label(PickleContext ctx, string key)
        {
            ctx.Require(
                key.CanTranslate(),
                $"no translation is loaded for '{key}', so no label can be built from it. " +
                $"active language: {LanguageDatabase.activeLanguage?.FriendlyNameEnglish ?? "(none)"}");
            return key.Translate().ToString();
        }

        // The type, or any of its bases, by short or full name: a scenario names MainTabWindow and gets the
        // window a tab replacer derived from it.
        private static bool IsNamed(Type type, string name)
        {
            for (var t = type; t != null; t = t.BaseType)
            {
                if (t.Name == name || t.FullName == name)
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>
        /// Every window on the stack, top first, with what decides whether a click reaches it.
        /// <para>
        /// An <see cref="ImmediateWindow"/> carries no identity of its own - its type name is all a report
        /// would say, and two of them look identical. What names it is the method that draws it, so the owner
        /// is read from <c>doWindowFunc</c>: the declaring type and its assembly say which mod put it there.
        /// </para>
        /// </summary>
        // The centre of the button as the probe last saw it drawn, in GUI space. A button never drawn is a broken
        // precondition, not a lost click.
        private static Vector2 CentreOf(PickleContext ctx, string label)
        {
            var screen = ButtonProbe.LatestRect(label);
            ctx.Require(
                screen.HasValue,
                $"no button labelled '{label}' was drawn in the last two frames, so there is no point to ask about");
            return screen.Value.center / Prefs.UIScale;
        }

        internal static string DescribeStack(Vector2 pointer)
        {
            var stack = Find.WindowStack;
            var windows = stack.Windows;
            var lines = new List<string>();

            for (var i = windows.Count - 1; i >= 0; i--)
            {
                var window = windows[i];
                var drawnBy = string.Empty;

                if (window is ImmediateWindow immediate && immediate.doWindowFunc != null)
                {
                    var method = immediate.doWindowFunc.Method;
                    drawnBy = $"  drawn by {method.DeclaringType?.FullName}.{method.Name} " +
                              $"[{method.DeclaringType?.Assembly.GetName().Name}]";
                }

                lines.Add(
                    $"  #{i}{(i == windows.Count - 1 ? " top" : string.Empty)}  {window.GetType().Name} " +
                    $"[{window.GetType().Assembly.GetName().Name}]  layer={window.layer}  " +
                    $"rect={window.windowRect}  absorbsInput={window.absorbInputAroundWindow}  " +
                    $"getsInput={stack.GetsInput(window)}  holdsPoint={window.windowRect.Contains(pointer)}" +
                    drawnBy);
            }

            return lines.Count == 0 ? "  (no window at all)" : string.Join("\n", lines);
        }
    }
}
