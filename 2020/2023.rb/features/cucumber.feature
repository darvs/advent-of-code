Feature: Day 23: Crab Cups

	Find the labels on the cups after the crab mixes them up

	Scenario: Part 1 small cases
		Given the moves in table
			| start     | moves | end       |
			| 389125467 | 1     | 328915467 |
			| 389125467 | 2     | 325467891 |
			| 389125467 | 3     | 725891346 |
			| 389125467 | 4     | 325846791 |
			| 389125467 | 5     | 925841367 |
			| 389125467 | 6     | 725841936 |
			| 389125467 | 7     | 836741925 |
			| 389125467 | 8     | 741583926 |
			| 389125467 | 9     | 574183926 |
			| 389125467 | 10    | 583741926 |
		Then the moves would be verified

	Scenario: Part 1 small cases
		Given the cups labeled "389125467"
		And 10 moves
		Then the order would be "92658374" 

	Scenario: Part 1 small cases
		Given the cups labeled "389125467"
		And 100 moves
		Then the order would be "67384529"

	Scenario: Part 1
		Given the cups labeled "467528193"
		And 100 moves
		Then the order would be "43769582"


