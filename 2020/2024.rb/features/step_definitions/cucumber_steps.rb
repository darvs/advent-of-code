# frozen_string_literal: true

Given(/^the tiles in file "([^"]*)"$/) do |arg1|
  @filename = arg1
end

Then(/^(\d+) tiles have been switched$/) do |arg1|
  expect(Tiles.from_file(@filename).switched).to eq(arg1)
end

Given(/^the tiles in file "([^"]*)" and the table$/) do |arg1, table|
  # table is a Cucumber::MultilineArgument::DataTable
  @filename = arg1
  @data = table.hashes
end

Then(/^all answers should be verified$/) do
  @data.each{|row|
    expect(Tiles.from_file(@filename).day(row['day'].to_i)).to eq(row['black'].to_i)
  }
end
