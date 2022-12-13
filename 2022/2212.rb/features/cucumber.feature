Feature: 

	Find the shortest path up a hill

	Scenario: Part 1 smol
	    Given the content of file '2212.smol.in'
	      Then the shortest path length is 31
	
	Scenario: Part 1
	    Given the content of file '2212.in'
	      Then the shortest path length is 484

	Scenario: Part 2 smol
	    Given the content of file '2212.smol.in'
      Then the shortest path from ground is 29

	Scenario: Part 2
	    Given the content of file '2212.in'
	    Then the shortest path from ground is 478
