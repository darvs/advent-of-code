Feature: Amplification circuit 

	Write multiple intcode program interpreters

	Scenario: Part 1 Run one phase-setting sequence #1
		Given a program of "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0"
		When phase setting sequence is "4,3,2,1,0"
		When the machine is run
		Then the max thruster signal should be 43210

	Scenario: Part 1 Run one phase-setting sequence #2
		Given a program of "3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0"
		When phase setting sequence is "0,1,2,3,4"
		When the machine is run
		Then the max thruster signal should be 54321

	Scenario: Part 1 Run one phase-setting sequence #3
		Given a program of "3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0"
		When phase setting sequence is "1,0,4,3,2"
		When the machine is run
		Then the max thruster signal should be 65210
	
	Scenario: Part 1 Get max thruster signal
		Given the program in file "1907.in"
		When all settings are run
		Then the max thruster signal should be 47064

	Scenario: Part 2 Get max thruster signal #1
		Given a program of "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"
		When phase setting sequence is "9,8,7,6,5"
		When amplifiers are connected in a feedback loop
		Then the max thruster signal should be 139629729

	Scenario: Part 2 Get max thruster signal #2
		Given a program of "3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10"
		When phase setting sequence is "9,7,8,5,6"
		When amplifiers are connected in a feedback loop
		Then the max thruster signal should be 18216

	Scenario: Part 2 Get max thruster signal for all settings #1
		Given a program of "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"
		When all settings are tried in a feedback loop
		Then the max thruster signal should be 139629729

	Scenario: Part 2 Get max thruster signal for all settings #2
		Given a program of "3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10"
		When all settings are tried in a feedback loop
		Then the max thruster signal should be 18216

	Scenario: Part 2 Get max thruster signal for all settings #2
		Given the program in file "1907.in"
		When all settings are tried in a feedback loop
		Then the max thruster signal should be 4248984
