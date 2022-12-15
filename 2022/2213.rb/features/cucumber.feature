Feature: 

	Check Order

	Scenario: smol
	    Given the content of file '2213.smol.in'
      Then the sum of the indices of the pairs in order is 13
      And the decoder key is 140

	Scenario: whol
	    Given the content of file '2213.in'
      Then the sum of the indices of the pairs in order is 5185
      And the decoder key is 23751
	

	
