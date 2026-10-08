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
        /// Gives a colonist a mouth by <c>MouthTypeDef</c> name (Nals Facial Animation, and the types of the mods that add some: Vanilla
        /// Textures Expanded has MouthSmile, MouthLipsSmallSmile, MouthSad, MouthScowl...). This is the fixed shape of the face, not an
        /// animation: it does not depend on the job, the mood or the heat. Reads the part back; a name that does not exist fails with the list.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} mouth is {string}")]
        public void SetMouth(PickleContext ctx, string nickname, string typeName) => SetPart(ctx, nickname, "Mouth", typeName);

        /// <summary>Gives a colonist brows by <c>BrowTypeDef</c> name, as the mouth step does for the mouth.</summary>
        [Given("Nelim's Pickle Tools: {string} brows are {string}")]
        public void SetBrows(PickleContext ctx, string nickname, string typeName) => SetPart(ctx, nickname, "Brow", typeName);

        /// <summary>Gives a colonist lids (the look of the eyes: cheerful, almond, squinting...) by <c>LidTypeDef</c> name, as the mouth step does for the mouth.</summary>
        [Given("Nelim's Pickle Tools: {string} lids are {string}")]
        public void SetLids(PickleContext ctx, string nickname, string typeName) => SetPart(ctx, nickname, "Lid", typeName);

        /// <summary>Gives a colonist a skin detail (rosy cheeks, freckles, smile lines...) by <c>SkinTypeDef</c> name, as the mouth step does for the mouth.</summary>
        [Given("Nelim's Pickle Tools: {string} face skin is {string}")]
        public void SetFaceSkin(PickleContext ctx, string nickname, string typeName) => SetPart(ctx, nickname, "Skin", typeName);

        /// <summary>Gives a colonist eyeballs (the iris and white shape) by <c>EyeballTypeDef</c> name, as the mouth step does for the mouth.</summary>
        [Given("Nelim's Pickle Tools: {string} eyeballs are {string}")]
        public void SetEyeballs(PickleContext ctx, string nickname, string typeName) => SetPart(ctx, nickname, "Eyeball", typeName);

        /// <summary>Gives a colonist an eyelid option (lashes and the like) by <c>LidOptionTypeDef</c> name, as the mouth step does for the mouth.</summary>
        [Given("Nelim's Pickle Tools: {string} lid option is {string}")]
        public void SetLidOption(PickleContext ctx, string nickname, string typeName) => SetPart(ctx, nickname, "LidOption", typeName);

        /// <summary>Gives a colonist an emotion mark (blush, sweat drops, anger marks) by <c>EmotionTypeDef</c> name, as the mouth step does for the mouth.</summary>
        [Given("Nelim's Pickle Tools: {string} emotion mark is {string}")]
        public void SetEmotion(PickleContext ctx, string nickname, string typeName) => SetPart(ctx, nickname, "Emotion", typeName);

        /// <summary>Gives a colonist a face head shape by Facial Animation's own <c>HeadTypeDef</c> name (not the game's head type), as the mouth step does for the mouth.</summary>
        [Given("Nelim's Pickle Tools: {string} face head shape is {string}")]
        public void SetFaceHead(PickleContext ctx, string nickname, string typeName) => SetPart(ctx, nickname, "Head", typeName);

        // Kits: a whole face in one step, a name for a list of parts. A part whose def is missing (a mod not loaded) fails the step and says which.
        private static readonly System.Collections.Generic.Dictionary<string, (string Part, string Def)[]> Kits = new System.Collections.Generic.Dictionary<string, (string, string)[]>(StringComparer.OrdinalIgnoreCase)
        {
            ["smile"] = new[] { ("Mouth", "MouthSmile"), ("Lid", "LidCheerful"), ("Brow", "BrowEven"), ("Skin", "SkinRosyCheeks") },
            ["calm"] = new[] { ("Mouth", "MouthLipsTinySmile"), ("Lid", "LidSimple"), ("Brow", "BrowEven") },
            ["sad"] = new[] { ("Mouth", "MouthSad"), ("Lid", "LidUnimpressed"), ("Brow", "BrowRaised") },
            ["angry"] = new[] { ("Mouth", "MouthScowl"), ("Lid", "LidHardened"), ("Brow", "BrowTriangle") },
            ["smug"] = new[] { ("Mouth", "MouthSmug"), ("Lid", "LidFlirty"), ("Brow", "BrowEven") },
            ["neutral"] = new[] { ("Mouth", "MouthSimpleMouth"), ("Lid", "LidSimple"), ("Brow", "BrowEven") },
        };

        /// <summary>
        /// Gives a colonist a whole face by kit name: a list of face parts set together (mouth, lids, brows, skin). Kits: smile, calm, sad, angry,
        /// smug, neutral. They use the part types of Vanilla Textures Expanded and Facial Animation; a part whose type does not exist (the mod is not
        /// loaded) fails the step naming it. A part step run afterwards overrides one part of the kit.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} face kit is {string}")]
        public void SetKit(PickleContext ctx, string nickname, string kit)
        {
            ctx.Require(Kits.TryGetValue(kit, out var parts), "No face kit \"" + kit + "\"; known: " + string.Join(", ", Kits.Keys));
            foreach (var (part, def) in parts) SetPart(ctx, nickname, part, def);
        }

        private void SetPart(PickleContext ctx, string nickname, string part, string typeName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Type defType = FaType(ctx, "FacialAnimation." + part + "TypeDef");
            Type compType = FaType(ctx, "FacialAnimation." + part + "ControllerComp");
            var all = ((IEnumerable)typeof(DefDatabase<>).MakeGenericType(defType).GetProperty("AllDefs", Any).GetValue(null)).Cast<Def>().ToList();
            Def wanted = all.FirstOrDefault(d => d.defName == typeName);
            ctx.Require(wanted != null, "No " + part.ToLowerInvariant() + " type \"" + typeName + "\"; valid: " + string.Join(", ", all.Select(d => d.defName).OrderBy(n => n)));
            ThingComp comp = pawn.AllComps.FirstOrDefault(c => compType.IsInstanceOfType(c));
            ctx.Require(comp != null, nickname + " has no " + part.ToLowerInvariant() + " controller (a pawn without the facial animation head)");
            FieldInfo field = FieldUp(compType, "faceType");
            ctx.Require(field != null, "the " + part.ToLowerInvariant() + " controller has no faceType field: Facial Animation changed, update this step");
            field.SetValue(comp, wanted);
            FieldUp(compType, "prevFaceType")?.SetValue(comp, wanted);
            compType.GetMethod("SetDirty", Any)?.Invoke(comp, null);
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
            Def read = field.GetValue(comp) as Def;
            ctx.Assert(read != null && read.defName == typeName, nickname + "'s " + part.ToLowerInvariant() + " should be " + typeName + "; it reads " + (read?.defName ?? "(none)"));
        }

        /// <summary>Asserts the mouth of a colonist is this <c>MouthTypeDef</c> (the failure prints the one it has).</summary>
        [Then("Nelim's Pickle Tools: {string} mouth reads {string}")]
        public void MouthReads(PickleContext ctx, string nickname, string typeName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Type compType = FaType(ctx, "FacialAnimation.MouthControllerComp");
            ThingComp comp = pawn.AllComps.FirstOrDefault(c => compType.IsInstanceOfType(c));
            ctx.Require(comp != null, nickname + " has no mouth controller");
            Def read = FieldUp(compType, "faceType")?.GetValue(comp) as Def;
            ctx.Assert(read != null && read.defName == typeName, nickname + "'s mouth should read " + typeName + "; it reads " + (read?.defName ?? "(none)"));
        }

        /// <summary>
        /// Plays a Nals Facial Animation expression on a colonist by <c>FaceAnimationDef</c> name (for example <c>normal</c>, <c>blink</c>,
        /// <c>laydown</c>, <c>SocialRelax</c>): the mod's own temporary animation, started now. The names are those of the mod's animation
        /// defs; a name that does not exist fails with the list of valid ones. Several names joined by <c>+</c> are played together, in order, and for each part
        /// of the face the last one that defines it wins (read in the mod's code): <c>normal+NLR-Smile</c> is a neutral face with no heat sweat and the smile on top.
        /// A temporary animation ends when its frames have run out, which counts game ticks: it holds while the game is paused, not after a long wait.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} facial expression is {string}")]
        public void SetExpression(PickleContext ctx, string nickname, string animationName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Type defType = FaType(ctx, "FacialAnimation.FaceAnimationDef");
            Type compType = FaType(ctx, "FacialAnimation.FacialAnimationControllerComp");
            var all = ((IEnumerable)typeof(DefDatabase<>).MakeGenericType(defType).GetProperty("AllDefs", Any).GetValue(null)).Cast<Def>().ToList();
            // Several animations at once, separated by "+": the mod merges the frames of the temporary animations in the order given and, for each part of the face
            // (head, brows, lids, mouth, emotion...), the LAST one that defines it wins. "normal+NLR-Smile" is a neutral face (no heat sweat) with the smile on top.
            string[] names = animationName.Split(new[] { '+' }, StringSplitOptions.RemoveEmptyEntries).Select(n => n.Trim()).ToArray();
            ctx.Require(names.Length > 0, "no animation name given");
            foreach (string n in names)
                ctx.Require(all.Any(d => d.defName == n), "No facial animation \"" + n + "\"; valid: " + string.Join(", ", all.Select(d => d.defName).OrderBy(x => x)));
            ThingComp face = pawn.AllComps.FirstOrDefault(c => compType.IsInstanceOfType(c));
            ctx.Require(face != null, nickname + " has no facial animation controller");
            object ok = compType.GetMethod("PlayTemporaryAnimation", Any).Invoke(face, new object[] { pawn, Find.TickManager.TicksGame, names });
            ctx.Assert(ok is bool b && b, "The mod refused to play \"" + animationName + "\" on " + nickname + " (not valid for this race or head?)");
        }
    }
}
