# frozen_string_literal: true

Given('the content of file {string}') do |arg1|
  @filename = arg1
end

Then(/^the sum of the indices of the pairs in order is (\d+)$/) do |arg1|
  expect(DistressSignal.from_file(@filename).run).to eq(arg1)
end
