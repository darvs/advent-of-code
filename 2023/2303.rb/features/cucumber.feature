Feature: Gear ratios

  Find all part numbers and gear ratios in the engine schematic 

	Scenario: Part 1 smol
		Given the values in file '2303.smol.in'
    Then the sum of all parts numbers is 4361 

	Scenario: Part 1
		Given the values in file '2303.in'
    Then the sum of all parts numbers is 546312

	Scenario: Part 2 smol
		Given the values in file '2303.smol.in'
    Then the sum of all gear ratios is 467835

	Scenario: Part 2
		Given the values in file '2303.in'
    Then the sum of all gear ratios is 87449461
