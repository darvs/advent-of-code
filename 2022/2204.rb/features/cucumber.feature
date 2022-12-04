Feature: Cleanup 

	Camp Cleanup

	Scenario: Part 1 smol
		Given the contents in file '2204.smol.in'
		Then there are 2 fully containing pairs.

	Scenario: Part 1
		Given the contents in file '2204.in'
		Then there are 509 fully containing pairs.

	Scenario: Part 2 smol
		Given the contents in file '2204.smol.in'
		Then there are 4 overlapping pairs.

	Scenario: Part 2
		Given the contents in file '2204.in'
		Then there are 870 overlapping pairs.
