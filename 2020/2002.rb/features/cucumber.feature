Feature: Password Philosophy

	How many passwords are valid according to their policies?

	Scenario: Part 1 smol case
		Given the policies and passwords in file '2002.smol.in'
		Then according to rule 1 there would be 2 valid passwords

	Scenario: Part 1 
		Given the policies and passwords in file '2002.in'
		Then according to rule 1 there would be 460 valid passwords

	Scenario: Part 2 smol case
		Given the policies and passwords in file '2002.smol.in'
		Then according to rule 2 there would be 1 valid passwords

	Scenario: Part 2
		Given the policies and passwords in file '2002.in'
		Then according to rule 2 there would be 251 valid passwords
