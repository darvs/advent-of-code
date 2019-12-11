Feature: Monitoring Station

	Find the best location for a monitoring station

	Scenario: Part 1 Example 1
		Given the map in "1910.p1-1.in"
		Then the most asteroids detected would be 8
		And the best position would be "(3, 4)"

	Scenario: Part 1 Example 2
		Given the map in "1910.p1-2.in"
		Then the most asteroids detected would be 33
		And the best position would be "(5, 8)"

	Scenario: Part 1 Example 3
		Given the map in "1910.p1-3.in"
		Then the most asteroids detected would be 35
		And the best position would be "(1, 2)"

	Scenario: Part 1 Example 4
		Given the map in "1910.p1-4.in"
		Then the most asteroids detected would be 41
		And the best position would be "(6, 3)"

	Scenario: Part 1 Example 5
		Given the map in "1910.p1-5.in"
		Then the most asteroids detected would be 210
		And the best position would be "(11, 13)"

	Scenario: Part 1
		Given the map in "1910.in"
		Then the most asteroids detected would be 326
		And the best position would be "(22, 28)"

	Scenario: Part 2 Example 1 
		Given the map in "1910.p2-1.in"
		When asteroids are blasted in order
		Then vaporized at #1 would be "(8, 1)"
		And vaporized at #2 would be "(9, 0)"
		And vaporized at #3 would be "(9, 1)"
		And vaporized at #4 would be "(10, 0)"
		And vaporized at #5 would be "(9, 2)"
		And vaporized at #6 would be "(11, 1)"
		And vaporized at #7 would be "(12, 1)"
		And vaporized at #8 would be "(11, 2)"
		And vaporized at #9 would be "(15, 1)"
		And vaporized at #10 would be "(12, 2)"

	Scenario: Part 2 Example 2
		Given the map in "1910.p1-5.in"
		When asteroids are blasted in order
		Then vaporized at #1 would be "(11, 12)"
		And vaporized at #2 would be "(12, 1)"
		And vaporized at #3 would be "(12, 2)"
		And vaporized at #10 would be "(12, 8)"
		And vaporized at #20 would be "(16, 0)"
		And vaporized at #50 would be "(16, 9)"
		And vaporized at #100 would be "(10, 16)"
		And vaporized at #199 would be "(9, 6)"
		And vaporized at #200 would be "(8, 2)"
		And vaporized at #201 would be "(10, 9)"
		And vaporized at #299 would be "(11, 1)"

	Scenario: Part 2
		Given the map in "1910.in"
		When asteroids are blasted in order
		Then vaporized at #200 would be "(16, 23)"
		And multiplied coords of the #200th vaporized would be 1623
