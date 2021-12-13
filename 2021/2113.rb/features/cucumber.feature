Feature: Transparent Origami

	Fold the paper and see what happens

	Scenario: Part 1 small sample
		Given the points in file "2113.smol.in"
		Then there is 16 dots visible

	Scenario: Part 1 whole enchilada
		Given the points in file "2113.in"
		And after just 1 fold
		Then there is 669 dots visible

	Scenario: Part 2 whole enchilada
		Given the points in file "2113.in"
		Then display the results 

