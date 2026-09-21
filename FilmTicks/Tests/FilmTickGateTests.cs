using System;
using Nelim.PickleTools.FilmTicks;
using Xunit;

namespace Nelim.PickleTools.FilmTicks.Tests
{
    public class FilmTickGateTests
    {
        [Fact]
        public void FirstFrameAlwaysCaptures()
        {
            Assert.True(new FilmTickGate(5).ShouldCapture(1000));
        }

        [Fact]
        public void OneTickCapturesEveryTickThatPasses()
        {
            var gate = new FilmTickGate(1);

            Assert.True(gate.ShouldCapture(10));
            Assert.False(gate.ShouldCapture(10));
            Assert.True(gate.ShouldCapture(11));
            Assert.True(gate.ShouldCapture(12));
        }

        [Fact]
        public void WaitsUntilTheCounterHasAdvancedFarEnough()
        {
            var gate = new FilmTickGate(15);

            Assert.True(gate.ShouldCapture(100));
            Assert.False(gate.ShouldCapture(101));
            Assert.False(gate.ShouldCapture(114));
            Assert.True(gate.ShouldCapture(115));
            Assert.False(gate.ShouldCapture(129));
            Assert.True(gate.ShouldCapture(130));
        }

        [Fact]
        public void CountsFromTheTickItCapturedNotFromTheOneItWasDue()
        {
            var gate = new FilmTickGate(10);

            Assert.True(gate.ShouldCapture(0));
            Assert.True(gate.ShouldCapture(13));
            Assert.False(gate.ShouldCapture(22));
            Assert.True(gate.ShouldCapture(23));
        }

        [Fact]
        public void CounterGoingBackwardsCapturesAndRestarts()
        {
            var gate = new FilmTickGate(10);

            Assert.True(gate.ShouldCapture(500));
            Assert.True(gate.ShouldCapture(20));
            Assert.False(gate.ShouldCapture(25));
            Assert.True(gate.ShouldCapture(30));
        }

        [Theory]
        [InlineData(0)]
        [InlineData(-3)]
        public void RejectsAnIntervalUnderOneTick(int ticksPerFrame)
        {
            Assert.Throws<ArgumentOutOfRangeException>(() => new FilmTickGate(ticksPerFrame));
        }
    }
}
