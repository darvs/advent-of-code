require_relative "../../lib/1803.rb"

Given("the list in {string}") do |string|
  @size, @unconflicted_claims = exec_file(string)
end

Then("the insection should be of {int} square inches") do |int|
  expect(@size).to eq(int)
end

Then("claim #\{int} should be the only one free of conflicts") do |int|
  expect(@unconflicted_claims.size).to eq(1)
  expect(@unconflicted_claims.to_a[0]).to eq(int)
end 
