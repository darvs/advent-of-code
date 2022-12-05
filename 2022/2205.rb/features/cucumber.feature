Feature: Cleanup 

	Camp Cleanup

	Scenario: Part 1 smol
		Given the content of file '2205.smol.in'
		When using CrateMover 9000
		Then it ends up looking like 'CMZ'

	Scenario: Part 1
		Given the content of file '2205.in'
		When using CrateMover 9000
		Then it ends up looking like 'QPJPLMNNR'

	Scenario: Part 2 smol
		Given the content of file '2205.smol.in'
		When using CrateMover 9001
		Then it ends up looking like 'MCD'

	Scenario: Part 2
		Given the content of file '2205.in'
		When using CrateMover 9001
		Then it ends up looking like 'BQDNWJPVJ'
