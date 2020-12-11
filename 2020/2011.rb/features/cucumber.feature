Feature: Day 11: Seating System

	Find the stable state

	Scenario: Part 1 small case
		Given the seats in '2011.smol.in'
		And a tolerance of 4 people
		Then 37 people would be seated once everybody stops moving

	Scenario: Part 1
		Given the seats in '2011.in'
		And a tolerance of 4 people
		Then 2324 people would be seated once everybody stops moving

	Scenario: Part 2 small case
		Given the seats in '2011.smol.in'
		And a tolerance of 5 people
		And an infinite horizon
		Then 26 people would be seated once everybody stops moving

	Scenario: Part 2
		Given the seats in '2011.in'
		And a tolerance of 5 people
		And an infinite horizon
		Then 2068 people would be seated once everybody stops moving


