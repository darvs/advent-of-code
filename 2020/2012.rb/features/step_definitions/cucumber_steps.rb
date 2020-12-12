# frozen_string_literal: true

Given('the direction in {string}') do |string|
  @filename = string
end

Then('the Manhatten distance from the start would be {int}') do |int|
  expect(Manhattan.from_file(@filename).distance).to eq(int)
end

Then('the Manhatten distance \(with a waypoint) from the start would be {int}') do |int|
  expect(Manhattan_waypoint.from_file(@filename).distance).to eq(int)
end
