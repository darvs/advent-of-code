# frozen_string_literal: true

Given('the string {string}') do |arg1|
  @decoder = PacketDecoder.from_string(arg1)
end

Given('the string in file {string}') do |arg1|
  @decoder = PacketDecoder.from_file(arg1)
end

Then(/^the version is (\d+)$/) do |arg1|
  expect(@decoder.version).to eq(arg1)
end

Then(/^the sum of versions is (\d+)$/) do |arg1|
  expect(@decoder.sum_of_versions).to eq(arg1)
end
