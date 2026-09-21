using System.Linq;
using System.Threading.Tasks;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.Rimmsqol
{
    /// <summary>
    /// Reveals and hides any MainButtonDef the way RIMMSQOL's own interface does, and asserts what the
    /// main bar then draws. See <see cref="RimmsqolBridge"/> for what RIMMSQOL does and how these steps
    /// reach it. Every step names the def by its defName, so the vocabulary belongs to no mod: a suite
    /// stages this assembly and writes <c>RIMMSQOL reveals the main button "MyMod_Settings"</c>.
    ///
    /// Every pattern says RIMMSQOL or names the main bar. Pickle loads the steps of every installed suite
    /// into one namespace and a repeated text is an "Ambiguous step" that fails healthy scenarios;
    /// Check-Steps.ps1 compares these against every suite in the repository.
    /// </summary>
    [PickleSteps]
    public class RimmsqolShortcutSteps
    {
        // ---- is it there, does its own interface list the button, what does it show ------------

        [Then("RIMMSQOL is ready to be driven")]
        public void AssertReady(PickleContext ctx) => RimmsqolBridge.RequireReady(ctx);

        /// <summary>
        /// The claim is that a player, opening RIMMSQOL's "Main Buttons" list, finds the button. The list
        /// is built from every MainButtonDef whatever its visibility, so this is expected to hold; the
        /// entry's own label is logged because it is what the player reads there.
        /// </summary>
        [Then("RIMMSQOL's own list of main buttons offers {string}")]
        public void AssertListed(PickleContext ctx, string defName)
        {
            var label = RimmsqolBridge.ListEntryLabel(ctx, defName);
            Log.Message($"[RIMMSQOL steps] RIMMSQOL's list offers '{defName}' as: {label?.Replace("\n", " | ")}");
            ctx.Assert(!string.IsNullOrEmpty(label), $"RIMMSQOL's list offers '{defName}' with an empty label");
        }

        /// <summary>What the Visible checkbox on the button's edit page reads, {word} being visible or hidden.</summary>
        [Then("RIMMSQOL shows the main button {string} as {word}")]
        public void AssertShows(PickleContext ctx, string defName, string state)
        {
            var wantVisible = ParseState(ctx, state);
            var shown = RimmsqolBridge.ShowsVisible(ctx, defName);
            ctx.Assert(shown == wantVisible,
                $"RIMMSQOL's Visible checkbox for '{defName}' reads {(shown ? "visible" : "hidden")}, expected {state}");
        }

        [Then("RIMMSQOL holds no choice for the main button {string}")]
        public void AssertHoldsNone(PickleContext ctx, string defName) =>
            ctx.Assert(!RimmsqolBridge.HoldsChoice(ctx, defName),
                $"RIMMSQOL still holds an active choice for '{defName}': it would be saved and applied again");

        // ---- what its interface does -----------------------------------------------------------

        [When("RIMMSQOL reveals the main button {string}")]
        public void Reveal(PickleContext ctx, string defName) => RimmsqolBridge.SetVisible(ctx, defName, true);

        [When("RIMMSQOL hides the main button {string}")]
        public void Hide(PickleContext ctx, string defName) => RimmsqolBridge.SetVisible(ctx, defName, false);

        /// <summary>The reset cross beside the list entry: the choice is dropped and the def goes back to what its mod shipped.</summary>
        [When("RIMMSQOL forgets its choice for the main button {string}")]
        public void Forget(PickleContext ctx, string defName) => RimmsqolBridge.Forget(ctx, defName);

        // ---- what is on disk, what the next launch will read -----------------------------------

        [Then("RIMMSQOL's settings file records the main button {string} as {word}")]
        public void AssertRecorded(PickleContext ctx, string defName, string state)
        {
            var want = ParseState(ctx, state) ? Recorded.Visible : Recorded.Hidden;
            var got = RimmsqolBridge.ReadFile(ctx, defName, out var detail);
            Log.Message($"[RIMMSQOL steps] settings file: {detail}");
            ctx.Assert(got == want, $"RIMMSQOL's settings file: {detail}. Expected it to record '{defName}' as {state}");
        }

        [Then("RIMMSQOL's settings file records no choice for the main button {string}")]
        public void AssertRecordedNothing(PickleContext ctx, string defName)
        {
            var got = RimmsqolBridge.ReadFile(ctx, defName, out var detail);
            Log.Message($"[RIMMSQOL steps] settings file: {detail}");
            ctx.Assert(got == Recorded.NoChoice, $"RIMMSQOL's settings file still records a choice: {detail}");
        }

        // ---- what the main bar draws -----------------------------------------------------------

        /// <summary>
        /// Both halves, because a def can be in the bar and dead: the bar visits it (Worker.Visible, hence
        /// a cell) and the worker is not Disabled, which is what turns the cell grey. MOD_SETTINGS.md
        /// forbids a greyed shortcut as firmly as a visible one.
        /// </summary>
        [Then("the main bar draws the button {string}")]
        public void AssertDrawn(PickleContext ctx, string defName)
        {
            var def = DefDatabase<MainButtonDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no MainButtonDef named '{defName}' is loaded");
            var cells = MainBar.Layout(ctx);
            var cell = cells.FirstOrDefault(c => c.Def == def);
            ctx.Assert(cell != null,
                $"the main bar does not visit '{defName}': buttonVisible is {def.buttonVisible}, Worker.Visible {def.Worker.Visible}. "
                + $"It draws {cells.Count}: {string.Join(", ", cells.Select(c => c.Def.defName).ToArray())}");
            ctx.Assert(cell.Rect.width >= 1f, $"the bar gives '{defName}' a cell {cell.Rect.width} wide");
            ctx.Assert(!def.Worker.Disabled, $"the bar draws '{defName}' greyed out, which MOD_SETTINGS.md forbids");
            Log.Message($"[RIMMSQOL steps] the bar draws '{defName}' at x {cell.Rect.x}..{cell.Rect.xMax}, y {cell.Rect.y}, of {cells.Count} buttons");
        }

        [Then("the main bar does not draw the button {string}")]
        public void AssertNotDrawn(PickleContext ctx, string defName)
        {
            var def = DefDatabase<MainButtonDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no MainButtonDef named '{defName}' is loaded");
            var cells = MainBar.Layout(ctx);
            ctx.Assert(cells.All(c => c.Def != def),
                $"the main bar draws '{defName}' (buttonVisible {def.buttonVisible}): it shows without anything having revealed it");
        }

        /// <summary>
        /// What the bar's own click ends up calling. InterfaceTryActivate, not Activate: it is the method
        /// DoButton invokes, tutorial checks included.
        /// </summary>
        [When("the main bar's button {string} is activated")]
        public void Activate(PickleContext ctx, string defName)
        {
            var def = DefDatabase<MainButtonDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no MainButtonDef named '{defName}' is loaded");
            ctx.Require(MainBar.Layout(ctx).Any(c => c.Def == def),
                $"'{defName}' is not drawn by the main bar, so a player could not click it");
            def.Worker.InterfaceTryActivate();
        }

        // ---- its own window --------------------------------------------------------------------

        /// <summary>
        /// Waits for its own frames, as every step that opens a Dialog_ModSettings must: the dialog
        /// force-pauses the game, so a tick wait in the scenario can never be satisfied. RIMMSQOL builds
        /// its whole menu on the first frame, which can take seconds, hence the timeout.
        /// </summary>
        [When("RIMMSQOL's own window is opened on its list of main buttons", TimeoutSeconds = 30)]
        public async Task OpenList(PickleContext ctx)
        {
            RimmsqolBridge.OpenWindow(ctx, null);
            await Settle(ctx);
        }

        [When("RIMMSQOL's own window is opened on the main button {string}", TimeoutSeconds = 30)]
        public async Task OpenEntry(PickleContext ctx, string defName)
        {
            RimmsqolBridge.OpenWindow(ctx, defName);
            await Settle(ctx);
        }

        [Then("RIMMSQOL's own window is open")]
        public void AssertWindowOpen(PickleContext ctx) =>
            ctx.Assert(RimmsqolBridge.WindowIsOpen(), "no Dialog_ModSettings built for RIMMSQOL is open");

        private static async Task Settle(PickleContext ctx)
        {
            // Consumed on a later frame by DoSettingsWindowContents; frames still pass while paused.
            await ctx.WaitUntil(() => !RimmsqolBridge.NavigationPending(), 25f);
            await ctx.WaitFrames(5);
            ctx.Assert(RimmsqolBridge.WindowIsOpen(), "RIMMSQOL's own window did not stay open");
        }

        private static bool ParseState(PickleContext ctx, string state)
        {
            if (state == "visible") return true;
            if (state == "hidden") return false;
            ctx.Require(false, $"'{state}' is not a state: say visible or hidden");
            return false;
        }
    }
}
