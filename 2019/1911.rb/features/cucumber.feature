Feature: Space Police 

	Paint the hull with the robot

	Scenario: Part 1
		Given the program in file "1911.in"
		When the machine starts on a black panel
		Then 2054 panels should have been painted

	Scenario: Part 2 
		Given the program in file "1911.in"
		When the machine starts on a white panel
		Then show the picture painted

