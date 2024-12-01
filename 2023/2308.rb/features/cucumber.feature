Feature: Haunted Wasteland

  How many steps are required to reach ZZZ

	Scenario: Part 1 smol 1
    Given the values in file '2308.smol1.in'
    When starting from AAA
    Then it takes 2 steps to reach ZZZ

	Scenario: Part 1 smol 2 
		Given the values in file '2308.smol2.in'
    When starting from AAA
    Then it takes 6 steps to reach ZZZ

	Scenario: Part 1
		Given the values in file '2308.in'
    When starting from AAA
    Then it takes 11911 steps to reach ZZZ

	Scenario: Part 2 smol
    Given the values in file '2308p2.smol.in'
    Then it takes 6 steps to reach ZZZ

	Scenario: Part 2 
		Given the values in file '2308.in'
    Then it takes 0 steps to reach ZZZ


