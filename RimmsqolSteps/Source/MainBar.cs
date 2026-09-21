using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using RimWorld;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.Rimmsqol
{
    /// <summary>
    /// What the main bar draws, worked out from the game's own list and its own rule, not from a guess.
    ///
    /// MainButtonsRoot.DoButtons walks <c>allButtonsInOrder</c> (private, and the very field RIMMSQOL
    /// rewrites when it applies a new order), keeps the defs whose <c>Worker.Visible</c> is true, gives each
    /// a cell of screenWidth / count (half for a minimized one, the last one takes what is left), and calls
    /// <c>Worker.DoButton</c> on it. This repeats that arithmetic against the live list, so the answer is
    /// the cell the bar will really give the button, and a def the bar does not visit has no cell.
    ///
    /// It is a calculation from the bar's own inputs, not a photograph. Whether the pixels are there is what
    /// the capture is for, and a scenario that says "the bar draws" is not a visual check.
    /// </summary>
    public static class MainBar
    {
        private static readonly FieldInfo Order =
            typeof(MainButtonsRoot).GetField("allButtonsInOrder", BindingFlags.Instance | BindingFlags.NonPublic);

        public sealed class Cell
        {
            public MainButtonDef Def;
            public Rect Rect;
        }

        public static List<Cell> Layout(PickleContext ctx)
        {
            ctx.Require(Order != null,
                "MainButtonsRoot has no field 'allButtonsInOrder' in this game version: the bar's list has moved, "
                + "and so has the field RIMMSQOL itself reflects on");
            ctx.Require(Current.ProgramState == ProgramState.Playing && Find.MainButtonsRoot != null,
                "there is no main bar: no game is running. Load the fixture ('the save \"test-colony\" is loaded') first");

            var all = (List<MainButtonDef>)Order.GetValue(Find.MainButtonsRoot);
            ctx.Require(all != null, "MainButtonsRoot.allButtonsInOrder is null");

            var visible = all.Where(d => d.Worker.Visible).ToList();
            var cells = new List<Cell>();
            if (visible.Count == 0) return cells;

            float count = 0f;
            foreach (var d in visible) count += d.minimized ? 0.5f : 1f;
            int full = (int)(UI.screenWidth / count);
            int half = full / 2;
            int x = 0;
            for (int i = 0; i < visible.Count; i++)
            {
                int width = visible[i].minimized ? half : full;
                if (i == visible.Count - 1) width = UI.screenWidth - x;
                cells.Add(new Cell { Def = visible[i], Rect = new Rect(x, UI.screenHeight - 35, width, 36f) });
                x += width;
            }
            return cells;
        }
    }
}
