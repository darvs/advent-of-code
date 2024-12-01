Feature: Aplenty

  Sort the machine parts

	Scenario: Part 1 smol 1
    Given the values in file '2319.smol.in'
    Then the sum of ratings of accepted parts is 19114

	Scenario: Part 1
    Given the values in file '2319.in'
    Then the sum of ratings of accepted parts is 319062
 
