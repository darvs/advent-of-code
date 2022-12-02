# frozen_string_literal: true

Given('the numbers in file {string}') do |string|
  @calories = Calories.from_file(string)
end

Then(/^the elf with the most calories has (\d+)$/) do |arg1|
  expect(@calories.most_calories).to eq(arg1)
end

Then(/^the top three elves total (\d+) calories$/) do |arg1|
  expect(@calories.total_three_most_calories).to eq(arg1)
end
