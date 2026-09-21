Feature: fail-fast probe
  Scenario: first passes
    Then no warnings from mod "RimLogging"

  Scenario: second fails
    Then no warnings from mod "NoSuchModAnywhere"

  Scenario: third would pass
    Then no warnings from mod "RimLogging"
