Feature: 

  Regolith Reservoir

	Scenario: Part 1 smol
	  Given the content of file '2214.smol.in'
	    Then 24 units of sand rest before falling into the abyss. 
	
	Scenario: Part 1
	  Given the content of file '2214.in'
	    Then 873 units of sand rest before falling into the abyss. 
  

  Scenario: Part 2 smol
    Given the content of file '2214.smol.in'
    Then 93 units of sand fall before filling the room.

  # Scenario: Part 2
  #   Given the content of file '2214.in'
  #   Then 24813 units of sand fall before filling the room.
  #

