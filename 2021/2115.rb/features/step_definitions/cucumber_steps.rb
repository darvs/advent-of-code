# frozen_string_literal: true

Given(/^the map in file "([^"]*)"$/) do |arg1|
  @map = ChitonMap.from_file(arg1)
end

Then(/^lowest total risk is (\d+)$/) do |arg1|
  expect(@map.total_risk).to eq(arg1)
end
