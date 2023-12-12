Feature: Cosmic Expansion

  See how far are the galaxies

	Scenario: Part 1 smol 1
    Given the values in file '2311.smol.in'
    Then the sum of distances is 374

	Scenario: Part 1
    Given the values in file '2311.in'
    Then the sum of distances is 9647174 

	Scenario: Part 2 smol 1
    Given the values in file '2311.smol.in'
    When the expansion factor is 10
    Then the sum of distances is 1030

	Scenario: Part 2 smol 2
    Given the values in file '2311.smol.in'
    When the expansion factor is 100
    Then the sum of distances is 8410

	Scenario: Part 2
    Given the values in file '2311.in'
    When the expansion factor is 1000000
    Then the sum of distances is 377318892554 
