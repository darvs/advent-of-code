# frozen_string_literal: true

Given('the bus routes in {string}') do |string|
  @filename = string
end

Then('the bus ID times number of minutes to wait would be {int}') do |int|
  expect(Bus1.from_file(@filename).run).to eq(int)
end

Then('the earliest timestamp to fit the restrictions would be {int}') do |int|
  expect(Bus2.from_file(@filename).run).to eq(int)
end
