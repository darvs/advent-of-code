# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @sh = Fertilizer.from_file(arg1)
  @using_seed_ranges = false
end

When(/^we are using seed ranges$/) do
  @using_seed_ranges = true
end

Then(/^the lowest location is (\d+)$/) do |arg1|
  expect(@sh.lowest_location(@using_seed_ranges)).to eq(arg1)
end
