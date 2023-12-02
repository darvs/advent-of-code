# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @conundrum = Cubes.from_file(arg1)
end

Then(/^the sum of ids of possible games is (\d+)$/) do |arg1|
  expect(@conundrum.sum).to eq(arg1)
end

Then(/^the sum of powers is (\d+)$/) do |arg1|
  expect(@conundrum.power_sum).to eq(arg1)
end
