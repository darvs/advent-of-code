require_relative "../../lib/1709.rb"

Given("the stream {string}") do |string|
	@str = string
end

Then("it should all be garbage") do
	expect(all_garbage(@str)).to eq(true)
end

Then("there are {int} groups") do |int|
	expect(count_groups(@str)).to eq(int)
end

Then("the score is {int}") do |int|
	expect(score(@str)).to eq(int)
end

Given("the file {string}") do |string|
	@str = file(string)	
end

Then("there are {int} trash characters") do |int|
	expect(trash_count(@str)).to eq(int)
end

