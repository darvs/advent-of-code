Feature: Red-Nosed 

  Check the reports

	Scenario: Part 1 smol
		Given the values in file '2402.smol.in'
    Then 2 reports are safe

	Scenario: Part 1
		Given the values in file '2402.in'
    Then 524 reports are safe

	Scenario: Part 2 smol
		Given the values in file '2402.smol.in'
    Then 4 reports are safe with a dampen

	Scenario: Part 2
		Given the values in file '2402.in'
    Then 569 reports are safe with a dampen
