using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.LostClickProbe
{
    /// <summary>
    /// Two windows that make a click on a main menu button open nothing, and both draw an ImmediateWindow,
    /// so the report has something to name. Not a fix and not a test of anything: it only makes the failure
    /// happen so the message can be read.
    /// </summary>
    [PickleSteps]
    public class LostClickProbeSteps
    {
        [Given("Nelim's Pickle Tools probe: a window covers the left of the screen and an image button in it takes every click")]
        public void CoveringWindow(PickleContext ctx)
        {
            Find.WindowStack.Add(new ProbeWindow(new Rect(0f, UI.screenHeight * 0.15f, UI.screenWidth * 0.5f, UI.screenHeight * 0.7f), true));
        }

        [Given("Nelim's Pickle Tools probe: a window that absorbs input sits in the top right corner")]
        public void AbsorbingWindow(PickleContext ctx)
        {
            Find.WindowStack.Add(new ProbeWindow(new Rect(UI.screenWidth - 320f, 20f, 300f, 160f), false));
        }
    }

    internal class ProbeWindow : Window
    {
        private readonly Rect place;
        private readonly bool imageTakesClicks;

        public ProbeWindow(Rect place, bool imageTakesClicks)
        {
            this.place = place;
            this.imageTakesClicks = imageTakesClicks;
            layer = WindowLayer.Dialog;
            absorbInputAroundWindow = true;
            closeOnClickedOutside = false;
            doCloseX = false;
            doCloseButton = false;
            preventCameraMotion = false;
        }

        public override Vector2 InitialSize => new Vector2(place.width, place.height);

        protected override void SetInitialSizeAndPosition()
        {
            windowRect = place;
        }

        public override void DoWindowContents(Rect inRect)
        {
            if (imageTakesClicks)
            {
                Widgets.ButtonImage(inRect, BaseContent.WhiteTex);
            }

            Find.WindowStack.ImmediateWindow(6091101, new Rect(place.x + 8f, place.y + 8f, 120f, 30f), WindowLayer.Super, DrawLabel);
        }

        private static void DrawLabel()
        {
            Widgets.Label(new Rect(0f, 0f, 120f, 30f), "probe");
        }
    }
}
