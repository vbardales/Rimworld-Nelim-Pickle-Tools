using System.Collections.Generic;
using HarmonyLib;
using RimWorld;
using VEF.Factions;
using Verse;

namespace QuietNewFactions;

public sealed class QuietNewFactionsMod : Mod
{
    public QuietNewFactionsMod(ModContentPack content) : base(content)
    {
        new Harmony("nelim.quietnewfactions").PatchAll();
    }
}

// Vanilla Expanded Framework asks, on every load, about each faction the world
// lacks. Its "skip" records nothing, so the question comes back next load; only
// "ignore" is remembered, in the save (NewFactionSpawningState). This answers
// "ignore" for the player.
//
// OpenDialog is where VEF shows one faction, and where the dialog's PostClose
// shows the next one: prefixing it walks the whole list, one faction per call.
// A faction the mod that defines it marks as required
// (forcePlayerToAddFactionIfMissing) is left to the real dialog, which refuses
// both skip and ignore for it — ignoring it here would break that mod's intent.
[HarmonyPatch(typeof(Dialog_NewFactionSpawning), nameof(Dialog_NewFactionSpawning.OpenDialog))]
public static class Dialog_NewFactionSpawning_OpenDialog
{
    public static bool Prefix(IEnumerator<FactionDef> enumerator, FactionDef faction)
    {
        var def = faction ?? enumerator.Current;
        if (def == null || FactionDefExtension.Get(def).forcedFactionData.forcePlayerToAddFactionIfMissing)
            return true;

        NewFactionSpawningState.Instance.Ignore(def);
        Log.Message($"[Quiet New Factions] {def.defName} ({def.modContentPack?.Name ?? "?"}) ignored in this save.");

        if (enumerator.MoveNext()) Dialog_NewFactionSpawning.OpenDialog(enumerator);
        else enumerator.Dispose();
        return false;
    }
}
