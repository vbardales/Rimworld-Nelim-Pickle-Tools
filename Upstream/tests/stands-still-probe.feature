Feature: stands-still probe (failure paths, both scenarios are EXPECTED to fail)

  # Not part of the pull request. It shows the two failure messages of
  # `I wait until button {string} stands still` in a game. Read the messages in the report:
  # a green here would be the defect.

  Scenario: probe, the button never appears
    When I wait until button "NoSuchButton" stands still

  Scenario: probe, the button never stops moving
    Given a window whose button drifts for 100000 frames
    When I wait until button "Drifting" stands still
