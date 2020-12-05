Feature: Day 5: Binary Boarding

	What is the highest seat ID on a boarding pass

	Scenario: Part 1 small case
		Given the boarding passes in '2005.smol.in'
		Then the highest ID would be 820

	Scenario: Part 1
		Given the boarding passes in '2005.in'
		Then the highest ID would be 974

	Scenario: Part 2
		Given the boarding passes in '2005.in'
		Then my boarding pass ID would be 646

	#Scenario: Part 1
		#Given the passports in file '2004.in'
		#Then there would be 230 valid passports

	#Scenario: Part 2 small case
		#Given the passports in file '2004.smol2.in'
		#And stricter validation
		#Then there would be 4 valid passports

	#Scenario: Part 2
		#Given the passports in file '2004.in'
		#And stricter validation
		#Then there would be 0 valid passports

	#Scenario: Part 1
		#Given the tree field in file '2003.in'
		#And the slope right 3, down 1
		#Then you would encounter 234 trees 

	#Scenario: Part 2
		#Given the tree field in file '2003.in'
		#And a pre-defined list of slopes
		#Then you would encounter 5813773056 trees 
