Feature: The Treachery of Whales

	The Treachery of Whales

	Scenario: Part 1 small sample
		Given the positions in file "2107.smol.in"
		Then the most economical fuel amount would be 37

	Scenario: Part 1 whole enchilada
		Given the positions in file "2107.in"
		Then the most economical fuel amount would be 344138

	Scenario: Part 2 small sample
		Given the positions in file "2107.smol.in"
		And using crab engineering measurements
		Then the most economical fuel amount would be 168

	Scenario: Part 2 whole enchilada
		Given the positions in file "2107.in"
		And using crab engineering measurements
		Then the most economical fuel amount would be 94862124
