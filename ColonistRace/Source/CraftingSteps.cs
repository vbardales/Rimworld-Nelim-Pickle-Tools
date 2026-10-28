using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Reads of what a colonist's stats and the crafting recipes say: a stat value of a colonist, the default ingredient filter of a bill, the benches a
    /// recipe is offered at and what it requires. Written 2026-10-28 for PreciousStonesAndJewelryRenew. NOT PLAYED when written: compiled only.
    /// </summary>
    [PickleSteps]
    public class CraftingSteps
    {
        private static float StatOf(PickleContext ctx, string nickname, string statName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            StatDef stat = DefDatabase<StatDef>.GetNamedSilentFail(statName);
            ctx.Require(stat != null, $"no stat '{statName}' in this game");
            float value = pawn.GetStatValue(stat, true, -1);
            Log.Message($"[stat] {nickname} {statName} = {value:0.####}");
            return value;
        }

        /// <summary>Asserts a stat of a colonist (by <c>StatDef</c> name, such as SocialImpact) is above a number (strictly), reading the value the game computes now, equipment and apparel offsets included.</summary>
        [Then("Nelim's Pickle Tools: {string} stat {string} is above {float}")]
        public void StatAbove(PickleContext ctx, string nickname, string statName, float limit)
        {
            float value = StatOf(ctx, nickname, statName);
            ctx.Assert(value > limit, $"{nickname}'s stat {statName} should be above {limit}; it is {value:0.####}");
        }

        /// <summary>The same, strictly below a number.</summary>
        [Then("Nelim's Pickle Tools: {string} stat {string} is below {float}")]
        public void StatBelow(PickleContext ctx, string nickname, string statName, float limit)
        {
            float value = StatOf(ctx, nickname, statName);
            ctx.Assert(value < limit, $"{nickname}'s stat {statName} should be below {limit}; it is {value:0.####}");
        }

        // A recipe by its own defName, else the first recipe that makes the thing of that name.
        private static RecipeDef Recipe(PickleContext ctx, string name)
        {
            RecipeDef recipe = DefDatabase<RecipeDef>.GetNamedSilentFail(name)
                ?? DefDatabase<RecipeDef>.AllDefsListForReading.FirstOrDefault(r => r.products != null && r.products.Any(p => p.thingDef != null && p.thingDef.defName == name));
            ctx.Require(recipe != null, $"no recipe named '{name}' and none that makes a thing of that name");
            return recipe;
        }

        private static ThingDef Thing(PickleContext ctx, string name, string what)
        {
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(name);
            ctx.Require(def != null, $"no {what} '{name}' in this game");
            return def;
        }

        /// <summary>
        /// Asserts a NEW bill for the recipe (by recipe defName, or the name of the thing it makes) allows the ingredient <c>ThingDef</c> in its default
        /// ingredient filter: the filter a player sees when the bill is added. Reads the bill's own filter, not the recipe's list.
        /// </summary>
        [Then("Nelim's Pickle Tools: a bill for {string} allows {string}")]
        public void BillAllows(PickleContext ctx, string recipeName, string ingredientName)
        {
            bool allowed = BillAllowsIngredient(ctx, recipeName, ingredientName, out string allowedList);
            ctx.Assert(allowed, $"a new bill for {recipeName} should allow {ingredientName}; it allows {allowedList}");
        }

        /// <summary>The same, asserting the default filter does NOT allow the ingredient.</summary>
        [Then("Nelim's Pickle Tools: a bill for {string} does not allow {string}")]
        public void BillDoesNotAllow(PickleContext ctx, string recipeName, string ingredientName)
        {
            bool allowed = BillAllowsIngredient(ctx, recipeName, ingredientName, out string allowedList);
            ctx.Assert(!allowed, $"a new bill for {recipeName} should not allow {ingredientName}; it does (it allows {allowedList})");
        }

        private static bool BillAllowsIngredient(PickleContext ctx, string recipeName, string ingredientName, out string allowedList)
        {
            RecipeDef recipe = Recipe(ctx, recipeName);
            ThingDef ingredient = Thing(ctx, ingredientName, "ingredient");
            Bill bill = BillUtility.MakeNewBill(recipe);
            allowedList = string.Join(", ", bill.ingredientFilter.AllowedThingDefs.Select(d => d.defName));
            return bill.ingredientFilter.Allows(ingredient);
        }

        /// <summary>
        /// Asserts the recipe (by recipe defName, or the name of the thing it makes) is offered at the bench <c>ThingDef</c> (its recipe users, as the
        /// bench's bill tab lists them). Does not look at research: see the requires steps.
        /// </summary>
        [Then("Nelim's Pickle Tools: the recipe for {string} is available at {string}")]
        public void RecipeAvailableAt(PickleContext ctx, string recipeName, string benchName)
        {
            RecipeDef recipe = Recipe(ctx, recipeName);
            ThingDef bench = Thing(ctx, benchName, "bench");
            ctx.Assert(bench.AllRecipes.Contains(recipe), $"the recipe {recipe.defName} should be offered at {benchName}; the bench offers {string.Join(", ", bench.AllRecipes.Select(r => r.defName))}");
        }

        /// <summary>The same, asserting the recipe is NOT offered at that bench.</summary>
        [Then("Nelim's Pickle Tools: the recipe for {string} is not available at {string}")]
        public void RecipeNotAvailableAt(PickleContext ctx, string recipeName, string benchName)
        {
            RecipeDef recipe = Recipe(ctx, recipeName);
            ThingDef bench = Thing(ctx, benchName, "bench");
            ctx.Assert(!bench.AllRecipes.Contains(recipe), $"the recipe {recipe.defName} should not be offered at {benchName}; it is");
        }

        private static string[] Research(RecipeDef recipe)
        {
            var list = new System.Collections.Generic.List<ResearchProjectDef>();
            if (recipe.researchPrerequisite != null) list.Add(recipe.researchPrerequisite);
            if (recipe.researchPrerequisites != null) list.AddRange(recipe.researchPrerequisites);
            return list.Select(r => r.defName).Distinct().ToArray();
        }

        /// <summary>Asserts the recipe needs the research project (<c>ResearchProjectDef</c> name) among its prerequisites.</summary>
        [Then("Nelim's Pickle Tools: the recipe for {string} requires the research {string}")]
        public void RecipeRequiresResearch(PickleContext ctx, string recipeName, string researchName)
        {
            RecipeDef recipe = Recipe(ctx, recipeName);
            string[] research = Research(recipe);
            ctx.Assert(research.Contains(researchName), $"the recipe {recipe.defName} should require the research {researchName}; it requires {(research.Length == 0 ? "no research" : string.Join(", ", research))}");
        }

        /// <summary>Asserts the recipe has no research prerequisite.</summary>
        [Then("Nelim's Pickle Tools: the recipe for {string} requires no research")]
        public void RecipeRequiresNoResearch(PickleContext ctx, string recipeName)
        {
            RecipeDef recipe = Recipe(ctx, recipeName);
            string[] research = Research(recipe);
            ctx.Assert(research.Length == 0, $"the recipe {recipe.defName} should require no research; it requires {string.Join(", ", research)}");
        }

        /// <summary>Asserts the recipe needs at least this level of the skill (<c>SkillDef</c> name, such as Crafting).</summary>
        [Then("Nelim's Pickle Tools: the recipe for {string} requires the skill {string} at level {int}")]
        public void RecipeRequiresSkill(PickleContext ctx, string recipeName, string skillName, int level)
        {
            RecipeDef recipe = Recipe(ctx, recipeName);
            SkillRequirement found = recipe.skillRequirements?.FirstOrDefault(s => s.skill.defName == skillName);
            ctx.Assert(found != null && found.minLevel == level, $"the recipe {recipe.defName} should require {skillName} {level}; it requires {(recipe.skillRequirements == null || recipe.skillRequirements.Count == 0 ? "no skill" : string.Join(", ", recipe.skillRequirements.Select(s => s.skill.defName + " " + s.minLevel)))}");
        }
    }
}
