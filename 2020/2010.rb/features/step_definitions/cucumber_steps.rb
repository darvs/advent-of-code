# frozen_string_literal: true

Given('the numbers in {string}') do |string|
  @filename = string
end

Then('the number of 1-jolt diff. times the number of 3-jolt diff. is {int}') do |int|
  expect(Adapters.from_file(@filename).part1).to eq(int)
end

Then('the number of combinations is {int}') do |int|
  expect(Adapters.from_file(@filename).part2).to eq(int)
end
