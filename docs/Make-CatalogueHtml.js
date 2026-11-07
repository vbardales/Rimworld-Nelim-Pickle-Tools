// Builds ColonistRace/docs/catalogues/index.html: one page over the look, apparel, colour, weapon, item and mod catalogues
// (ColonistRace/docs/catalogues/*.md) and the photograph sheets of ColonistRace/docs/img.
//   node Docs/Make-CatalogueHtml.js        (run from the repository root; rerun after Docs/Make-LookSheets.ps1)
// No dependency: the markdown subset the catalogues use (headings, tables, lists, images, links, code, bold) is rendered here.
// The pages come from ColonistRace/docs/catalogues/pages.json: another mod adds its own page there, without touching this file (see catalogues/README.md).
const fs = require('fs'), path = require('path');
const root = path.resolve(__dirname, '..');
const docs = path.join(root, 'ColonistRace', 'docs');
const cat = path.join(docs, 'catalogues');

const esc = s => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
// A link to a look sheet keeps working when a new sheet shifts the numbers: it is matched on what follows the number ("<label> - <mod> - <page>.jpg").
function sheetLink(u) {
  const m = decodeURI(u).match(/^\.\.\/img\/looks\/[0-9]{3,4} (.*\.jpg)$/);
  if (!m) return u;
  const hit = Object.values(byBlock).flat().find(f => f.slice(5) === m[1]);
  return hit ? '../img/looks/' + encodeURI(hit) : u;
}
// The page being rendered (an entry of pages.json): its relative images resolve from its imgBase. A page of this repository keeps its paths (they are relative to
// catalogues/, where index.html lives, or are rewritten to be); an image of another repository is copied to catalogues/pages/<id>/ so that index.html stays one
// standalone page that opens from file:/// and survives this repository being published alone.
let cur = null;
function pageImg(u) {
  if (!cur || cur.imgAbs === cat || /^(https?:|data:|#|\/)/.test(u)) return u;
  const abs = path.join(cur.imgAbs, decodeURI(u).split(/[?#]/)[0]);
  if (!fs.existsSync(abs)) { console.warn(`warning: page ${cur.id}: image not found: ${abs}`); return u; }
  const rel = path.relative(root, abs);
  if (!rel.startsWith('..') && !path.isAbsolute(rel)) return encodeURI(path.relative(cat, abs).split(path.sep).join('/'));
  const dest = 'pages/' + cur.id + '/' + path.relative(cur.imgAbs, abs).split(path.sep).join('/');
  fs.mkdirSync(path.dirname(path.join(cat, dest)), { recursive: true });
  fs.copyFileSync(abs, path.join(cat, dest));
  return encodeURI(dest);
}
const isImage = u => /\.(png|jpe?g|gif|webp)$/i.test(u.split(/[?#]/)[0]);
function inline(s) {
  s = esc(s);
  s = s.replace(/!\[([^\]]*)\]\(([^)]+)\)/g, (_, a, u) => `<img loading="lazy" src="${sheetLink(pageImg(u))}" alt="${a}">`);
  s = s.replace(/\[([^\]]+)\]\(([^)]+)\)/g, (_, a, u) => `<a href="${sheetLink(isImage(u) ? pageImg(u) : u)}">${a}</a>`);
  s = s.replace(/`([^`]+)`/g, '<code>$1</code>').replace(/\*\*([^*]+)\*\*/g, '<b>$1</b>');
  return s;
}
function render(md) {
  const out = [], lines = md.replace(/\r/g, '').split('\n');
  for (let i = 0; i < lines.length; i++) {
    const l = lines[i];
    let m;
    if ((m = l.match(/^(#{1,4}) (.*)/))) { const n = m[1].length; out.push(`<h${n + 1} id="${m[2].toLowerCase().replace(/[^a-z0-9]+/g, '-')}">${inline(m[2])}</h${n + 1}>`); }
    else if (l.startsWith('|')) {
      const rows = [];
      while (i < lines.length && lines[i].startsWith('|')) { rows.push(lines[i]); i++; } i--;
      const cells = r => r.trim().replace(/^\||\|$/g, '').split('|').map(c => c.trim());
      const head = cells(rows[0]), body = rows.slice(2).map(cells);
      const table = '<table><thead><tr>' + head.map(c => `<th>${inline(c)}</th>`).join('') + '</tr></thead><tbody>' +
        body.map(r => '<tr>' + r.map(c => `<td>${inline(c)}</td>`).join('') + '</tr>').join('') + '</tbody></table>';
      // The Mod | Names tables (the lists of defNames per mod) are long: folded by default (owner, 2026-10-31); the filter box opens the ones that match.
      out.push(head.length === 2 && head[0] === 'Mod' && head[1] === 'Names' ? `<details class="names"><summary>Liste des noms par mod (${body.length} lignes)</summary>${table}</details>` : table);
    } else if (/^\s*[-*] /.test(l)) {
      const items = [];
      while (i < lines.length && /^\s*[-*] /.test(lines[i])) { items.push(lines[i].replace(/^\s*[-*] /, '')); i++; } i--;
      out.push('<ul>' + items.map(t => `<li>${inline(t)}</li>`).join('') + '</ul>');
    } else if (l.trim() === '') { /* skip */ }
    else out.push(`<p>${inline(l)}</p>`);
  }
  return out.join('\n');
}


// Photograph sheets: img/looks/<NNNN> <label> - <mod> - <page>.jpg grouped by kind (its block), plus the part sheets, the animation sheets and the building tabs.
const looksDir = path.join(docs, 'img', 'looks');
// Sheets are named "<NNNN> <label> - <mod> - <page>.jpg": the first two digits are the kind's block (Make-LookSheets.ps1 kindBlock, the two tables agree), the last two the rank of the sheet in it.
const kindBlock = { hair: 0, hairgene: 1, beard: 2, head: 3, facetattoo: 4, eyegene: 5, faceparts: 6, serenhead: 7, serenlid: 8, serenbrow: 9, sereneyeball: 10, serenmouth: 11, animations: 12, body: 13, skingene: 14, serenskin: 15, serenvteskin: 16, serenxeno: 17, bodymask: 18, lookgene: 19, bodytattoo: 20, ideocolour: 21, colour: 22, garment: 23, hat: 24, weapon: 25, weather: 26, animalapparel: 27, fahead: 28, rhygene: 29, mouth: 30 };
const byBlock = {};
for (const f of fs.readdirSync(looksDir).filter(f => /^[0-9]{4} .*.(jpg|png|gif)$/.test(f)).sort()) (byBlock[+f.slice(0, 2)] = byBlock[+f.slice(0, 2)] || []).push(f);
const byKind = {};
for (const [k, n] of Object.entries(kindBlock)) if (byBlock[n]) byKind[k] = byBlock[n];
// The colour sheet of the beards (0204) has its own sub-category, with the step that sets the colour.
if (byBlock[2]) { byKind.beardcolour = byBlock[2].filter(f => / Couleurs de barbe /.test(f)); byKind.beard = byBlock[2].filter(f => !/ Couleurs de barbe /.test(f)); }
// The face part sheets (block 6, Make-PartSheets.ps1) are split by their label so that each goes with its own sub-category (the eyes, the eyelids and the brows are with the eyes, not with the face).
for (const [k, re] of Object.entries({ fpBrow: /Sourcils/, fpLid: /Paupieres/, fpLidOption: /Options de paupieres/, fpSkin: /Peaux/, fpEye: / - Yeux/, fpHead: /Formes de tete/, fpTattoo: /Tatouages visage/, fpEmotion: /Marques d emotion/ })) byKind[k] = (byBlock[6] || []).filter(f => re.test(f));
let sheetText = {}; try { sheetText = JSON.parse(fs.readFileSync(path.join(looksDir, 'sheets.json'), 'utf8')); } catch (e) { /* no manifest: the sheets stay images */ }
const sheetCells = f => { const c = sheetText[f]; return c ? (Array.isArray(c) ? c : [c]) : null; };
// Skin marks (owner, 2026-11-03): the Seren marking genes sit on the look gene sheet; Peau shows them too, as a sheet of their own cut from the same tiles (the full sheet stays under Genes d'apparence).
const markSource = {};
{
  const marks = [];
  let src = null;
  for (const f of byKind.lookgene || []) for (const c of sheetCells(f) || []) if (/^SerenMarkings_/.test(c.text || '')) { marks.push(c); src = src || f; }
  if (marks.length) { const v = src.replace(/^(\d{4}) .* - (.* - \d+\.jpg)$/, '$1 Marques de peau Seren - $2'); sheetText[v] = marks; markSource[v] = src; byKind.skinmark = [v]; }
}
const sheet = f => sheetCells(f) ? `<div class="sheet"><div class="shname"><a href="../img/looks/${encodeURI(markSource[f] || f)}" target="_blank">${path.basename(f).replace(/.(jpg|png|gif)$/, '')}</a></div><div class="tl">` + sheetCells(f).map(c => `<figure>${c.tile ? `<img loading="lazy" src="../img/looks/tiles/${encodeURI(c.tile)}" alt="${esc(c.text)}">` : '<div class="nophoto"></div>'}<figcaption>${c.hex ? `<i class="sw" style="background:#${c.hex}"></i>` : ''}${esc(c.text)}</figcaption></figure>`).join('') + '</div></div>' : `<a href="../img/looks/${encodeURI(f)}" target="_blank"><img loading="lazy" src="../img/looks/${encodeURI(f)}" alt="${f}"><span>${path.basename(f).replace(/.(jpg|png|gif)$/, '')}</span></a>`;
let gallery = '';
for (const [k, files] of Object.entries(byKind))
  gallery += `<h3>${k}</h3><div class="sheets">` + files.map(sheet).join('') + '</div>';

// The sheets of a kind go right under the heading of their section in the catalogue pages.
const sheetsFor = kinds => {
  const files = kinds.flatMap(k => byKind[k] || []);
  return files.length ? '<div class="sheets wide">' + files.map(sheet).join('') + '</div>' : '';
};
const sectionKinds = [[/^Photographs/, ['serenhead', 'serenlid', 'sereneyeball', 'serenbrow', 'serenmouth', 'serenskin', 'serenvteskin', 'serenxeno']], [/^Animal garments/, ['animalapparel']], [/^Hairstyles/, ['hair']], [/^Beards/, ['beard']], [/^Head types/, ['head', 'fahead']], [/^Face tattoos/, ['facetattoo']], [/^Body tattoos/, ['bodytattoo']], [/^Body types/, ['body']],
  [/^Garments/, ['garment', 'hat']], [/^Colours/, ['ideocolour', 'colour']], [/^Weapons/, ['weapon']],
  [/^Eye colours/, ['eyegene']], [/^Skin colours/, ['skingene']], [/^Hair colours/, ['hairgene']], [/^Look genes/, ['lookgene']], [/^Weather/, ['weather']], [/^Contact sheets/, ['rhygene']]];
const withSheets = h => h.replace(/(<h3 id="[^"]*">)([^<]*)(<\/h3>)/g, (m, a, text) => {
  const hit = sectionKinds.find(([re]) => re.test(text));
  return m + (hit ? sheetsFor(hit[1]) : '');
});

// Browsing by category (owner, 2026-10-31): the side menu lists the categories of the columns of the NSB roster (Roster.xlsx: Physique, Apparence peau, cheveux, Visage, yeux, Tete,
// Caractere et animation, Tenues), each with its sub-categories; the drop-down at the top jumps to any sub-category. A sub-category shows its photograph sheets and the tables
// (the sections of the .md pages) that belong to it. `place` says where each section of each page goes; what it does not place stays in the Documentation group.
// [category, [[sub-category, [photograph kinds]], ...]]
const categories = [
  ['Peau', [['Couleurs de peau (genes)', ['skingene']], ['Tatouages de visage', ['facetattoo', 'fpTattoo']], ['Tatouages de corps', ['bodytattoo']], ['Masques corporels Seren', ['bodymask']], ['Marques de peau Seren (genes)', ['skinmark']]]],
  ['Cheveux', [['Couleurs de cheveux (genes)', ['hairgene']], ['Coiffures', ['hair']]]],
  ['Visage', [['Formes de tete (vanilla)', ['head']], ['Formes de tete (Facial Animation)', ['fahead', 'fpHead', 'serenhead']], ['Barbes', ['beard']], ['Couleurs de barbe', ['beardcolour']], ['Bouches', ['mouth', 'serenmouth']], ['Peaux du visage', ['fpSkin']], ['Masques de visage Seren', ['serenskin', 'serenvteskin']]]],
  ['Yeux', [['Couleurs des yeux (genes)', ['eyegene']], ['Globes des yeux', ['fpEye', 'sereneyeball']], ['Paupieres', ['fpLid', 'fpLidOption', 'serenlid']], ['Sourcils', ['fpBrow', 'serenbrow']]]],
  ['Tete : oreilles, cornes, marques', [['Genes d\'apparence', ['lookgene']]]],
  ['Corps', [['Corpulences', ['body']]]],
  ['Animations', [['Animations du visage', ['animations']], ['Taches (jobs)', []]]],
  ['Tenues', [['Vetements et chapeaux', ['garment', 'hat']], ['Armes et objets fabriques', ['weapon']], ['Couleurs', ['ideocolour', 'colour']], ['Objets utiles', []]]],
  ['Animaux', [['Vetements pour animaux', ['animalapparel']]]],
  ['Monde', [['Meteo', ['weather']]]],
  ['Seren', [['Xenotype Seren', ['serenxeno']]]],
];
const place = (file, h) => {
  const rules = {
    'looks.md': [[/^Hairstyles/, 'Coiffures'], [/^Beards/, 'Barbes'], [/^Head types/, 'Formes de tete (vanilla)'], [/^Face tattoos/, 'Tatouages de visage'], [/^Body tattoos/, 'Tatouages de corps'], [/^Body types/, 'Corpulences']],
    'face-parts.md': [[/^Mouths/, 'Bouches'], [/^Skins/, 'Peaux du visage'], [/^Brows/, 'Sourcils'], [/^Lids/, 'Paupieres'], [/^Eyeballs/, 'Globes des yeux'], [/^Head shapes/, 'Formes de tete (Facial Animation)'], [/^Heat/, 'Animations du visage']],
    'genes.md': [[/^Eye colours/, 'Couleurs des yeux (genes)'], [/^Skin colours/, 'Couleurs de peau (genes)'], [/^Hair colours/, 'Couleurs de cheveux (genes)'], [/^Look genes/, 'Genes d\'apparence']],
    'apparel.md': [[/./, 'Vetements et chapeaux']], 'colours.md': [[/./, 'Couleurs']], 'weapons-crafts.md': [[/./, 'Armes et objets fabriques']], 'items.md': [[/./, 'Objets utiles']],
    'weather.md': [[/./, 'Meteo']], 'animal-apparel.md': [[/./, 'Vetements pour animaux']], 'jobs.md': [[/./, 'Taches (jobs)']], 'seren.md': [[/./, 'Xenotype Seren']],
  }[file] || [];
  const hit = rules.find(([re]) => re.test(h));
  return hit ? hit[1] : null;
};
// Sheet numbers shown next to a table title and a sub-category title.
const numsOf = kinds => [...new Set(kinds.flatMap(k => byKind[k] || []).map(f => f.slice(0, 4)))].sort();
const sectionKinds2 = [[/^Mouths/, ['mouth']], [/^Brows/, ['fpBrow']], [/^Lids/, ['fpLid', 'fpLidOption']], [/^Skins/, ['fpSkin']], [/^Eyeballs/, ['fpEye']], [/^Head shapes/, ['fpHead']], [/^Hairstyles/, ['hair']], [/^Beards/, ['beard']], [/^Head types/, ['head']], [/^Face tattoos/, ['facetattoo', 'fpTattoo']], [/^Body tattoos/, ['bodytattoo']], [/^Body types/, ['body']], [/^Eye colours/, ['eyegene']], [/^Skin colours/, ['skingene']], [/^Hair colours/, ['hairgene']], [/^Look genes/, ['lookgene']], [/^Weather/, ['weather']]];
const numLabel = kinds => { const n = numsOf(kinds); return n.length ? ' : planche' + (n.length > 1 ? 's ' : ' ') + n.join(', ') : ''; };
const slug = s => s.toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '').replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
// Split every placed page at its "## " headings: [{sub, html}]; the first block of a page (before any "## ") goes with the page's first section.
const placed = {}, docTabs = [];
// The pages are declared in catalogues/pages.json (see catalogues/README.md): the generator knows no page by name. A page whose file name has no placement rule below
// gets its own tab in the nav, under its group.
const mono = path.resolve(root, '..');   // the monorepo root: a page may live in the repository of its own mod
const taken = new Set(['photos', ...categories.map(([c]) => 'c-' + slug(c))]);
const pages = JSON.parse(fs.readFileSync(path.join(cat, 'pages.json'), 'utf8')).pages.map((e, seq) => {
  for (const k of ['id', 'title', 'source']) if (!e[k]) throw new Error(`pages.json, entry ${seq + 1}: "${k}" is required`);
  if (taken.has(e.id)) throw new Error(`pages.json: duplicate or reserved id "${e.id}"`);
  taken.add(e.id);
  const abs = path.resolve(mono, e.source);
  return { ...e, seq, group: e.group || 'Documentation', abs, imgAbs: e.imgBase ? path.resolve(mono, e.imgBase) : path.dirname(abs) };
}).sort((a, b) => (a.order ?? 1e6) - (b.order ?? 1e6) || a.seq - b.seq);
for (const pg of pages) {
  const { id, title } = pg, file = path.basename(pg.abs), p = pg.abs;
  if (!fs.existsSync(p)) { console.warn(`warning: page ${id}: source not found, tab skipped: ${pg.source}`); continue; }
  cur = pg;
  const parts = fs.readFileSync(p, 'utf8').replace(/\r/g, '').replace(/^# .*\n/, '').split(/^(?=## )/m);
  let any = false;
  for (const part of parts) {
    const head = (part.match(/^## (.*)/) || [])[1] || '';
    const sub = head ? place(file, head) : null;
    if (sub) { (placed[sub] = placed[sub] || []).push({ kinds: (sectionKinds2.find(([re]) => re.test(head)) || [0, []])[1], html: `<h4 class="from">${esc(title)} : ${esc(head)}${(() => { const h = sectionKinds2.find(([re]) => re.test(head)); return h ? numLabel(h[1]) : ''; })()}</h4>` + render(part.replace(/^## .*\n/, '')) }); any = true; }
    else if (!head && parts.length > 1) { /* introduction of the page: kept with the page text below */ }
  }
  if (!any) docTabs.push(pg);
}
cur = null;
const kindHow = {
  serenhead: ['Seren : Head shapes', '"<pawn>" face head shape is "<defName>"'], serenlid: ['Seren : Lids', '"<pawn>" lids are "<defName>"'], sereneyeball: ['Seren : Eyeballs', '"<pawn>" eyeballs are "<defName>"'],
  serenbrow: ['Seren : Brows', '"<pawn>" brows are "<defName>"'], serenmouth: ['Seren : Mouths', '"<pawn>" mouth is "<defName>"'],
  serenskin: ['Seren : Face masks (marking skins)', '"<pawn>" face skin is "<defName>"'], serenvteskin: ['Seren : Face masks (marking skins, Vanilla Textures Expanded set)', '"<pawn>" face skin is "<defName>"'],
  bodymask: ['Seren : Body masks', '"<pawn>" has the gene "<defName>" (the masks are genes: SerenOriginalMask_<n> for Seren Biotech Extended, zero-based)'],
  beardcolour: ['Looks : Beard colours', '"<pawn>" hair colour is rgb (<r>, <g>, <b>)', ' A beard is drawn in the hair colour: there is no separate beard colour step. The eight hair colours with their hex values are on the sheet.'],
  fahead: ['Facial Animation : Head shapes', '"<pawn>" face head shape is "<defName>"'],
};
const howBlock = k => { const h = kindHow[k]; return h ? '<h4 class="from">' + esc(h[0]) + esc(numLabel([k])) + '</h4>' + render('Step texts: ' + String.fromCharCode(96) + h[1] + String.fromCharCode(96) + '.' + (h[2] || '')) : ''; };
const catSection = c => '';
const catId = (c, s) => `cat-${slug(c)}-${slug(s)}`;
const sections = [
  ...categories.map(([c, subs]) => `<section id="c-${slug(c)}" hidden><h1>${esc(c)}</h1>` + subs.map(([s, kinds]) => {
    const have = kinds.some(k => byKind[k] && byKind[k].length);
    const shown = new Set();
    return `<h2 id="${catId(c, s)}">${esc(s)}${kinds.length ? '<span class="num">' + esc(numLabel(kinds)) + '</span>' : ''}</h2>` + (kinds.length ? (have ? kinds.filter(k => (byKind[k] || []).length && !(placed[s] || []).some(e => e.kinds.includes(k))).map(k => sheetsFor([k]) + howBlock(k)).join('') : '<p class="src">Pas encore de photographie.</p>') : '') + (placed[s] || []).map(e => { const own = e.kinds.filter(k => kinds.includes(k) && !shown.has(k)); own.forEach(k => shown.add(k)); return sheetsFor(own) + e.html; }).join('\n');
  }).join('\n') + '</section>'),
  ...docTabs.map(pg => {
    cur = pg;
    const body = withSheets(render(fs.readFileSync(pg.abs, 'utf8').replace(/^# .*\n/, '')));
    cur = null;
    const m = pg.mod, src = m ? `${esc(pg.source)}, mod ${esc(m.name)}${m.workshopId ? ` (<a href="https://steamcommunity.com/sharedfiles/filedetails/?id=${esc(String(m.workshopId))}">${esc(String(m.workshopId))}</a>)` : ''}` : path.basename(pg.abs);
    return `<section id="${pg.id}" hidden><h1>${pg.title}</h1><p class="src">${src}</p>${body}</section>`;
  }),
].join('\n');
const navHtml = categories.map(([c, subs]) => `<details><summary data-t="c-${slug(c)}">${esc(c)}</summary>` + subs.map(([s]) => `<a data-t="c-${slug(c)}" data-j="${catId(c, s)}">${esc(s)}</a>`).join('') + '</details>').join('') +
  [...new Set(['Documentation', ...docTabs.map(p => p.group)])].map(g =>
    `<h2 style="margin-top:14px">${esc(g)}</h2>` + docTabs.filter(p => p.group === g).map(p => `<a data-t="${p.id}">${esc(p.title)}</a>`).join('') + (g === 'Documentation' ? '<a data-t="photos">Photographies (toutes)</a>' : '')).join('');
const jumpMenu = '<select id="jump"><option value="">Aller a...</option>' + categories.map(([c, subs]) =>
  `<optgroup label="${esc(c)}">` + subs.map(([s]) => `<option value="${catId(c, s)}" data-t="c-${slug(c)}">${esc(s)}</option>`).join('') + '</optgroup>').join('') + '</select>';
const firstSection = 'c-' + slug(categories[0][0]);


const html = `<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Look catalogues</title>
<style>
:root{--bg:#fafaf7;--fg:#1d1d1b;--mut:#6b6b66;--line:#dcdcd4;--acc:#2f7d32;--card:#fff}
@media (prefers-color-scheme:dark){:root{--bg:#161614;--fg:#e8e8e2;--mut:#9a9a92;--line:#33332f;--acc:#7fd17f;--card:#1f1f1c}}
*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--fg);font:15px/1.5 system-ui,Segoe UI,sans-serif;display:flex;min-height:100vh}
nav{width:210px;flex:none;padding:16px;border-right:1px solid var(--line);position:sticky;top:0;height:100vh;overflow:auto}
nav h2{font-size:13px;text-transform:uppercase;letter-spacing:.06em;color:var(--mut);margin:0 0 8px}
nav details{margin:0 0 2px}nav summary{padding:6px 8px;border-radius:6px;cursor:pointer;font-weight:600}nav details a{padding-left:20px;font-size:14px}nav a{display:block;padding:6px 8px;border-radius:6px;color:var(--fg);text-decoration:none;cursor:pointer}
nav a.on{background:var(--acc);color:#fff}
main{flex:1;min-width:0;padding:20px 28px 60px}
#jump{display:block;margin:0 0 10px;padding:8px 10px;border:1px solid var(--line);border-radius:6px;background:var(--card);color:var(--fg);font:inherit;max-width:420px;width:100%}#q{width:100%;max-width:420px;padding:8px 10px;border:1px solid var(--line);border-radius:6px;background:var(--card);color:var(--fg);margin-bottom:12px}
h1{margin:0 0 4px}.src{color:var(--mut);margin:0 0 16px;font-size:13px}
h2,h3,h4{margin:24px 0 8px}span.num{font-size:13px;font-weight:400;color:var(--mut);margin-left:8px}details.names{margin:8px 0}details.names summary{cursor:pointer;color:var(--mut);padding:4px 0}h4.from{font-size:13px;color:var(--mut);margin:14px 0 4px}
table{border-collapse:collapse;width:100%;background:var(--card);margin:8px 0}
th,td{border:1px solid var(--line);padding:6px 8px;text-align:left;vertical-align:top;font-size:14px;overflow-wrap:anywhere}td:not(:last-child),th:not(:last-child){white-space:nowrap;overflow-wrap:normal}a{color:var(--acc)}
th{background:color-mix(in srgb,var(--acc) 12%,var(--card))}
code{background:color-mix(in srgb,var(--fg) 8%,transparent);padding:1px 4px;border-radius:4px;font-size:13px}
main img{max-width:100%}p>img,li>img{display:block;margin:8px 0}
.sheets{display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:12px}
.sheets a{background:var(--card);border:1px solid var(--line);border-radius:8px;padding:6px;text-decoration:none;color:var(--mut);font-size:12px}
.sheet{grid-column:1/-1}.shname{font-size:12px;color:var(--mut);margin:6px 0}.tl{display:grid;grid-template-columns:repeat(auto-fill,minmax(130px,1fr));gap:6px}.tl figure{margin:0;font-size:11px;word-break:break-word}.tl img{width:100%;display:block;border-radius:4px}.nophoto{aspect-ratio:1;background:repeating-linear-gradient(45deg,var(--card),var(--card) 4px,var(--line) 4px,var(--line) 5px);border-radius:4px}.sw{display:inline-block;width:10px;height:10px;margin-right:4px;border:1px solid var(--line)}
.sheets.wide{grid-template-columns:repeat(auto-fill,minmax(520px,1fr))}.sheets img{width:100%;display:block;border-radius:4px}
tr.hide{display:none}
@media(max-width:700px){body{display:block}nav{width:auto;height:auto;position:static;border:0;border-bottom:1px solid var(--line)}main{padding:16px}}
</style></head><body>
<nav><h2>Catalogues</h2>${navHtml}</nav>
<main>${jumpMenu}<input id="q" type="search" placeholder="Filter rows (a defName, a mod...)">
${sections}
<section id="photos" hidden><h1>Photographs</h1><p class="src">ColonistRace/docs/img</p>${gallery}</section>
</main>
<script>
const links=[...document.querySelectorAll('nav a,nav summary')],secs=[...document.querySelectorAll('main section')],q=document.getElementById('q');
function show(id,j){links.forEach(a=>a.classList.toggle('on',a.dataset.t===id&&(!a.dataset.j||a.dataset.j===j)));secs.forEach(s=>s.hidden=s.id!==id);try{localStorage.setItem('cat-tab',id)}catch(e){}filter();if(j){const el=document.getElementById(j);if(el)el.scrollIntoView()}else window.scrollTo(0,0)}
function filter(){const v=q.value.toLowerCase();document.querySelectorAll('main section:not([hidden]) tbody tr').forEach(r=>r.classList.toggle('hide',v&&!r.textContent.toLowerCase().includes(v)));document.querySelectorAll('main section:not([hidden]) details.names').forEach(d=>{if(v)d.open=!!d.querySelector('tbody tr:not(.hide)')})}
links.forEach(a=>a.onclick=()=>{location.hash=a.dataset.j||a.dataset.t;show(a.dataset.t,a.dataset.j)});q.oninput=filter;
const jump=document.getElementById('jump');
jump.onchange=()=>{const o=jump.options[jump.selectedIndex];if(!o.value)return;location.hash=o.value;show(o.dataset.t,o.value);jump.selectedIndex=0};
const hash=location.hash.slice(1);let start=hash;try{start=start||localStorage.getItem('cat-tab')}catch(e){}
const jumpTarget=document.getElementById(hash);const owner=jumpTarget&&jumpTarget.closest('section');
if(owner)show(owner.id,hash);else show(secs.some(s=>s.id===start)?start:'${firstSection}');
</script></body></html>`;
fs.writeFileSync(path.join(cat, 'index.html'), html);
console.log('wrote ColonistRace/docs/catalogues/index.html', (html.length / 1024).toFixed(0) + ' KB,', Object.values(byKind).flat().length, 'sheets');
