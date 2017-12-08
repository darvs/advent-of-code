require_relative "../../lib/1708.rb"

$registers = Hash.new 0

Given("the instruction {string}") do |string|
	$registers = exec($registers, parse(string))
end

Then("the value of {string} should be {int}") do |string, int|
	expect($registers[string]).to eq(int)
end

Given("the existing context") do
	# Don't change anything
end

Given("the program in file {string}") do |string|
	$registers, @max = exec_file(string)
end

Then("the largest value in any register would be {int}") do |int|
	expect(largest($registers)).to eq(int)
end

Then("the largest value in a register ever would be {int}") do |int|
	expect(@max).to eq(int)
end
