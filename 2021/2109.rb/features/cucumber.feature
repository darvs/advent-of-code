Feature: Smoke Basin 

	Find the lowest points

	Scenario: Part 1 small sample
		Given the points in file "2109.smol.in"
		Then the sum of the risks is 15
	
	Scenario: Part 1 whole enchilada
		Given the points in file "2109.in"
		Then the sum of the risks is 0


