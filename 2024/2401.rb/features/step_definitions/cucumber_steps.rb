# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @locations = Locations.from_file(arg1)
end

Then(/^the sum of differences is (\d+)$/) do |arg1|
  expect(@locations.sum_of_diff).to eq(arg1)
end

Then(/^the sum of occurences is (\d+)$/) do |arg1|
  expect(@locations.sum_of_occurences).to eq(arg1)
end
