Feature: Day 24: Lobby Layout

	Find how many tiles have been swapped

	Scenario: Part 1 small cases
		Given the tiles in file "2024.smol.in"
		Then 10 tiles have been switched

	Scenario: Part 1
		Given the tiles in file "2024.in"
		Then 312 tiles have been switched

	Scenario: Part 2 small cases
		Given the tiles in file "2024.smol.in" and the table
			| day | black |
			| 1   | 15    |
			| 2   | 12    |
			| 3   | 25    |
			| 4   | 14    |
			| 5   | 23    |
			| 6   | 28    |
			| 7   | 41    |
			| 8   | 37    |
			| 9   | 49    |
			| 10  | 37    |
			| 20  | 132   |
			| 30  | 259   |
			| 40  | 406   |
			| 50  | 566   |
			| 60  | 788   |
			| 70  | 1106  |
			| 80  | 1373  |
			| 90  | 1844  |
			| 100 | 2208  |
		Then all answers should be verified

	Scenario: Part 2
		Given the tiles in file "2024.in" and the table
			| day | black |
			| 100 | 3733  |
		Then all answers should be verified
