Feature: Lanternfish

	Lanternfish

	Scenario: Part 1 small sample
		Given the fish in file "2106.smol.in"
		Then after 18 days there would be 26 fish

	Scenario: Part 1 small sample 2
		Given the fish in file "2106.smol.in"
		Then after 80 days there would be 5934 fish

	Scenario: Part 1 whole enchilada
		Given the fish in file "2106.in"
		Then after 80 days there would be 356190 fish

	Scenario: Part 2 small sample
		Given the fish in file "2106.smol.in"
		Then after 256 days there would be 26984457539 fish

	Scenario: Part 2 whole enchilada
		Given the fish in file "2106.in"
		Then after 256 days there would be 1617359101538 fish


