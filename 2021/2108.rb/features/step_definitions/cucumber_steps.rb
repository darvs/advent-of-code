# frozen_string_literal: true

Given('the segments in file {string}') do |arg1|
  @abba = Abba.from_file(arg1)
end

Then('there would be {int} digits with unique segments') do |arg1|
  expect(@abba.run).to eq(arg1)
end

Then(/^the sum of output values should be (\d+)$/) do |arg1|
  expect(@abba.decode).to eq(arg1)
end
