Feature: Space Stoichiometry

	Figure out how much ORE we need for FUEL

	Scenario: Part 1 Example 1
		Given the program in file "1914.p1-1.in"
		Then the reactions to produce 1 FUEL require 31 ORE 

	Scenario: Part 1 Example 2 
		Given the program in file "1914.p1-2.in"
		Then the reactions to produce 1 FUEL require 165 ORE 

	Scenario: Part 1 Example 3
		Given the program in file "1914.p1-3.in"
		Then the reactions to produce 1 FUEL require 13312 ORE 

	Scenario: Part 1 Example 4
		Given the program in file "1914.p1-4.in"
		Then the reactions to produce 1 FUEL require 180697 ORE 

	Scenario: Part 1 Example 5
		Given the program in file "1914.p1-5.in"
		Then the reactions to produce 1 FUEL require 2210736 ORE 

	Scenario: Part 1
		Given the program in file "1914.in"
		Then the reactions to produce 1 FUEL require 483766 ORE 


