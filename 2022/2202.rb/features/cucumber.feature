Feature: RoShamBo

	Score RoShamBo games

	Scenario: Part 1 smol
		Given the moves in file '2202.smol.in'
		Then my total score is 15

	Scenario: Part 1
		Given the moves in file '2202.in'
		Then my total score is 15691


