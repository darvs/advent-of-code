# frozen_string_literal: true

Given('the content of file {string}') do |arg1|
  @filename = arg1
end

Then(/^on row y=(\d+) there are (\d+) positions where a beacon cannot be present$/) do |arg1, arg2|
  expect(AllBeacons.from_file(@filename).coverage(arg1)).to eq(arg2)
end

When(/^the limit on coordinates is (\d+)$/) do |arg1|
  @limit = arg1.to_i
end

Then(/^the tuning frequency is (\d+)$/) do |arg1|
  expect(AllBeacons.from_file(@filename).tuning_frequency(@limit)).to eq(arg1)
end
