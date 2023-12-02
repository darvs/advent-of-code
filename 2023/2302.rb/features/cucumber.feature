Feature: Cube conundrum

  Determine which games would have been possible

	Scenario: Part 1 smol
		Given the values in file '2302.smol.in'
		Then the sum of ids of possible games is 8

  Scenario: Part 1
    Given the values in file '2302.in'
		Then the sum of ids of possible games is 2600

 	Scenario: Part 2 smol
		Given the values in file '2302.smol.in'
		Then the sum of powers is 2286

 	Scenario: Part 2
		Given the values in file '2302.in'
		Then the sum of powers is 86036

  
