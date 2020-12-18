Feature: Day 11: Seating System

	Find the stable state

	Scenario: Part 1 small case
		Given the equation "1 + 2 * 3 + 4 * 5 + 6"
		Then the answer should be 71

	Scenario: Part 1
		Given the file "2018.in"
		Then the total should be 45840336521334

	Scenario: Part 2 small case
		Given the equation "1 + 2 * 3 + 4 * 5 + 6"
		And reverse operator priority
		Then the answer should be 231

	Scenario: Part 2 small case 2
		Given the equation "1 + (2 * 3) + (4 * (5 + 6))"
		And reverse operator priority
		Then the answer should be 51

	Scenario: Part 2 small case 3
		Given the equation "2 * 3 + (4 * 5)"
		And reverse operator priority
		Then the answer should be 46

	Scenario: Part 2 small case 4
		Given the equation "5 + (8 * 3 + 9 + 3 * 4 * 3)"
		And reverse operator priority
		Then the answer should be 1445

	Scenario: Part 2 small case 5
		Given the equation "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"
		And reverse operator priority
		Then the answer should be 669060  

	Scenario: Part 2 small case 6 
		Given the equation "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"
		And reverse operator priority
		Then the answer should be 23340

	Scenario: Part 2
		Given the file "2018.in"
		And reverse operator priority
		Then the total should be 0 







