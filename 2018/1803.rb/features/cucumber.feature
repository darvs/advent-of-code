Feature: Compute Fabric Claim Intersections.
	Given a list of claims defined by location and size
	we need to compute the intersections between all such claims

	Scenario: Compute intersections in sample input
		Given the list in "1803.sample.in"
		Then the insection should be of 4 square inches
		And claim #3 should be the only one free of conflicts

	Scenario: Compute intersections in real input
		Given the list in "1803.in"
		Then the insection should be of 105071 square inches
		And claim #222 should be the only one free of conflicts

