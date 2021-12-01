# frozen_string_literal: true

Given('the numbers in file {string}') do |string|
  @depths = Depths.from_file(string)
end

Then('we go deeper {int} times') do |int|
  expect(@depths.run).to eq(int)
end

Then('in a sliding window we go deeper {int} times') do |int|
  expect(@depths.sliding).to eq(int)
end
