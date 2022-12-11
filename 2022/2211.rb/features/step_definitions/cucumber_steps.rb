# frozen_string_literal: true

Given('the content of file {string}') do |arg1|
  @filename = arg1
  @worry_divider = 1
end

Given(/^after (\d+) rounds$/) do |arg1|
  @rounds = arg1
end

Given(/^a worry level divider of (\d+)$/) do |arg1|
  @worry_divider = arg1
end

Then(/^the level of monkey business is (\d+)$/) do |arg1|
  expect(Business.from_file(@filename).level_of_monkey_business(@rounds, @worry_divider)).to eq(arg1)
end
