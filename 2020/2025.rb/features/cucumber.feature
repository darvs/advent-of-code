Feature: Day 25: Combo Breaker

	What is the encryption key?

	Scenario: Part 1 small cases
		Given the public keys in file "2025.smol.in"
		Then the encryption key is 14897079

	Scenario: Part 1
		Given the public keys in file "2025.in"
		Then the encryption key is 16457981

