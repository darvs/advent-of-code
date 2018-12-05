require_relative "../../lib/1805.rb"

Given("the polymer in {string}") do |string|
  @polymer, @filtered = exec_file(string)
end

Then("the remaining polymer would be {int} characters long") do |int|
  expect(@polymer.length).to eq(int)
end

Then("it would be {string}") do |string|
  expect(@polymer).to eq(string)
end

Then("if we filtered all {string} units, it would only be {int} characters long") do |string, int|
  expect(@filtered[:unit]).to eq(string)
  expect(@filtered[:len]).to eq(int)
end
