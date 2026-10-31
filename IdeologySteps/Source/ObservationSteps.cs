using System;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.IdeologySteps
{
    /// <summary>
    /// Steps that read what happened: the interaction modes the prisoner tab offers for a prisoner,
    /// and the job a colonist is doing. Each waits for the state, since it may come a few frames or ticks after the action.
    /// </summary>
    [PickleSteps]
    public class ObservationSteps
    {
        private const float WaitSeconds = 10f;

        /// <summary>
        /// Asserts that the prisoner tab lists the interaction mode for this prisoner. The test is the game's own: the local
        /// function of ITab_Pawn_Visitor.DoPrisonerTab that decides which rows the tab draws, called by reflection, not a copy.
        /// </summary>
        [Then("Nelim's Pickle Tools: the prisoner {string} is offered the interaction mode {string}", TimeoutSeconds = 15f)]
        public async Task IsOffered(PickleContext ctx, string nickname, string modeName)
        {
            await AssertOffered(ctx, nickname, modeName, true);
        }

        /// <summary>Asserts that the prisoner tab does not list the interaction mode for this prisoner (same test as the step that asserts it is offered).</summary>
        [Then("Nelim's Pickle Tools: the prisoner {string} is not offered the interaction mode {string}", TimeoutSeconds = 15f)]
        public async Task IsNotOffered(PickleContext ctx, string nickname, string modeName)
        {
            await AssertOffered(ctx, nickname, modeName, false);
        }

        private static async Task AssertOffered(PickleContext ctx, string nickname, string modeName, bool expected)
        {
            Pawn pawn = Lookups.RequirePawn(ctx, nickname);
            ctx.Require(pawn.IsPrisonerOfColony, $"pawn '{nickname}' is not a prisoner of the colony, so the prisoner tab offers it nothing");
            PrisonerInteractionModeDef mode = Lookups.RequireDef<PrisonerInteractionModeDef>(ctx, modeName, "interaction mode");
            OfferTest test = OfferTest.Resolve(ctx);

            await ctx.AssertEventually(
                () => test.Offered(pawn, mode) == expected,
                () => $"the prisoner tab should {(expected ? string.Empty : "not ")}offer the interaction mode '{modeName}' for '{nickname}' within {WaitSeconds} seconds; " +
                    $"it offers {string.Join(", ", DefDatabase<PrisonerInteractionModeDef>.AllDefsListForReading.Where(d => test.Offered(pawn, d)).Select(d => d.defName))}",
                WaitSeconds);
        }

        /// <summary>Asserts that the job a colonist is doing now is this JobDef, by defName, waiting up to 30 seconds for it.</summary>
        [Then("Nelim's Pickle Tools: the colonist {string} is doing the job {string}", TimeoutSeconds = 35f)]
        public async Task IsDoing(PickleContext ctx, string nickname, string jobName)
        {
            Pawn pawn = Lookups.RequirePawn(ctx, nickname);
            Lookups.RequireDef<JobDef>(ctx, jobName, "job");

            await ctx.AssertEventually(
                () => pawn.CurJobDef != null && string.Equals(pawn.CurJobDef.defName, jobName, StringComparison.OrdinalIgnoreCase),
                () => $"the colonist '{nickname}' should be doing the job '{jobName}' within 30 seconds; it is doing '{pawn.CurJobDef?.defName ?? "(no job)"}'" +
                    $"{(pawn.CurJob?.targetA.Thing != null ? " on " + pawn.CurJob.targetA.Thing.LabelShort : string.Empty)}",
                30f);
        }

        /// <summary>The game's own test for a row of the prisoner tab, found by name in the compiler-generated closure of DoPrisonerTab.</summary>
        private sealed class OfferTest
        {
            private static OfferTest cached;

            private readonly MethodInfo method;
            private readonly Type closure;
            private readonly FieldInfo wildMan;
            private readonly FieldInfo owner;
            private readonly object tab;

            private OfferTest(MethodInfo method, Type closure, FieldInfo wildMan, FieldInfo owner, object tab)
            {
                this.method = method;
                this.closure = closure;
                this.wildMan = wildMan;
                this.owner = owner;
                this.tab = tab;
            }

            public static OfferTest Resolve(PickleContext ctx)
            {
                if (cached != null)
                {
                    return cached;
                }

                const BindingFlags all = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;
                foreach (Type nested in typeof(ITab_Pawn_Visitor).GetNestedTypes(BindingFlags.NonPublic | BindingFlags.Public))
                {
                    MethodInfo m = nested.GetMethods(all).FirstOrDefault(x => x.Name.Contains("CanUsePrisonerInteractionMode"));
                    if (m == null)
                    {
                        continue;
                    }

                    ParameterInfo[] p = m.GetParameters();
                    FieldInfo wild = nested.GetField("wildMan", all);
                    FieldInfo self = nested.GetFields(all).FirstOrDefault(f => f.FieldType == typeof(ITab_Pawn_Visitor));
                    ctx.Require(
                        !m.IsStatic && p.Length == 2 && p[0].ParameterType == typeof(Pawn) && p[1].ParameterType == typeof(PrisonerInteractionModeDef) && wild != null && self != null,
                        "the test of the prisoner tab changed shape in this game build (expected a closure with a wildMan field and a reference to the tab, and a method taking a Pawn and a PrisonerInteractionModeDef); this tool has to follow");
                    // The closure keeps a reference to the tab, which the test uses only to ask whether the colony has a bloodfeeder.
                    Type concrete = typeof(ITab_Pawn_Visitor).Assembly.GetTypes().FirstOrDefault(t => t.IsSubclassOf(typeof(ITab_Pawn_Visitor)) && !t.IsAbstract);
                    ctx.Require(concrete != null, "no concrete subclass of ITab_Pawn_Visitor in this game build, so no tab to hand to the test of the prisoner tab; this tool has to follow");
                    cached = new OfferTest(m, nested, wild, self, Activator.CreateInstance(concrete));
                    return cached;
                }

                ctx.Require(false, "ITab_Pawn_Visitor has no nested closure with a CanUsePrisonerInteractionMode method in this game build: the game moved it, this tool has to follow");
                return null;
            }

            public bool Offered(Pawn pawn, PrisonerInteractionModeDef mode)
            {
                object instance = Activator.CreateInstance(closure, true);
                wildMan.SetValue(instance, WildManUtility.IsWildMan(pawn));
                owner.SetValue(instance, tab);
                return (bool)method.Invoke(instance, new object[] { pawn, mode });
            }
        }
    }
}
