using System.Collections.Generic;
using RimWorld;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// A baseline for galleries that change one look value per photograph: the look of a colonist is saved once, then restored before each
    /// photograph, so the value of the previous photograph (a tattoo, a beard, a head, a hair colour) never leaks into the next one. Covers hairstyle,
    /// hair colour, head type, body type, beard, face and body tattoo, and the skin colour override. Apparel and genes are not covered (see
    /// LookSteps.RestoreAll and the gene steps). Written 2026-10-26 at the owner's request (porosity between the shots of a gallery). NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class BaselineSteps
    {
        private sealed class Saved
        {
            public HairDef Hair; public Color HairColor; public HeadTypeDef Head; public BodyTypeDef Body;
            public BeardDef Beard; public TattooDef FaceTattoo, BodyTattoo; public Color? Skin;
        }

        private static readonly Dictionary<Pawn, Saved> Looks = new Dictionary<Pawn, Saved>();

        [Given("Nelim's Pickle Tools: the look of {string} is saved")]
        public void SaveLook(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story != null, $"pawn '{nickname}' has no story, so it has no look to save");
            Looks[pawn] = new Saved
            {
                Hair = pawn.story.hairDef, HairColor = pawn.story.HairColor, Head = pawn.story.headType, Body = pawn.story.bodyType,
                Beard = pawn.style?.beardDef, FaceTattoo = pawn.style?.FaceTattoo, BodyTattoo = pawn.style?.BodyTattoo, Skin = pawn.story.skinColorOverride,
            };
        }

        [Given("Nelim's Pickle Tools: the look of {string} is restored")]
        public void RestoreLook(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(Looks.TryGetValue(pawn, out Saved s), $"the look of '{nickname}' was not saved in this scenario (add the step 'the look of \"{nickname}\" is saved' before the first photograph)");
            pawn.story.hairDef = s.Hair; pawn.story.HairColor = s.HairColor; pawn.story.headType = s.Head; pawn.story.bodyType = s.Body; pawn.story.skinColorOverride = s.Skin;
            if (pawn.style != null) { pawn.style.beardDef = s.Beard; pawn.style.FaceTattoo = s.FaceTattoo; pawn.style.BodyTattoo = s.BodyTattoo; }
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
            ctx.Assert(pawn.story.hairDef == s.Hair && pawn.story.headType == s.Head && pawn.story.bodyType == s.Body, $"the look of '{nickname}' did not come back");
        }

        [BeforeScenario]
        public void ForgetLooks() { Looks.Clear(); }
    }
}
