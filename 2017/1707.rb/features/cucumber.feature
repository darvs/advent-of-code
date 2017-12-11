Feature:
	In a program tower every program has a weight and a list of program that it supports
	That list can be empty for program at the top of the tower
	At the bottom of the tower there is only one program which supports the whole tower

	Scenario:
		Given a program describes itself as "pbga (66)"
		Then its name is "pbga"
		And its weight is 66
		And its supported list length is 0

	Scenario:
		Given a program describes itself as "fwft (72) -> ktlj, cntj, xhth"
		Then its name is "fwft"
		And its weight is 72
		And its supported list length is 3

	Scenario:
		Given a program list file of "1707.sample.in"
		Then the program at the bottom is "tknk"
		And the correct weight to balance is 60

	Scenario Outline:
		Given a program list file of "1707.sample.in"
		Then the total weight for "<program>" is <weight>

		Examples:
			| program | weight |
			| gyxo    | 61     |
			| ebii    | 61     |
			| jptl    | 61     |
			| ugml    | 251    |
			| padx    | 243    |
			| fwft    | 243    |

	Scenario:
		Given a program list file of "1707.in"
		Then the program at the bottom is "vgzejbd"
		And the correct weight to balance is 1226
