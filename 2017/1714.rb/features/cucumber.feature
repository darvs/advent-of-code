Feature:
	The disk defragmenter uses knot hashes from Day 10.
	The disk is a 128x128 grid.
	Each row is tracked by the bits in a knot hash.

	Scenario:
		Given a key of "flqrgnkx"
		Then 8108 squares are used in the grid
		And there are 1242 regions present

	Scenario:
		Given a key of "oundnydw"
		Then 8106 squares are used in the grid

