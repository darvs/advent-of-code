# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @trebuchet = Trebuchet.from_file(arg1)
end

Then(/^the sum of calibration values is (\d+)$/) do |arg1|
  expect(@trebuchet.sum).to eq(arg1)
end

Then(/^the sum of string or integer calibration values is (\d+)$/) do |arg1|
  expect(@trebuchet.sum_with_replacements).to eq(arg1)
end
