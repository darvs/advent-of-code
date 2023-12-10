Feature: Wait For It

  Find out the number of ways you can beat the records.

	Scenario: Part 1 smol
		Given the values in file '2306.smol.in'
    Then if you multiply the number of ways you get 288

	Scenario: Part 1 
		Given the values in file '2306.in'
    Then if you multiply the number of ways you get 281600

	Scenario: Part 2 smol
    Given the values in file '2306.smol.in'
    When the values are badly kerned
    Then if you multiply the number of ways you get 71503

	Scenario: Part 2
    Given the values in file '2306.in'
    When the values are badly kerned
    Then if you multiply the number of ways you get 33875953 
