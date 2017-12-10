require_relative "../../lib/1710.rb"

Given("a list of length {int} with elements counting from {int}") do |int, int2|
	$knots = Hashf.new(int, int2)  
end

Given("the same list and input lengths") do
	# keep $knots
end

Given("a list of input lengths of {string}") do |string|
	$knots.set_input_lengths(string)
end

Then("one step should modify our list to {string}") do |string|
	$knots.step
	expect($knots.arr).to eq(string)
end

Then("our current position should be {int}") do |int|
	expect($knots.pos).to eq(int)
end

Then("the skip size should be {int}") do |int|
	expect($knots.skip_size).to eq(int)
end

Then("our first two elements multiplied together should be {int}") do |int|
	expect($knots.mult).to eq(int)
end

Given("the list of input lengths in file {string}") do |string|
	$knots.read_input_lengths(string)  
end

Then("after {int} rounds our first two elements multiplied together should be {int}") do |int, int2|
	$knots.calc(int)
	expect($knots.mult).to eq(int2)
end

Given("the binary list of input lengths in file {string}") do |string|
	$knots.read_binary_input_lengths(string)  
end

Given("a binary list of input lengths of {string}") do |string|
	$knots.set_binary_input_lengths(string)
end
 
Then("the hexadecimal dense hash is {string}") do |string|
	$knots.calc(64)
	expect($knots.hash).to eq(string)
end

