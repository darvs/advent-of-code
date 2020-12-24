Feature: Day 23: Crab Combat

	Find the final score

	Scenario: Part 1 small cases
		Given the decks in file "2022.smol.in"
		Then the winning score would be 306

	Scenario: Part 1
		Given the decks in file "2022.in"
		Then the winning score would be 32179

	Scenario: Part 2 small case
		Given the decks in file "2022.smol.in"
		Then the winning score at recursive combat would be 291

	Scenario: Part 2 infinite case
		Given the decks in file "2022.infinite.in"
		Then the winning score at recursive combat would be 105

	Scenario: Part 2
		Given the decks in file "2022.in"
		Then the winning score at recursive combat would be 30498

