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

        public static string RecordArguments(string source, string file, int maxSeconds, int rate = 22050, int channels = 1)
        {
            return $"-hide_banner -loglevel error -y -f pulse -i {source} -ar {rate} -ac {channels} -t {maxSeconds} \"{file}\"";
        }

        /// <summary>
        /// The picture of a film and the sound recorded beside it, in one mp4 that Windows plays as it is (H.264 and AAC).
        /// The film is a webm, so the picture is encoded again; the sides are made even, which yuv420p needs. The sound is
        /// cut to the picture's length, since the recorder starts and stops a little either side of it.
        /// </summary>
        public static string MuxArguments(string film, string sound, string output)
        {
            return $"-hide_banner -loglevel error -y -i \"{film}\" -i \"{sound}\" -map 0:v:0 -map 1:a:0 " +
                   "-vf \"scale=trunc(iw/2)*2:trunc(ih/2)*2\" -c:v libx264 -preset veryfast -crf 23 -pix_fmt yuv420p " +
                   $"-c:a aac -b:a 160k -shortest -movflags +faststart \"{output}\"";
        }

        public static string VolumeDetectArguments(string file)
        {
            return $"-hide_banner -nostats -i \"{file}\" -af volumedetect -f null -";
        }

        /// <summary>What ffmpeg says of a file: its streams and its length, on the error output.</summary>
        public static string ProbeArguments(string file)
        {
            return $"-hide_banner -i \"{file}\"";
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
