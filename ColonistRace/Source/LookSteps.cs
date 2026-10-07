using System;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that dress a colonist for a gallery capture: any hairstyle and hair colour, face and body tattoos, and the colour of a
    /// worn garment. Each sets the value, redraws the pawn and reads it back, failing with what it found. Colours are RGB 0 to 255.
    ///
    /// Written on 2026-10-02 for CrystalBall's staged workshop captures (its session, at Virginie's request). NOT PLAYED: compiled
    /// against the reference assemblies only. Tattoos need the Ideology DLC (a pawn has no style tracker without it).
    /// </summary>
    [PickleSteps]
    public class LookSteps
    {
        /// <summary>Gives a colonist a hairstyle by <c>HairDef</c> name and redraws it. The hair colour is left as it is.</summary>
        [Given("Nelim's Pickle Tools: {string} hairstyle is {string}")]
        public void SetHairstyle(PickleContext ctx, string nickname, string hairDefName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story != null, $"pawn '{nickname}' has no story, so it has no hairstyle");
            pawn.story.hairDef = Def<HairDef>(ctx, hairDefName, "hairstyle");
            Redraw(pawn);
            ctx.Assert(
                pawn.story.hairDef.defName == hairDefName,
                $"{nickname} should wear the hairstyle {hairDefName}; it wears {pawn.story.hairDef?.defName ?? "(none)"}");
        }

        /// <summary>
        /// Gives a colonist any hair colour, RGB 0 to 255, and redraws it. The game multiplies the hairstyle texture by this colour; the
        /// step that lets a hairstyle show its own colours is the white case. A colour forced on top by an effect such as a gene is not
        /// undone: the step reads the colour back and fails saying what the game reports.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} hair colour is rgb \\({int}, {int}, {int}\\)")]
        public void SetHairColour(PickleContext ctx, string nickname, int r, int g, int b)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story != null, $"pawn '{nickname}' has no story, so it has no hair colour");
            Color wanted = Rgb(ctx, r, g, b);
            pawn.story.HairColor = wanted;
            Redraw(pawn);
            Color read = pawn.story.HairColor;
            ctx.Assert(
                Near(read, wanted),
                $"{nickname}'s hair colour should read {wanted}; it reads {read}. Something forces a colour on top of it (a gene?)");
        }

        /// <summary>
        /// Gives a colonist a face tattoo by <c>TattooDef</c> name, or <c>none</c> to remove it, and redraws it. Needs Ideology. The tattoo
        /// must belong to the face: the game's own face tattoos are the ones whose <c>tattooType</c> is Face.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} face tattoo is {string}")]
        public void SetFaceTattoo(PickleContext ctx, string nickname, string tattooName)
        {
            Pawn pawn = Styled(ctx, nickname);
            TattooDef wanted = Tattoo(ctx, tattooName, TattooType.Face) ?? TattooDefOf.NoTattoo_Face;
            pawn.style.FaceTattoo = wanted;
            Redraw(pawn);
            ctx.Assert(
                pawn.style.FaceTattoo == wanted,
                $"{nickname} should have the face tattoo {wanted.defName}; it has {pawn.style.FaceTattoo?.defName ?? "(none)"}");
        }

        /// <summary>Gives a colonist a body tattoo by <c>TattooDef</c> name, or <c>none</c> to remove it, and redraws it. Needs Ideology.</summary>
        [Given("Nelim's Pickle Tools: {string} body tattoo is {string}")]
        public void SetBodyTattoo(PickleContext ctx, string nickname, string tattooName)
        {
            Pawn pawn = Styled(ctx, nickname);
            TattooDef wanted = Tattoo(ctx, tattooName, TattooType.Body) ?? TattooDefOf.NoTattoo_Body;
            pawn.style.BodyTattoo = wanted;
            Redraw(pawn);
            ctx.Assert(
                pawn.style.BodyTattoo == wanted,
                $"{nickname} should have the body tattoo {wanted.defName}; it has {pawn.style.BodyTattoo?.defName ?? "(none)"}");
        }

        /// <summary>
        /// Dyes a garment the colonist wears, by apparel def name, in an RGB colour 0 to 255, and redraws the pawn. Fails if the colonist
        /// does not wear it, or if the garment cannot be coloured (no colour comp, as for apparel drawn from its stuff alone).
        /// </summary>
        [Given("Nelim's Pickle Tools: the {string} worn by {string} is dyed rgb \\({int}, {int}, {int}\\)")]
        public void DyeApparel(PickleContext ctx, string apparelDefName, string nickname, int r, int g, int b)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.apparel != null, $"pawn '{nickname}' has no apparel tracker");
            Apparel apparel = pawn.apparel.WornApparel.FirstOrDefault(a => a.def.defName == apparelDefName);
            ctx.Require(
                apparel != null,
                $"{nickname} does not wear '{apparelDefName}'; it wears {string.Join(", ", pawn.apparel.WornApparel.Select(a => a.def.defName))}");
            Color wanted = Rgb(ctx, r, g, b);
            apparel.DesiredColor = wanted;
            apparel.SetColor(wanted, false);  // the colour comp keeps its own colour (a fresh garment draws a random one), DesiredColor alone does not replace it
            apparel.Notify_ColorChanged();
            Redraw(pawn);
            Color read = apparel.DrawColor;
            ctx.Assert(
                Near(read, wanted),
                $"the {apparelDefName} worn by {nickname} should be drawn in {wanted}; it is drawn in {read} (a garment with no colour comp, or a stuff colour that wins)");
        }

        private static readonly System.Collections.Generic.Dictionary<Pawn, System.Collections.Generic.List<Apparel>> DroppedClothes =
            new System.Collections.Generic.Dictionary<Pawn, System.Collections.Generic.List<Apparel>>();

        /// <summary>Takes every garment off with the game's own drop (Pawn_ApparelTracker.TryDrop: the same Thing is placed on the ground, as the bath job does) and remembers them for the step that checks their colour.</summary>
        [Given("Nelim's Pickle Tools: {string} drops its clothes")]
        public void DropsClothes(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.apparel != null, $"pawn '{nickname}' has no apparel tracker");
            var dropped = new System.Collections.Generic.List<Apparel>();
            foreach (Apparel worn in pawn.apparel.WornApparel.ToList())
            {
                Color before = worn.DrawColor;
                if (!pawn.apparel.TryDrop(worn, out Apparel result, pawn.Position, false)) continue;
                dropped.Add(result);
                Log.Message($"[drop] {worn.def.defName}: same Thing {ReferenceEquals(worn, result)}, id {result.thingIDNumber}, colour comp active {result.TryGetComp<CompColorable>()?.Active}, DrawColor {before} -> {result.DrawColor}, ground graphic colour {result.Graphic?.Color}");
            }
            DroppedClothes[pawn] = dropped;
            Redraw(pawn);
        }

        /// <summary>Reads a garment dropped by the step above: its DrawColor must be the colour asked for. (Graphic.Color reads white even when the ground picture is dyed: run fd04 photo, so it is only logged.)</summary>
        [Then("Nelim's Pickle Tools: the {string} dropped by {string} is drawn in rgb \\({int}, {int}, {int}\\)")]
        public void DroppedIsDyed(PickleContext ctx, string apparelDefName, string nickname, int r, int g, int b)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(DroppedClothes.TryGetValue(pawn, out var list), $"{nickname} dropped nothing: use the step '{nickname} drops its clothes' first");
            Apparel a = list.FirstOrDefault(x => x.def.defName == apparelDefName);
            ctx.Require(a != null, $"{nickname} did not drop '{apparelDefName}'; dropped: {string.Join(", ", list.Select(x => x.def.defName))}");
            Color wanted = Rgb(ctx, r, g, b);
            ctx.Assert(Near(a.DrawColor, wanted), $"the dropped {apparelDefName} should have DrawColor {wanted}; it has {a.DrawColor}");
        }

        // What could explain a colour other than the one asked for, listed in the failure message.
        private static string ColourFacts(Pawn pawn, Apparel apparel) =>
            $"[desired {apparel.DesiredColor}, stuff {apparel.Stuff?.defName ?? "(none)"} {apparel.Stuff?.stuffProps?.color}, favourite colour {pawn.story?.favoriteColor}, ideo colour {pawn.Ideo?.Color}, colour comp {apparel.TryGetComp<CompColorable>() != null}, layers {string.Join("/", apparel.def.apparel.layers.Select(l => l.defName))}, worn: {string.Join(", ", pawn.apparel.WornApparel.Select(a => a.def.defName + " " + a.DrawColor))}]";

        // What each pawn wore before a step dressed it, by the pawn itself: the original items are moved to the inventory (not destroyed) so
        // they can be put back. After a reload the pawn is another object and the entry is simply unused.
        private static readonly System.Collections.Generic.Dictionary<Pawn, System.Collections.Generic.List<Apparel>> OriginalClothes =
            new System.Collections.Generic.Dictionary<Pawn, System.Collections.Generic.List<Apparel>>();
        private static readonly System.Collections.Generic.List<Apparel> DressedIn = new System.Collections.Generic.List<Apparel>();

        /// <summary>
        /// Dresses a colonist in a garment of the def, dyed in an RGB colour 0 to 255: makes it of its default stuff, moves the garments
        /// that cannot be worn with it (same layer and body parts) to the inventory, wears it and dyes it, then reads the colour back.
        /// What the colonist wore is remembered once, for the step that gives it back.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} wears {string} dyed rgb \\({int}, {int}, {int}\\)")]
        public void WearsDyed(PickleContext ctx, string nickname, string apparelDefName, int r, int g, int b)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.apparel != null, $"pawn '{nickname}' has no apparel tracker");
            ThingDef def = Def<ThingDef>(ctx, apparelDefName, "apparel");
            ctx.Require(def.IsApparel, $"'{apparelDefName}' is not an apparel def");
            ctx.Require(ApparelUtility.HasPartsToWear(pawn, def), $"{nickname} has no body part to wear '{apparelDefName}' on");
            Color wanted = Rgb(ctx, r, g, b);

            if (!OriginalClothes.ContainsKey(pawn))
            {
                // The first garment dressed in a scenario takes everything else off first (an outer cloak would hide the new shirt); the next ones add to it.
                OriginalClothes[pawn] = pawn.apparel.WornApparel.ToList();
                StowApparel(pawn, a => true);
            }

            StowApparel(pawn, a => !ApparelUtility.CanWearTogether(a.def, def, pawn.RaceProps.body));
            var apparel = (Apparel)ThingMaker.MakeThing(def, def.MadeFromStuff ? GenStuff.DefaultStuffFor(def) : null);
            pawn.apparel.Wear(apparel, false);
            DressedIn.Add(apparel);
            apparel.DesiredColor = wanted;
            apparel.SetColor(wanted, false);  // the colour comp keeps its own colour (a fresh garment draws a random one), DesiredColor alone does not replace it
            apparel.Notify_ColorChanged();
            Redraw(pawn);

            ctx.Assert(
                pawn.apparel.WornApparel.Contains(apparel),
                $"{nickname} should wear '{apparelDefName}'; it wears {string.Join(", ", pawn.apparel.WornApparel.Select(a => a.def.defName))}");
            Color read = apparel.DrawColor;
            ctx.Assert(Near(read, wanted), $"the {apparelDefName} worn by {nickname} should be drawn in {wanted}; it is drawn in {read}. " + ColourFacts(pawn, apparel));
        }

        /// <summary>
        /// Takes off what the dyed-clothes step made and puts back what the colonist wore before. Does nothing for a colonist that step never
        /// dressed. Also run after every scenario, so a failed one leaves the colonist as it found it.
        /// </summary>
        /// <summary>
        /// Takes every garment off a colonist (to the inventory, nothing destroyed), so the garments dressed afterwards are the only ones drawn, an
        /// outer cloak no longer covering a shirt. "gets back the clothes it had" puts them on again, and so does the end of the scenario.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} is undressed")]
        [When("Nelim's Pickle Tools: I undress {string}")]
        public void Undress(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.apparel != null, $"pawn '{nickname}' has no apparel tracker");
            if (!OriginalClothes.ContainsKey(pawn)) OriginalClothes[pawn] = pawn.apparel.WornApparel.ToList();
            StowApparel(pawn, a => true);
            pawn.Drawer.renderer.SetAllGraphicsDirty();
        }

        [When("Nelim's Pickle Tools: {string} gets back the clothes it had")]
        public void GetsBack(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Restore(pawn);
        }

        [AfterScenario]
        public void RestoreAll(PickleContext ctx)
        {
            foreach (Pawn pawn in OriginalClothes.Keys.ToList())
            {
                if (!pawn.Destroyed && pawn.apparel != null)
                {
                    Restore(pawn);
                }
            }

            OriginalClothes.Clear();
            DressedIn.Clear();
        }

        // Takes garments off into the inventory, never onto the ground: a garment dropped where the colonist stands shows up beside whatever the scene is about.
        private static void StowApparel(Pawn pawn, System.Func<Apparel, bool> which)
        {
            foreach (Apparel a in pawn.apparel.WornApparel.Where(which).ToList())
            {
                pawn.apparel.Remove(a);
                if (pawn.inventory == null || !pawn.inventory.innerContainer.TryAdd(a, false)) a.Destroy();
            }
        }

        private static void Restore(Pawn pawn)
        {
            if (!OriginalClothes.TryGetValue(pawn, out System.Collections.Generic.List<Apparel> original))
            {
                return;
            }

            foreach (Apparel made in DressedIn.Where(a => pawn.apparel.WornApparel.Contains(a)).ToList())
            {
                pawn.apparel.Remove(made);
                made.Destroy();
            }

            foreach (Apparel old in original)
            {
                if (old.Destroyed || pawn.apparel.WornApparel.Contains(old))
                {
                    continue;
                }

                if (pawn.inventory != null && pawn.inventory.innerContainer.Contains(old))
                {
                    pawn.inventory.innerContainer.Remove(old);
                }

                if (ApparelUtility.HasPartsToWear(pawn, old.def))
                {
                    pawn.apparel.Wear(old, false);
                }
            }

            OriginalClothes.Remove(pawn);
            Redraw(pawn);
        }

        /// <summary>
        /// Puts a colonist on a cell of the current map, stops its job and its walking, and keeps it where it stands: the pawn stays
        /// put as long as the game is paused (Pickle's own <c>game speed is paused</c>) and as long as nothing gives it a job. Fails if the
        /// cell is off the map or not standable.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} stands at \\({int}, {int}\\)")]
        public void StandsAt(PickleContext ctx, string nickname, int x, int z)
        {
            Place(ctx, nickname, x, z, null);
        }

        /// <summary>The same, and turns the colonist to face North, East, South or West (what the renderer draws it looking at).</summary>
        [Given("Nelim's Pickle Tools: {string} stands at \\({int}, {int}\\) facing {word}")]
        public void StandsAtFacing(PickleContext ctx, string nickname, int x, int z, string direction)
        {
            Rot4 facing;
            switch (direction.ToLowerInvariant())
            {
                case "north":
                    facing = Rot4.North;
                    break;
                case "east":
                    facing = Rot4.East;
                    break;
                case "south":
                    facing = Rot4.South;
                    break;
                case "west":
                    facing = Rot4.West;
                    break;
                default:
                    throw new ArgumentException($"unknown direction '{direction}'; supported: North, East, South, West");
            }

            Place(ctx, nickname, x, z, facing);
        }

        /// <summary>
        /// Puts an ANIMAL (any spawned pawn that is not a free colonist, found by its short name, e.g. the <c>coat-N</c> names) on a standable
        /// cell, stops it and keeps it there while the game is paused. Same checks and read-back as the colonist step.
        /// </summary>
        [Given("Nelim's Pickle Tools: the animal {string} stands at \\({int}, {int}\\)")]
        public void AnimalStandsAt(PickleContext ctx, string name, int x, int z)
        {
            Place(ctx, name, x, z, null, true);
        }

        /// <summary>The same, turned North, East, South or West.</summary>
        [Given("Nelim's Pickle Tools: the animal {string} stands at \\({int}, {int}\\) facing {word}")]
        public void AnimalStandsAtFacing(PickleContext ctx, string name, int x, int z, string direction)
        {
            Place(ctx, name, x, z, Direction(direction), true);
        }

        /// <summary>Turns a pawn (colonist or animal, found by its short name) where it stands, without moving it.</summary>
        [Given("Nelim's Pickle Tools: {string} faces {word}")]
        public void Faces(PickleContext ctx, string name, string direction)
        {
            Pawn pawn = AnyPawn(ctx, name);
            Rot4 facing = Direction(direction);
            pawn.Rotation = facing;
            Redraw(pawn);
            ctx.Assert(pawn.Rotation == facing, $"{name} should face {facing}; it faces {pawn.Rotation}");
        }

        /// <summary>
        /// Puts one item in the hands of a pawn (colonist or animal, found by its short name), as a hauler carries it: the thing is made from the
        /// def and held by the carry tracker, which draws it on the pawn. Holds while the game is paused and nothing gives the pawn a job; a pawn
        /// already carrying something drops it first. Fails on an unknown def or when the pawn cannot carry it.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} carries the item {string}")]
        public void CarriesItem(PickleContext ctx, string name, string defName)
        {
            CarryItems(ctx, name, 1, defName);
        }

        /// <summary>The same, with a stack of {int} items.</summary>
        [Given("Nelim's Pickle Tools: {string} carries {int} of the item {string}")]
        public void CarriesItems(PickleContext ctx, string name, int count, string defName)
        {
            CarryItems(ctx, name, count, defName);
        }

        private static void CarryItems(PickleContext ctx, string name, int count, string defName)
        {
            Pawn pawn = AnyPawn(ctx, name);
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThingDef named '{defName}'");
            ctx.Require(pawn.carryTracker != null, $"{name} has no carry tracker");
            if (pawn.carryTracker.CarriedThing != null) pawn.carryTracker.DestroyCarriedThing();
            Thing thing = ThingMaker.MakeThing(def);
            int wanted = Math.Max(1, Math.Min(count, def.stackLimit));
            thing.stackCount = wanted;
            int carried = pawn.carryTracker.TryStartCarry(thing, wanted, true);
            ctx.Assert(carried > 0 && pawn.carryTracker.CarriedThing != null, $"{name} could not carry {wanted} {defName}");
            Redraw(pawn);
        }

        private static Rot4 Direction(string direction)
        {
            switch (direction.ToLowerInvariant())
            {
                case "north":
                    return Rot4.North;
                case "east":
                    return Rot4.East;
                case "south":
                    return Rot4.South;
                case "west":
                    return Rot4.West;
                default:
                    throw new ArgumentException($"unknown direction '{direction}'; supported: North, East, South, West");
            }
        }

        private static Pawn AnyPawn(PickleContext ctx, string name)
        {
            Pawn pawn = Find.Maps.SelectMany(m => m.mapPawns.AllPawnsSpawned)
                .FirstOrDefault(p => p.Name != null && string.Equals(p.Name.ToStringShort, name, StringComparison.OrdinalIgnoreCase));
            ctx.Require(pawn != null, $"no spawned pawn named '{name}' on any map");
            return pawn;
        }

        private static void Place(PickleContext ctx, string nickname, int x, int z, Rot4? facing, bool anyPawn = false)
        {
            Pawn pawn = anyPawn ? AnyPawn(ctx, nickname) : ColonistLookup.Require(nickname);
            Map map = pawn.Map ?? Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map, which is {map.Size.x} by {map.Size.z}");
            ctx.Require(cell.Standable(map), $"the cell ({x}, {z}) is not standable");

            if (pawn.Spawned)
            {
                pawn.jobs?.StopAll();
                pawn.pather?.StopDead();
                pawn.Position = cell;
                pawn.Notify_Teleported(true, true);
            }
            else
            {
                GenSpawn.Spawn(pawn, cell, map);
            }

            if (facing.HasValue)
            {
                pawn.Rotation = facing.Value;
            }

            Subjects.Add(pawn);
            Redraw(pawn);
            ctx.Assert(
                pawn.Position == cell,
                $"{nickname} should stand at ({x}, {z}); it stands at {pawn.Position}");
            if (facing.HasValue)
            {
                ctx.Assert(pawn.Rotation == facing.Value, $"{nickname} should face {facing.Value}; it faces {pawn.Rotation}");
            }
        }

        /// <summary>
        /// Takes a colonist off the map (despawns it) so it is not in the picture, e.g. the actors a studio fixture puts on the camera cell.
        /// The pawn is not destroyed; a reload brings the fixture back as it was. Fails if the colonist is not on a map.
        /// </summary>
        [Given("Nelim's Pickle Tools: the colonist {string} is removed from the map")]
        public void RemoveFromMap(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.Spawned, $"{nickname} is not on a map");
            pawn.DeSpawn();
            ctx.Assert(!pawn.Spawned, $"{nickname} should be off the map; it is still at {pawn.Position}");
        }

        /// <summary>
        /// Dresses a colonist in a new garment of the apparel def, undyed, in the same way as the dyed step: the garments that cannot be
        /// worn with it go to the inventory, and the clothes it had come back with the step that gives them back.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} wears {string}")]
        public void Wears(PickleContext ctx, string nickname, string apparelDefName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.apparel != null, $"pawn '{nickname}' has no apparel tracker");
            ThingDef def = Def<ThingDef>(ctx, apparelDefName, "apparel");
            ctx.Require(def.IsApparel, $"'{apparelDefName}' is not an apparel def");
            ctx.Require(ApparelUtility.HasPartsToWear(pawn, def), $"{nickname} has no body part to wear '{apparelDefName}' on");

            if (!OriginalClothes.ContainsKey(pawn))
            {
                // The first garment dressed in a scenario takes everything else off first (an outer cloak would hide the new shirt); the next ones add to it.
                OriginalClothes[pawn] = pawn.apparel.WornApparel.ToList();
                StowApparel(pawn, a => true);
            }

            StowApparel(pawn, a => !ApparelUtility.CanWearTogether(a.def, def, pawn.RaceProps.body));
            var apparel = (Apparel)ThingMaker.MakeThing(def, def.MadeFromStuff ? GenStuff.DefaultStuffFor(def) : null);
            pawn.apparel.Wear(apparel, false);
            DressedIn.Add(apparel);
            Redraw(pawn);
            ctx.Assert(
                pawn.apparel.WornApparel.Contains(apparel),
                $"{nickname} should wear '{apparelDefName}'; it wears {string.Join(", ", pawn.apparel.WornApparel.Select(a => a.def.defName))}");
        }

        /// <summary>Gives a colonist a head (a <c>HeadTypeDef</c> name, e.g. Male_AverageNormal) and redraws it. The def must suit the colonist's gender.</summary>
        [Given("Nelim's Pickle Tools: {string} head type is {string}")]
        public void SetHeadType(PickleContext ctx, string nickname, string headDefName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story != null, $"pawn '{nickname}' has no story, so it has no head");
            HeadTypeDef def = Def<HeadTypeDef>(ctx, headDefName, "head type");
            ctx.Require(
                def.gender == Gender.None || def.gender == pawn.gender,
                $"the head type '{headDefName}' is for {def.gender}; {nickname} is {pawn.gender}");
            pawn.story.headType = def;
            Redraw(pawn);
            ctx.Assert(pawn.story.headType == def, $"{nickname} should have the head {headDefName}; it has {pawn.story.headType?.defName ?? "(none)"}");
        }

        /// <summary>
        /// Gives a colonist a beard (a <c>BeardDef</c> name) or <c>none</c>, and redraws it. Refuses a beard for a pawn that has no style
        /// tracker. The failure lists the valid beard defs.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} beard is {string}")]
        public void SetBeard(PickleContext ctx, string nickname, string beardName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.style != null, $"pawn '{nickname}' has no style tracker, so it has no beard");
            BeardDef wanted = string.Equals(beardName, "none", StringComparison.OrdinalIgnoreCase)
                ? BeardDefOf.NoBeard
                : Def<BeardDef>(ctx, beardName, "beard");
            pawn.style.beardDef = wanted;
            Redraw(pawn);
            ctx.Assert(pawn.style.beardDef == wanted, $"{nickname} should have the beard {wanted.defName}; it has {pawn.style.beardDef?.defName ?? "(none)"}");
        }

        // The colonists a staging step put somewhere (stands at) are the subjects of the picture; everyone else is moved out of it.
        private static readonly System.Collections.Generic.HashSet<Pawn> Subjects = new System.Collections.Generic.HashSet<Pawn>();
        private static readonly System.Collections.Generic.Dictionary<Pawn, IntVec3> Moved = new System.Collections.Generic.Dictionary<Pawn, IntVec3>();

        /// <summary>
        /// Moves every colonist that no "stands at" step has placed in this scenario to a standable cell far from the camera (the corner
        /// of the map farthest from the first subject, or the map's far corner when there is none), so the studio's actors are out of the
        /// picture. Each is put back where it stood after the scenario. Fails if a colonist finds no cell.
        /// </summary>
        [Given("Nelim's Pickle Tools: the other colonists are out of frame")]
        public void OthersOutOfFrame(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            IntVec3 anchor = Subjects.FirstOrDefault(p => p.Spawned)?.Position ?? map.Center;
            IntVec3 far = new IntVec3(anchor.x < map.Size.x / 2 ? map.Size.x - 6 : 5, 0, anchor.z < map.Size.z / 2 ? map.Size.z - 6 : 5);
            foreach (Pawn pawn in map.mapPawns.FreeColonistsSpawned.Where(p => !Subjects.Contains(p)).ToList())
            {
                // Widen the search when the far corner is dense (the Sanctuary's corners are bamboo forest), then take any standable cell at least 40 cells from the subject.
                IntVec3 cell = IntVec3.Invalid;
                bool found = false;
                foreach (int radius in new[] { 12, 40, 100 })
                    if (found = CellFinder.TryFindRandomCellNear(far, map, radius, c => c.Standable(map) && c.GetFirstPawn(map) == null, out cell, 200)) break;
                if (!found)
                    found = CellFinder.TryFindRandomCell(map, c => c.Standable(map) && c.GetFirstPawn(map) == null && c.DistanceTo(anchor) >= 40f, out cell);
                ctx.Require(found, $"no standable cell near {far} or 40 cells from {anchor} to send {pawn.LabelShort} to");
                Moved[pawn] = pawn.Position;
                pawn.jobs?.StopAll();
                pawn.pather?.StopDead();
                pawn.Position = cell;
                pawn.Notify_Teleported(true, true);
            }
        }

        [AfterScenario]
        public void PutBackOthers(PickleContext ctx)
        {
            foreach (var pair in Moved.ToList())
            {
                if (pair.Key.Spawned && !pair.Key.Destroyed)
                {
                    pair.Key.Position = pair.Value;
                    pair.Key.Notify_Teleported(true, true);
                }
            }

            Moved.Clear();
            Subjects.Clear();
        }

        private static Pawn Styled(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(ModsConfig.IdeologyActive, "tattoos need the Ideology DLC, and it is not active in this run");
            ctx.Require(pawn.style != null, $"pawn '{nickname}' has no style tracker, so it has no tattoo");
            return pawn;
        }

        private static TattooDef Tattoo(PickleContext ctx, string name, TattooType type)
        {
            if (string.Equals(name, "none", StringComparison.OrdinalIgnoreCase))
            {
                return null;
            }

            TattooDef def = Def<TattooDef>(ctx, name, "tattoo");
            ctx.Require(def.tattooType == type, $"the tattoo '{name}' is a {def.tattooType} tattoo, not a {type} one");
            return def;
        }

        private static T Def<T>(PickleContext ctx, string defName, string what) where T : Def
        {
            T def = DefDatabase<T>.GetNamedSilentFail(defName);
            ctx.Require(
                def != null,
                $"no {what} '{defName}' in this game; the {what}s are {string.Join(", ", DefDatabase<T>.AllDefsListForReading.Select(d => d.defName))}");
            return def;
        }

        private static Color Rgb(PickleContext ctx, int r, int g, int b)
        {
            ctx.Require(
                r >= 0 && r <= 255 && g >= 0 && g <= 255 && b >= 0 && b <= 255,
                $"a colour is RGB 0 to 255, not ({r}, {g}, {b})");
            return new Color(r / 255f, g / 255f, b / 255f, 1f);
        }

        private static bool Near(Color a, Color b)
        {
            return Mathf.Abs(a.r - b.r) < 0.01f && Mathf.Abs(a.g - b.g) < 0.01f && Mathf.Abs(a.b - b.b) < 0.01f;
        }

        private static void Redraw(Pawn pawn)
        {
            pawn.Drawer.renderer.SetAllGraphicsDirty();
        }
    }
}
