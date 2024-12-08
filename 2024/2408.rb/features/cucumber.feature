Feature: Resonant Collinearity

  Solve it

	Scenario: Part 1 smol
		Given the values in file 'smol.in'
    Then the result is 14

	Scenario: Part 1 full
		Given the values in file 'full.in'
    Then the result is 220

	Scenario: Part 2 smol
    Given the values in file 'smol.in'
    When there is resonance
    Then the result is 34 

	Scenario: Part 2 full
    Given the values in file 'full.in'
    When there is resonance
    Then the result is 813
