# frozen_string_literal: true

Given('the content of file {string}') do |arg1|
  @filename = arg1
end

When(/^there are (\d+) knots$/) do |arg1|
  @number_of_knots = arg1
end

Then(/^the tail visits (\d+) positions at least once$/) do |arg1|
  expect(Rope.from_file(@filename, @number_of_knots).position_count).to eq(arg1)
end
