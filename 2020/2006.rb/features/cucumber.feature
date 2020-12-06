Feature: Day 6: Custom Customs

	For each group, count the number of questions to which anyone answered "yes". What is the sum of those counts?

	Scenario: Part 1 small case
		Given the custom declarations in '2006.smol.in'
		Then the sum of the counts is 11

	Scenario: Part 1
		Given the custom declarations in '2006.in'
		Then the sum of the counts is 6911

	Scenario: Part 2 small case
		Given the custom declarations in '2006.smol.in'
		Then the sum of the questions to which everyone in a group answered yes is 6

	Scenario: Part 2
		Given the custom declarations in '2006.in'
		Then the sum of the questions to which everyone in a group answered yes is 3473
