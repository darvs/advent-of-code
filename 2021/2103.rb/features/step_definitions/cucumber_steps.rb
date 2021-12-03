# frozen_string_literal: true

Given(/^the numbers in file "([^"]*)"$/) do |arg1|
  @diag = BinaryDiagnostic.from_file(arg1)
end

Then(/^the power consumption of the submarine is (\d+)$/) do |arg1|
  expect(@diag.run).to eq(arg1)
end
