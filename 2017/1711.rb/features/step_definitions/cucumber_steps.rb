require_relative "../../lib/1711.rb"

Given("a path of {string}") do |string|
	@steps = set_steps(string)
end

Given("the path in file {string}") do |string|
	@steps = load_steps(string)
end

Then("the destination is {int} steps away") do |int|
	distance, @farthest = optimize(@steps)
	expect(distance).to eq(int)
end

Then("the furthest he ever got was {int} steps away") do |int|           
	expect(@farthest).to eq(int)
end
