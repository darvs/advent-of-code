# frozen_string_literal: true

Given(/^the following data$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  @data = table.hashes
end

Then(/^all answers should be verified$/) do
  @data.each{|row|
    #puts "eq #{row['priority']}, #{row['answer']} =? #{row['equation']}"
    expect(Equation.with_priority(row['priority'].to_i).parse(row['equation']).solve).to eq(row['answer'].to_i)
  }
end

Given(/^the file "([^"]*)"$/) do |arg1|
  @file = arg1
  @part = 1
end

Given(/^reverse operator priority$/) do
  @part = 2
end

Then(/^the total should be (\d+)$/) do |arg1|
  expect(EquationFile.from_file(@file).with_priority(@part).solve).to eq(arg1)
end
