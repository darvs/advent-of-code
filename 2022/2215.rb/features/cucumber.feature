Feature: 

  Beacon Exclusion Zone

	Scenario: Part 1 smol
	  Given the content of file '2215.smol.in'
    Then on row y=10 there are 26 positions where a beacon cannot be present

	Scenario: Part 1
	  Given the content of file '2215.in'
	    Then on row y=2000000 there are 5832528 positions where a beacon cannot be present
