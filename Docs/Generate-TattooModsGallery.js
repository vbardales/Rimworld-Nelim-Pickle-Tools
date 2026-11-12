// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-tattoomods-face.feature and pickletools-tattoomods-face-side.feature: one photograph (front, then profile) of every
// face tattoo of the tattoo mods whose sheets were still hatched (2026-11-07, Virginie: complete the catalogue): Myf's Tattoos, Sunny's Dr Stone Scars, Morphs Assorted
// Tattoos, Tattoo Face Scars, Misc Tattoos, Bill Doors' Miqo'te Tattoo. Same set-up as pickletools-roo-gallery (bald Nelim, underwear, zoom 2, look reset). One scenario
// per chunk of at most 10 shots inside one mod (Pickle's watchdog stops a scenario at 300 s); shots facetattoo-<def> and facetattoo-<def>-side, so that
// docs/Make-LookSheets.ps1 fills the tiles from the run folders. Face values are the names that do not start with Body_ / OE_Body_ (looks.md rows carry no Face/Body mark for these mods).
// Body tattoos (three views) are a later generator.
// usage: node docs/Generate-TattooModsGallery.js   (from the repository root; map wsl-deps.look-catalogue-tattoo.map). Run one scenario: -Filter '::tattoomods-face-<n>:'
const fs = require('fs');
const md = fs.readFileSync('ColonistRace/docs/catalogues/looks.md', 'utf8').split(/\r?\n/);
// order: the small mods first, Bill Doors last (its Workshop item is subscribed last)
const mods = [['Myf', /^\| Myf's Tattoos \|/], ['Sunny', /^\| Sunny's Dr Stone Scars/], ['Morphs', /^\| Morphs Assorted: Tattoos \|/], ['FaceScars', /^\| Tattoo Face Scars \|/], ['Misc', /^\| Misc Tattoos \|/], ['BillDoors', /^\| Bill Doors/]];
const chunks = [];
for (const [label, re] of mods) {
  // a mod can have two rows (face and body values listed apart): take every row that matches, keep the face values
  const names = md.filter(l => re.test(l)).flatMap(r => r.split('|')[2].replace(/^\s*\(\d+\)\s*/, '').split(', ').map(s => s.trim())).filter(n => n && !/^(Body_|OE_Body_)/.test(n));
  const size = Math.ceil(names.length / Math.ceil(names.length / 10));
  for (let i = 0; i < names.length; i += size) chunks.push({ label, names: names.slice(i, i + size), of: names.length, from: i + 1 });
}
const P = "Nelim's Pickle Tools: ";
const base = (facing) => [
  'Given the save "Nelims-tribe" is loaded', 'And game speed is paused',
  `And ${P}the item and name labels are hidden`, `And ${P}the tooltips are hidden`, `And ${P}the colonist bar is hidden`, `And ${P}the learning helper is hidden`,
  `And ${P}the temperature of the map is 20 degrees`, `And ${P}I frame the area centred on (177, 121) at root size 6.5`,
  `And ${P}"Nelim" stands at (176, 120) facing ${facing}`,
  `And ${P}"Nelim" hairstyle is "Bald"`, `And ${P}"Nelim" face tattoo is "none"`, `And ${P}"Nelim" mouth is "MouthNormal"`, `And ${P}"Nelim" brows are "BrowNormal"`,
  `And ${P}"Nelim" lids are "LidNormal"`, `And ${P}"Nelim" face skin is "SkinNormal"`, `And ${P}"Nelim" eyeballs are "EyeNormal"`, `And ${P}"Nelim" face head shape is "HeadNormal"`,
  `And ${P}"Nelim" facial expression is "normal"`, `And ${P}"Nelim" face is held neutral`,
  `And ${P}"Nelim" is undressed`, `And ${P}"Nelim" wears "UnderWhere_Panties"`, `And ${P}"Nelim" wears "UnderWhere_Bra"`,
  `And ${P}I frame the cell (176, 119) at zoom 2`,
];
const tags = ['@requires:nelim.pickletools.screenshotstudio', '@requires:nelim.pickletools.colonistrace', '@requires:nelim.pickletools.camerazoom'];
for (const [file, facing, suffix, title] of [['pickletools-tattoomods-face', 'South', '', 'Front of every face tattoo of the tattoo mods still hatched'], ['pickletools-tattoomods-face-side', 'East', '-side', 'Profile of every face tattoo of the tattoo mods still hatched']]) {
  const out = [...tags, `Feature: ${title}`, ''];
  chunks.forEach((c, n) => {
    out.push(`  Scenario: tattoomods-face${suffix}-${n + 1}: ${c.label} ${c.from} to ${c.from + c.names.length - 1} of ${c.of}`);
    base(facing).forEach(l => out.push('    ' + l));
    for (const v of c.names) out.push(`    When ${P}"Nelim" face tattoo is "${v}"`, `    And ${P}I let 5 frames pass`, `    And I take a screenshot "facetattoo-${v}${suffix}"`);
    out.push('');
  });
  const f = `Tests/Pickle/Mod/Pickle/Features/${file}.feature`;
  fs.writeFileSync(f, out.join('\n'));
  require('./Add-LookReset').apply(f);
  console.log(f, chunks.length, 'scenarios', chunks.reduce((a, c) => a + c.names.length, 0), 'shots');
}
