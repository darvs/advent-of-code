require_relative '../../lib/2017d02.rb'

Given("a line such as {string}") do |string|
	@line = line(string) 
end

Then("the lowest number should be {int}") do |int|
	expect(lowest(@line)).to eq(int)
end

Then("the highest number should be {int}") do |int|
	expect(highest(@line)).to eq(int)
end

Then("the difference should be {int}") do |int|
	expect(difference(@line)).to eq(int)
end

Given("a spreadsheet file such as {string}") do |string|
	@spreadsheet = load(string)
end

Then("the checksum should be {int}") do |int|
	expect(checksum(@spreadsheet)).to eq(int)
end

Then("the even division should be {int}") do |int|
	expect(even_division(@line)).to eq(int)
end

Then("the even division checksum should be {int}") do |int|
	expect(even_division_checksum(@spreadsheet)).to eq(int)
end

