Feature: Reduce polymers
	Polymer units are defined as either uppercase or lowercase letters
	adjacent units which are the same letter but different case will 
	get destroyed

	Scenario: Figure out how many units remain after all the destruction in sample file
		Given the polymer in "1805.sample.in"
		Then the remaining polymer would be "dabCBAcaDA"

	Scenario: Figure out how many units remain after all the destruction
		Given the polymer in "1805.in"
		Then the remaining polymer would be "dabCBAcaDA"

