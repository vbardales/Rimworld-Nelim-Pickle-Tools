# Does a dyed garment keep its colour once the colonist drops it (DrumBathHygiene: the bath job drops the clothes beside the tub)?
# The drop step uses the game's own Pawn_ApparelTracker.TryDrop and logs "[drop] ..." (same Thing, comp state, colours before and after).
#
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.colonistrace.map -Filter pickletools-colonistrace-dropped-clothes
@requires:nelim.pickletools.colonistrace
Feature: PickleTools dyed clothes keep their colour on the ground

  Background:
    Given the save "test-colony" is loaded

  Scenario: a dyed shirt dropped by its wearer keeps its colour
    Given a colonist "Ash" exists
    And Nelim's Pickle Tools: "Ash" wears "Apparel_BasicShirt" dyed rgb (238, 224, 190)
    When Nelim's Pickle Tools: "Ash" drops its clothes
    Then Nelim's Pickle Tools: the "Apparel_BasicShirt" dropped by "Ash" is drawn in rgb (238, 224, 190)
