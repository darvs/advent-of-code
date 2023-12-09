# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @mirage = Mirage.from_file(arg1)
end

Then(/^the sum of extrapolated values is (\d+)$/) do |arg1|
  expect(@mirage.total).to eq(arg1)
end

Then(/^the sum of the first values is (\d+)$/) do |arg1|
  expect(@mirage.total_first).to eq(arg1)
end
