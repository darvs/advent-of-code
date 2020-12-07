Feature: Day 7: Handy Haversacks

	How many bag colors can eventually contain at least one shiny gold bag?

	Scenario: Part 1 small case
		Given the rules in '2007.smol.in'
		Then 4 bag colors can eventually contain at least one shiny gold bag
	
	Scenario: Part 1
		Given the rules in '2007.in'
		Then 257 bag colors can eventually contain at least one shiny gold bag

	Scenario: Part 2 small case
		Given the rules in '2007.smol.in'
		Then a shiny gold bag contains 32 bags

	Scenario: Part 2
		Given the rules in '2007.in'
		Then a shiny gold bag contains 1038 bags
