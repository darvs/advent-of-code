Feature: Day 12: Rain Risk

	Where are we going?

	Scenario: Part 1 small case
		Given the direction in '2012.smol.in'
		Then the Manhatten distance from the start would be 25

	Scenario: Part 1
		Given the direction in '2012.in'
		Then the Manhatten distance from the start would be 415

	Scenario: Part 2 small case
		Given the direction in '2012.smol.in'
		Then the Manhatten distance (with a waypoint) from the start would be 286

	Scenario: Part 2
		Given the direction in '2012.in'
		Then the Manhatten distance (with a waypoint) from the start would be 29401
