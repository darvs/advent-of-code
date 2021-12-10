Feature: Syntax Scoring

	Syntax error in navigation subsystem on line: all of them

	Scenario: Part 1 small sample
		Given the lines in file "2110.smol.in"
		Then the syntax score would be 26397

	#Scenario: Part 1 whole enchilada
		#Given the lines in file "2110.in"
		#Then the syntax score would be 0

	Scenario: Part 2 small sample
		Given the lines in file "2110.smol.in"
		Then the auto-complete score would be 288957

	Scenario: Part 2 whole enchilada
		Given the lines in file "2110.in"
		Then the auto-complete score would be 0



