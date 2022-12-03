Feature: Rucksack

	Rucksack Reorgnization

	Scenario: Part 1 smol
		Given the contents in file '2203.smol.in'
		Then the sum of priorities is 157

	Scenario: Part 1
		Given the contents in file '2203.in'
		Then the sum of priorities is 7597

	Scenario: Part 2 smol
		Given the contents in file '2203.smol.in'
		Then the sum of priorities for trios is 70

	Scenario: Part 2
		Given the contents in file '2203.in'
		Then the sum of priorities for trios is 2607


