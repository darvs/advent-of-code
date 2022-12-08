# frozen_string_literal: true

Given('the content of file {string}') do |arg1|
  @treehouse = Treehouse.from_file(arg1)
end

Then(/^there are (\d+) visible trees$/) do |arg1|
  expect(@treehouse.visible_count).to eq(arg1)
end
