# frozen_string_literal: true

Given('the numbers in file {string}') do |string|
  @dive = Dive.from_file(string)
end

Then(/^we end up at a value of (\d+)$/) do |arg1|
  expect(@dive.part2).to eq(arg1)
end
