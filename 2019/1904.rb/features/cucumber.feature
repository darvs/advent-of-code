Feature: Secure Container

	Find out is a password is valid or not.

	Scenario: Part 1 Test Case 1
		Given the password 122345 
		Then it is valid

	Scenario: Part 1 Test Case 2
		Given the password 111123
		Then it is valid

	Scenario: Part 1 Test Case 3
		Given the password 135679
		Then it is invalid

	Scenario: Part 1 Test Case 4
		Given the password 111111
		Then it is valid

	Scenario: Part 1 Test Case 5
		Given the password 223450
		Then it is invalid

	Scenario: Part 1 Test Case 6
		Given the password 123789
		Then it is invalid

	Scenario: Part 1 Test Case 7
		Given the range 122345 to 122345
		Then 1 passwords meet the criteria for the first part

	Scenario: Part 1
		Given the range 284639 to 748759
		Then 895 passwords meet the criteria for the first part

	Scenario: Part 2 Test Case 1
		Given the password 112233
		Then it is valid for part two

	Scenario: Part 2 Test Case 2
		Given the password 123444
		Then it is invalid for part two

	Scenario: Part 2 Test Case 3
		Given the password 111122
		Then it is valid for part two

	Scenario: Part 2 Test Case 4
		Given the password 111223
		Then it is valid for part two

	Scenario: Part 2 Test Case 5
		Given the password 122233
		Then it is valid for part two

	Scenario: Part 2 Test Case 6
		Given the password 122234
		Then it is invalid for part two

	Scenario: Part 2
		Given the range 284639 to 748759
		Then 591 passwords meet the criteria for the second part
