# frozen_string_literal: true

Given('the content of file {string}') do |arg1|
  @filename = arg1
end

Then(/^on row y=(\d+) there are (\d+) positions where a beacon cannot be present$/) do |arg1, arg2|
  expect(AllBeacons.from_file(@filename).row(arg1)).to eq(arg2)
end
