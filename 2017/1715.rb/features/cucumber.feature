Feature:
	We need to compare the 16 lowest bits of dueling generators.

	Scenario Outline:
		Given a generator "A" with a starting value of 65 and a factor of 16807
		And a generator "B" with a starting value of 8921 and a factor of 48271
		Then after <n> steps the total number of matches would be <matches_so_far>
		And generated values would be <A> for "A"
		And generated values would be <B> for "B"

		Examples:
			| n | A          | B          | matches_so_far |
			| 1 | 1092455    | 430625591  | 0              |
			| 2 | 1181022009 | 1233683848 | 0              |
			| 3 | 245556042  | 1431495498 | 1              |
			| 4 | 1744312007 | 137874439  | 1              |
			| 5 | 1352636452 | 285222916  | 1              |

	Scenario:
		Given a generator "A" with a starting value of 65 and a factor of 16807
		And a generator "B" with a starting value of 8921 and a factor of 48271
		Then after 40000000 steps the total number of matches would be 588

	Scenario:
		Given a generator "A" with a starting value of 516 and a factor of 16807
		And a generator "B" with a starting value of 190 and a factor of 48271
		Then after 40000000 steps the total number of matches would be 597

	Scenario:
		Given a generator "A" with a starting value of 65 and a factor of 16807
		And a generator "B" with a starting value of 8921 and a factor of 48271
		But generator "A" only looks for values that are multiples of 4
		And generator "B" only looks for values that are multiples of 8
		Then after 1055 steps the total number of matches would be 0

	Scenario:
		Given a generator "A" with a starting value of 65 and a factor of 16807
		And a generator "B" with a starting value of 8921 and a factor of 48271
		But generator "A" only looks for values that are multiples of 4
		And generator "B" only looks for values that are multiples of 8
		Then after 1056 steps the total number of matches would be 1

	Scenario:
		Given a generator "A" with a starting value of 65 and a factor of 16807
		And a generator "B" with a starting value of 8921 and a factor of 48271
		But generator "A" only looks for values that are multiples of 4
		And generator "B" only looks for values that are multiples of 8
		Then after 5000000 steps the total number of matches would be 309

	Scenario:
		Given a generator "A" with a starting value of 516 and a factor of 16807
		And a generator "B" with a starting value of 190 and a factor of 48271
		But generator "A" only looks for values that are multiples of 4
		And generator "B" only looks for values that are multiples of 8
		Then after 5000000 steps the total number of matches would be 303

