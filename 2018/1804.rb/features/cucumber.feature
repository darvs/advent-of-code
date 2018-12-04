Feature: Figure out a stealth schedule.
	Given a list of when guards come in, fall asleep and wake up,
	we need to find the perfect time to sneak in.

	Scenario: Figure out the perfect time for the sample schedule
		Given the schedule in "1804.sample.in"
		Then the guard with the most minutes asleep would be guard number 10
		And they would be most asleep in minute number 24
		And multiplying both answers would give us 240

	Scenario: Figure out the perfect time for the real schedule
		Given the schedule in "1804.in"
		Then the guard with the most minutes asleep would be guard number 2251
		And they would be most asleep in minute number 42
		And multiplying both answers would give us 94542

