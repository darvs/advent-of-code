Feature: Day 4: Passport Processing

	How many passports are valid?

	Scenario: Part 1 small case
		Given the passports in file '2004.smol.in'
		Then there would be 2 valid passports

	Scenario: Part 1
		Given the passports in file '2004.in'
		Then there would be 230 valid passports

	Scenario: Part 2 small case
		Given the passports in file '2004.smol2.in'
		And stricter validation
		Then there would be 4 valid passports

	Scenario: Part 2
		Given the passports in file '2004.in'
		And stricter validation
		Then there would be 0 valid passports

	#Scenario: Part 1
		#Given the tree field in file '2003.in'
		#And the slope right 3, down 1
		#Then you would encounter 234 trees 

	#Scenario: Part 2
		#Given the tree field in file '2003.in'
		#And a pre-defined list of slopes
		#Then you would encounter 5813773056 trees 
