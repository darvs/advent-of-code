Feature: Day 11: Seating System

	Find the stable state

	Scenario: Part 1 small case
		Given the seats in '2011.smol.in'
		Then 37 people would be seated once everybody stops moving

	Scenario: Part 1
		Given the seats in '2011.in'
		Then 0 people would be seated once everybody stops moving
