# frozen_string_literal: true

Given(/^the numbers in file "([^"]*)"$/) do |arg1|
  @diag = BinaryDiagnostic.from_file(arg1)
end

Then(/^the power consumption of the submarine is (\d+)$/) do |arg1|
  expect(@diag.run_part1).to eq(arg1)
end

Then(/^the life support rating of the submarine is (\d+)$/) do |arg1|
  expect(@diag.run_part2).to eq(arg1)
end
