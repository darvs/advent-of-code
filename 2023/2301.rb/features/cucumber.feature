Feature: Trebuchet?!

  Compute the sum of calibration values	

	Scenario: Part 1 smol
		Given the values in file '2301.smol.in'
		Then the sum of calibration values is 142

	Scenario: Part 1
		Given the values in file '2301.in'
		Then the sum of calibration values is 54968

