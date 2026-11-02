# Adding a page to the catalogue

`index.html` is one standalone page (no server, it opens from `file:///`) built by `Docs/Make-CatalogueHtml.js` from the pages declared in `pages.json` (this folder). The generator knows no page by name: a mod adds its own page by declaring it here and keeping its text and images in its own repository.

## Adding a page

1. Write the page as markdown in the mod (for example `AnimalCosmeticGenes/Docs/catalogue.md`) and put its images next to it.
2. Append one entry to `pages` in `pages.json`.
3. Run, from the PickleTools repository root: `node Docs/Make-CatalogueHtml.js`, then commit `index.html` and `pages.json` by path.

No change to the generator is needed.

## Entry fields

| Field | Required | Meaning |
|---|---|---|
| `id` | yes | Anchor and section id of the page (`#c-animaux` style, letters, digits and dashes). Unique: a duplicate id, or `photos` or an id starting with `c-` that a category already uses, stops the build with an error. |
| `title` | yes | Name shown in the nav and as the page heading. |
| `source` | yes | Path of the `.md` file, relative to the monorepo root (the folder that holds `PickleTools/` and the mod folders), or absolute. A missing file is a warning and the tab is skipped, the build goes on. |
| `group` | no | Nav section the tab sits under. Default `Documentation`. Any other name makes a new section after it (for example `Mods`, `Animals`). |
| `imgBase` | no | Folder the relative images of the page resolve from, relative to the monorepo root. Default: the folder of the `.md`. |
| `mod` | no | `{ "name": "...", "workshopId": "..." }`, shown under the page title with a link to the Workshop page. |
| `order` | no | Number: lower comes first in its group. Default: declaration order. |

Example:

```json
{
  "id": "acg-traits",
  "title": "Animal traits",
  "group": "Mods",
  "source": "AnimalCosmeticGenes/Docs/catalogue.md",
  "imgBase": "AnimalCosmeticGenes/Docs/img",
  "mod": { "name": "Animal Cosmetic Genes", "workshopId": "0000000000" }
}
```

## Markdown subset

Headings (`#` to `####`, the first `# ` line is dropped: the entry's `title` replaces it), pipe tables (a table whose header is `Mod | Names` is folded), bullet lists (`-` or `*`), images `![alt](path)`, links `[text](url)`, `` `code` ``, `**bold**`, paragraphs (one line each, no wrapping across lines). No code fences, no nested lists, no HTML.

## Images

A relative image path (`![x](img/chest.png)`, or a link to an image file) resolves from `imgBase`. An image outside PickleTools is copied to `ColonistRace/docs/catalogues/pages/<id>/` and the page points at the copy, so `index.html` keeps working when PickleTools is published or moved alone: commit that `pages/` folder with `index.html`. An image inside PickleTools keeps a relative path to it. Absolute URLs (`https:`, `data:`) are left alone. A missing image is a warning, the broken path stays in the page.

## Filter box and nav

The nav lists the categories first, then one section per `group`, each with its tabs. The filter box hides the table rows that do not match, on whichever page is open, mod pages included.

The pages that were hard-coded before (`looks`, `apparel`, `genes`...) are the first entries of `pages.json` and keep their category placement rules in the generator (`place`): a page whose file name has no rule gets its own tab, as every mod page does.
