using System;

namespace Nelim.PickleTools.FilmTicks
{
    /// <summary>
    /// Decides, frame by frame, when a film that counts in game ticks takes its next picture. Pickle's
    /// own film is paced by a stopwatch, so an effect that lives one tick in fifteen is caught by chance.
    /// This gate is fed the tick counter on every rendered frame and answers true once the counter has
    /// moved on by the requested number of ticks.
    ///
    /// It is a copy, on purpose, of the rule proposed to Pickle as <c>@film-ticks:N</c>
    /// (<c>FilmTickGate</c> in Pickle.Core), so these steps work on the Workshop build of Pickle as it is.
    /// When that lands, this file and the steps that use it can go.
    /// </summary>
    public sealed class FilmTickGate
    {
        private readonly int ticksPerFrame;

        private int? lastCapturedTick;

        public FilmTickGate(int ticksPerFrame)
        {
            if (ticksPerFrame < 1)
            {
                throw new ArgumentOutOfRangeException(nameof(ticksPerFrame), ticksPerFrame,
                    "A film needs at least one tick between pictures.");
            }

            this.ticksPerFrame = ticksPerFrame;
        }

        /// <summary>
        /// True for the first frame, and whenever the counter has advanced far enough since the last
        /// picture taken. A counter that has gone backwards means a load or a debug rewind: the remembered
        /// tick is meaningless, so take the picture and start counting again from there.
        /// </summary>
        public bool ShouldCapture(int ticksGame)
        {
            if (lastCapturedTick.HasValue && ticksGame >= lastCapturedTick.Value
                && ticksGame - lastCapturedTick.Value < ticksPerFrame)
            {
                return false;
            }

            lastCapturedTick = ticksGame;
            return true;
        }
    }
}
