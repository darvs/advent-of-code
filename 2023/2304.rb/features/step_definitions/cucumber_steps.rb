# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @scratch = Scratchcards.from_file(arg1)
end

Then(/^they are worth (\d+) points in total$/) do |arg1|
  expect(@scratch.total_worth).to eq(arg1)
end

Then(/^we end up with (\d+) scratchcards$/) do |arg1|
  expect(@scratch.number_of_cards).to eq(arg1)
end
