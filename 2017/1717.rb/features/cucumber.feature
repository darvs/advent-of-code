Feature: Short-circuit the spinlock
	A spinlock steps forward and insert new values,
	we need to predict where it will strike next.

	Scenario: Predict the spinlock in test
		Given the spinlock steps a number of times defined in "1717.sample.in"
		Then the value after the final position would be 638

	Scenario: Predict the spinlock with real values
		Given the spinlock steps a number of times defined in "1717.in"
		Then the value after the final position would be 1506

	Scenario: Stop the angry spinlock
		Given the spinlock steps a number of times defined in "1717.in"
		Then the value after the 0 would be 39479736 




