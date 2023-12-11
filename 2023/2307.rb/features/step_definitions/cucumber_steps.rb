# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @cards = Cards.from_file(arg1)
  @jokers_are_wild = false
end

When(/^Jokers are wild$/) do
  @jokers_are_wild = true
end

Then(/^the total of winnings is (\d+)$/) do |arg1|
  expect(@cards.winnings(@jokers_are_wild)).to eq(arg1)
end
