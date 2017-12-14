Feature:
	A firewall is described with a list of "depth: range" statements.
	Within each layer of depth, a security scanner moves back and forth within its range. Each security scanner starts at the top and moves down until it reaches the bottom, then moves up until it reaches the top, and repeats.
	If a packet starts at depth=0, how will it collide with the security scanners?

	Scenario:
		Given depths and ranges in the file "1713.sample.in"
		Then the severity of the trip is 24.
		And a delay of 10 would make it completely safe.

	Scenario:
		Given depths and ranges in the file "1713.in"
		Then the severity of the trip is 1844.
		And a delay of 3897604 would make it completely safe.

