require_relative "../../lib/1808.rb"

Given("the nodes listed in {string}") do |string|
  @total, @root_value = exec_file(string)
end

Then("the sum of metadata entries would be {int}") do |int|
  expect(@total).to eq(int)
end

Then("the value of the root node would be {int}") do |int|
  expect(@root_value).to eq(int)
end
