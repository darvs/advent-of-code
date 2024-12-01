# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @wasteland = Wasteland.from_file(arg1)
  @starting_point = nil
end

When(/^starting from AAA$/) do
  @starting_point = 'AAA'
end

Then(/^it takes (\d+) steps to reach ZZZ$/) do |arg1|
  expect(@wasteland.steps(@starting_point)).to eq(arg1)
end
