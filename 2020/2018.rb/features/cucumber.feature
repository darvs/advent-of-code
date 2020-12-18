Feature: Day 11: Seating System

	Find the stable state

	Scenario: Part 1 small cases
		Given the following data
		| priority | equation                                        | answer | 
		| 1        | 1 + 2 * 3 + 4 * 5 + 6                           | 71     |
		| 1        | 2 * 3 + (4 * 5)                           	     | 26     |
		| 1        | 5 + (8 * 3 + 9 + 3 * 4 * 3)                     | 437    |
		| 1        | 5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))       | 12240  |
		| 1        | ((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2 | 13632  |
		Then all answers should be verified

	Scenario: Part 1
		Given the file "2018.in"
		Then the total should be 45840336521334

	Scenario: Part 2 small cases
		Given the following data
		| priority | equation                                        | answer | 
		| 2        | 1 + 2 * 3 + 4 * 5 + 6                           | 231    |
		| 2 	   | 1 + (2 * 3) + (4 * (5 + 6))                     | 51     |
		| 2        | 2 * 3 + (4 * 5)                                 | 46     |
		| 2        | 5 + (8 * 3 + 9 + 3 * 4 * 3)                     | 1445   |
		| 2        | 5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))       | 669060 |
		| 2        | ((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2 | 23340  |
		Then all answers should be verified

	Scenario: Part 2
		Given the file "2018.in"
		And reverse operator priority
		Then the total should be 328920644404583


