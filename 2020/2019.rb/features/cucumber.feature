Feature: Day 19: Monster Messages 

	Parse the messages

	#Scenario: Part 1 small cases
		#Given the grammar in file "2019.smol.in"
			#| message | valid |
			#| ababbb  | 1     |
			#| bababa  | 0     |
			#| abbbab  | 1     |
			#| aaabbb  | 0     |
			#| aaaabbb | 0     |
		#Then the messages should be validated

	#Scenario: Part 1 small cases #2
		#Given the grammar and messages in file "2019.smol.in"
		#Then 2 messages should be valid
		
	Scenario: Part 1
		Given the grammar and messages in file "2019.in"
		Then 147 messages should be valid

	#Scenario: Part 2 smol 1
		#Given the grammar and messages in file "2019.p2.smol.in"
		#Then 3 messages should be valid

	#Scenario: Part 2 smol 2
		#Given the grammar and messages in file "2019.p2.smol2.in"
		#Then 12 messages should be valid

	Scenario: Part 2 small messages
		Given the grammar in file "2019.p2.smol2.in"
			| message                                      | valid |
			| bbabbbbaabaabba                              | 1     |
			| babbbbaabbbbbabbbbbbaabaaabaaa               | 1     |
			| aabbbbbbaaaabaababaabababbabaaabbababababaaa | 1     |
			| bbbbbbbaaaabbbbaaabbabaaa                    | 1     |
			| bbbababbbbaaaaaaaabbababaaababaabab          | 1     |
			| ababaaaaaabaaab                              | 1     |
			| babaaaaabbbaba                               | 1     |
			| baabbaaaabbaaaababbaababb                    | 1     |
			| abbbbabbbbaaaababbbbbbaaaababb               | 1     |
			| aaaaabbaabaaaaababaa                         | 1     |
			| aaabbaabbaaaaaaabbbabbbaaabbaabaaa           | 1     |
			| aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba     | 1     |
		Then the messages should be validated



	#Scenario: Part 2
		#Given the grammar and messages in file "2019.p2.in"
		#Then 0 messages should be valid




