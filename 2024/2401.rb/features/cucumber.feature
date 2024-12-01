Feature: Historian Hysteria

  Find the locations to investigate

	Scenario: Part 1 smol
		Given the values in file '2401.smol.in'
    Then the sum of differences is 11

	Scenario: Part 1
		Given the values in file '2401.in'
		Then the sum of differences is 1189304
