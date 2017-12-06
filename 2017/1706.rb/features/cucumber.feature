Feature:
	We need to simulate memory reallocation.
	We need to detect loops.

	Scenario:
		Given the memory banks "0 2 7 0"
		Then bank # 2 with 7 items would be chosen for redistribution

	Scenario Outline:
		Given the memory banks <banks>
		Then after one redistribution it should look like <result>

		Examples:
			| banks     | result    |
			| "0 2 7 0" | "2 4 1 2" | 
			| "2 4 1 2" | "3 1 2 3" |
			| "3 1 2 3" | "0 2 3 4" |
			| "0 2 3 4" | "1 3 4 1" |
			| "1 3 4 1" | "2 4 1 2" |

	Scenario:
		Given the memory banks "0 2 7 0"
		Then it would take 5 steps to enter an infinite loop
		And the loop would have a length of 4
	
	Scenario:
		Given the memory bank file "1706.in"
		Then it would take 7864 steps to enter an infinite loop
		And the loop would have a length of 1695
