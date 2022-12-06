# frozen_string_literal: true

Given('the table') do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  @data = table.hashes
end

Given('the string in file {string}') do |string|
  @file = string
end

Given(/^we are looking for a packet$/) do
  @distinct = 4
end

Given(/^we are looking for a message$/) do
  @distinct = 14
end

Then('all answers should be verified.') do
  @data.each{|row|
    expect(Handheld.new(row['datastream']).first_distinct(@distinct)).to eq(row['start'].to_i)
  }
end

Then(/^it should start at position (\d+)$/) do |arg1|
  expect(Handheld.from_file(@file).first_distinct(@distinct)).to eq(arg1)
end


