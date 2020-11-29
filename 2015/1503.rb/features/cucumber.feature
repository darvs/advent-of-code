Feature: Perfectly Spherical Houses in a Vacuum 

	Santa is delivering presents to an infinite two-dimensional grid of houses.

	Scenario: Part 1 Case 1
		Given the itinerary '>'
		Then 1 Santa(s) would visit 2 houses

	Scenario: Part 1 Case 2
		Given the itinerary '^>v<'
		Then 1 Santa(s) would visit 4 houses

	Scenario: Part 1 Case 3
		Given the itinerary '^v^v^v^v^v'
		Then 1 Santa(s) would visit 2 houses

	Scenario: Part 1
		Given the itinerary in file '1503.in'
		Then 1 Santa(s) would visit 2572 houses

	Scenario: Part 2 Case 1
		Given the itinerary '^v'
		Then 2 Santa(s) would visit 3 houses

	Scenario: Part 2 Case 2
		Given the itinerary '^>v<'
		Then 2 Santa(s) would visit 3 houses

	Scenario: Part 2 Case 3
		Given the itinerary '^v^v^v^v^v'
		Then 2 Santa(s) would visit 11 houses

	Scenario: Part 2
		Given the itinerary in file '1503.in'
		Then 2 Santa(s) would visit 2631 houses
