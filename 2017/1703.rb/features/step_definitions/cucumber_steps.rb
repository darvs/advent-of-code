require_relative '../../lib/1703.rb'

When("data starts from square {int}") do |int|
	@square = Location.new(int)  
end

Then("it should reach the center in {int} steps") do |int|
	steps, _ = @square.walk()
	expect(steps).to eq(int)
end

When("data is written to square number {int} for the stress test") do |int|
	@square = Location.new(int)  
end

Then("the sum of adjacent values should be {int}") do |int|
	_, sum = @square.walk(:stress_test)
	expect(sum).to eq(int)
end

Given("a stress test limit value of {int}") do |int|
	@square = Location.new(0, int)  
end

Then("the first value written over it during stress test is {int}") do |int|
	_, sum = @square.walk(:stress_test)
	expect(sum).to eq(int)
end

