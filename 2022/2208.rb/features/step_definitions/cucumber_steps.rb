# frozen_string_literal: true

Given('the content of file {string}') do |arg1|
  @treehouse = Treehouse.from_file(arg1)
end

Then(/^there are (\d+) visible trees$/) do |arg1|
  expect(@treehouse.visible_count).to eq(arg1)
end

When(/^we look at the tree at y = (\d+) and x = (\d+)$/) do |arg1, arg2|
  @y = arg1
  @x = arg2
end

Then(/^the scenic score is (\d+)$/) do |arg1|
  expect(@treehouse.scenic_score(@y, @x)).to eq(arg1)
end

Then(/^the best scenic score is (\d+)$/) do |arg1|
  expect(@treehouse.best_scenic_score).to eq(arg1)
end
