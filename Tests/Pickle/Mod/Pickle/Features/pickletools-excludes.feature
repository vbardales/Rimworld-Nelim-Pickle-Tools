# The @excludes: tag of PickleTools/Excludes, played against stock Pickle.
#
# Pass map: Tests/Pickle/wsl-deps.excludes.map. Expected report: 1 passed, 1 skipped.
#
# The first scenario names a mod that is always loaded (Pickle itself), so it must be SKIPPED; its
# only step cannot pass (no such window is ever open), so a run that does not skip it fails here.
# The second names a mod that is never loaded, so it must RUN and pass: the control, without which
# a tag that skipped every scenario would look like a working tag.
Feature: PickleTools excludes tag

  Background:
    Given the save "test-colony" is loaded

  @excludes:rimworks.pickle
  Scenario: a loaded mod excludes the scenario
    Then window "Dialog_NoSuchWindowForTheExcludesProbe" is open

  @excludes:nelim.no.such.mod
  Scenario: an absent mod does not exclude the scenario
    Then window "Dialog_NoSuchWindowForTheExcludesProbe" is closed
