Feature:
	We need a CPU emulator that needs to process jump instructions.
	The PC will be our program counter, starting at 0.
	Every instruction is a jump offet, but after being executed the offset is incremented by 1.
	However, sometimes the jumps are even stranger.
	When the jumps are stranger, if the offset is equal or bigger than 3 then it is decremented by 1 instead.
		In other case, it is incremented by 1 as usual.
	Emulation stops when the PC is outside of the program.

	Scenario Outline:
		Given the program is <prg>
		And the PC is <pc>
		Then after a single step the program should be <result>
		Then the PC should be <pc2>

		Examples:
			| prg    | pc | result     | pc2 |
			| "0 3 0 1 -3" | 0  | "1 3 0 1 -3" | 0   |
			| "1 3 0 1 -3" | 0  | "2 3 0 1 -3" | 1   |
			| "2 3 0 1 -3" | 1  | "2 4 0 1 -3" | 4   |
			| "2 4 0 1 -3" | 4  | "2 4 0 1 -2" | 1   |
			| "2 4 0 1 -2" | 1  | "2 5 0 1 -2" | 5   |

	Scenario:
		Given the program is "0 3 0 1 -3"
		Then it should exit in 5 steps

	Scenario:
		Given the program file "1705.in"
		Then it should exit in 342669 steps

	Scenario:
		Given the program is "0 3 0 1 -3"
		And the jumps are stranger
		Then it should exit in 10 steps

	Scenario:
		Given the program file "1705.in"
		And the jumps are stranger
		Then it should exit in 25136209 steps


