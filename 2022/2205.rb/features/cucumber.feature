Feature: Cleanup 

	Camp Cleanup

	Scenario: Part 1 smol
		Given the content of file '2205.smol.in'
		Then it ends up looking like 'CMZ'

	Scenario: Part 1
		Given the content of file '2205.in'
		Then it ends up looking like 'QPJPLMNNR'
