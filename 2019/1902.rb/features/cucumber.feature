Feature: 1202 program alarm

	Write an intcode program interpreter

	Scenario: Part 1 Test Case 1
		Given a program of "1,0,0,0,99"
		Then the result should be "2,0,0,0,99" 

	Scenario: Part 1 Test Case 2
		Given a program of "2,3,0,3,99"
		Then the result should be "2,3,0,6,99" 

	Scenario: Part 1 Test Case 3
		Given a program of "2,4,4,5,99,0"
		Then the result should be "2,4,4,5,99,9801" 

	Scenario: Part 1 Test Case 2
		Given a program of "1,1,1,4,99,5,6,0,99"
		Then the result should be "30,1,1,4,2,5,6,0,99" 

	Scenario: Part 1 Inputfile
		Given the program in file "1902.in"
		Then if the error is set to 1202
		Then at the end, position 0 should be 3101844

	Scenario: Part 2 Inputfile
		Given the program in file "1902.in"
		Then when position 0 is 19690720
		Then the error should be 8478




