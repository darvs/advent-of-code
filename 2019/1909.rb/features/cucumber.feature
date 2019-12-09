Feature: Sensor Boost

	Boost the capabilities of the Intcode computer

	Scenario: Part 1 Run a quine
		Given a program of "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99"
		When the machine is run
		Then the output should be "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99" 

	Scenario: Part 2 Return a 16-digits number
		Given a program of "1102,34915192,34915192,7,4,7,99,0"
		When the machine is run
		Then the output should be "1219070632396864" 

	Scenario: Part 1
		Given the program in file "1909.in"
		And the input "1"
		When the machine is run
		Then the output should be "2399197539" 

	Scenario: Part 2
		Given the program in file "1909.in"
		And the input "2"
		When the machine is run
		Then the output should be "35106" 
