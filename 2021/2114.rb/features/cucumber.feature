Feature: Extended Polymerization

	Follow the chain of polymer templates

	Scenario: Part 1 small sample results
		Given the rules in file "2114.smol.in"
		And the table
			| step | polymer                                           |
			| 1    | NCNBCHB                                           |
			| 2    | NBCCNBBBCBHCB                                     |
			| 3    | NBBBCNCCNBBNBNBBCHBHHBCHB                         |
			| 4    | NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB |
		Then my polymers are verified

	Scenario: Part 1 small sample length
		Given the rules in file "2114.smol.in"
		And the table
			| step | length |
			| 5    | 97     |
			| 10   | 3073   | 
		Then my lengths are verified

	Scenario: Part 1 small counts
		Given the rules in file "2114.smol.in"
		And after 10 steps
		Then the difference in count is 1588

	Scenario: Part 1 whole enchilada counts
		Given the rules in file "2114.in"
		And after 10 steps
		Then the difference in count is 3095

	Scenario: Part 2 small counts
		Given the rules in file "2114.smol.in"
		And after 40 steps
		Then the difference in count is 2188189693529


