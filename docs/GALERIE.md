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

Les images partent dans le dossier de preuves de votre run. Copiez dans `Art/Gallery/` de votre mod uniquement vos propres images retenues. `Art/Gallery/0-preview.png` est produite par `scripts/Render-Preview.cjs` (voir `Art/Preview.config.json`), pas par un scénario. Nombre d'images : autant qu'on veut, tant que le TOTAL de la galerie reste sous 8 Mo et que CHAQUE image reste sous 2 Mo (Virginie, 2026-10-06 ; une limite à 8 images, annoncée plus tôt, était fausse).

## Joindre la session Pickle Tools

- Question à la propriétaire du mod: écrivez toujours que **Nelim, c'est elle** (Virginie), la seule colon de la fixture, et non un tiers.
- Session injoignable (archivée, adresse périmée, envoi refusé par la limite de messages): passez par la session **Ticket Manager**, qui relaie.

## Choisir un lieu

Les mods ne voient un lieu que par son nom ou sa description. Avant de choisir, parcourez **tous** les lieux disponibles (table `SanctuarySites` de `ScreenshotStudio/Source/StudioSteps.cs`, ou `docs/SANCTUAIRE-LIEUX.md`) et lisez le nom et la description de chacun. N'en prenez pas un au hasard ni le premier venu: un lieu inconnu fait échouer le step avec la liste des lieux connus.

Fenêtre plein écran sur fond de bambous (Virginie, 2026-10-06) : PRIVILÉGIEZ `window-backdrop-for-height` ; prenez `window-backdrop-for-width` seulement si la fenêtre est trop large ou trop peu haute pour lui.  `window-backdrop-for-width` (centre (162, 49), zoom 18) pour une fenêtre LARGE de hauteur limitée : deux smileys (`smiley-bottom-west` et `smiley-bottom-centre`) dépassent dans les deux coins du haut, queue de cheval visible, sans le pavillon de thé. `window-backdrop-for-height` (validé par Virginie) pour une fenêtre HAUTE : centre (90, 140), zoom 47, trois smileys (sud-ouest, rivière, ouest) sur un grand fond de bambous, eau de la rivière à droite avec un cœur d'eau profonde. Retirez les animaux (`all animals are removed`) si vous voulez un fond vide.

Conseil de Virginie (2026-10-06) : quand le sujet est une fenêtre de jeu PLEIN ÉCRAN (fiche d'info, dialogue qui recouvre la carte), choisissez `exhibition-zone` (alias `exhibition-area`, `grand-place`) : fond de moquette orange clair, un objet par case, plutôt qu'un intérieur à meubles. La grande fiche d'information (le bouton « i » : toutes les propriétés d'une espèce ou d'un objet) est un cas de fenêtre plein écran. Un onglet d'inspection (l'onglet Santé d'un pion, un panneau qui laisse voir la carte) n'est pas plein écran : il reste dans le lieu de l'histoire, à son heure.

Sol peint ou posé (par exemple le carré vert vif d'`emerald-clearing`) : `Given Nelim's Pickle Tools: the floor of the sanctuary "<lieu>" is bared` (ou `When ... I bare the floor of the sanctuary "<lieu>"`) donne à chaque case du lieu le sol nu de la terre voisine, sans peinture ; murs, toits et objets restent. À jouer AVANT `I am at the sanctuary`. Ajouté le 2026-10-06, en cours de vérification.

Cases libres et meubles : `docs/SANCTUAIRE-CASES.md` donne, pour les lieux d'intérieur et de galerie courants (sofa-corner, sleeping-nook, dining-nook, fire-pit, terrace, emerald-clearing, cloister, hearth-hall, prestige-hall, ritual-hall, calm-zone), les cases libres où poser un sujet et les meubles et étagères avec leurs piles. Pour un autre lieu ou après un changement de fixture : `Given Nelim's Pickle Tools: the sanctuary "<lieu>" is listed` (écrit dans le journal du jeu et joint au rapport). Le mode présentation masque aussi les compteurs de piles et les noms de pawns (Harmony requis dans la map).

Décor : `I place the decor "<def>" at (x, z)`, `I place the decor "<def>" at (x, z) fully grown` (plante adulte d'un seul step), `the plants from (x1, z1) to (x2, z2) are fully grown`, `the decor "<def>" at (x, z) is lit`, `the decor is removed` (StageDecor ; voir docs/steps.md). Ces steps ont été compilés, pas tous joués en jeu par Pickle Tools.

Une série peut aussi photographier plusieurs fois le même coin d'un lieu, y compris à la même période de la journée : ce n'est pas un problème (Virginie, 2026-10-06). Il n'y a pas de coins nommés. Une série n'a pas besoin d'un lieu nommé différent par image (Virginie, 2026-10-06) : tous les mods peuvent rester dans UN seul lieu, voire le même pour toutes les images, et varier le sujet, l'heure (`I set the hour to N`) et la météo (`I set the weather to "<nom>"`). Choisir plusieurs lieux est permis, jamais obligatoire. `I set the hour` et `I set the weather` sont des steps de Pickle, pas de ScreenshotStudio.

Interface gardée (capture de menu) : `the colonist bar is hidden`, `the learning helper is hidden` (coupe aussi les NOUVELLES cartes d'aide tant que le scénario dure), `the tooltips are hidden` (plus d'infobulle de survol sur la carte), `the resource readout is hidden` (la liste de ressources à gauche), `the alerts are hidden` (les alertes en bas à droite ; les onglets du bas restent), `I move the mouse to (x, y)` (ClickDiagnostics). Les repères de sélection restent si un pion est sélectionné. Ces steps passent par Harmony (carte de dépendances avec ClearScreen ou Harmony) ; compilés, pas tous joués.

Scènes d'animaux : de préférence l'enclos du bas, `enclosure-south`, plus lisible que `enclosure-north` pour des animaux imposants ou des monstres ; l'enclos du haut convient aux animaux de la bambouseraie (pandas, par exemple). Conseil relayé par AnimalArk de la part de Virginie, 2026-10-06.

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

## Où chercher un step avant d'en écrire un

Quatre sources, dans cet ordre :
1. L'inventaire de Pickle Tools : `docs/steps.md` (steps `Nelim's Pickle Tools:`).
2. Les steps de Pickle lui-même : `Docs/steps.md` du dépôt RimWorks/Rimworld-Pickle (dont `I trigger debug action {string}`, pour les actions SANS cible).
3. `Elsewhere/` : les steps restés dans le dépôt d'un mod en attendant une deuxième utilisation (`Elsewhere/README.md`).
4. Les menus de debug du jeu (`[DebugAction]`) : une action qui demande un pion ou une case ne se lance pas par Pickle ; on copie son code dans un step.
Rien dans les quatre : écrivez-le dans votre suite, et signalez-le à Pickle Tools pour `Elsewhere/`.

## Zoom : ce que vaut le nombre N

`I frame the cell (x, z) at zoom N` et `the camera root size is set to N` règlent la **demi-hauteur** de la caméra (root size, N peut être décimal) : le cadre montre **2·N cellules en hauteur** et environ **3,56·N en largeur** (16:9), une cellule fait **540 / N pixels** sur un écran 1080p. Pour H cellules de haut : N = H / 2 ; pour W cellules de large : N = W / 3,56 ; pour un sujet de S cellules qui remplit une part f de la hauteur : N = S / (2·f). Dans le cadrage du Sanctuaire, N va de 2 à 130 ; hors de lui, le jeu borne le zoom. Un « 3 cellules de haut » demandé comme N = 3 donne donc 6 cellules (ACertainSeries, 2026-10-07).
Décaler le sujet pour laisser un panneau à gauche (inspecteur d'environ 500 px) : cadrer la case décalée de N·0,46 cellules vers la gauche.

## Interface gardée : repères et étiquettes

`the selection brackets are hidden` (les repères blancs de la sélection ; la sélection et le panneau d'inspection restent), `the item and name labels are hidden` (compteurs de pile sous les objets, noms sous les pions, icônes d'état des bâtiments ; sans le mode capture, l'interface reste). Harmony requis ; restitués à la fin du scénario.

## Cadrer un rectangle (sujet + animal)

Step : `When Nelim's Pickle Tools: I frame the rectangle from (x1, z1) to (x2, z2)`. Centre la caméra sur le rectangle, prend N = max(hauteur/2, largeur/3,56), une cellule de marge de chaque côté. Compilé, pas encore vu sur une photo. Sans ce step : garder l'animal à moins de 0,8·N cellules du centre en hauteur (z) et 1,5·N en largeur (x), moins une cellule pour la taille du corps.
