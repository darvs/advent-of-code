# frozen_string_literal: true

Given(/^the cups labeled "([^"]*)"$/) do |arg1|
  @order = arg1
end

Given(/^(\d+) moves$/) do |arg1|
  @nb_moves = arg1.to_i
end

Then(/^the order would be "([^"]*)"$/) do |arg1|
  expect(Cups.from_order(@order).formatted_moves(@nb_moves)).to eq(arg1)
end

Given(/^the moves in table$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  @data = table.hashes
end

Then(/^the moves would be verified$/) do
  @data.each{|row|
    expect(Cups.from_order(row[:start]).moves(row[:moves].to_i)).to eq(row[:end])
  }
end
