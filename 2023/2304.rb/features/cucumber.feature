Feature: Scratchcards

  Find all part numbers and gear ratios in the engine schematic 

	Scenario: Part 1 smol
		Given the values in file '2304.smol.in'
    Then they are worth 13 points in total 

	Scenario: Part 1
		Given the values in file '2304.in'
    Then they are worth 25183 points in total 

	Scenario: Part 2 smol
		Given the values in file '2304.smol.in'
    Then we end up with 30 scratchcards 

	Scenario: Part 2
		Given the values in file '2304.in'
    Then we end up with 5667240 scratchcards 
