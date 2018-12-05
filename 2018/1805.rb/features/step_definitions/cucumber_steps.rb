require_relative "../../lib/1805.rb"

Given("the polymer in {string}") do |string|
  @polymer = exec_file(string)
end

Then("the remaining polymer would be {int} characters long") do |int|
  expect(@polymer.length).to eq(int)
end

Then("it would be {string}") do |string|
  expect(@polymer).to eq(string)
end
