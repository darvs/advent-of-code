Feature:
	I must implement a new password policy where passphrases are used
	Passphrases must contain no repeating words.

	Scenario Outline:
		Given a list of words "<list>"
		Then the passphrase is <status>

		Examples:
			| list            | status  |
			| aa bb cc dd ee  | valid   |
			| aa bb cc dd aa  | invalid |
			| aa bb cc dd aaa | valid   | 

	Scenario:
		Given the file "1701.in"
		Then there are 455 passphrases that are valid

	Scenario Outline:
		Given a list of words "<list>"
		And the fact that passphrases must also not contain anagrams 
		Then the passphrase is <status>

		Examples:
			| list                     | status  |
			| abcde fghij              | valid   |
			| abcde xyz ecdab          | invalid |
			| a ab abc abd abf abj     | valid   | 
			| iiii oiii ooii oooi oooo | valid   | 
			| oiii ioii iioi iiio      | invalid | 

	Scenario:
		Given the file "1701.in"
		And the fact that passphrases must also not contain anagrams 
		Then there are 186 passphrases that are valid
	
