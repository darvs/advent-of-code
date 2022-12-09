Feature: 

	Find out how many trees are visible

	Scenario: Part 1 smol
		Given the content of file '2209.smol.in'
    Then the tail visits 13 positions at least once

	Scenario: Part 1
		Given the content of file '2209.in'
		Then the tail visits 6376 positions at least once

