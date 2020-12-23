# frozen_string_literal: true

Given(/^the decks in file "([^"]*)"$/) do |arg1|
  @filename = arg1
end

Then(/^the winning score would be (\d+)$/) do |arg1|
  expect(CrabCombat.from_file(@filename).winning).to eq(arg1.to_i)
end
