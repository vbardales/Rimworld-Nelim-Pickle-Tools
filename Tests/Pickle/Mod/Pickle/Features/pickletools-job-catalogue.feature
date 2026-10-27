# Lists every job (with a driver) and the work givers of the loaded game as [look-job] and [look-workgiver] lines in the log, for the job pose
# catalogue (one pose per job, drawn with Show Me Your Tools: ColonistRace/docs/catalogues/jobs.md). Not a test: it never fails on a value.
# Written 2026-10-25, NOT PLAYED.
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.look-gallery.map -Filter 'pickletools-job-catalogue'
@requires:nelim.pickletools.colonistrace
Feature: PickleTools job catalogue
  Scenario: the job options are listed
    Given the save "Nelims-tribe" is loaded
    And Nelim's Pickle Tools: the job options are listed
