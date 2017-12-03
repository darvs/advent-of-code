require_relative '../../lib/1703.rb'

When("data starts from square {int}") do |int|
	@square = Location.new(int)  
end

Then("it should reach the center in {int} steps") do |int|
	steps, _, _ = @square.walk()
	expect(steps).to eq(int)
end

When("data is written to square number {int}") do |int|
	@square = Location.new(int)  
end

Then("the sum of adjacent values should be {int}") do |int|
	_, sum, _ = @square.walk()
	expect(sum).to eq(int)
end

Given("a limit value of {int}") do |int|
	@square = Location.new(0, int)  
end

Then("we should go over it at square {int}") do |int|
	_, _, counter = @square.walk()
	expect(counter).to eq(int)
end

Then("the first value written over it is {int}") do |int|
	_, sum, _ = @square.walk()
	expect(sum).to eq(int)
end

