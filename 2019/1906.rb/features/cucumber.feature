Feature: Universal Orbit Map

	Parse orbit maps to find all indirect orbits

	Scenario: Part 1 Test Case
		Given the orbits in file "1906.p1test.in"
		Then the total number of orbits is 42

	Scenario: Part 1
		Given the orbits in file "1906.in"
		Then the total number of orbits is 160040

	Scenario: Part 2 Test Case
		Given the orbits in file "1906.p2test.in"
		Then the minimum number of orbital transfers to move between "YOU" and "SAN" is 4

	Scenario: Part 2
		Given the orbits in file "1906.in"
		Then the minimum number of orbital transfers to move between "YOU" and "SAN" is 373



