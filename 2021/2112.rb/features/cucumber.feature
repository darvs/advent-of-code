Feature: Passage Pathing

	Find paths

	Scenario: Part 1 really small sample
		Given the subpaths in file "2112.rlysmol.in"
		Then there is 10 different paths

	Scenario: Part 1 small sample
		Given the subpaths in file "2112.smol.in"
		Then there is 19 different paths

	Scenario: Part 1 kind of small sample
		Given the subpaths in file "2112.kindasmol.in"
		Then there is 226 different paths

	Scenario: Part 1 whole enchilada
		Given the subpaths in file "2112.in"
		Then there is 5076 different paths

