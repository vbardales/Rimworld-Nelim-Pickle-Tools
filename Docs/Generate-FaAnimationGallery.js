// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-fa-animation-gallery.feature: one short photo sequence per Facial Animation animation (FacialAnimation.FaceAnimationDef),
// frame by frame: the animation is started on a bald Nelim in underwear (step `facial expression is`), then the paused game advances by FRAME_TICKS ticks between two
// photographs. docs/Make-FaGifs.ps1 turns each sequence into a gif cropped on the head. (The film steps did not work: FilmTicks caught 3 frames in 60 ticks of a paused game,
// df59, 2026-10-31.) Animation names are read from the listing of the look catalogue runs (`[face-animations] <mod> (n): a, b, c`), so nothing is typed by hand.
// Scenarios are grouped by GROUP animations, title fa-anim-g<k>-<name>, so a ticket filter `::fa-anim-g<k>-` plays one group. Shots faceanim-<name>-<frame>.
// Map wsl-deps.face-animations.map. The face is NOT held neutral (that would stop the animation). Written 2026-10-31 at the owner's request (gifs of all the animations).
// usage: node docs/Generate-FaAnimationGallery.js   (from the repository root)
const fs = require('fs');
const RUNS = ['Tests/Pickle/Inbox/look-catalogue-9-b6/Player.log', 'Tests/Pickle/Inbox/look-catalogue-8-b2/Player.log'];
const P = "Nelim's Pickle Tools: ";
const FRAMES = 8, FRAME_TICKS = 20, GROUP = 4;
const found = new Map();
for (const f of RUNS) {
  if (!fs.existsSync(f)) continue;
  for (const l of fs.readFileSync(f, 'utf8').replace(/<[^>]*>/g, '').split('\n')) {
    const m = l.match(/\[face-animations\] (.*?) \((\d+)\): (.*)$/);
    if (m && m[1] !== 'total') for (const n of m[3].split(', ')) found.set(n.trim(), m[1]);
  }
  if (found.size) break;
}
const names = [...found.keys()].sort((a, b) => a.localeCompare(b));
const out = ['@requires:nelim.pickletools.screenshotstudio', '@requires:nelim.pickletools.colonistrace', '@requires:nelim.pickletools.camerazoom', 'Feature: One photo sequence per Facial Animation animation, for the animation gifs', ''];
names.forEach((n, i) => {
  const g = Math.floor(i / GROUP) + 1;
  out.push(`  Scenario: fa-anim-g${g}-${n}: ${FRAMES} frames of the animation ${n}`,
    '    Given the save "Nelims-tribe" is loaded', '    And game speed is paused',
    `    And ${P}the item and name labels are hidden`, `    And ${P}the tooltips are hidden`, `    And ${P}the colonist bar is hidden`, `    And ${P}the learning helper is hidden`,
    `    And ${P}the temperature of the map is 20 degrees`, `    And ${P}the other colonists are out of frame`,
    `    And ${P}I frame the area centred on (177, 121) at root size 6.5`,
    `    And ${P}"Nelim" stands at (176, 120) facing South`,
    `    And ${P}"Nelim" is undressed`, `    And ${P}"Nelim" wears "UnderWhere_Panties"`, `    And ${P}"Nelim" wears "UnderWhere_Bra"`,
    `    And ${P}"Nelim" hairstyle is "Bald"`, `    And ${P}"Nelim" face tattoo is "none"`, `    And ${P}"Nelim" face kit is "neutral"`,
    `    And ${P}I frame the cell (176, 119) at zoom 3`,
    `    And ${P}"Nelim" waits in place`,
    `    And ${P}"Nelim" facial expression is "normal"`, `    And ${P}I advance the paused game by exactly 30 ticks`,
    `    When ${P}"Nelim" facial expression is "${n}"`);
  for (let k = 1; k <= FRAMES; k++)
    out.push(`    And ${P}I advance the paused game by exactly ${FRAME_TICKS} ticks`, `    And I take a screenshot "faceanim-${n}-${String(k).padStart(2, '0')}"`);
  out.push('');
});
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-fa-animation-gallery.feature', out.join('\n'));
console.log(names.length + ' animations, ' + Math.ceil(names.length / GROUP) + ' groups of ' + GROUP + ': ' + names.join(', '));
