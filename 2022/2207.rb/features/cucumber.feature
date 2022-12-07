Feature: No Space Left on Device

	Create a shell to explore disk space.

	Scenario: Part 1 smol
		Given the content of file '2207.smol.in'
		Then the sum of the size is 95437

	Scenario: Part 1
		Given the content of file '2207.in'
		Then the sum of the size is 1644735   

	Scenario: Part 2 smol
		Given the content of file '2207.smol.in'
		Then the minimum space to free is 24933642 

	Scenario: Part 2
		Given the content of file '2207.in'
		Then the minimum space to free is 1300850
