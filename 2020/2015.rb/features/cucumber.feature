Feature: Day 15: Rambunctious Recitation

	Find the Nth number the elves will say

	Scenario: Part 1 small case #1
		Given the list "0,3,6"
		Then the 10th number will be 0

	Scenario: Part 1 small case #2
		Given the list "0,3,6"
		Then the 2020th number will be 436

	Scenario: Part 1 small case #3
		Given the list "0,3,6"
		Then the 100000th number will be 340

	Scenario: Part 1
		Given the list "0,5,4,1,10,14,7"
		Then the 2020th number will be 203

	Scenario: Part 1
		Given the list "0,5,4,1,10,14,7"
		Then the 30000000th number will be 9007186 
