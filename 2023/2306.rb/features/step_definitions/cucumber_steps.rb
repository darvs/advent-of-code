# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @wait = Wait.from_file(arg1)
  @bad_kerning = false
end

When(/^the values are badly kerned$/) do
  @bad_kerning = true
end

Then(/^if you multiply the number of ways you get (\d+)$/) do |arg1|
  expect(@wait.mult(@bad_kerning)).to eq(arg1)
end
