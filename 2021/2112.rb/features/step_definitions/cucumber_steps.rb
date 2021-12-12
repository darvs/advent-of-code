# frozen_string_literal: true

Given('the points in file {string}') do |arg1|
  @smoke = Smoke.from_file(arg1)
end

Then('the sum of the risks is {int}') do |arg1|
  expect(@smoke.part1).to eq(arg1)
end

Then('the product of the size of the three largest basins is {int}') do |arg1|
  expect(@smoke.part2).to eq(arg1)
end

Given('the subpaths in file {string}') do |arg1|
  @cave = Cave.from_file(arg1)
end

Then(/^there is (\d+) different paths$/) do |arg1|
  expect(@cave.number_of_paths).to eq(arg1)
end
