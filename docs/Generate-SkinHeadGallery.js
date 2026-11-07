// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-skin-head-gallery.feature (maps wsl-deps.gene-gallery.map: Biotech, melanin, Genes Expanded - Skin, Cookie Genes) and
// pickletools-skin-head-gallery-seren.feature (map wsl-deps.seren.map: the 13 Seren skin colours): the skin colour genes of the catalogue photographed again with the head
// framed (Virginie, 2026-11-07: the sheets showed the whole body and a corner of the room). The scenarios of pickletools-gene-gallery.feature (gene-gallery-skins-N) and
// pickletools-seren-gallery.feature (seren-gallery-1) are read as they are, the zoom line is changed to `I frame the cell (176, 119) at zoom 2`, and the shots are cut in chunks of at most 12.
// Shots keep their names (skingene-<gene>), so docs/Make-LookSheets.ps1 (job skingene, head crop) replaces the tile of each gene as its new photograph appears.
// usage: node docs/Generate-SkinHeadGallery.js   (from the repository root). Run one scenario: -Filter '::skin-head-<n>:' (or '::skin-head-seren-<n>:')
const fs = require('fs');
const F = 'Tests/Pickle/Mod/Pickle/Features/';
const P = "Nelim's Pickle Tools: ";
function blocks(file, re) {
  const lines = fs.readFileSync(F + file, 'utf8').split(/\r?\n/);
  const out = []; let cur = null;
  for (const l of lines) {
    if (/^\s*Scenario:/.test(l)) { cur = re.test(l) ? [] : null; if (cur) out.push(cur); continue; }
    if (cur) cur.push(l);
  }
  return out;
}
function rebuild(file, re, prefix, title) {
  const header = fs.readFileSync(F + file, 'utf8').split(/\r?\n/).filter(l => /^@requires/.test(l));
  let setup = null; const genes = [];
  for (const b of blocks(file, re)) {
    const firstShot = b.findIndex(l => /^\s*(When|And) .*has the gene/.test(l));
    if (!setup) setup = b.slice(0, firstShot).filter(l => l.trim()).map(l => l.trim().replace('I frame the cell (176, 120) at zoom 2', 'I frame the cell (176, 119) at zoom 2'));
    for (const l of b) { const m = l.match(/take a screenshot "skingene-([^"]+)"/); if (m) genes.push(m[1]); }
  }
  const out = [...header, `Feature: ${title}`, ''];
  const size = Math.ceil(genes.length / Math.ceil(genes.length / 12));
  for (let i = 0, n = 1; i < genes.length; i += size, n++) {
    const part = genes.slice(i, i + size);
    out.push(`  Scenario: ${prefix}-${n}: skin colour genes ${i + 1} to ${i + part.length} of ${genes.length}`);
    setup.forEach(l => out.push('    ' + l));
    for (const g of part) out.push(`    When ${P}"Nelim" has the gene "${g}"`, `    And ${P}I let 5 frames pass`, `    And I take a screenshot "skingene-${g}"`);
    out.push('');
  }
  return { text: out.join('\n'), genes: genes.length, chunks: Math.ceil(genes.length / size) };
}
const a = rebuild('pickletools-gene-gallery.feature', /gene-gallery-skins-\d+:/, 'skin-head', 'Head photograph of every skin colour gene of Biotech, Genes Expanded - Skin and Cookie Genes');
fs.writeFileSync(F + 'pickletools-skin-head-gallery.feature', a.text);
const b = rebuild('pickletools-seren-gallery.feature', /seren-gallery-1: skin colours/, 'skin-head-seren', 'Head photograph of every skin colour gene of Seren, from Stardust');
fs.writeFileSync(F + 'pickletools-skin-head-gallery-seren.feature', b.text);
console.log(`gene gallery: ${a.genes} genes in ${a.chunks} scenarios; seren: ${b.genes} genes in ${b.chunks} scenarios`);
