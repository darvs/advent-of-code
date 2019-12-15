Feature: The N-Body Problem

	Calculate the interaction between n moons

	Scenario Outline:
		Given the moon positions in file <file>
		When <n> steps have been calculated
		Then the total energy in the system would be <energy>

		Examples:

			| file           | n    | energy |
			| "1912.p1-1.in" | 10   | 179    |
			| "1912.p1-2.in" | 100  | 1940   |
			| "1912.in"      | 1000 | 12490  |



