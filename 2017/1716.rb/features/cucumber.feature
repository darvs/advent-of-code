Feature: Watch the programs dance
	Given a starting position and a sequence of dance moves
	we need to find out where every program is at the end of the dance

	Scenario: Watch the dummy dance
		Given the programs "abcde"
		And the sequence of dance moves in "1716.dummy.in"
		Then the ending positions should be "cdeab" after performing it 1 times

	Scenario: Watch the sample dance
		Given the programs "abcde"
		And the sequence of dance moves in "1716.sample.in"
		Then the ending positions should be "baedc" after performing it 1 times
		And the ending positions should be "ceadb" after performing it 2 times

	Scenario: Watch the main dance
		Given the programs "abcdefghijklmnop"
		And the sequence of dance moves in "1716.in"
		Then the ending positions should be "gkmndaholjbfcepi" after performing it 1 times
		##And the ending positions should be "ceadb" after performing it 1000000000 times
		##And the ending positions should be "ceadb" after performing it 1000 times
		

