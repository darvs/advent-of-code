Feature: Space Stoichiometry

	Figure out how much ORE we need for FUEL

	Scenario Outline:
		Given the program in file <pgm>
		Then the reactions to produce 1 FUEL require <ore> ORE

		Examples:
			| pgm		 | ore	   |
			| "1914.p1-1.in" | 31 	   |
			| "1914.p1-2.in" | 165	   |
			| "1914.p1-3.in" | 13312   |
			| "1914.p1-4.in" | 180697  |
			| "1914.p1-5.in" | 2210736 |

	Scenario: Part 1
		Given the program in file "1914.in"
		Then the reactions to produce 1 FUEL require 483766 ORE 


