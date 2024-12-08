Feature: Bridge Repair

  Solve it

	Scenario: Part 1 smol
		Given the values in file 'smol.in'
    Then the result is 3749

	Scenario: Part 1 full
		Given the values in file 'full.in'
    Then the result is 42283209483350

	Scenario: Part 2 smol
		Given the values in file 'smol.in'
    When we use concatenation as well
    Then the result is 11387

	Scenario: Part 2 full
		Given the values in file 'full.in'
    When we use concatenation as well
    Then the result is 1026766857276279 


