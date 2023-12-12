# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @stars = Stars.from_file(arg1)
  @expansion_factor = 2
end

When(/^the expansion factor is (\d+)$/) do |arg1|
  @expansion_factor = arg1
end

Then(/^the sum of distances is (\d+)$/) do |arg1|
  expect(@stars.distance(@expansion_factor)).to eq(arg1)
end
