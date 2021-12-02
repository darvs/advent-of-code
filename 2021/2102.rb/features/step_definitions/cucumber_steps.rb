# frozen_string_literal: true

Given('the numbers in file {string}') do |string|
  @dive = Dive.from_file(string)
end

Given(/^that we account for aim$/) do
  @dive.use_aim
end

Then(/^we end up at a value of (\d+)$/) do |arg1|
  expect(@dive.run).to eq(arg1)
end
