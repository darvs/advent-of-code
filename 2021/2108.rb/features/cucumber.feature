Feature: Seven Segment Search

	be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb

	Scenario: Part 1 small sample
		Given the segments in file "2108.smol.in"
		Then there would be 26 digits with unique segments

	Scenario: Part 1 whole enchilada
		Given the segments in file "2108.in"
		Then there would be 397 digits with unique segments

	Scenario: Part 2 really small sample
		Given the segments in file "2108.rly.smol.in"
		Then the sum of output values should be 5353

	Scenario: Part 2 small sample
		Given the segments in file "2108.smol.in"
		Then the sum of output values should be 61229

	Scenario: Part 2 whole enchilada
		Given the segments in file "2108.in"
		Then the sum of output values should be 1027422




