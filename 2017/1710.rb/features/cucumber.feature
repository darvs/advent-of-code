Feature:
	We need to implement a software emulation of a hash.

	To achieve this, begin with a list of numbers from 0 to 255, a current position which begins at 0 (the first element in the list), a skip size (which starts at 0), and a sequence of lengths (our puzzle input). Then, for each length:

	Steps:

	1) Reverse the order of that length of elements in the list, starting with the element at the current position.
	2) Move the current position forward by that length plus the skip size.
	3) Increase the skip size by one.

	The list is circular.

	Scenario:
		Given a list of length 5 with elements counting from 0
		And a list of input lengths of "3,4,1,5"
		Then our current position should be 0
		And the skip size should be 0

	Scenario Outline:
		Given the same list and input lengths
		Then one step should modify our list to "<list>"
		And our current position should be <index>
		And the skip size should be <skip>

		Examples:
			| list      | index | skip |
			| 2 1 0 3 4 | 3     | 1    |
			| 4 3 0 1 2 | 3     | 2    |
			| 4 3 0 1 2 | 1     | 3    |
			| 3 4 2 1 0 | 4     | 4    |

	Scenario:
		Given the same list and input lengths
		Then our first two elements multiplied together should be 12

	Scenario:
		Given a list of length 256 with elements counting from 0
		And the list of input lengths in file "1710.in"
		Then after 1 rounds our first two elements multiplied together should be 5577

	Scenario Outline:
		Given a list of length 256 with elements counting from 0
		And a binary list of input lengths of <binary>
		Then the hexadecimal dense hash is "<hash>"

		Examples:
			| binary     | hash                             |
			| ""         | a2582a3a0e66e6e86e3812dcb672a272 |
			| "AoC 2017" | 33efeb34ea91902bb2f59c9920caa6cd |
			| "1,2,3"    | 3efbe78a8d82f29979031a4aa0b16a9d |
			| "1,2,4"    | 63960835bcdc130f0b66d7ff4f6a5a8e |

	Scenario:
		Given a list of length 256 with elements counting from 0
		And the binary list of input lengths in file "1710.in"
		Then the hexadecimal dense hash is "44f4befb0f303c0bafd085f97741d51d"

