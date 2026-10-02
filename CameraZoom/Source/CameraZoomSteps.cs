using System.Linq;
using System;
using System.Threading.Tasks;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.CameraZoom
{
    /// <summary>
    /// Two steps for a capture that needs the camera closer than Pickle's own zoom steps go. Pickle's
    /// <c>I zoom all the way in</c> is clamped to a root size of 12 (<c>CameraSteps.CloseSize</c>, read from its source on
    /// 2026-10-02), and <c>CameraDriver.SetRootSize</c> called directly is not. Whether the game itself bounds the size below
    /// that is not established: the read-back step exists to say what the camera actually reached.
    ///
    /// Ported on 2026-10-02 from AncientBuildingsRenew's provisional steps (its session, at Virginie's request), so the
    /// gallery suites share one copy.
    /// </summary>
    [PickleSteps]
    public class CameraZoomSteps
    {
        private const int FramesToSettle = 90;
        private const float Tolerance = 0.05f;

        /// <summary>
        /// Sets the camera root size directly (smaller is closer: Pickle's closest is 12, the studio presets use 12 to 16) and waits
        /// 90 frames, since the game smooths the zoom over several frames. Does not check the size reached: use the read-back step.
        /// </summary>
        [When("Nelim's Pickle Tools: the camera root size is set to {float}", TimeoutSeconds = 40f)]
        public async Task SetRootSize(PickleContext ctx, float size)
        {
            ctx.Require(Find.CameraDriver != null, "no camera driver is loaded: load a map first");
            ctx.Require(size > 0f, $"a camera root size must be positive, not {size}");
            Find.CameraDriver.SetRootSize(size);
            await ctx.WaitFrames(FramesToSettle);
        }

        /// <summary>
        /// Centres the camera on the middle of a rectangle of cells and sets the zoom so the rectangle fills the given percentage of the
        /// screen: of the height or of the width, whichever the rectangle fills more. The camera shows twice its root size in cells on
        /// the vertical (measured: size 12 gives about 45 px a cell on a 1080 px screen), and the screen's aspect ratio gives the
        /// horizontal. Waits 90 frames, then reads the root size back and fails saying what it found if the game stopped short.
        /// </summary>
        [When("Nelim's Pickle Tools: I frame the cells \\({int}, {int}\\) to \\({int}, {int}\\) filling {int} percent of the screen", TimeoutSeconds = 40f)]
        public async Task FrameCells(PickleContext ctx, int x1, int z1, int x2, int z2, int percent)
        {
            ctx.Require(Find.CameraDriver != null, "no camera driver is loaded: load a map first");
            ctx.Require(percent >= 5 && percent <= 100, $"a rectangle fills 5 to 100 percent of the screen, not {percent}");
            CellRect rect = CellRect.FromLimits(x1, z1, x2, z2);
            float aspect = (float)UI.screenWidth / UI.screenHeight;
            float fill = percent / 100f;
            float size = Math.Max(rect.Height / (2f * fill), rect.Width / (2f * fill * aspect));

            lastFramed = rect;
            Find.CameraDriver.JumpToCurrentMapLoc(rect.CenterCell);
            Find.CameraDriver.SetRootSize(size);
            await ctx.WaitFrames(FramesToSettle);

            float read = Find.CameraDriver.RootSize;
            ctx.Assert(
                Math.Abs(read - size) < Tolerance,
                $"to fill {percent} percent the camera root size should be {size}; it reads {read}: the game bounds the zoom there, or the zoom had not finished");
        }

        /// <summary>Centres the camera on a named pawn (colonist or animal) at a root size and reads it back, as the cell version does.</summary>
        [When("Nelim's Pickle Tools: the camera is centered on {string} at root size {float}", TimeoutSeconds = 40f)]
        public async Task CenterOnPawn(PickleContext ctx, string pawnName, float size)
        {
            ctx.Require(Find.CameraDriver != null, "no camera driver is loaded: load a map first");
            ctx.Require(size > 0f, $"a camera root size must be positive, not {size}");
            Pawn pawn = Find.CurrentMap?.mapPawns.AllPawnsSpawned.FirstOrDefault(p => p.Name != null && string.Equals(p.LabelShort, pawnName, StringComparison.OrdinalIgnoreCase));
            ctx.Require(pawn != null, $"no pawn named '{pawnName}' is on the current map");
            Find.CameraDriver.JumpToCurrentMapLoc(pawn.Position);
            Find.CameraDriver.SetRootSize(size);
            await ctx.WaitFrames(FramesToSettle);
            float read = Find.CameraDriver.RootSize;
            ctx.Assert(
                Math.Abs(read - size) < Tolerance,
                $"the camera root size should be {size}; it reads {read}: the game bounds the zoom there, or the zoom had not finished");
        }

        private static CellRect? lastFramed;

        /// <summary>
        /// After a rectangle was framed, asserts from the camera as it IS now (the root size read back, not the one asked for) that the
        /// rectangle fills at least this percentage of the screen's height or of its width, whichever it fills more. The failure prints both
        /// shares. Fails if no rectangle was framed in this scenario.
        /// </summary>
        [Then("Nelim's Pickle Tools: the framed cells fill at least {int} percent of the screen")]
        public void FramedFills(PickleContext ctx, int percent)
        {
            ctx.Require(lastFramed.HasValue, "no rectangle was framed: use 'I frame the cells (x1, z1) to (x2, z2) filling N percent of the screen' first");
            ctx.Require(Find.CameraDriver != null, "no camera driver is loaded");
            CellRect rect = lastFramed.Value;
            float size = Find.CameraDriver.RootSize;
            float aspect = (float)UI.screenWidth / UI.screenHeight;
            float ofHeight = 100f * rect.Height / (2f * size);
            float ofWidth = 100f * rect.Width / (2f * size * aspect);
            ctx.Assert(
                Math.Max(ofHeight, ofWidth) >= percent - 0.5f,
                $"the framed cells fill {ofHeight:0.#} percent of the height and {ofWidth:0.#} of the width at root size {size}, less than {percent}");
        }

        /// <summary>
        /// Centres the camera on one cell at the given root size (smaller is closer), then reads it back like the step that sets the size.
        /// </summary>
        [When("Nelim's Pickle Tools: I frame the cell \\({int}, {int}\\) at zoom {float}", TimeoutSeconds = 40f)]
        public async Task FrameCell(PickleContext ctx, int x, int z, float size)
        {
            ctx.Require(Find.CameraDriver != null, "no camera driver is loaded: load a map first");
            ctx.Require(size > 0f, $"a camera root size must be positive, not {size}");
            Find.CameraDriver.JumpToCurrentMapLoc(new IntVec3(x, 0, z));
            Find.CameraDriver.SetRootSize(size);
            await ctx.WaitFrames(FramesToSettle);
            float read = Find.CameraDriver.RootSize;
            ctx.Assert(
                Math.Abs(read - size) < Tolerance,
                $"the camera root size should be {size}; it reads {read}: the game bounds the zoom there, or the zoom had not finished");
        }

        /// <summary>
        /// Asserts that the camera root size reads the value asked for, to 0.05. The failure prints the value read, which tells
        /// whether the game bounds the zoom (the size stops short and stays there) or the zoom had not finished.
        /// </summary>
        [Then("Nelim's Pickle Tools: the camera root size is {float}")]
        public void RootSizeIs(PickleContext ctx, float size)
        {
            ctx.Require(Find.CameraDriver != null, "no camera driver is loaded: load a map first");
            float read = Find.CameraDriver.RootSize;
            ctx.Assert(
                Math.Abs(read - size) < Tolerance,
                $"the camera root size reads {read}, not {size}: the game bounds the zoom there, or the zoom had not finished");
        }
    }
}
