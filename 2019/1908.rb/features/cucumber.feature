Feature: Space Image Format

	Decode a picture in the Space Image Format

	Scenario: Part 1
		Given the image in "1908.in"
		When the image size is 25 x 6 pixels
		Then on the layer with the least 0 the number of 1 digits multiplied by the number of 2 digits is 1950

	Scenario: Part 2
		Given the image in "1908.in"
		When the image size is 25 x 6 pixels
		Then show us the image

