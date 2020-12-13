Feature: Day 13: Shuttle Search

	We are going to the airport

	#Scenario: Part 1 small case
		#Given the bus routes in '2013.smol.in'
		#Then the bus ID times number of minutes to wait would be 295

	#Scenario: Part 1
		#Given the bus routes in '2013.in'
		#Then the bus ID times number of minutes to wait would be 8063

	#Scenario: Part 2 tiny case
		#Given the bus routes in '2013.tiny.in'
		#Then the earliest timestamp to fit the restrictions would be 3417

	#Scenario: Part 2 small case
		#Given the bus routes in '2013.smol.in'
		#And starting at 0
		#Then the earliest timestamp to fit the restrictions would be 1068781

	#Scenario: Part 2 small case
		#Given the bus routes in '2013.smol2.in'
		#And starting at 1200000000
		#Then the earliest timestamp to fit the restrictions would be 1202161486

	Scenario: Part 2
		Given the bus routes in '2013.in'
		And starting at 100000000000000
		Then the earliest timestamp to fit the restrictions would be 0

