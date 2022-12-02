Feature: Calories

	Count calories

	Scenario: Part 1 smol
		Given the numbers in file '2201.smol.in'
		Then the elf with the most calories has 24000

	Scenario: Part 1
		Given the numbers in file '2201.in'
		Then the elf with the most calories has 66616

	Scenario: Part 2 smol
		Given the numbers in file '2201.smol.in'
		Then the top three elves total 45000 calories

	Scenario: Part 2
		Given the numbers in file '2201.in'
		Then the top three elves total 199172 calories

