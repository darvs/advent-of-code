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

Given('the moves in file {string}') do |arg1|
  @game = RoShamBo.from_file(arg1)
end

Then(/^my total score is (\d+)$/) do |arg1|
  expect(@game.score_part1).to eq(arg1)
end

Then(/^my total score in part 2 is (\d+)$/) do |arg1|
  expect(@game.score_part2).to eq(arg1)
end
