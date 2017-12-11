require_relative "../../lib/1707.rb"

Given("a program describes itself as {string}") do |string|
	@line = read_line(string)
end

Then("its name is {string}") do |string|
	expect(@line[:name]).to eq(string)
end

Then("its weight is {int}") do |int|
	expect(@line[:weight]).to eq(int)
end

Then("its supported list length is {int}") do |int|
	expect(@line[:supported].length).to eq(int)
end

Given("a program list file of {string}") do |string|
	@programs = read_file(string)
end

Then("the program at the bottom is {string}") do |string|
	weight(@programs, bottom(@programs))
	expect(bottom(@programs)).to eq(string)
end

Then("the total weight for {string} is {int}") do |string, int|
	expect(weight(@programs, string)).to eq(int)
end

Then("the correct weight to balance is {int}") do |int|
	expect(unbalanced(@programs, bottom(@programs))).to eq(int)
end
