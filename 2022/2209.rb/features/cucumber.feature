Feature: 

	Find out how many trees are visible

	Scenario: Part 1 smol
    Given the content of file '2209.smol.in'
    When there are 2 knots
    Then the tail visits 13 positions at least once

  Scenario: Part 1
    Given the content of file '2209.in'
    When there are 2 knots
    Then the tail visits 6376 positions at least once

  Scenario: Part 2 smol
    Given the content of file '2209.smol.in'
    When there are 10 knots
    Then the tail visits 1 positions at least once

  Scenario: Part 2 smol 2
    Given the content of file '2209.smol2.in'
    When there are 10 knots
    Then the tail visits 36 positions at least once

  Scenario: Part 2
    Given the content of file '2209.in'
    When there are 10 knots
    Then the tail visits 2607 positions at least once




