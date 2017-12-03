Feature: A Manhattan Distance calculator (in Taxicab Coordinates)
	In an infinite two-dimensional memory grid, 
	Spiraling from the center without skipping a square,
	I need to calculate the Manhattan Distance from the center for any square

	Scenario Outline: Calculate the distance for a given square
		When data starts from square <square>
		Then it should reach the center in <steps> steps

		Examples:
			| square | steps |
			| 1      | 0     |
#			| 12     | 3     |
#			| 23     | 2     |
#			| 1024   | 31    |
#			| 289326 | 419   |

	Scenario Outline: Calculate values written during the stress test
		When data is written to square number <square>
		Then the sum of adjacent values should be <value>

		Examples:
			| square | value |
			| 1      | 1     |
			| 2      | 1     |
		        | 3      | 2     |
		        | 4      | 4     |
			| 5      | 5     |
			| 6      | 10    |
			| 7      | 11    |
			| 8      | 23    |
			| 9      | 25    |


	Scenario Outline: Calculate when values written during the stress test go over a limit
		Given a limit value of <limit>
		Then the first value written over it is <over>

		Examples:
			| limit  | over   |
			| 0	 | 1      |
			| 1      | 2      |
			| 2      | 4      |     
			| 4      | 5      |     
		        | 5      | 10     |
		        | 10     | 11     |
		        | 11     | 23     |
		        | 23     | 25     |
			| 289326 | 295229 |
		

