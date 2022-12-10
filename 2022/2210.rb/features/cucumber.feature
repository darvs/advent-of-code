Feature: 

	Fix the Cathode-Ray Tube

	Scenario: Part 1 smol 1
    Given the content of file '2210.smol1.in'
		And the table
			| cycle | value |
			| 1     | 1     |
			| 2     | 1     |
      | 3     | 1     |
      | 4     | 4     |
      | 5     | 4     |
      | 6     | -1    |
    Then all answers should be verified.

  Scenario: Part 1 smol 2
    Given the content of file '2210.smol2.in'
    And the table
    	| cycle | value |
      | 20    | 21    |
      | 60    | 19    |
      | 100   | 18    |
      | 140   | 21    |
      | 180   | 16    |
      | 220   | 18    |
    Then all answers should be verified.

  Scenario: Part 1 smol 2 strengths
    Given the content of file '2210.smol2.in'
    Then the sum of interesting signal strengths must be 13140

  Scenario: Part 1 strengths
    Given the content of file '2210.in'
    Then the sum of interesting signal strengths must be 14240

