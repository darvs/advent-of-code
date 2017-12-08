Feature:
	We need to implement an interpreter for register instructions.
	They are in the form `b inc 5 if a > 1`
	We will start will all undefined variables and KEEP our state between scenarios

	Scenario Outline:
		Given the instruction "<code>"
		Then the value of "<var>" should be <val>

		Examples:
			| code                 | var | val |
			| b inc 5 if a > 1     | b   | 0   |
			| a inc 1 if b < 5     | a   | 1   |
			| c dec -10 if a >= 1  | c   | 10  |
			| c inc -20 if c == 10 | c   | -10 |

	Scenario:
		Given the existing context
		Then the largest value in any register would be 1

	Scenario:
		Given the program in file "1708.in"
		Then the largest value in any register would be 7787
		And the largest value in a register ever would be 8997
