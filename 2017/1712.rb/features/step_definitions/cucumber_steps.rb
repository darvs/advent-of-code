require_relative "../../lib/1712.rb"

Given("the program list file of {string}") do |string|
	@programs = read_file(string)
end

Then("there are {int} distinct groups") do |int|
	@connected = all_connected(@programs)
	expect(@connected.length).to eq(int)
end
Then("{int} programs are interconnected to program id {int}") do |int, int2|
	expect(count_connected_to(@connected, int2)).to eq(int)
end


