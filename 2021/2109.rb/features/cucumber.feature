Feature: Smoke Basin 

	Find the lowest points

	Scenario: Part 1 small sample
		Given the points in file "2109.smol.in"
		Then the sum of the risks is 15
	
	Scenario: Part 1 whole enchilada
		Given the points in file "2109.in"
		Then the sum of the risks is 417

	Scenario: Part 2 small sample
		Given the points in file "2109.smol.in"
		Then the product of the size of the three largest basins is 1134  	

	Scenario: Part 2 whole enchilada
		Given the points in file "2109.in"
		Then the product of the size of the three largest basins is 1148965

