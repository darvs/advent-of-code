Feature: Treetop Tree House

	Find out how many trees are visible

	Scenario: Part 1 smol
		Given the content of file '2208.smol.in'
		Then there are 21 visible trees

	Scenario: Part 1
		Given the content of file '2208.in'
		Then there are 1672 visible trees

	Scenario: Scenic Score 1
		Given the content of file '2208.smol.in'
		When we look at the tree at y = 1 and x = 2
		Then the scenic score is 4

	Scenario: Scenic Score 2
		Given the content of file '2208.smol.in'
		When we look at the tree at y = 3 and x = 2
		Then the scenic score is 8

	Scenario: Best smol scenic score
		Given the content of file '2208.smol.in'
		Then the best scenic score is 8

	Scenario: Best scenic score
		Given the content of file '2208.in'
		Then the best scenic score is 327180
