using System;
using System.Collections;
using System.Linq;
using System.Reflection;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps for the face of a colonist when Nals Facial Animation (<c>Nals.FacialAnimation</c>) is loaded: the eye colour and a facial
    /// expression. The mod is reached by reflection, so this assembly needs no reference to it and the steps fail with a clear message when it
    /// is not loaded. NOT PLAYED when written (2026-10-08): compiled only; read the capture before relying on them.
    /// </summary>
    [PickleSteps]
    public class FaceSteps
    {
        private const BindingFlags Any = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;

        private static Type FaType(PickleContext ctx, string fullName)
        {
            Type t = GenTypes.AllTypes.FirstOrDefault(x => x.FullName == fullName);
            ctx.Require(t != null, "Nals Facial Animation is not loaded (no type " + fullName + "): load the mod before this step");
            return t;
        }

        private static FieldInfo FieldUp(Type t, string name)
        {
            for (; t != null; t = t.BaseType) { var f = t.GetField(name, Any | BindingFlags.DeclaredOnly); if (f != null) return f; }
            return null;
        }

        /// <summary>
        /// Gives a colonist an eye colour, RGB 0 to 255, in Nals Facial Animation's eyeball controller (both eyes, so no heterochromia), and
        /// reads it back through the mod's own colour. A colour forced by a gene (EyeGenes3 for instance) is not undone: if the mod keeps
        /// reading the gene, the step fails saying what the mod reports.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} eye colour is rgb \\({int}, {int}, {int}\\)")]
        public void SetEyeColour(PickleContext ctx, string nickname, int r, int g, int b)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(r >= 0 && r <= 255 && g >= 0 && g <= 255 && b >= 0 && b <= 255, "rgb values run from 0 to 255");
            Type comp = FaType(ctx, "FacialAnimation.EyeballControllerComp");
            ThingComp eyes = pawn.AllComps.FirstOrDefault(c => comp.IsInstanceOfType(c));
            ctx.Require(eyes != null, nickname + " has no eyeball controller (a pawn without the facial animation head)");
            Color wanted = new Color(r / 255f, g / 255f, b / 255f, 1f);
            foreach (string field in new[] { "color", "prevColor", "secondColor", "prevSecondColor" })
                FieldUp(comp, field)?.SetValue(eyes, wanted);
            comp.GetMethod("SetDirty", Any)?.Invoke(eyes, null);
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
            Color read = (Color)comp.GetMethod("GetCurrentColor", Any).Invoke(eyes, null);
            ctx.Assert(
                Math.Abs(read.r - wanted.r) < 0.02f && Math.Abs(read.g - wanted.g) < 0.02f && Math.Abs(read.b - wanted.b) < 0.02f,
                nickname + "'s eye colour should read " + wanted + "; the mod reports " + read + ". Something forces a colour on top of it (an eye gene?)");
        }

        /// <summary>
        /// Plays a Nals Facial Animation expression on a colonist by <c>FaceAnimationDef</c> name (for example <c>normal</c>, <c>blink</c>,
        /// <c>laydown</c>, <c>SocialRelax</c>): the mod's own temporary animation, started now. The names are those of the mod's animation
        /// defs; a name that does not exist fails with the list of valid ones. The animation runs on game ticks, so a scenario that holds the
        /// game paused may need a few ticks before the capture.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} facial expression is {string}")]
        public void SetExpression(PickleContext ctx, string nickname, string animationName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Type defType = FaType(ctx, "FacialAnimation.FaceAnimationDef");
            Type compType = FaType(ctx, "FacialAnimation.FacialAnimationControllerComp");
            var all = ((IEnumerable)typeof(DefDatabase<>).MakeGenericType(defType).GetProperty("AllDefs", Any).GetValue(null)).Cast<Def>().ToList();
            ctx.Require(all.Any(d => d.defName == animationName),
                "No facial animation \"" + animationName + "\"; valid: " + string.Join(", ", all.Select(d => d.defName).OrderBy(n => n)));
            // The mod keeps a situation face (the heat sweat, priority 20000) above a low-priority animation: raise the asked one above every other, for this run.
            Def asked = all.First(d => d.defName == animationName);
            FieldInfo priority = defType.GetField("priority", Any);
            if (priority != null && priority.FieldType == typeof(int)) priority.SetValue(asked, 1000000);
            ThingComp face = pawn.AllComps.FirstOrDefault(c => compType.IsInstanceOfType(c));
            ctx.Require(face != null, nickname + " has no facial animation controller");
            object ok = compType.GetMethod("PlayTemporaryAnimation", Any).Invoke(face, new object[] { pawn, Find.TickManager.TicksGame, new[] { animationName } });
            ctx.Assert(ok is bool b && b, "The mod refused to play \"" + animationName + "\" on " + nickname + " (not valid for this race or head?)");
        }
    }
}
