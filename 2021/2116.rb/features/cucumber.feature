Feature: Packet Decoder

	Decode the following packets

	Scenario: Part 1 string
		Given the table
			| string             		 | version_sum | 
			| D2FE28             		 | 6           |
			| 8A004A801A8002F478 		 | 16          |
			| 620080001611562C8802118E34 	 | 12 	       |
			| C0015000016115A2E0802F182340 	 | 23 	       |
			| A0016C880162017C3686B18A3D4780 | 31 	       |
		Then the our versions sums match

	Scenario: Part 1 file
		Given the string in file "2116.in"
		Then the sum of versions is 991

	Scenario: Part 2 result
		Given the table
			| string            		| result	|
			| C200B40A82 			| 3		|
			| 04005AC33890 			| 54		|
			| 880086C3E88112 		| 7 		|
			| CE00C43D881120 		| 9 		|
			| D8005AC2A8F0 			| 1 		| 
			| F600BC2D8F 			| 0 		|
			| 9C005AC2F8F0 			| 0 		|
			| 9C0141080250320F1802104A08 	| 1 		|
		Then the our results match

	Scenario: Part 1 file
		Given the string in file "2116.in"
		Then the sum is 1264485568252






