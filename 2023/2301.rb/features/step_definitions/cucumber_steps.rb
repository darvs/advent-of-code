# frozen_string_literal: true
Given('the numbers in file {string}') do |string|
  @calories = Calories.from_file(string)
end

Then(/^the elf with the most calories has (\d+)$/) do |arg1|
  expect(@calories.most_calories).to eq(arg1)
end

Given('the values in file {string}') do |arg1|
  @trebuchet = Trebuchet.from_file(arg1)
end

Then(/^the sum of calibration values is (\d+)$/) do |arg1|
  expect(@trebuchet.sum).to eq(arg1)
end
