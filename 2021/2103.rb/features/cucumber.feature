Feature: Binary Diagnostic

	Find out the gamma and epsilon rate

	Scenario: Part 1 small sample
		Given the numbers in file "2103.smol.in"
		Then the power consumption of the submarine is 198

	Scenario: Part 1 whole enchilada
		Given the numbers in file "2103.in"
		Then the power consumption of the submarine is 2595824

