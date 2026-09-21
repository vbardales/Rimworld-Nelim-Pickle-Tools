using System;
using System.IO;
using System.Linq;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.Rimmsqol
{
    /// <summary>
    /// RIMMSQOL's choice is written to the profile's Config folder by WriteSettings, which is exactly
    /// what these steps call. Left alone that is a leak: the staging does not wipe Config between
    /// passes, so a revealed shortcut would still be revealed for the next run that stages RIMMSQOL,
    /// under whatever mod that run tests. Hence a teardown after every scenario that puts back what a
    /// step changed, and it runs when the scenario failed too.
    ///
    /// The restart chain needs the opposite, once: the choice must SURVIVE the process so the next
    /// launch can read it. The scenario that wants that says so in its own text
    /// ("RIMMSQOL's choices are kept for the next launch"), where a reader of the feature sees it, and the
    /// launch that reads it says so too. A step sets the flag, never a hook, because Pickle runs hooks in
    /// reflection order and steps always run between the before and after hooks (technique from
    /// SkillIcons/Tests/Pickle/Source/SettingsSandbox.cs).
    ///
    /// If the second launch never comes (a run killed between the two, the machine reserved, a session
    /// ended), the choice stays on disk. The marker beside the file says whose it is: the first scenario
    /// to finish in ANOTHER process that is not the reader puts it back. Nothing can do that in a process
    /// that never starts, so README.md gives the two files to delete by hand.
    /// </summary>
    [PickleSteps]
    public class RimmsqolSandbox
    {
        [Given("RIMMSQOL's choices are kept for the next launch")]
        public void KeepForNextLaunch(PickleContext ctx) => RimmsqolSession.KeepForNextLaunch = true;

        /// <summary>
        /// First step of a launch that reads what the previous one kept. It refuses to pass when the
        /// writer ran in THIS process: that would be a restart test that never restarted, with the
        /// values still sitting in memory. It takes ownership of the kept choices, so the teardown of
        /// this launch puts them back unless this launch keeps them again.
        /// </summary>
        [Given("the choices RIMMSQOL kept in the previous launch are in place")]
        public void ReadKept(PickleContext ctx)
        {
            var marker = MarkerPath(ctx);
            ctx.Require(File.Exists(marker),
                $"no kept-choices marker at {marker}: the launch before this one did not keep any. "
                + "Play the writer feature first, in the same run: -Filter <writer> -Then <this>");
            var lines = File.ReadAllLines(marker);
            ctx.Require(lines.Length > 0, "the kept-choices marker is empty");

            // Taken over BEFORE the check that can fail, so that a launch that refuses to pass still
            // hands the choices to the teardown instead of leaving them on disk.
            foreach (var name in lines.Skip(1).Where(l => l.Length > 0)) RimmsqolSession.Touch(name);
            File.Delete(marker);
            Log.Message($"[RIMMSQOL steps] taking over the choices of the previous launch: {string.Join(", ", lines.Skip(1).ToArray())}");

            ctx.Assert(lines[0] != RimmsqolSession.ProcessId,
                "the marker was written by THIS process, so nothing restarted between the two features: "
                + "they ran in one game and the values were read from memory. Play the chain with "
                + "-Filter <first> -Then <second>,<third>, one launch each");
        }

        /// <summary>Runs after every scenario of every feature in the run, and does nothing when there is nothing to do.</summary>
        [AfterScenario]
        public void PutBack(PickleContext ctx)
        {
            // Game types only until RIMMSQOL is known to be there.
            if (!RimmsqolBridge.IsLoaded()) return;

            string marker;
            try { marker = MarkerPath(ctx); }
            catch (Exception) { return; } // not ready: nothing of ours can have been changed

            if (RimmsqolSession.KeepForNextLaunch)
            {
                RimmsqolSession.KeepForNextLaunch = false;
                var text = new[] { RimmsqolSession.ProcessId }.Concat(RimmsqolSession.Touched).ToArray();
                File.WriteAllLines(marker, text);
                Log.Message($"[RIMMSQOL steps] keeping for the next launch: {string.Join(", ", RimmsqolSession.Touched.ToArray())}");
                RimmsqolSession.Touched.Clear();
                return;
            }

            var toForget = RimmsqolSession.Touched.ToList();
            if (File.Exists(marker))
            {
                // Written by another process and not consumed by this scenario: it was not the reader.
                var lines = File.ReadAllLines(marker);
                if (lines.Length > 0 && lines[0] != RimmsqolSession.ProcessId)
                {
                    toForget.AddRange(lines.Skip(1).Where(l => l.Length > 0));
                    File.Delete(marker);
                }
            }
            RimmsqolSession.Touched.Clear();
            if (toForget.Count == 0) return;

            var problem = RimmsqolBridge.ForgetQuietly(toForget.Distinct());
            if (problem != null)
                Log.Error($"[RIMMSQOL steps] could not put back RIMMSQOL's choice for {string.Join(", ", toForget.ToArray())}: {problem}. "
                          + "It is still in RIMMSQOL's settings file: see PickleTools/RimmsqolSteps/README.md, 'Leftovers'");
        }

        private static string MarkerPath(PickleContext ctx) => RimmsqolBridge.SettingsFilePath(ctx) + ".pickle-kept";
    }
}
