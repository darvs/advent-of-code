Feature: Fertilizer

  What is the lowest location number that corresponds to any of the initial seed numbers?

	Scenario: Part 1 smol
		Given the values in file '2305.smol.in'
    Then the lowest location is 35

	Scenario: Part 1
		Given the values in file '2305.in'
    Then the lowest location is 340994526

	Scenario: Part 2 smol
    Given the values in file '2305.smol.in'
    When we are using seed ranges
    Then the lowest location is 46
  
# Scenario: Part 1
# 	Given the values in file '2305.in'
#    When we are using seed ranges
#    Then the lowest location is 0
