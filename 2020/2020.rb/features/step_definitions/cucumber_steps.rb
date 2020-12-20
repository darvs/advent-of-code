# frozen_string_literal: true

Given(/^the puzzle in file "([^"]*)"$/) do |arg1|
  @filename = arg1
end

Then(/^the multiplication of the corners would be (\d+)$/) do |arg1|
  expect(Puzzle.from_file(@filename).multiply).to eq(arg1.to_i)
end
