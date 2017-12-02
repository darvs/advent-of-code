Feature: Compute Spreadsheet Checksum.
	I need to compute a Spreadsheet Checksum
	A Spreadsheet Checksum is the sum of all each Line Difference
	A Line Difference is the difference between the highest and lowest numbers on a line
	
	Scenario: Compute lowest number for first row
		Given a line such as "5 1 9 5"
		Then the lowest number should be 1

	Scenario: Compute highest number for first row
		Given a line such as "5 1 9 5"
		Then the highest number should be 9

	Scenario: Compute Line Difference for first row
		Given a line such as "5 1 9 5"
		Then the difference should be 8 

	Scenario: Compute lowest number for second row
		Given a line such as "7 5 3  "
		Then the lowest number should be 3

	Scenario: Compute highest number for second row
		Given a line such as "7 5 3  "
		Then the highest number should be 7

	Scenario: Compute Line Difference for second row
		Given a line such as "7 5 3  "
		Then the difference should be 4

	Scenario: Compute Line Difference for third row
		Given a line such as "2 4 6 8"
		Then the difference should be 6

	Scenario: Compute Checksum for sample file
		Given a spreadsheet file such as "2017d02.sample.in"
		Then the checksum should be 18

	Scenario: Compute Checksum for part 1 file
		Given a spreadsheet file such as "2017d02.in"
		Then the checksum should be 41919

	Scenario: Compute Even Division for first row of second spreadsheet 
		Given a line such as "5 9 2 8"
		Then the even division should be 4

	Scenario: Compute Even Division for second row of second spreadsheet 
		Given a line such as "9 4 7 3"
		Then the even division should be 3

	Scenario: Compute Even Division for third row of second spreadsheet 
		Given a line such as "3 8 6 5"
		Then the even division should be 2

	Scenario: Compute Even Division Checksum for part 3 file
		Given a spreadsheet file such as "2017d02.in"
		Then the even division checksum should be 303
