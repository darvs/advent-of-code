Feature: Handheld Device

	Find the start-of-packet marker

	Scenario: Part 1 smol
		Given the table
			| datastream                        | start |
			| bvwbjplbgvbhsrlpgdmjqwftvncz      | 5     |
			| nppdvjthqldpwncqszvftbrmjlhg      | 6     |
			| nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg | 10    |
			| zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw  | 11    |
		And we are looking for a packet
		Then all answers should be verified.

	Scenario: Part 1
		Given the string in file '2206.in'
		And we are looking for a packet
		Then it should start at position 1766

	Scenario: Part 2 smol
		Given the table
			| datastream                        | start |
			| mjqjpqmgbljsphdztnvjfqwrcgsmlb    | 19    |
			| bvwbjplbgvbhsrlpgdmjqwftvncz      | 23    |
			| nppdvjthqldpwncqszvftbrmjlhg      | 23    |
			| nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg | 29    |
			| zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw  | 26    |
		And we are looking for a message
		Then all answers should be verified.

	Scenario: Part 1
		Given the string in file '2206.in'
		And we are looking for a message
		Then it should start at position 2383


