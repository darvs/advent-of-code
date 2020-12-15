# frozen_string_literal: true

Given('the list {string}') do |string|
  @list = string
end

Then('the {int}th number will be {int}') do |int, int2|
  expect(ElvesGame.from_list(@list).run(int)).to eq(int2)
end
