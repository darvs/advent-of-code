# frozen_string_literal: true

Given(/^the equation "([^"]*)"$/) do |arg1|
  @equation = arg1
  @part = 1
end

Given(/^the file "([^"]*)"$/) do |arg1|
  @file = arg1
  @part = 1
end

Given(/^reverse operator priority$/) do
  @part = 2
end

Then(/^the answer should be (\d+)$/) do |arg1|
  expect(Equation.parse(@equation).solve(nil, @part)).to eq(arg1)
end

Then(/^the total should be (\d+)$/) do |arg1|
  expect(EquationFile.from_file(@file).solve_all(@part)).to eq(arg1)
end
