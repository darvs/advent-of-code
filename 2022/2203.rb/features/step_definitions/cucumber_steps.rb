# frozen_string_literal: true

Given('the contents in file {string}') do |arg1|
  @sack = Rucksack.from_file(arg1)
end

Then(/^the sum of priorities is (\d+)$/) do |arg1|
  expect(@sack.sum_priorities).to eq(arg1)
end

Then(/^the sum of priorities for trios is (\d+)$/) do |arg1|
  expect(@sack.sum_priorities3).to eq(arg1)
end
