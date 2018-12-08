Feature: Find the North Pole
	Decode the navigation system's tree structure to find the North Pole.

	Scenario: Decode the sample tree
		Given the nodes listed in "1808.sample.in"
		Then the sum of metadata entries would be 138
		And the value of the root node would be 66

	Scenario: Decode the tree
		Given the nodes listed in "1808.in"
		Then the sum of metadata entries would be 46962
		And the value of the root node would be 22633 
