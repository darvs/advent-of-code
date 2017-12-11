Feature:
	We need to optimize steps in an hex grid.
	The hexes have neighbouts to the north, northeast, southeast, south, southwest, and northwest.
	We have a path, we need to find the minimum number of steps to reach its destination.

	Scenario Outline:
		Given a path of "<path>"
		Then the destination is <n> steps away

		Examples:
			| path           | n |
			| ne,ne,ne       | 3 |
			| ne,ne,sw,sw    | 0 |
			| ne,ne,s,s      | 2 |
			| se,sw,se,sw,sw | 3 |

	Scenario:
		Given the path in file "1711.in"
		Then the destination is 818 steps away
		And the furthest he ever got was 1596 steps away
