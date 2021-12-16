Feature: Chitauri

	Find the lowest risk in a Chiton cave

	Scenario: Part 1 small counts
		Given the map in file "2115.smol.in"
		Then lowest total risk is 40

	Scenario: Part 1 enchilada count
		Given the map in file "2115.in"
		Then lowest total risk is 0
