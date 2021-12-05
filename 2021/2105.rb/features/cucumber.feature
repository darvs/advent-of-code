Feature: Hydrothermal Venture

	Hydrothermal Venture

	Scenario: Part 1 small sample
		Given the coordinates in file "2105.smol.in"
		And we ignore diagonals
		Then the lines overlap at 5 points

	#Scenario: Part 1 whole enchilada
		#Given the coordinates in file "2105.in"
		#And we ignore diagonals
		#Then the lines overlap at 5145 points
