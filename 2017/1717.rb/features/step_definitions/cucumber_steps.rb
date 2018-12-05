require_relative "../../lib/1717.rb"

Given("the spinlock steps a number of times defined in {string}") do |string|
  @step = string
end

Then("the value after the final position would be {int}") do |int|
  expect(exec_spinlock(@step)).to eq(int)
end

Then("the value after the {int} would be {int}") do |int, int2|
  expect(angry_spinlock(@step)).to eq(int2)
end
