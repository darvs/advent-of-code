Feature: Report Repair 

	Find the two entries that sum to 2020; what do you get if you multiply them together?

	Scenario: Part 1 smol case
		Given the number in file '2001.smol.in'
		Then the answer would be 514579

	Scenario: Part 1
		Given the number in file '2001.in'
		Then the answer would be 121396

