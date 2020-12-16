Feature: Day 16: Ticket Translation

	Find invalid values in tickets

	Scenario: Part 1 small case
		Given the tickets in '2016.smol.in'
		Then the scanning error rate is 71

	Scenario: Part 1
		Given the tickets in '2016.in'
		Then the scanning error rate is 26941

	Scenario: Part 2
		Given the tickets in '2016.in'
		Then the multiplication of departure values is 634796407951

