# frozen_string_literal: true

Given('the values in file {string}') do |arg1|
  @beams = Beams.from_file(arg1)
end

Then(/^(\d+) tiles become energized$/) do |arg1|
  expect(@beams.energized).to eq(arg1)
end
