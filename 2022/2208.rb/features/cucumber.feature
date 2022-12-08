Feature: Treetop Tree House

	Find out how many trees are visible

	Scenario: Part 1 smol
		Given the content of file '2208.smol.in'
		Then there are 21 visible trees

	Scenario: Part 1
		Given the content of file '2208.in'
		Then there are 1672 visible trees
