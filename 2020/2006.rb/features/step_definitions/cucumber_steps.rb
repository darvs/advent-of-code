# frozen_string_literal: true

Given('the custom declarations in {string}') do |string|
  @cd = CustomDeclarations.from_file(string)
end

Then('the sum of the counts is {int}') do |int|
  expect(@cd.total).to eq(int)
end

Then("the sum of the questions to which everyone in a group answered yes is {int}") do |int|
  expect(@cd.allyes).to eq(int)
end
