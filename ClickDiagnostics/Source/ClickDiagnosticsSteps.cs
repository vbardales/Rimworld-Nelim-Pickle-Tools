using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ClickDiagnostics
{
    /// <summary>
    /// Three steps for a click that must land, and a report that says why when it did not.
    /// <para>
    /// Pickle resolves a button's tag, moves the pointer to its centre and presses. Two things it cannot
    /// see make that fail with a message that names nothing: the button was still MOVING (IMGUI counts a
    /// click only when press and release land on the same control), or something sat on top of it, or the
    /// window holding it was not receiving input. The steps below wait, check, and on a lost click print
    /// the pointer, every button drawn under it, and the window stack.
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
        // A dozen frames is a fifth of a second at 60 fps: longer than any layout settling measured, and
        // shorter than a player's reaction.
        private const int FramesToStandStill = 12;
        private const int FramesToGiveUp = 300;

        // Pickle kills a step at its declared timeout with a bare message. Under a software renderer the
        // game may run at a few frames a second, so 300 frames can outlast that: give up on the clock too.
        private const int SecondsToGiveUp = 25;
        private const int FramesToOpen = 60;

        // What Pickle's tag store held right after the hover step, kept for the failure message of the click.
        private static string storeAfterHover = "(no hover step ran before the click)";

        /// <summary>
        /// Waits until the button has been drawn at the same place for a dozen frames in a row.
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
            var frame = 0;
            for (; frame < FramesToGiveUp && stable < FramesToStandStill
                   && clock.Elapsed.TotalSeconds < SecondsToGiveUp; frame++)
            {
                await ctx.WaitFrames(1);
                var now = ButtonProbe.LatestRect(label);
                stable = now.HasValue && last.HasValue && now.Value == last.Value ? stable + 1 : 0;
                last = now;
            }

            var waited = $"{frame} frames in {clock.Elapsed.TotalSeconds:0.#} s" +
                (frame < FramesToGiveUp && stable < FramesToStandStill
                    ? $" (the {SecondsToGiveUp} s clock ended the wait before the {FramesToGiveUp}-frame limit)" : "");
            ctx.Assert(last.HasValue,
                $"no button labelled '{label}' (key '{key}') was drawn in {waited}, so there is nothing to wait for");
            ctx.Assert(stable >= FramesToStandStill,
                $"the button '{label}' never stood still for {FramesToStandStill} frames in a row in {waited}; last seen at {last}. " +
                "Clicking a control that is still moving loses the click between press and release.");
        }

        /// <summary>
        /// Hovers the button and asserts the window under the pointer is the named one, and that it receives
        /// input.
        /// </summary>
        // Pickle's failure for a covered button is "tag not found", which reads like the button is missing
        // when something is sitting on it. Hovering first is not politeness: Input.mousePosition is sampled
        // once per frame, so the pointer has to be where the click will land a frame earlier for the
        // question to mean anything. GetWindowAt only asks which rectangle holds the point; it cannot see a
        // window that does not hold it but absorbs input around itself, which is why GetsInput is asked too.
        [Then("Nelim's Pickle Tools: the button keyed {string} is reachable in {string}", TimeoutSeconds = 30)]
        public async Task ButtonIsReachable(PickleContext ctx, string key, string windowName)
        {
            var label = Label(ctx, key);
            await ctx.Hover($"btn:{label}");
            await ctx.WaitFrames(2);

            var pointer = UI.MousePositionOnUIInverted;
            storeAfterHover = $"  pointer {pointer}\n{ButtonProbe.DescribeTagStore(label)}";
            var under = Find.WindowStack.GetWindowAt(pointer);
            ctx.Assert(under != null,
                $"'{label}' is under no window at all; the pointer is at {pointer}\nWindow stack, top first:\n{DescribeStack(pointer)}");

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
        // names that identify nothing. The pointer is read on both sides of the click: Pickle moves it to the
        // centre of the rectangle it stored, so the two readings should agree and sit on the drawn button; a
        // disagreement says something moved it, and a shared wrong place says the stored rectangle is not
        // where the button is drawn. The stack is read while it is still as the click left it.
        [When("Nelim's Pickle Tools: I click the button keyed {string} and the window {string} opens", TimeoutSeconds = 30)]
        public async Task ClickAndExpectWindow(PickleContext ctx, string key, string windowName)
        {
            var label = Label(ctx, key);
            ButtonProbe.EnsureInstalled();

            // Windows of that name already open: a click that opened nothing must not pass because one
            // was sitting on the stack from an earlier step.
            var alreadyOpen = new HashSet<Window>(
                Find.WindowStack.Windows.Where(window => IsNamed(window.GetType(), windowName)));

            var beforeClick = UI.MousePositionOnUIInverted;
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

            var pointer = UI.MousePositionOnUIInverted;
            var absorber = Find.WindowStack.Windows.Any(window => window.absorbInputAroundWindow);

            ctx.Assert(false,
                $"the click on '{label}' (key '{key}') reached no window named {windowName} in {FramesToOpen} frames. " +
                (absorber
                    ? "A window on the stack absorbs input around itself - see below."
                    : "No window on the stack absorbs input, so nothing sits above the button; this message does not say " +
                      "which cause it was: compare where the button was drawn with where the pointer was, both printed below.") +
                $"\nPointer before the click {beforeClick}, after it {pointer}." +
                "\nWhere the button was drawn, as Pickle records it (the click goes to the centre):\n" +
                ButtonProbe.DescribeText(label) +
                "\nButtons on the pointer, in draw order (Pickle does not tag image buttons):\n" +
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
                    $"getsInput={stack.GetsInput(window)}  holdsPointer={window.windowRect.Contains(pointer)}" +
                    drawnBy);
            }

            return lines.Count == 0 ? "  (no window at all)" : string.Join("\n", lines);
        }
    }
}
