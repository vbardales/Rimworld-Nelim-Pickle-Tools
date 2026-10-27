// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-job-gallery.feature: first lot of the job pose catalogue (owner, 2026-10-25: one pose per job, with
// Show Me Your Tools): the jobs whose target can be staged with the steps that exist, on the bare clearing of the Sanctuary. One scenario, one shot per job,
// the game paused, `I advance the paused game by exactly N ticks` after the forced job so the pose is caught mid-gesture. Shots are named job-<JobDef>.
// A job whose forced start is refused (target, state) fails its step with the reason: that is a finding, not a defect of the catalogue.
// usage: node Docs/Generate-JobGallery.js   (map wsl-deps.look-gallery.map: Show Me Your Tools and Show Me Your Hands are staged)
const fs = require('fs');
const P = "Nelim's Pickle Tools: ";
// [job, target kind, setup lines, forced line, frame cell]
const plant = (job, def, x, z) => ({ job, setup: [`${P}I place the decor "${def}" at (${x}, ${z}) fully grown`], force: `${P}"Nelim" is forced into the job "${job}" on the plant at (${x}, ${z})`, frame: [x, z] });
const animal = (job, kind, name, x, z) => ({ job, setup: [`${P}an adult animal of kind "${kind}" named "${name}" is spawned at (${x}, ${z})`, `${P}the animal "${name}" is ready for the job "${job}"`], force: `${P}"Nelim" is forced into the job "${job}" on "${name}"`, frame: [x, z] });
const jobs = [
  plant('CutPlant', 'Plant_TreeOak', 192, 150), plant('Harvest', 'Plant_Rice', 197, 150),
  animal('Milk', 'Cow', 'Vache', 192, 154), animal('Shear', 'Sheep', 'Mouton', 197, 154),
  animal('Slaughter', 'Pig', 'Cochon', 192, 148), animal('Train', 'LabradorRetriever', 'Chien', 197, 148),
];
const pre = ['    Given the save "Nelims-tribe" is loaded', '    And game speed is paused',
  `    And ${P}the item and name labels are hidden`, `    And ${P}the tooltips are hidden`, `    And ${P}the colonist bar is hidden`, `    And ${P}the learning helper is hidden`,
  `    And ${P}the temperature of the map is 20 degrees`, '    And I set the hour to 12', '    And I set the weather to "Clear"',
  `    And ${P}the other colonists are out of frame`,
  `    And ${P}"Nelim" stands at (195, 152) facing South`, `    And ${P}"Nelim" facial expression is "normal"`];
const out = ['@requires:nelim.pickletools.screenshotstudio', '@requires:nelim.pickletools.colonistrace', '@requires:nelim.pickletools.camerazoom',
  'Feature: One pose per job, first lot (the job catalogue)', ''];
let n = 0;
for (const j of jobs) {   // one scenario per job: a refused start fails that scenario only
  n++;
  out.push(`  Scenario: job-gallery-${n}: ${j.job}`, ...pre);
  j.setup.forEach(l => out.push(`    And ${l}`));
  out.push(`    And ${j.force}`, `    And ${P}I advance the paused game by exactly 25 ticks`,
    `    And ${P}I frame the cell (${j.frame[0]}, ${j.frame[1]}) at zoom 4`, `    And ${P}I let 5 frames pass`, `    And I take a screenshot "job-${j.job}"`, '');
}
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-job-gallery.feature', out.join('\n'));
console.log(jobs.length + ' jobs');
