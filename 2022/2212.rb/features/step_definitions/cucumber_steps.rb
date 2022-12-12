# frozen_string_literal: true

Given('the content of file {string}') do |arg1|
  @filename = arg1
end

Then(/^the shortest path length is (\d+)$/) do |arg1|
  expect(KateBush.from_file(@filename).running_up_that_hill).to eq(arg1)
end
