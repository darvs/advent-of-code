Feature:
	Count the number of groups in a stream ignoring garbage
	The score is sum of each of the opening parenthesis levels starting at 1

	Scenario Outline:
		Given the stream "<stream>"
		Then it should all be garbage

		Examples:
			| stream 		|
			| <> 			|
			| <random characters>	|
			| <<<<> 		|
			| <{!>}> 		|
			| <!!> 			|
			| <!!!>> 		|
			| <{o\"i!a,<{i<a> 	|

	Scenario Outline:
		Given the stream "<stream>"
		Then there are <n> groups

		Examples:
			| stream 			| n |
			| {} 				| 1 |
			| {{{}}} 			| 3 |
			| {{},{}} 			| 3 |
			| {{{},{},{{}}}} 		| 6 |
			| {<{},{},{{}}>} 		| 1 |
			| {<a>,<a>,<a>,<a>} 		| 1 |
			| {{<a>},{<a>},{<a>},{<a>}} 	| 5 |
			| {{<!>},{<!>},{<!>},{<a>}} 	| 2 |

	Scenario Outline:
		Given the stream "<stream>"
		Then the score is <score>

		Examples:
			| stream 			| score |
			| {} 				| 1     |
			| {{{}}}			| 6     |
			| {{},{}}			| 5     |
			| {{{},{},{{}}}}		| 16    |
			| {<a>,<a>,<a>,<a>}		| 1     |
			| {{<ab>},{<ab>},{<ab>},{<ab>}}	| 9     |
			| {{<!!>},{<!!>},{<!!>},{<!!>}}	| 9     |
			| {{<a!>},{<a!>},{<a!>},{<ab>}}	| 3     |

	Scenario:
		Given the file "1709.in"
		Then the score is 12396


