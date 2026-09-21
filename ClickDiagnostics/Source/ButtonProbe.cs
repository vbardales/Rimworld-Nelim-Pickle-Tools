using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using HarmonyLib;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ClickDiagnostics
{
    /// <summary>
    /// Remembers the rectangles of the buttons drawn during the last two frames, so a click that reached a
    /// button and opened nothing can say which control sat on the point, and so a step can tell that a
    /// button has stopped moving.
    /// <para>
    /// Pickle records only <c>Widgets.ButtonText</c>, under a <c>btn:</c> tag, and does not say where it
    /// recorded it. A button with no label - <c>Widgets.ButtonImage</c> - is invisible to it, so a click that
    /// reached one gave a report with no reason in it. This changes nothing in Pickle: it is a Harmony
    /// postfix, installed by the first step that needs it, and it exists only while the tests run.
    /// </para>
    /// <para>
    /// Rectangles are converted the way Pickle converts its own (<c>GUIUtility.GUIToScreenRect</c>, during
    /// <c>Repaint</c> only), so a point taken from a tag and a rectangle taken from here are in the same
    /// space.
    /// </para>
    /// </summary>
    internal static class ButtonProbe
    {
        internal struct Seen
        {
            public Rect Screen;
            public string Widget;
            public string Label;
            public int Order;
        }

        private static readonly string[] ImageWidgets = { "ButtonImage", "ButtonImageFitted", "ButtonImageWithBG", "ButtonImageDraggable" };

        private static bool installed;
        private static int frame = -1;
        private static int order;
        private static List<Seen> current = new List<Seen>();
        private static List<Seen> previous = new List<Seen>();

        /// <summary>Idempotent: the patch goes on once per game, however many scenarios ask.</summary>
        internal static void EnsureInstalled()
        {
            if (installed)
            {
                return;
            }

            installed = true;
            var harmony = new Harmony("nelim.pickletools.clickdiagnostics");

            // Every overload: they are separate methods and a control may call any of them. All of them
            // take the rectangle first, which is what the postfix reads by position.
            var imagePostfix = new HarmonyMethod(typeof(ButtonProbe), nameof(ImagePostfix));
            foreach (var method in typeof(Widgets)
                         .GetMethods(BindingFlags.Public | BindingFlags.Static)
                         .Where(m => ImageWidgets.Contains(m.Name)))
            {
                harmony.Patch(method, postfix: imagePostfix);
            }

            // ButtonText too, with its label: Pickle tags these but does not say WHERE it recorded them,
            // and a click that lands somewhere other than the drawn button needs that number. Arguments are
            // read as an array because the overloads do not agree on the label's type.
            var textPostfix = new HarmonyMethod(typeof(ButtonProbe), nameof(TextPostfix));
            foreach (var method in typeof(Widgets)
                         .GetMethods(BindingFlags.Public | BindingFlags.Static)
                         .Where(m => m.Name == "ButtonText"))
            {
                harmony.Patch(method, postfix: textPostfix);
            }
        }

        public static void TextPostfix(Rect __0, object[] __args)
        {
            if (__args == null || __args.Length < 2)
            {
                return;
            }

            Record(__0, "ButtonText", __args[1]?.ToString());
        }

        public static void ImagePostfix(Rect __0, MethodBase __originalMethod)
        {
            Record(__0, __originalMethod.Name, null);
        }

        private static void Record(Rect rect, string widget, string label)
        {
            if (Event.current == null || Event.current.type != EventType.Repaint)
            {
                return;
            }

            if (Time.frameCount != frame)
            {
                previous = current;
                current = new List<Seen>();
                frame = Time.frameCount;
                order = 0;
            }

            current.Add(new Seen
            {
                Screen = GUIUtility.GUIToScreenRect(rect),
                Widget = widget,
                Label = label,
                Order = order++,
            });
        }

        /// <summary>The last rectangle a text button with this label was drawn at, or null if none was seen.</summary>
        internal static Rect? LatestRect(string label)
        {
            foreach (var frameSeen in new[] { current, previous })
            {
                for (var i = frameSeen.Count - 1; i >= 0; i--)
                {
                    if (frameSeen[i].Widget == "ButtonText" && frameSeen[i].Label == label)
                    {
                        return frameSeen[i].Screen;
                    }
                }
            }

            return null;
        }

        /// <summary>
        /// Where a text button with this label was drawn, in the space Pickle records its tags in. The click
        /// lands at the centre of the rectangle Pickle stored, so when the pointer is nowhere near the button
        /// on the screenshot, this is the number that says whether the rectangle or the pointer is wrong.
        /// </summary>
        internal static string DescribeText(string label)
        {
            var matches = previous.Concat(current)
                .Where(seen => seen.Widget == "ButtonText" && seen.Label == label)
                .GroupBy(seen => seen.Screen)
                .Select(group => group.First())
                .ToList();

            if (matches.Count == 0)
            {
                return $"  no Widgets.ButtonText labelled '{label}' was seen in the last two frames";
            }

            return string.Join("\n", matches.Select(s =>
                $"  Widgets.ButtonText '{label}' drawn at {s.Screen}, centre {s.Screen.center}"));
        }

        /// <summary>
        /// The buttons, of either kind, whose rectangle contains a UI-space point, in the order they were
        /// drawn. Two frames are looked at because a step reads a frame or two after the button was drawn,
        /// and a rectangle drawn on both is reported once.
        /// </summary>
        internal static List<Seen> At(Vector2 uiPoint)
        {
            var screen = uiPoint * Prefs.UIScale;

            return previous.Concat(current)
                .Where(seen => seen.Screen.Contains(screen))
                .GroupBy(seen => seen.Screen)
                .Select(group => group.First())
                .OrderBy(seen => seen.Order)
                .ToList();
        }

        /// <summary>The lines a failure message shows for them, or a sentence saying there were none.</summary>
        internal static string Describe(Vector2 uiPoint)
        {
            var seen = At(uiPoint);
            if (seen.Count == 0)
            {
                return "  no drawn button contains the pointer";
            }

            return string.Join("\n", seen.Select(s =>
                $"  Widgets.{s.Widget}{(s.Label == null ? string.Empty : " '" + s.Label + "'")} at {s.Screen}, drawn #{s.Order} this frame"));
        }
    }
}
