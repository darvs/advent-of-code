Feature: Sunny with a Chance of Asteroids

	Write an intcode program interpreter

	Scenario: 1902 Part 1 Test Case 1
		Given a program of "1,0,0,0,99"
		Then the result should be "2,0,0,0,99" 

	Scenario: 1902 Part 1 Test Case 2
		Given a program of "2,3,0,3,99"
		Then the result should be "2,3,0,6,99" 

	Scenario: 1902 Part 1 Test Case 3
		Given a program of "2,4,4,5,99,0"
		Then the result should be "2,4,4,5,99,9801" 

	Scenario: 1902 Part 1 Test Case 4 
		Given a program of "1,1,1,4,99,5,6,0,99"
		Then the result should be "30,1,1,4,2,5,6,0,99" 

	Scenario: 1902 Part 1 Inputfile
		Given the program in file "1902.in"
		Then if the error is set to 1202
		Then at the end, position 0 should be 3101844

	Scenario: 1902 Part 2 Inputfile
		Given the program in file "1902.in"
		Then when position 0 is 19690720
		Then the error should be 8478

	Scenario: Part 1 Test Case 1
		Given a program of "1002,4,3,4,33"
		Then the result should be "1002,4,3,4,99" 

	Scenario: Part 1 Test Case 2
		Given a program of "1101,100,-1,4,0"
		Then the result should be "1101,100,-1,4,99" 


	Scenario: Part 1 Test Case 3
		Given a program of "3,4,99,0,0"
		Given the input "66"
		Then the result should be "3,4,99,0,66" 

	Scenario: Part 1 Test Case 4: input
		Given a program of "3,4,99,0,0"
		Given the input "66"
		Then the result should be "3,4,99,0,66" 

	Scenario: Part 1 Test Case 4: output
		Given a program of "4,3,99,42,0"
		Then the output should be "42" 

	Scenario: Part 1 inputfile
		Given the program in file "1905.in"
		Given the input "1"
		Then the output should be "0,0,0,0,0,0,0,0,0,7988899"

	Scenario: Part 2 Test Case 5 (positional == 8?, <) 
		Given a program of "3,9,8,9,10,9,4,9,99,-1,8"
		Given the input "4"
		Then the output should be "0"

	Scenario: Part 2 Test Case 5 (positional == 8?, ==) 
		Given a program of "3,9,8,9,10,9,4,9,99,-1,8"
		Given the input "8"
		Then the output should be "1"

	Scenario: Part 2 Test Case 5 (positional == 8?, >) 
		Given a program of "3,9,8,9,10,9,4,9,99,-1,8"
		Given the input "143"
		Then the output should be "0"

	Scenario: Part 2 Test Case 6 (positional <8?, <) 
		Given a program of "3,9,7,9,10,9,4,9,99,-1,8"
		Given the input "4"
		Then the output should be "1"

	Scenario: Part 2 Test Case 6 (positional <8?, ==) 
		Given a program of "3,9,7,9,10,9,4,9,99,-1,8"
		Given the input "8"
		Then the output should be "0"

	Scenario: Part 2 Test Case 6 (positional <8?, >) 
		Given a program of "3,9,7,9,10,9,4,9,99,-1,8"
		Given the input "143"
		Then the output should be "0"

	Scenario: Part 2 Test Case 7 (immediate == 8?, <) 
		Given a program of "3,3,1108,-1,8,3,4,3,99"
		Given the input "4"
		Then the output should be "0"

	Scenario: Part 2 Test Case 7 (immediate == 8?, ==) 
		Given a program of "3,3,1108,-1,8,3,4,3,99"
		Given the input "8"
		Then the output should be "1"

	Scenario: Part 2 Test Case 7 (immediate == 8?, >) 
		Given a program of "3,3,1108,-1,8,3,4,3,99"
		Given the input "143"
		Then the output should be "0"

	Scenario: Part 2 Test Case 8 (immediate <8?, <) 
		Given a program of "3,3,1107,-1,8,3,4,3,99"
		Given the input "4"
		Then the output should be "1"

	Scenario: Part 2 Test Case 8 (immediate <8?, ==) 
		Given a program of "3,3,1107,-1,8,3,4,3,99"
		Given the input "8"
		Then the output should be "0"

	Scenario: Part 2 Test Case 8 (immediate <8?, >) 
		Given a program of "3,3,1107,-1,8,3,4,3,99"
		Given the input "143"
		Then the output should be "0"

	Scenario: Part 2 Test Case 9 (positional jump, == 0) 
		Given a program of "3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9"
		Given the input "0"
		Then the output should be "0"

	Scenario: Part 2 Test Case 9 (positional jump, != 0) 
		Given a program of "3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9"
		Given the input "42"
		Then the output should be "1"

	Scenario: Part 2 Test Case 9 (positional jump, != 0) 
		Given a program of "3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9"
		Given the input "-42"
		Then the output should be "1"

	Scenario: Part 2 Test Case 9 (immediate jump, == 0) 
		Given a program of "3,3,1105,-1,9,1101,0,0,12,4,12,99,1"
		Given the input "0"
		Then the output should be "0"

	Scenario: Part 2 Test Case 9 (immediate jump, != 0) 
		Given a program of "3,3,1105,-1,9,1101,0,0,12,4,12,99,1"
		Given the input "42"
		Then the output should be "1"

	Scenario: Part 2 Test Case 9 (immediate jump, != 0) 
		Given a program of "3,3,1105,-1,9,1101,0,0,12,4,12,99,1"
		Given the input "-42"
		Then the output should be "1"

	Scenario: Part 2 Test Case 10 (immediate ==8?, <) 
		Given the program in file "1905.part2.larger.example.in"
		Given the input "4"
		Then the output should be "999"

	Scenario: Part 2 Test Case 10 (immediate ==8?, ==) 
		Given the program in file "1905.part2.larger.example.in"
		Given the input "8"
		Then the output should be "1000"

	Scenario: Part 2 Test Case 10 (immediate ==8?, >) 
		Given the program in file "1905.part2.larger.example.in"
		Given the input "42"
		Then the output should be "1001"

	Scenario: Part 2
		Given the program in file "1905.in"
		Given the input "5"
		Then the output should be "13758663"
