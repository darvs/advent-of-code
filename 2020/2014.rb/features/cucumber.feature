Feature: Day 14: Docking Data

	What is the final content of the memory?

	Scenario: Part 1 small case
		Given the code in '2014.smol.in'
		Then the total of all memory values is 165

	Scenario: Part 1
		Given the code in '2014.in'
		Then the total of all memory values is 5055782549997

	Scenario: Part 2 small case
		Given the code in '2014.smol2.in'
		Then a memory adress decoder would output 208

	Scenario: Part 2
		Given the code in '2014.in'
		Then a memory adress decoder would output 4795970362286
