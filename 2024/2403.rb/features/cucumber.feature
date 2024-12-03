Feature: Mull it Over

  Do the computations

	Scenario: Part 1 smol
		Given the values in file '2403.smol.in'
    Then the result is 161

	Scenario: Part 1
		Given the values in file '2403.in'
    Then the result is 155955228

	Scenario: Part 2 smol
		Given the values in file '2403.smol2.in'
    Then the result with do's and don'ts is 48

	Scenario: Part 2
		Given the values in file '2403.in'
    Then the result with do's and don'ts is 100189366  

