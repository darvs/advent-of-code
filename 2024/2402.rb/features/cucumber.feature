Feature: Red-Nosed 

  Check the reports

	Scenario: Part 1 smol
		Given the values in file '2402.smol.in'
    Then 2 reports are safe

	Scenario: Part 1
		Given the values in file '2402.in'
    Then 0 reports are safe
