# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @scheme = Schematic.from_file(arg1)
end

Then(/^the sum of all parts numbers is (\d+)$/) do |arg1|
  expect(@scheme.sum_of_part_numbers).to eq(arg1)
end

Then(/^the sum of all gear ratios is (\d+)$/) do |arg1|
  expect(@scheme.sum_of_gear_ratios).to eq(arg1)
end
