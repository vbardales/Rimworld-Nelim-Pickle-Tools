# Le Sanctuaire de Nelim

Cahier des charges du studio de prises de vue qui remplace la fixture zenNelim. Les sections 23 à 26 sont de Virginie (collées le 2026-10-03, d'une autre conversation) ; les sections 1 à 22 n'existent pas dans ce dépôt. Périmètre : Core et les cinq DLC, aucun autre mod.

État au 2026-10-03 : un premier jet est enregistré dans la sauvegarde `dream-japanese-house` (maison japonaise en bois à deux pièces, jardin d'eau, rivière, bambou, plantations, smiley d'origine). Il n'a ni faune ni accents vifs, et son cercle orange est à refaire. Voir `docs/FIXTURES.md` pour ce que contient le studio d'origine.

## 23. Couleur : zen ne signifie pas terne

Le Sanctuaire de Nelim doit avoir une base naturelle (bambou, bois, eau, pierre, végétation) mais accepter des accents franchement vifs et joyeux.

Les pierres Glitterworld sont une référence importante pour cette intention : couleurs saturées, jolies, presque précieuses, utilisées comme petites surprises visuelles.

Comme elles ne font pas partie du périmètre RW + DLC, on ne les prend pas comme dépendance. En revanche, elles donnent une direction pour chercher des équivalents disponibles dans le jeu de base ou les DLC ou, si vraiment un élément devient indispensable, décider plus tard s'il mérite d'être intégré à Pickle Tools.

Les couleurs vives peuvent apparaître dans :

* fleurs et plantations ;
* textiles, coussins et tapis ;
* objets personnels de Nelim ;
* détails du jardin ;
* petites sculptures ;
* pierres et minéraux lorsque les assets disponibles le permettent ;
* signatures Nelim ;
* accessoires kawaii.

Le orange Nelim reste une couleur signature, mais n'a pas besoin d'être la seule couleur vive.

Règle esthétique : **le calme vient de la composition, pas de l'absence de couleurs.** On peut avoir un petit caillou turquoise, des fleurs roses, un objet orange et un textile violet dans une scène parfaitement zen.

## 24. Faune permanente du Sanctuaire

Il ne faut pas remplir le sanctuaire avec toutes les espèces : préserver le calme, éviter l'effet zoo. On crée une petite population permanente, choisie pour ses silhouettes, ses tailles et les scènes qu'elle produit.

### Résidents emblématiques

* **LabradorRetriever** : incontournable, à la fois un des animaux totems et un excellent compagnon de Nelim.
* **Cat** : petit, parfait à caméra 10, facile à placer autour de la maison et de l'engawa.
* **Thrumbo** : une énorme silhouette fantastique. Un seul. Gardien paisible du sanctuaire, aperçu dans le jardin ou entre les bambous plutôt que planté devant la maison.

Trois échelles très différentes, excellentes photographiquement : `Cat 0.32 → Labrador 0.75 → Thrumbo 4.00`.

### Petite faune kawaii

Candidats : Squirrel, GuineaPig, Chinchilla, Hare, Otter, Capybara, Duck, Swan, Bluebird et éventuellement Panda. **Une sélection seulement à la fois.**

* Otter : faite pour le réseau d'eau. Un ou deux petits animaux près des canaux donnent de la vie aux captures.
* Canards et cygnes : le même rôle sur les bassins.
* Écureuils, lièvres et oiseaux : plutôt aux limites végétales du sanctuaire.
* Panda : très raccord avec la bambouseraie et le côté kawaii. Au moins une apparition, pas nécessairement résident permanent.

## 25. Faune par zones plutôt qu'enclos

| Zone | Faune |
|---|---|
| Maison, engawa | Chat et Labrador |
| Jardin aménagé | Petits oiseaux, éventuellement écureuils et petits animaux |
| Eau et jardin humide | Loutre, canards ou cygnes selon la scène |
| Bambouseraie | Thrumbo, panda ou faune sauvage occasionnelle |
| Cultures | Quelques petites bestioles ou oiseaux lorsque cela sert la scène |

Le sanctuaire ne comporte aucun gros enclos visuellement dominant. Si des contraintes techniques imposent des zones, elles sont dissimulées dans la composition.

## 26. Les animaux comme props vivants

Un studio n'est pas une partie : on ne subit pas le hasard de RimWorld. Les animaux font partie de la mise en scène photographique. On doit pouvoir demander, par exemple :

* Nelim assise sur l'engawa, Labrador couché à proximité, chat dans un coin ;
* bâtiment au bord de l'eau, loutre dans le canal, végétation pleinement développée ;
* capture large du sanctuaire, Thrumbo entre les bambous à l'arrière-plan.

Cela rejoint StageDecor (`StageDecor/README.md`) : une partie de la faune est permanente, une autre est introduite pour une scène puis retirée.

### Les animaux totems

Le foxsquirrel n'est pas simplement `Fox_Red + Squirrel`, et le blocmâchoire n'est pas représenté dans la liste sous ce nom. On ne les remplace pas par des animaux « presque pareils ». Les cinq totems restent une catégorie propre :

`foxsquirrel` · `thrumbo` · `labrador` · `chat` · `blocmâchoire`

Quand leur contenu réel est disponible dans l'environnement de la galerie, on les utilise comme casting Nelim officiel. Le reste de la liste constitue la faune de décor disponible.
