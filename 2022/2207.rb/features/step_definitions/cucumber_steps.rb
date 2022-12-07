# frozen_string_literal: true

Given('the content of file {string}') do |arg1|
  @shell = Shell.from_file(arg1)
end

Then(/^the sum of the size is (\d+)$/) do |arg1|
  expect(@shell.sum_of_total_sizes).to eq(arg1)
end

Then(/^the minimum space to free is (\d+)$/) do |arg1|
  expect(@shell.space_to_free).to eq(arg1)
end
