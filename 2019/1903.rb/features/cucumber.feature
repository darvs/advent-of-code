Feature: Crossed Wires

	Find out the manhattan distance to the closest intersections in two wires

	Scenario: Part 1 Test Case 1
		Given the wires in '1903p1x1.in' 
		Then the closest intersection should be at distance 6
		And the shortest wire length to an intersection would be 30

	Scenario: Part 1 Test Case 2
		Given the wires in '1903p1x2.in' 
		Then the closest intersection should be at distance 159
		And the shortest wire length to an intersection would be 610

	Scenario: Part 1 Test Case 3
		Given the wires in '1903p1x3.in' 
		Then the closest intersection should be at distance 135
		And the shortest wire length to an intersection would be 410

	Scenario: Part 1 Puzzle Input
		Given the wires in '1903.in' 
		Then the closest intersection should be at distance 855
		And the shortest wire length to an intersection would be 11238
