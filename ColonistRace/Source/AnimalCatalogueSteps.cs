using System.Linq;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Lists, in the log and in an attachment, every animal kind of the loaded game with its mod: the registry an animal photo pass is built from.
    /// Written 2026-10-30 at the request of AnimalsNaturally (Virginie's order: face, back and profile of every animal of every mod). Not played here.
    /// </summary>
    [PickleSteps]
    public class AnimalCatalogueSteps
    {
        /// <summary>
        /// Logs (<c>[animal-kind]</c>, one line per kind, tab separated) the mod name, its packageId, the PawnKindDef defName, the race ThingDef
        /// defName, the label and the baseBodySize of every kind whose race is an animal, and attaches the same lines as <c>animal-kinds</c>. Sorted by
        /// mod then defName. Never fails. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the animal kinds are listed")]
        public void ListAnimalKinds(PickleContext ctx)
        {
            var rows = DefDatabase<PawnKindDef>.AllDefsListForReading
                .Where(k => k.race != null && k.race.race != null && k.race.race.Animal)
                .OrderBy(k => k.modContentPack?.Name ?? "(none)").ThenBy(k => k.defName)
                .Select(k => string.Join("\t", new[]
                {
                    k.modContentPack?.Name ?? "(none)",
                    k.modContentPack?.PackageId ?? "(none)",
                    k.defName,
                    k.race.defName,
                    k.label ?? k.race.label ?? "",
                    k.race.race.baseBodySize.ToString("0.###", System.Globalization.CultureInfo.InvariantCulture),
                }))
                .ToList();
            foreach (string row in rows) Log.Message("[animal-kind] " + row);
            Log.Message("[animal-kind] total " + rows.Count);
            ctx.Attach("animal-kinds", "mod\tpackageId\tkind\trace\tlabel\tbaseBodySize\n" + string.Join("\n", rows));
        }
    }
}
