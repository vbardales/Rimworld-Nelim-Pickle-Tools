# Captures de galerie: mode d'emploi commun (état 2026-10-06)

Toutes les sessions de mod jouent leurs captures de galerie sur la même scène: la fixture **Nelims-tribe** (Sanctuaire de Nelim, carte 250 x 250).

## Statut

La fixture finale est installée (2026-10-06) : `Nelims-tribe`, midi, sans éclipse, une seule colon (Nelim, c'est Virginie). Les steps ci-dessous existent dans le DLL ScreenshotStudio. Cadrages encore en revue par Virginie : left-bank, gravel-yard, emerald-clearing, barn, preindustrial-workshop, postindustrial-workshop, cotton-field, rice-paddy, flower-garden, hut, dump.

## Personnages et animaux (Virginie, 2026-10-06)

Si vous utilisez le Sanctuaire, le pawn principal est **Nelim** (Virginie, la seule colon de la fixture). Vous pouvez en créer d'autres si le sujet l'exige (`a colonist "<nom>" of kind "<kind>" exists`, voir docs/steps.md ColonistRace).

Animaux de la fixture à utiliser avant d'en créer : les **thrumbos**, et les chiens, dans cet ordre de priorité : **Shogun** (labrador mâle), puis **Yuki** (husky femelle). Pour une scène sans animaux : `Given Nelim's Pickle Tools: all animals are removed`. Je n'ai pas vérifié ces noms dans la sauvegarde : d'après Virginie.

Mods tiers dans les scénarios de capture (Virginie, 2026-10-06) : tout mod qui ajoute des vêtements, des tatouages, des armes, des animaux, des plantes ou des accessoires particuliers est acceptable dans un scénario de capture, comme sujet ou comme décor, à condition que le mod soit dans la liste du -DepMap du scénario.

## Steps

- Charger: `Given the save "Nelims-tribe" is loaded`
- Cadrer un lieu nommé: `Given Nelim's Pickle Tools: I am at the sanctuary "<lieu>"` (ou `When ... I frame the sanctuary "<lieu>"`)
- Nettoyer une zone: `... the sanctuary "<lieu>" is emptied`, `... the animals are removed from the sanctuary "<lieu>"`, `... the roof is removed from the sanctuary "<lieu>"`
- Animaux mis en scène: `an animal of kind "X" named "Y" is spawned at (x, z) at life stage N`, `an adult animal of kind "X" named "Y" is spawned at (x, z)`, `I frame the animal "Y" at zoom N`
- Mode présentation: `Nelim's Pickle Tools: studio presentation mode is enabled`

Lieux, coordonnées et exemples complets: `docs/SANCTUAIRE-LIEUX.md`.

## Carte de dépendances

Ajoutez `screenshotstudio` (et `camerazoom`, `stagedecor`, `inspecttabs`, `screenshotmode` si vous les utilisez) à votre `-DepMap`; modèle: `Tests/Pickle/wsl-deps.sanctuary.map`.

## Sortie

Les images partent dans le dossier de preuves de votre run. Copiez dans `Art/Gallery/` de votre mod uniquement vos propres images retenues. `Art/Gallery/0-preview.png` est produite par `scripts/Render-Preview.cjs` (voir `Art/Preview.config.json`), pas par un scénario.

## Joindre la session Pickle Tools

- Question à la propriétaire du mod: écrivez toujours que **Nelim, c'est elle** (Virginie), la seule colon de la fixture, et non un tiers.
- Session injoignable (archivée, adresse périmée, envoi refusé par la limite de messages): passez par la session **Ticket Manager**, qui relaie.

## Choisir un lieu

Les mods ne voient un lieu que par son nom ou sa description. Avant de choisir, parcourez **tous** les lieux disponibles (table `SanctuarySites` de `ScreenshotStudio/Source/StudioSteps.cs`, ou `docs/SANCTUAIRE-LIEUX.md`) et lisez le nom et la description de chacun. N'en prenez pas un au hasard ni le premier venu: un lieu inconnu fait échouer le step avec la liste des lieux connus.

Conseil de Virginie (2026-10-06) : quand le sujet est une fenêtre de jeu (fiche d'info, dialogue), choisissez `exhibition-zone` (alias `exhibition-area`, `grand-place`) : fond de moquette orange clair, un objet par case, plutôt qu'un intérieur à meubles.

Sol peint ou posé (par exemple le carré vert vif d'`emerald-clearing`) : `Given Nelim's Pickle Tools: the floor of the sanctuary "<lieu>" is bared` (ou `When ... I bare the floor of the sanctuary "<lieu>"`) donne à chaque case du lieu le sol nu de la terre voisine, sans peinture ; murs, toits et objets restent. À jouer AVANT `I am at the sanctuary`. Ajouté le 2026-10-06, en cours de vérification.

Cases libres et meubles : `docs/SANCTUAIRE-CASES.md` donne, pour les lieux d'intérieur et de galerie courants (sofa-corner, sleeping-nook, dining-nook, fire-pit, terrace, emerald-clearing, cloister, hearth-hall, prestige-hall, ritual-hall, calm-zone), les cases libres où poser un sujet et les meubles et étagères avec leurs piles. Pour un autre lieu ou après un changement de fixture : `Given Nelim's Pickle Tools: the sanctuary "<lieu>" is listed` (écrit dans le journal du jeu et joint au rapport). Le mode présentation masque aussi les compteurs de piles et les noms de pawns (Harmony requis dans la map).

Décor : `I place the decor "<def>" at (x, z)`, `I place the decor "<def>" at (x, z) fully grown` (plante adulte d'un seul step), `the plants from (x1, z1) to (x2, z2) are fully grown`, `the decor "<def>" at (x, z) is lit`, `the decor is removed` (StageDecor ; voir docs/steps.md). Ces steps ont été compilés, pas tous joués en jeu par Pickle Tools.

## Aucun lieu ne convient

Un mod peut vider un lieu nommé pour son besoin (`the sanctuary "<lieu>" is emptied`, animaux, meubles). Ce qu'il ne peut pas faire sans en parler à la session Pickle Tools : **créer un lieu au milieu de la nature**, par exemple dégager la bambouseraie pour s'y fabriquer un fond ou une scène. Cela ferait croire qu'aucun lieu existant ne convient parce qu'il n'est pas assez naturel, et cela ôterait le contrôle de proximité des smileys. Si rien ne convient, **prévenez la session Pickle Tools** en décrivant le besoin (taille, sol, fond, lumière, faune) : nous en discutons, nous recueillons les besoins et créons le lieu qui manque.

## Éclairer un lieu sombre

Un lieu couvert et sombre s'éclaire avec des **torches**, **jamais** en retirant le toit: le toit fait partie du bâtiment photographié, et le retirer crée des ombres. `the roof is removed from the sanctuary "<lieu>"` reste une exception pour les tests, pas pour une capture de galerie.

Recette (MegabeesRenew, grange, pas encore jouée): placez plusieurs torches autour du sujet et allumez chacune, par exemple six autour d'une zone de 12 x 12 cases:

```gherkin
Given Nelim's Pickle Tools: I place the decor "TorchLamp" at (x, z)
And Nelim's Pickle Tools: the decor "TorchLamp" at (x, z) is lit
...
And Nelim's Pickle Tools: the decor is removed
```

Retirez le décor (`the decor is removed`) après chaque prise. Si six torches ne suffisent pas, ajoutez-en et signalez-le.
