# frozen_string_literal: true

Given(/^the numbers in file "([^"]*)"$/) do |arg1|
  @squid_game = SquidGame.from_file(arg1)
end

Given('we play to win') do
  @squid_game.play
end

Given('we play to lose') do
  @squid_game.play_to_lose
end

Then('the winning number is {int}') do |int|
  expect(@squid_game.numbers_drawn[@squid_game.last_winning_turn]).to eq(int)
end

Then('the sum of unmarked squares is {int}') do |arg1|
  expect(@squid_game.unmarked).to eq(arg1)
end

Then('the sum of unmarked squares multiplied by the winning number is {int}') do |arg1|
  expect(@squid_game.formula).to eq(arg1)
end
