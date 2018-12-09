Feature: The sum of its parts

	Instructions specify a series of steps and requirements about which steps must be finished before others can begin. Our first goal is to determine the order in which the steps should be completed.

	Scenario: Find out the order of the sample steps
		Given an input file named "1807.sample.in"
		Then the correct order should be "CABDFE"

	Scenario: Find out the order and time of the sample steps for two workers
		Given an input file named "1807.sample.in"
		And 2 workers
		And a time completion base of 0 seconds
		Then the correct order should be "CABFDE"
		And it should be finished in 15 seconds

	Scenario: Find out the order of the steps
		Given an input file named "1807.in"
		Then the correct order should be "FDSEGJLPKNRYOAMQIUHTCVWZXB"

	Scenario: Find out the time it takes for the steps with 5 workers
		Given an input file named "1807.in"
		And 5 workers
		And a time completion base of 60 seconds
		Then it should be finished in 1000 seconds
