# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @hash = StringHash.from_file(arg1)
end

Then(/^the hash value is (\d+)$/) do |arg1|
  expect(@hash.run).to eq(arg1)
end

Then(/^the total focusing power is (\d+)$/) do |arg1|
  expect(@hash.focusing_power).to eq(arg1)
end
