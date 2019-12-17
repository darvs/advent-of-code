Feature: Flawed Frequency Transmission 

	Implement a FFT decoder

	Scenario Outline:
		Given the input signal <signal>
		When the signal is processed for <phases> phases
		Then the first 8 digits are <digits>

		Examples:
			| signal                             | phases | digits     |
			| "12345678"                         | 1      | "48226158" |
			| "12345678"                         | 2      | "34040438" |
			| "12345678"                         | 3      | "03415518" |
			| "12345678"                         | 4      | "01029498" |
			#| "80871224585914546619083218645595" | 100    | "24176176" |
			#| "19617804207202209144916044189917" | 100    | "73745418" |
			#| "69317163492948606335995924319873" | 100    | "52432133" |
		
	#Scenario: Part 1
		#Given the input signal in "1916.in"
		#When the signal is processed for 100 phases
		#Then the first 8 digits are "32002835"

	#Scenario Outline:
		#Given the input signal <signal> repeated 10000 times
		#When the signal is processed for <phases> phases
		#Then the 8 digits at the check offset are <digits>

		#Examples:
			#| signal                             | phases | digits     |
			#| "03036732577212944063491565474664" | 100    | "84462026" |
			##| "02935109699940807407585447034323" | 100    | "78725270" |
			#| "03081770884921959731165446850517" | 100    | "53553731" |
		

