# frozen_string_literal: true

Given(/^the tiles in file "([^"]*)"$/) do |arg1|
  @filename = arg1
end

Then(/^(\d+) tiles have been switched$/) do |arg1|
  expect(Tiles.from_file(@filename).switched).to eq(arg1)
end

