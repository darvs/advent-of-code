Feature: 

  Beacon Exclusion Zone

	Scenario: Part 1 smol
	  Given the content of file '2215.smol.in'
    Then on row y=10 there are 26 positions where a beacon cannot be present

	Scenario: Part 1
	  Given the content of file '2215.in'
    Then on row y=2000000 there are 5832528 positions where a beacon cannot be present

  Scenario: Part 2 smol
    Given the content of file '2215.smol.in'
    When the limit on coordinates is 20
    Then the tuning frequency is 56000011

  Scenario: Part 2
    Given the content of file '2215.in'
    When the limit on coordinates is 4000000
    Then the tuning frequency is 13360899249595  
