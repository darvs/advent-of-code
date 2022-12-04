# frozen_string_literal: true

Given('the contents in file {string}') do |arg1|
  @cleanup = Cleanup.from_file(arg1)
end

Then(/^there are (\d+) fully containing pairs\.$/) do |arg1|
  expect(@cleanup.fully_contained).to eq(arg1)
end

Then(/^there are (\d+) overlapping pairs\.$/) do |arg1|
  expect(@cleanup.overlapping).to eq(arg1)
end
