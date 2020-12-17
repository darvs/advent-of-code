Feature: Day 17: Conway Cubes

	How many cubes are lit?

	Scenario: Part 1 small case
		Given the starting map in '2017.smol.in'
		And 3 dimensions
		Then after 6 cycles, 112 are left active

	Scenario: Part 1
		Given the starting map in '2017.in'
		And 3 dimensions
		Then after 6 cycles, 380 are left active

	Scenario: Part 2 
		Given the starting map in '2017.in'
		And 4 dimensions
		Then after 6 cycles, 2332 are left active


