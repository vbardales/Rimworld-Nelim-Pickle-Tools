# The translation report as an assertion (Nelim's Pickle Tools: the translation report has no problem for the mod "<packageId>"): the game writes its own
# report (Dev, Save translation report), the step keeps only the lines that belong to the named mod. Played in a French pass, on the main menu (no save needed).
# The negative side (a mod that does have missing keys) is checked offline by the parser on a real report: a mod with nothing in the report must pass,
# one with findings must list them.
@requires:nelim.pickletools.screenshotstudio
Feature: Translation report: one mod's lines of the game's report

  Scenario: translation-shot: the report holds nothing for the Pickle Tools studio
    Then Nelim's Pickle Tools: the translation report has no problem for the mod "nelim.pickletools.screenshotstudio"
