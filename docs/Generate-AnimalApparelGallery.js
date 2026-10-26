// Writes ColonistRace/docs/CATALOGUE-ANIMAL-APPAREL.md and Tests/Pickle/Mod/Pickle/Features/pickletools-animal-apparel-gallery.feature: one photograph per
// garment of Animal Apparel Collars and Kit Renew (read from its Defs), worn by the first animal the def itself lists as a host (descriptionHyperlinks;
// Husky when it lists none). Shots: animalapparel-<defName>. Map wsl-deps.animal-portraits.map (Animal Apparel Framework and Collars and Kit Renew).
// Written 2026-10-26 at the owner's request. The garments other mods add (Mods/*/ patches, VEF Apparel_Universal) are NOT in this first pass.
// usage: node docs/Generate-AnimalApparelGallery.js   (from the repository root)
const fs = require('fs');
const DEFS = '../AnimalApparelCollarsAndKitRenew/Mod/Defs/ThingDefs/';
const P = "Nelim's Pickle Tools: ";
const items = [];
for (const f of fs.readdirSync(DEFS).filter(f => f.endsWith('.xml')).sort()) {
  const x = fs.readFileSync(DEFS + f, 'utf8');
  for (const b of x.split(/<ThingDef (?=ParentName|Name|Class)/).slice(1)) {
    const name = (b.match(/<defName>([^<]+)</) || [])[1];
    if (!name) continue;
    const hosts = [...((b.match(/<descriptionHyperlinks>([\s\S]*?)<\/descriptionHyperlinks>/) || ['', ''])[1]).matchAll(/<ThingDef>([^<]+)</g)].map(z => z[1]);
    const groups = [...((b.match(/<bodyPartGroups>([\s\S]*?)<\/bodyPartGroups>/) || ['', ''])[1]).matchAll(/<li>([^<]+)</g)].map(z => z[1]);
    const tags = [...b.matchAll(/<li[^>]*>defName([^<]+)</g)].map(z => z[1]);
    items.push({ name, hosts, tags, groups, file: f.replace(/^Apparel_/, '').replace(/\.xml$/, '') });
  }
}
// The garments are whitelisted by race (apparel tags defName<Race>): a Thrumbo is refused the Small and dog ones ('tried to wear ... but is not allowed to', 2026-10-26, d81b bdbe).
const PREFERRED = ['Thrumbo', 'LabradorRetriever', 'Husky', 'Alpaca', 'Wolf_Timber', 'Fox_Red'];
const hostOf = i => PREFERRED.find(r => i.tags.includes(r)) || i.tags[0] || 'Husky';   // owner 2026-10-26: a thrumbo whenever the def allows it
const md = ['# Animal apparel catalogue', '',
  `Read on 2026-10-26 from the Defs of Animal Apparel Collars and Kit Renew (${items.length} garments). One photograph each, on the first host the def lists (Husky when it lists none): shots \`animalapparel-<defName>\`, feature \`pickletools-animal-apparel-gallery\`, map \`wsl-deps.animal-portraits.map\`. The garments other mods add are not in this first pass.`, '',
  'Step text: `the animal "<name>" is dressed in "<defName>"`.', '',
  '## Animal garments', '', '| Mod | Group | Names |', '| --- | --- | --- |'];
const byFile = {};
for (const i of items) (byFile[i.file] = byFile[i.file] || []).push(i.name);
for (const [g, names] of Object.entries(byFile)) md.push(`| Collars and Kit Renew | ${g} | (${names.length}) ${names.join(', ')} |`);
md.push('', '## Hosts', '', '| Garment | Photographed on | Listed hosts | Body groups |', '| --- | --- | --- | --- |');
for (const i of items) md.push(`| ${i.name} | ${hostOf(i)} | ${i.hosts.join(', ') || 'none listed'} | ${i.groups.join(', ') || ''} |`);
fs.writeFileSync('ColonistRace/docs/CATALOGUE-ANIMAL-APPAREL.md', md.join('\n') + '\n');

const out = ['@requires:nelim.pickletools.screenshotstudio', '@requires:nelim.pickletools.camerazoom', '@requires:nelim.pickletools.colonistrace',
  'Feature: One photograph per animal garment (the animal apparel catalogue)', ''];
const pre = ['Given the save "Nelims-tribe" is loaded', 'And game speed is paused',
  `And ${P}the item and name labels are hidden`, `And ${P}the tooltips are hidden`, `And ${P}the colonist bar is hidden`, `And ${P}the learning helper is hidden`,
  `And ${P}the temperature of the map is 20 degrees`, `And ${P}the weather is set at once to "Clear"`, `And ${P}the other colonists are out of frame`];
const CHUNK = 6;   // 12 shots per scenario (front and side): a long scenario was killed by the game on 2026-10-26 (man tattoos, 12 x 2 shots); Pickle's watchdog stops one at 300 s
for (let c = 0; c * CHUNK < items.length; c++) {
  const part = items.slice(c * CHUNK, (c + 1) * CHUNK);
  out.push(`  Scenario: animal-apparel-gallery-${c + 1}: garments ${c * CHUNK + 1} to ${c * CHUNK + part.length} of ${items.length}`);
  pre.forEach(l => out.push('    ' + l));
  part.forEach((i, k) => {
    const nick = `Mannequin${k + 1}`, x = 160 + 6 * k, z = [172, 202].includes(x) ? 121 : 120;   // (172, 120) holds a TorchLamp and (202, 120) a Reliquary in the Nelims-tribe fixture
    out.push(`    And ${P}an adult animal of kind "${hostOf(i)}" named "${nick}" is spawned at (${x}, ${z})`,
      `    And ${P}the animal "${nick}" stands at (${x}, ${z}) facing South`,
      `    And ${P}the animal "${nick}" is dressed in "${i.name}"`,
      `    And ${P}I frame the animal "${nick}" at zoom 5`,
      `    And ${P}I let 5 frames pass`,
      `    And I take a screenshot "animalapparel-${i.name}-front"`,
      `    And ${P}the animal "${nick}" stands at (${x}, ${z}) facing East`,
      `    And ${P}I let 5 frames pass`,
      `    And I take a screenshot "animalapparel-${i.name}-side"`);
  });
  out.push('');
}
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-animal-apparel-gallery.feature', out.join('\n'));
console.log(`${items.length} garments, ${Math.ceil(items.length / CHUNK)} scenarios`);
