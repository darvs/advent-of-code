Feature: Day 9: Encoding Error

	The first step of attacking the weakness in the XMAS data is to find the first number
	in the list (after the preamble) which is not the sum of two of the 25 numbers before it. 
	What is the first number that does not have this property?

	Scenario: Part 1 small case
		Given the numbers in '2009.smol.in'
		And a preamble of 5 numbers
		And checking the last 5 numbers
		Then the first non-valid number is 127
		And adding the smallest and largest numbers is 62

	Scenario: Part 1
		Given the numbers in '2009.in'
		And a preamble of 25 numbers
		And checking the last 25 numbers
		Then the first non-valid number is 23278925
		And adding the smallest and largest numbers is 4011064
