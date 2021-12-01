# frozen_string_literal: true

Given('the numbers in file {string}') do |string|
  @depths = Depths.from_file(string)
end

Then('we go deeper {int} times') do |int|
  expect(@depths.run_with_sliding_size(1)).to eq(int)
end

Then('in a sliding window we go deeper {int} times') do |int|
  expect(@depths.run_with_sliding_size(3)).to eq(int)
end
