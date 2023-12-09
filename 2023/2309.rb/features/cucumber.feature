Feature: Mirage Maintenance

  What is the sum of these extrapolated values

	Scenario: Part 1 smol 1
    Given the values in file '2309.smol1.in'
    Then the sum of extrapolated values is 18

	Scenario: Part 1 smol 2
    Given the values in file '2309.smol2.in'
    Then the sum of extrapolated values is 28

	Scenario: Part 1 smol 3
    Given the values in file '2309.smol3.in'
    Then the sum of extrapolated values is 68

	Scenario: Part 1 smol
    Given the values in file '2309.smol.in'
    Then the sum of extrapolated values is 114

	Scenario: Part 1
    Given the values in file '2309.in'
    Then the sum of extrapolated values is 1974913025  

	Scenario: Part 2 smol 3
    Given the values in file '2309.smol3.in'
    Then the sum of the first values is 5

	Scenario: Part 2 smol 2
    Given the values in file '2309.smol2.in'
    Then the sum of the first values is 0

  Scenario: Part 2 smol
    Given the values in file '2309.smol.in'
    Then the sum of the first values is 2

  Scenario: Part 2
    Given the values in file '2309.in'
    Then the sum of the first values is 884
