using System;
using System.Collections;
using System.Reflection;
using HarmonyLib;
using RimWorks.Pickle;
using UnityEngine;

namespace Nelim.PickleTools.InterfaceScale
{
    /// <summary>
    /// Puts right, from outside, what <c>TagStore.Record</c> stores at any interface scale but 100.
    ///
    /// Pickle records a tagged widget by converting its window-local rect with
    /// <c>GUIUtility.GUIToScreenRect</c>. That function composes two spaces: it adds the clip origin
    /// UNSCALED and the local offset SCALED. Every consumer of the store wants GUI space -
    /// <c>InputBackends.ToScreen</c> applies <c>Prefs.UIScale</c> itself, and the hit test compares
    /// against <c>UI.MousePositionOnUIInverted</c> - so at a scale other than 100 the stored rect
    /// belongs to neither space, and the click that follows lands elsewhere. Measured in a running game
    /// at 1920x1080 and 150 percent: a clip origin of (0, 375) and a local y of 285 were stored as 802.5,
    /// where the GUI rect is 660. At scale 1 the two spaces coincide, which is why nothing else noticed.
    ///
    /// The fix is to unclip through the origin alone: <c>GUIToScreenPoint(zero)</c> is exact for it,
    /// because the scaled term vanishes at zero. That is the change proposed to Pickle itself,
    /// RimWorks/Rimworld-Pickle pull request 23, and this class is its copy for a Pickle that does not
    /// have it yet. **When it lands and a Pickle release carries it, this whole tool can go.**
    ///
    /// It is a postfix on <c>Record</c> rather than a copy of it: the original runs, then the rect it
    /// just stored is replaced by the right one. Two consequences worth knowing:
    ///
    ///   - it is idempotent. On a Pickle that already unclips through the origin it stores the same
    ///     value again, so having both in one run does no harm and nothing has to detect which it is;
    ///   - it touches nothing but the rect, so whatever else the store keeps (the duplicate flag, and on
    ///     a build that has it the scale each entry was measured at) is left as the original wrote it.
    ///
    /// The store is reached by reflection: <c>TagStore</c> is internal to Pickle.
    /// </summary>
    public static class TagStoreRepair
    {
        private const string HarmonyId = "nelim.pickletools.interfacescale";

        private static bool applied;
        private static IDictionary store;
        private static MethodInfo sessionActiveGetter;
        private static PropertyInfo rectProperty;
        private static PropertyInfo duplicateProperty;
        private static PropertyInfo duplicateRectProperty;

        /// <summary>Puts the repair in place, once. Safe to call before every scenario.</summary>
        public static void Ensure(PickleContext ctx)
        {
            if (applied)
            {
                return;
            }

            var storeType = AccessTools.TypeByName("RimWorks.Pickle.Input.TagStore");
            ctx.Require(storeType != null,
                "RimWorks.Pickle.Input.TagStore no longer exists: Pickle renamed or moved it, so the tag store repair " +
                "cannot find what to repair. If the fix has been merged upstream, remove this tool from the pass map");

            var storeField = AccessTools.Field(storeType, "Store");
            ctx.Require(storeField != null && typeof(IDictionary).IsAssignableFrom(storeField.FieldType),
                "TagStore.Store is not a dictionary any more: the tag store repair has to be rewritten for this Pickle");
            store = (IDictionary)storeField.GetValue(null);

            sessionActiveGetter = AccessTools.PropertyGetter(storeType, "SessionActive");
            var entryType = storeField.FieldType.GetGenericArguments()[1];
            rectProperty = AccessTools.Property(entryType, "Rect");
            duplicateProperty = AccessTools.Property(entryType, "Duplicate");
            duplicateRectProperty = AccessTools.Property(entryType, "DuplicateRect");
            ctx.Require(sessionActiveGetter != null && rectProperty != null && duplicateProperty != null && duplicateRectProperty != null,
                "TagStore or its entries changed shape: the tag store repair has to be rewritten for this Pickle");

            var record = AccessTools.Method(storeType, "Record", new[] { typeof(string), typeof(Rect) });
            ctx.Require(record != null,
                "TagStore.Record(string, Rect) no longer exists: the tag store repair has to be rewritten for this Pickle");

            new Harmony(HarmonyId).Patch(record,
                postfix: new HarmonyMethod(typeof(TagStoreRepair), nameof(Postfix)));
            applied = true;
        }

        /// <summary>
        /// Runs after <c>Record</c>. The parameter names are the original's: Harmony binds a postfix's
        /// parameters by name.
        /// </summary>
        public static void Postfix(string tag, Rect rect)
        {
            // The same three conditions Record starts with. If it returned early there is nothing of this
            // call in the store, and whatever is there was already put right when it was recorded.
            if (!(bool)sessionActiveGetter.Invoke(null, null))
            {
                return;
            }

            var current = Event.current;
            if (current == null || current.type != EventType.Repaint)
            {
                return;
            }

            if (!store.Contains(tag))
            {
                return;
            }

            var entry = store[tag];
            var guiRect = new Rect(rect.position + GUIUtility.GUIToScreenPoint(Vector2.zero), rect.size);

            // Record either created the entry (not a duplicate) or marked it a duplicate and stored the
            // second rect beside it. It did one of the two with THIS call's rect, so that is the one to fix.
            if ((bool)duplicateProperty.GetValue(entry))
            {
                duplicateRectProperty.SetValue(entry, guiRect);
            }
            else
            {
                rectProperty.SetValue(entry, guiRect);
            }
        }
    }
}
