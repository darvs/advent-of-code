Feature: Lens Library

  Calcute string hashes

	Scenario: Part 1 smol 1
    Given the values in file '2315.smol1.in'
    Then the hash value is 52

	Scenario: Part 1 smol 2
    Given the values in file '2315.smol2.in'
    Then the hash value is 1320

	Scenario: Part 1
    Given the values in file '2315.in'
    Then the hash value is 505459 

	Scenario: Part 2 smol 2
    Given the values in file '2315.smol2.in'
    Then the total focusing power is 145

	Scenario: Part 2
    Given the values in file '2315.in'
    Then the total focusing power is 228508   
