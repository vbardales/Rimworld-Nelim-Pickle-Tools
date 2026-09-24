using System;
using System.Globalization;
using System.Text.RegularExpressions;

namespace Nelim.PickleTools.SoundCapture
{
    /// <summary>
    /// The parts of sound recording that need no game: the ffmpeg command lines and the reading of what
    /// <c>volumedetect</c> says. Kept apart from the steps so plain .NET can test them, the way FilmTicks tests its gate.
    /// </summary>
    public static class SoundAnalysis
    {
        // Measured on the WSL install, 2026-09-24: an idle monitor of the WSLg sink reads -91.0 dB, a 440 Hz test tone
        // at the default level reads -18.1 dB. Game sounds sit between: quiet UI clicks are far above -60.
        public const double NotSilentAboveDb = -60.0;
        public const double SilentBelowDb = -80.0;

        public const string DefaultSource = "RDPSink.monitor";

        public static string RecordArguments(string source, string file, int maxSeconds)
        {
            return $"-hide_banner -loglevel error -y -f pulse -i {source} -ar 22050 -ac 1 -t {maxSeconds} \"{file}\"";
        }

        public static string VolumeDetectArguments(string file)
        {
            return $"-hide_banner -nostats -i \"{file}\" -af volumedetect -f null -";
        }

        private static readonly Regex MaxVolume =
            new Regex(@"max_volume:\s*(-inf|-?\d+(?:\.\d+)?)\s*dB", RegexOptions.CultureInvariant);

        /// <summary>The loudest sample, in dB, from ffmpeg's report; false when the report has no such line.</summary>
        public static bool TryParseMaxVolume(string ffmpegOutput, out double decibels)
        {
            decibels = double.NegativeInfinity;
            if (string.IsNullOrEmpty(ffmpegOutput))
            {
                return false;
            }

            Match match = MaxVolume.Match(ffmpegOutput);
            if (!match.Success)
            {
                return false;
            }

            string text = match.Groups[1].Value;
            decibels = text == "-inf"
                ? double.NegativeInfinity
                : double.Parse(text, CultureInfo.InvariantCulture);
            return true;
        }

        public static bool IsNotSilent(double maxDecibels)
        {
            return maxDecibels > NotSilentAboveDb;
        }

        public static bool IsSilent(double maxDecibels)
        {
            return maxDecibels < SilentBelowDb;
        }
    }
}
