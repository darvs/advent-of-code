Feature: Day 8: Handheld Halting

	Immediately before any instruction is executed a second time, what value is in the accumulator?

	Scenario: Part 1 small case
		Given the program in '2008.smol.in'
		Then 5 is in the accumulator just before any instruction is executed a second time.

	Scenario: Part 1
		Given the program in '2008.in'
		Then 1684 is in the accumulator just before any instruction is executed a second time.

	Scenario: Part 2 small case
		Given the program in '2008.smol.in'
		Then 8 is in the accumulator at the end when the program is debugged.

	Scenario: Part 2
		Given the program in '2008.in'
		Then 2188 is in the accumulator at the end when the program is debugged.
