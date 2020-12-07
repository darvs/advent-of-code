Feature: Day 7: Handy Haversacks

	How many bag colors can eventually contain at least one shiny gold bag?

	Scenario: Part 1 small case
		Given the rules in '2007.smol.in'
		Then 4 bag colors can eventually contain at least one shiny gold bag
	
	Scenario: Part 1
		Given the rules in '2007.in'
		Then 0 bag colors can eventually contain at least one shiny gold bag
