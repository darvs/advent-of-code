# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @cards = Cards.from_file(arg1)
end

Then(/^the total of winnings is (\d+)$/) do |arg1|
  expect(@cards.winnings).to eq(arg1)
end
