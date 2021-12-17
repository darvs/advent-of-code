Feature: Packet Decoder

	Decode the following packets

	Scenario: Part 1 string
		Given the string 'D2FE28'
		Then the version is 6

	Scenario: Part 1 subpacket
		Given the string '8A004A801A8002F478'
		Then the sum of versions is 16

	Scenario: Part 1 subpacket
		Given the string '620080001611562C8802118E34'
		Then the sum of versions is 12

	Scenario: Part 1 subpacket
		Given the string 'C0015000016115A2E0802F182340'
		Then the sum of versions is 23 

	Scenario: Part 1 subpacket
		Given the string 'A0016C880162017C3686B18A3D4780'
		Then the sum of versions is 31

	Scenario: Part 1 file
		Given the string in file "2116.in"
		Then the sum of versions is 991
