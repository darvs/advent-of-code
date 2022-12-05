# frozen_string_literal: true

Given('the content of file {string}') do |arg1|
  @stacks = Stacks.from_file(arg1)
end

When(/^using CrateMover (\d+)$/) do |arg1|
  @mover = arg1
end

Then('it ends up looking like {string}') do |arg1|
  expect(@stacks.ends_up_as(@mover)).to eq(arg1)
end
