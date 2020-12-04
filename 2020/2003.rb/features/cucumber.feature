Feature: Toboggan Trajectory

	How many trees would you encounter?

	Scenario: Part 1 smol case
		Given the tree field in file '2003.smol.in'
		And the slope right 3, down 1
		Then you would encounter 7 trees 

	Scenario: Part 1
		Given the tree field in file '2003.in'
		And the slope right 3, down 1
		Then you would encounter 234 trees 

	Scenario: Part 2
		Given the tree field in file '2003.in'
		And a pre-defined list of slopes
		Then you would encounter 5813773056 trees 
