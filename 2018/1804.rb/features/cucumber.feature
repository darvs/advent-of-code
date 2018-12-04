Feature: Figure out a stealth schedule.
	Given a list of when guards come in, fall asleep and wake up,
	we need to find the perfect time to sneak in.

	Scenario: Figure out the perfect time for the sample schedule
		Given the schedule in "1804.sample.in"
		Then the guard with the most minutes asleep would be guard number 10
		And the guard with the most minutes asleep would be most asleep in minute number 24
		And the answer to part one would be 10 * 24 = 240
		And the guard asleep the most in one minute would be guard number 99
		And the minute most asleep by one guard would be minute 45
		And the answer to part two would be 99 * 45 = 4455

	Scenario: Figure out the perfect time for the real schedule
		Given the schedule in "1804.in"
		Then the guard with the most minutes asleep would be guard number 2251
		And the guard with the most minutes asleep would be most asleep in minute number 42 
		And the answer to part one would be 2251 * 42 = 94542
		And the guard asleep the most in one minute would be guard number 1499
		And the minute most asleep by one guard would be minute 34 
		And the answer to part two would be 1499 * 34 = 50966

