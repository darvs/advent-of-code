Feature: Squid Game 

	Let's play Squid Game

	Scenario: Part 1 small sample
		Given the numbers in file "2104.smol.in"
		And we play to win
		Then the winning number is 24
		And the sum of unmarked squares is 188
		And the sum of unmarked squares multiplied by the winning number is 4512

	Scenario: Part 1 whole enchilada
		Given the numbers in file "2104.in"
		And we play to win
		Then the sum of unmarked squares multiplied by the winning number is 5685

	Scenario: Part 2 small sample
		Given the numbers in file "2104.smol.in"
		And we play to lose
		Then the sum of unmarked squares multiplied by the winning number is 1924

	Scenario: Part 2 whole enchilada
		Given the numbers in file "2104.in"
		And we play to lose
		Then the sum of unmarked squares multiplied by the winning number is 21070



