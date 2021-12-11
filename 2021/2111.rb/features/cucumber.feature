Feature: Dumbo Octopus

	Find the glowies

	Scenario: Part 1 really small sample
		Given the octopi in file "2111.rly.smol.in"
		And after 1 step
		Then there are 9 glowies

	Scenario: Part 1 small sample
		Given the octopi in file "2111.smol.in"
		And after 10 step
		Then there are 204 glowies

	Scenario: Part 1 small sample
		Given the octopi in file "2111.smol.in"
		And after 100 step
		Then there are 1656 glowies

	Scenario: Part 1 whole enchilada
		Given the octopi in file "2111.in"
		And after 100 step
		Then there are 1642 glowies

	Scenario: Part 1 small sample
		Given the octopi in file "2111.smol.in"
		Then they all sync at step 195

	Scenario: Part 1 whole enchilada
		Given the octopi in file "2111.in"
		Then they all sync at step 320

