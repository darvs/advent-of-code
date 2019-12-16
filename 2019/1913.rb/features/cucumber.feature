Feature: Care Package

	Create an arcade cabinet using the Intcode computer

	Scenario: Part 1
		Given the code positions in file "1913.in"
		When the program has completed its run
		Then there should be 315 block tiles on the screen
