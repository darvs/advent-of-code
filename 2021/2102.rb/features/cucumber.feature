Feature: Dive!

	Find out where we dive

	Scenario: Part 2 small sample
		Given the numbers in file "2102.smol.in"
		Then we end up at a value of 900

	Scenario: Part 2 whole enchilada
		Given the numbers in file "2102.in"
		Then we end up at a value of 1408487760
