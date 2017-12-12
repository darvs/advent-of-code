Feature:
	Programs communicate with each other.
	They can be connected directly or indirectly.
	Find out all programs that are connected to one root directly or indirectly.

	Scenario:
		Given the program list file of "1712.sample.in"
		Then there are 2 distinct groups
		And 6 programs are interconnected to program id 0

	Scenario:
		Given the program list file of "1712.in"
		Then there are 204 distinct groups
		And 378 programs are interconnected to program id 0


