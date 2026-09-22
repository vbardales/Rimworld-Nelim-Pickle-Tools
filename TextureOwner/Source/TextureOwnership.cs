using System;
using System.Collections.Generic;
using System.Linq;

namespace Nelim.PickleTools.TextureOwner
{
    /// <summary>A running mod that ships a texture path, as the steps see it.</summary>
    public sealed class Provider
    {
        public Provider(string packageId, string name)
        {
            PackageId = packageId ?? "";
            Name = name ?? "";
        }

        public string PackageId { get; }
        public string Name { get; }
    }

    /// <summary>
    /// What the two steps decide, with no game type in it, so that the wording of every failure can be exercised
    /// offline (<c>Check-Ownership.ps1</c>) and does not have to wait for a scenario that fails.
    ///
    /// Each method returns null when the claim holds, and otherwise the sentence the person reading the report
    /// gets. That person wants to know who took the path, not only that someone did: every message names the
    /// winner and lists every mod shipping the path in load order.
    ///
    /// The winner is the LAST provider. <c>ContentFinder&lt;Texture2D&gt;.Get</c> walks
    /// <c>LoadedModManager.RunningModsListForReading</c> from the end and returns the first non-null answer of a
    /// mod's <c>ModContentHolder</c> (read from the 1.6 IL of Assembly-CSharp, 2026-09-21).
    /// </summary>
    public static class TextureOwnership
    {
        private const string LastWins = "The mod that loads last wins.";

        /// <summary>A path no running mod ships. The steps stop on this instead of passing.</summary>
        public static string NoProvider(string path) =>
            $"no running mod ships the texture '{path}' at all: the path is wrong (it is case-sensitive, relative to "
            + "a mod's Textures folder, with no extension), or the mod that should ship it is not loaded";

        /// <summary>
        /// The claim: the mod <paramref name="expectedPackageId"/> answers for the path.
        /// <paramref name="providers"/> are the running mods that ship it, in load order, and are not empty.
        /// <paramref name="running"/> are the package ids of every running mod, to tell "not loaded at all"
        /// from "loaded, and beaten".
        /// </summary>
        public static string OwnerVerdict(string path, IList<Provider> providers, string expectedPackageId, ICollection<string> running)
        {
            var winner = providers[providers.Count - 1];
            if (Same(winner.PackageId, expectedPackageId))
                return null;

            var shippers = string.Join(" -> ", providers.Select(p => p.PackageId));
            var index = IndexOf(providers, expectedPackageId);
            string why;
            if (index >= 0)
                why = $"'{expectedPackageId}' ships it, in position {index + 1} of {providers.Count}, and loads before the winner. "
                    + LastWins + " A loadAfter (or a load order) that puts it after the others is missing or no longer wins.";
            else if (running != null && running.Any(id => Same(id, expectedPackageId)))
                why = $"'{expectedPackageId}' is running but ships no texture at that path, so it is not in the contest. "
                    + "Its Textures folder does not hold that path.";
            else
                why = $"'{expectedPackageId}' is not among the running mods at all: it is not staged in this pass, "
                    + "or its packageId is not the one written here.";

            return $"'{path}' resolves to '{winner.Name}' ({winner.PackageId}), not to '{expectedPackageId}'. "
                + $"Mods shipping it, in load order: {shippers}. " + why;
        }

        /// <summary>The claim: at least <paramref name="atLeast"/> running mods ship the path.</summary>
        public static string ContestVerdict(string path, IList<Provider> providers, int atLeast)
        {
            if (providers.Count >= atLeast)
                return null;

            var winner = providers[providers.Count - 1];
            return $"'{path}' is shipped by {providers.Count} running mod(s), expected at least {atLeast}. "
                + $"Mods shipping it, in load order: {string.Join(" -> ", providers.Select(p => p.PackageId))}. "
                + $"It resolves to '{winner.Name}' ({winner.PackageId}). "
                + "A path with fewer shippers than the scenario expects means the competing mod is not actually loaded "
                + "in this pass, and an ownership claim made here would prove nothing.";
        }

        /// <summary>A count below one makes the claim empty: every path that exists passes it.</summary>
        public static string EmptyCount(int atLeast) =>
            atLeast >= 1 ? null : $"'at least {atLeast}' running mods is not a claim: it holds for any path. Ask for 1 or more.";

        private static int IndexOf(IList<Provider> providers, string packageId)
        {
            for (var i = 0; i < providers.Count; i++)
                if (Same(providers[i].PackageId, packageId))
                    return i;
            return -1;
        }

        private static bool Same(string a, string b) =>
            string.Equals((a ?? "").Trim(), (b ?? "").Trim(), StringComparison.OrdinalIgnoreCase);
    }
}
