Feature: Camel Cards

  Calculate the value of card hands

	Scenario: Part 1 smol
		Given the values in file '2307.smol.in'
    Then the total of winnings is 6440

	Scenario: Part 1
		Given the values in file '2307.in'
    Then the total of winnings is 251545216 

	Scenario: Part 2 smol
    Given the values in file '2307.smol.in'
    When Jokers are wild
    Then the total of winnings is 5905

	Scenario: Part 2
		Given the values in file '2307.in'
    When Jokers are wild
    Then the total of winnings is 250384185  

