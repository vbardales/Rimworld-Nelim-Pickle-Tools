# Captures de galerie: mode d'emploi commun (état 2026-10-05)

Toutes les sessions de mod jouent leurs captures de galerie sur la même scène: la fixture **Nelims-tribe** (Sanctuaire de Nelim, carte 250 x 250).

## Statut

La fixture finale n'est PAS encore installée dans `ScreenshotStudio/Mod/Pickle/Fixtures/`. Ne soumettez aucun ticket de galerie avant le message « fixture prête » de la session Pickle Tools. Les steps ci-dessous existent déjà dans le DLL ScreenshotStudio reconstruit, mais ce DLL n'est pas encore committé.

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
