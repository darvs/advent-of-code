Feature: Trick Shot

	Launch a probe into a designated area
	and find the maximum y value it can reach

	Scenario: Part 1 example apex
		Given the target area in file "2117.smol.in"
		Then it can reach a y value of 45 at its apex

	Scenario: Part 1 real value apex
		Given the target area in file "2117.in"
		Then it can reach a y value of 6555 at its apex

	Scenario: Part 2 example hit count
		Given the target area in file "2117.smol.in"
		Then it hits the target 112 times

	Scenario: Part 2 real value apex
		Given the target area in file "2117.in"
		Then it hits the target 4973 times


