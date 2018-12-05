Feature: Reduce polymers
	Polymer units are defined as either uppercase or lowercase letters
	adjacent units which are the same letter but different case will 
	get destroyed

	Scenario: Figure out how many units remain after all the destruction in sample file
		Given the polymer in "1805.sample.in"
		Then the remaining polymer would be 10 characters long
		And it would be "dabCBAcaDA"
		And if we filtered all "c" units, it would only be 4 characters long

	Scenario: Figure out how many units remain after all the destruction
		Given the polymer in "1805.in"
		Then the remaining polymer would be 9154 characters long
		And if we filtered all "e" units, it would only be 4556 characters long
