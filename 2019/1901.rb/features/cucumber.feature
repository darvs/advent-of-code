Feature: The Tyranny of the Rocket Equation

	Fuel required to launch a given module is based on its mass. Specifically, to find the fuel required for a module, take its mass, divide by three, round down, and subtract 2.

	Scenario: Find the fuel required for a mass of 12
		Given a mass of 12
		Then the amount of fuel required would be 2

	Scenario: Find the fuel required for a mass of 14
		Given a mass of 14
		Then the amount of fuel required would be 2

	Scenario: Find the fuel required for a mass of 1969
		Given a mass of 1969
		Then the amount of fuel required would be 654

	Scenario: Find the fuel required for a mass of 100756
		Given a mass of 100756
		Then the amount of fuel required would be 33583
	
	Scenario: Find the total fuel needed for all modules
		Given the list of masses in file '1901.in'
		Then the total amount of fuel required would be 3481005

	Scenario: Find the fuel required for a mass of 14 and its fuel
		Given a mass of 14
		Then the amount of fuel required with the recursive method would be 2 
	
	Scenario: Find the fuel required for a mass of 1969 and its fuel
		Given a mass of 1969
		Then the amount of fuel required with the recursive method would be 966
	
	Scenario: Find the fuel required for a mass of 100756 and its fuel
		Given a mass of 100756
		Then the amount of fuel required with the recursive method would be 50346
	
	Scenario: Find the total fuel needed for all modules with fuel
		Given the list of masses in file '1901.in'
		Then the total amount of fuel required with the recursive method would be 3481005
