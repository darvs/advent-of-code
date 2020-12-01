Feature: Report Repair 

	Find the two entries that sum to 2020; what do you get if you multiply them together?

	Scenario: Part 1 smol case
		Given the number in file '2001.smol.in'
		Then the multiplication of 2 numbers would be 514579

	Scenario: Part 1
		Given the number in file '2001.in'
		Then the multiplication of 2 numbers would be 121396

	Scenario: Part 2 smol case
		Given the number in file '2001.smol.in'
		Then the multiplication of 3 numbers would be 241861950

	Scenario: Part 2 
		Given the number in file '2001.in'
		Then the multiplication of 3 numbers would be 73616634
