Feature: The sum of its parts

	Instructions specify a series of steps and requirements about which steps must be finished before others can begin. Our first goal is to determine the order in which the steps should be completed.

	Scenario: Find out the order of the sample steps
		Given an input file named "1807.sample.in"
		Then the correct order should be "CABDFE"

	Scenario: Find out the order of the steps
		Given an input file named "1807.in"
		Then the correct order should be "FDSEGJLPKNRYOAMQIUHTCVWZXB"

