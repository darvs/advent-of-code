# frozen_string_literal: true

Given('the boarding passes in {string}') do |string|
  @bp = BoardingPasses.from_file(string)
end

Then('the highest ID would be {int}') do |int|
  expect(@bp.highest).to eq(int)
end

Then('my boarding pass ID would be {int}') do |int|
  expect(@bp.mine).to eq(int)
end
