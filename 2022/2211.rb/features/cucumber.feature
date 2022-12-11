Feature: 

	Fix the Cathode-Ray Tube

	Scenario: Part 1 smol
    Given the content of file '2211.smol.in'
    And after 20 rounds
    And a worry level divider of 3
    Then the level of monkey business is 10605

	Scenario: Part 1
    Given the content of file '2211.in'
    And after 20 rounds
    And a worry level divider of 3
    Then the level of monkey business is 57838

	Scenario: Part 2 smol
    Given the content of file '2211.smol.in'
    And after 1000 rounds
    And a worry level divider of 1
    Then the level of monkey business is 0


